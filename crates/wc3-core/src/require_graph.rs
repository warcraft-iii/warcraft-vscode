//! require/dofile/loadfile 扫描与解析，移植自 TS ReleaseCompiler
//! （src/app/compiler/release.ts:42-158 的 onCreateNode 扫描 + getMaybeFiles/resolveFile）。
//!
//! 本模块只做"扫描 + 解析"两步；编排（DFS 去重递归）由 Task 15 的构建管线负责。
//! - 扫描：仅命中裸 Name 前缀且恰一个调用后缀的调用（与 comptime.rs 同款过滤，
//!   对应 TS `node.base.type === 'Identifier'`），实参须为单个字符串字面量。
//!   圆括号形式 `require('x')`（TS CallExpression，arguments.length !== 1 则忽略，
//!   release.ts:114-116）与字符串糖形式 `require 'x'` / `require [[x]]`
//!   （TS StringCallExpression）均命中；`require(x)`（非字面量）、`m.require('no')`、
//!   `obj:require('no')`、`require{t}`（TS TableCallExpression 不在分支内）均忽略。
//! - 解析：require 走 package.path finders（`?` ← 模块名按 `.` 分段、滤空段、`/` 连接），
//!   dofile/loadfile 按路径相对 src（绝对路径保留）。classic 下未命中返回 Ok(None)
//!   （内置 jass.* 包，release.ts:66-71），reforge 报 "error.notFound"。
//!
//! full-moon 1.2.0 API 适配说明（已对照 crate 源码验证）：
//! - `Expression::String(TokenReference)`（ast/mod.rs:330）即字符串字面量表达式，
//!   非 0.x 时代的 `Expression::Value` 嵌套；
//! - 字符串糖形式为 `FunctionArgs::String(TokenReference)`（ast/mod.rs:484）；
//! - `TokenType::StringLiteral { literal, .. }` 的 `literal` 为去引号内容
//!   （tokenizer/structs.rs:273-275 "ignoring quotation marks"，长括号串同样只含正文），
//!   与 TS luaparse `StringLiteral.value` 对齐。

use std::path::{Path, PathBuf};

use full_moon::ast::{Call, Expression, FunctionArgs, Prefix, Suffix};
use full_moon::tokenizer::{TokenReference, TokenType};
use full_moon::visitors::Visitor;

use crate::error::{Error, Result};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct RequireItem {
    pub module: String,
    pub is_require: bool, // true=require（走 package.path），false=dofile/loadfile（按路径）
}

/// 去引号字符串字面量内容；非字符串 token 返回 None。
fn string_literal(tok: &TokenReference) -> Option<String> {
    match tok.token().token_type() {
        TokenType::StringLiteral { literal, .. } => Some(literal.to_string()),
        _ => None,
    }
}

#[derive(Default)]
struct ReqFinder {
    items: Vec<RequireItem>,
}

impl Visitor for ReqFinder {
    fn visit_function_call(&mut self, node: &full_moon::ast::FunctionCall) {
        // 与 comptime.rs 同款裸调用过滤：Name 前缀 + 恰一个调用后缀。
        // TS: node.base.type === 'Identifier' && isRequireFunction(name)
        let Prefix::Name(name) = node.prefix() else {
            return;
        };
        let func = name.token().to_string();
        if func != "require" && func != "dofile" && func != "loadfile" {
            return;
        }
        let mut suffixes = node.suffixes();
        let (Some(first), None) = (suffixes.next(), suffixes.next()) else {
            return;
        };
        let Suffix::Call(Call::AnonymousCall(args)) = first else {
            return;
        };
        let module = match args {
            // TS release.ts:114-116：CallExpression 实参数 != 1 直接忽略。
            FunctionArgs::Parentheses { arguments, .. } if arguments.len() == 1 => {
                match arguments.iter().next() {
                    Some(Expression::String(tok)) => string_literal(tok),
                    _ => None, // 非字符串字面量（TS:128 arg.type !== 'StringLiteral'）
                }
            }
            // 字符串糖形式（TS StringCallExpression），含长括号串 require [[x]]。
            FunctionArgs::String(tok) => string_literal(tok),
            _ => None, // 表构造糖 require{t} 等：TS 无对应分支，忽略。
        };
        if let Some(module) = module {
            self.items.push(RequireItem {
                module,
                is_require: func == "require",
            });
        }
    }
}

/// 扫描源码中 require/dofile/loadfile 的字符串字面量调用（出现序）。
/// 解析失败返回空表（与 TS luaparse 抛错前已被上游 parse 拦截的行为等价——
/// 上游 comptime/编译流程会先报 parse 错）。
pub fn scan_requires(source: &str) -> Vec<RequireItem> {
    let Ok(ast) = full_moon::parse(source) else {
        return Vec::new();
    };
    let mut finder = ReqFinder::default();
    finder.visit_ast(&ast);
    finder.items
}

/// TS getMaybeFiles + resolveFile。Ok(None) = classic 下允许的内置包缺失。
pub fn resolve(
    source_dir: &Path,
    finders: &[String],
    item: &RequireItem,
    classic: bool,
) -> Result<Option<PathBuf>> {
    let candidates: Vec<PathBuf> = if item.is_require {
        // TS getMaybeFiles：'.' 分段、滤空段（'.x.' → 'x'）、'/' 连接，替换 finder 的 '?'。
        let name = item
            .module
            .split('.')
            .filter(|w| !w.is_empty())
            .collect::<Vec<_>>()
            .join("/");
        finders
            .iter()
            .map(|f| source_dir.join(f.replace('?', &name)))
            .collect()
    } else {
        let p = Path::new(&item.module);
        vec![if p.is_absolute() {
            p.to_path_buf()
        } else {
            source_dir.join(p)
        }]
    };
    for c in candidates {
        if c.exists() {
            return Ok(Some(c));
        }
    }
    if classic {
        // classic 允许内置包（jass.xxx）缺失，调用方静默跳过（release.ts:66-71）。
        return Ok(None);
    }
    Err(Error::with_args(
        "error.notFound",
        format!("Not found {}", item.module),
        vec![item.module.clone()],
    ))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn scans_require_calls_including_sugar() {
        let reqs = scan_requires(
            "require('a.b')\nrequire 'c'\ndofile('d.lua')\nloadfile('e.lua')\nrequire(x)\nm.require('no')\nobj:require('no')\n",
        );
        assert_eq!(
            reqs,
            vec![
                RequireItem {
                    module: "a.b".into(),
                    is_require: true
                },
                RequireItem {
                    module: "c".into(),
                    is_require: true
                },
                RequireItem {
                    module: "d.lua".into(),
                    is_require: false
                },
                RequireItem {
                    module: "e.lua".into(),
                    is_require: false
                },
            ],
            "非字符串字面量与非裸调用忽略"
        );
    }

    #[test]
    fn resolves_require_via_package_path() {
        let dir = tempdir();
        std::fs::create_dir_all(dir.join("lib")).unwrap();
        std::fs::write(dir.join("lib/util.lua"), "x").unwrap();
        std::fs::create_dir_all(dir.join("mod")).unwrap();
        std::fs::write(dir.join("mod/init.lua"), "x").unwrap();
        let finders = vec!["./?.lua".to_string(), "./?/init.lua".to_string()];

        let p = resolve(
            &dir,
            &finders,
            &RequireItem {
                module: "lib.util".into(),
                is_require: true,
            },
            false,
        )
        .unwrap();
        // 路径相等性说明（红阶段已实测）：Rust PathBuf 的 PartialEq 按 Components 比较，
        // 中段 `.` 被跳过，故 dir.join("./lib/util.lua") == dir.join("lib/util.lua") 为 true
        // （Debug 字面量保留 `./`，但相等性与 TS path.resolve 规范化对齐）。
        // 按任务指示取简化形式断言；解析结果仅供 fs::read，非 golden 字节。
        assert_eq!(p.unwrap(), dir.join("lib/util.lua"));
        let p = resolve(
            &dir,
            &finders,
            &RequireItem {
                module: "mod".into(),
                is_require: true,
            },
            false,
        )
        .unwrap();
        assert_eq!(p.unwrap(), dir.join("mod/init.lua"));
        // dofile：直接相对 src
        let p = resolve(
            &dir,
            &finders,
            &RequireItem {
                module: "lib/util.lua".into(),
                is_require: false,
            },
            false,
        )
        .unwrap();
        assert_eq!(p.unwrap(), dir.join("lib/util.lua"));
        std::fs::remove_dir_all(&dir).unwrap();
    }

    #[test]
    fn require_with_leading_dots_drops_empty_segments() {
        let dir = tempdir();
        std::fs::write(dir.join("x.lua"), "x").unwrap();
        let finders = vec!["./?.lua".to_string()];
        let p = resolve(
            &dir,
            &finders,
            &RequireItem {
                module: ".x.".into(),
                is_require: true,
            },
            false,
        )
        .unwrap();
        assert_eq!(p.unwrap(), dir.join("x.lua"));
        std::fs::remove_dir_all(&dir).unwrap();
    }

    #[test]
    fn missing_module_classic_vs_reforge() {
        let dir = tempdir();
        let finders = vec!["./?.lua".to_string()];
        let item = RequireItem {
            module: "jass.common".into(),
            is_require: true,
        };
        assert!(
            resolve(&dir, &finders, &item, true).unwrap().is_none(),
            "classic 跳过"
        );
        let err = resolve(&dir, &finders, &item, false).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        std::fs::remove_dir_all(&dir).unwrap();
    }

    fn tempdir() -> std::path::PathBuf {
        static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
        let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let d = std::env::temp_dir().join(format!("wc3-req-{}-{n}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }
}
