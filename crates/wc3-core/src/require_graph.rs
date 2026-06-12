//! require/dofile/loadfile 扫描与解析，移植自 TS ReleaseCompiler
//! （src/app/compiler/release.ts:42-158 的 onCreateNode 扫描 + getMaybeFiles/resolveFile）。
//!
//! 本模块只做"扫描 + 解析"两步；编排（DFS 去重递归）由 Task 15 的构建管线负责。
//! - 扫描：命中裸 Name 前缀且【首个】后缀为匿名调用的前缀表达式（对应 TS
//!   `node.base.type === 'Identifier'`），实参须为单个字符串字面量；首个调用
//!   之后的后缀（`require('x').field` 的成员访问、`require('a')('b')` /
//!   `require('m').init()` 的链式调用）不影响命中——luaparse 对内层
//!   CallExpression 独立触发 onCreateNode，外层调用的 base 非 Identifier 不计。
//!   full-moon 按末后缀分流（parsers.rs:271-280 / 1696-1712）：末后缀为 Call
//!   是 FunctionCall 节点，为 Index 则是 Var::Expression（VarExpression）节点，
//!   两类节点互斥，故两处 visitor 共用同一匹配逻辑不会双计。
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
//!   与 TS luaparse `StringLiteral.value` 对齐；
//! - `VarExpression`（ast/mod.rs:1491）与 `FunctionCall` 同样提供 `prefix()` 与
//!   `suffixes()`（迭代器），对应 visitor 方法为 `visit_var_expression`
//!   （visitors.rs:276）。

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

impl ReqFinder {
    /// 共用匹配逻辑：裸 Name 前缀（require/dofile/loadfile）且【首个】后缀为
    /// 匿名调用、实参为单个字符串字面量（圆括号）或字符串糖。
    /// TS: node.base.type === 'Identifier' && isRequireFunction(name)。
    /// 首个调用之后的后缀（成员访问、继续调用）一律忽略——只有首个调用绑定
    /// 到裸名；外层链式调用在 TS 中 base 为 CallExpression/MemberExpression，
    /// 同样不计。
    fn scan_prefixed<'a>(
        &mut self,
        prefix: &Prefix,
        mut suffixes: impl Iterator<Item = &'a Suffix>,
    ) {
        let Prefix::Name(name) = prefix else {
            return;
        };
        let func = name.token().to_string();
        if func != "require" && func != "dofile" && func != "loadfile" {
            return;
        }
        let Some(Suffix::Call(Call::AnonymousCall(args))) = suffixes.next() else {
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

impl Visitor for ReqFinder {
    // 末后缀为 Call 的前缀表达式：require('x')、require('a')('b')、
    // require('m').init() 等均为 FunctionCall 节点。
    fn visit_function_call(&mut self, node: &full_moon::ast::FunctionCall) {
        self.scan_prefixed(node.prefix(), node.suffixes());
    }

    // 末后缀为 Index 的前缀表达式：require('x').field 被 full-moon 解析为
    // Var::Expression（后缀 [Call, Dot]），不产生 FunctionCall 节点，内层调用
    // 须在此登记（对齐 luaparse 对内层 CallExpression 的访问）。
    // 同一前缀表达式按末后缀只会落入 FunctionCall / VarExpression 之一，
    // 不会双计（见模块顶部说明；scan 测试覆盖全形态恰一次）。
    fn visit_var_expression(&mut self, node: &full_moon::ast::VarExpression) {
        self.scan_prefixed(node.prefix(), node.suffixes());
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
        // 后四个正例覆盖 Var::Expression（成员访问，full-moon 末后缀为 Index）
        // 与多后缀 FunctionCall（链式调用）；整表精确相等同时断言每个 require
        // 恰计一次（FunctionCall / VarExpression 两 visitor 无双计）。
        let reqs = scan_requires(
            "require('a.b')\nrequire 'c'\ndofile('d.lua')\nloadfile('e.lua')\nlocal v = require('cn.mod').value\nlocal w = require('m').who\nrequire('a')('b')\nrequire('mm').init()\nrequire(x)\nm.require('no')\nobj:require('no')\n",
        );
        let req = |module: &str| RequireItem {
            module: module.into(),
            is_require: true,
        };
        assert_eq!(
            reqs,
            vec![
                req("a.b"),
                req("c"),
                RequireItem {
                    module: "d.lua".into(),
                    is_require: false
                },
                RequireItem {
                    module: "e.lua".into(),
                    is_require: false
                },
                req("cn.mod"),
                req("m"),
                req("a"), // require('a')('b')：仅首个调用绑定裸名，'b' 不计
                req("mm"),
            ],
            "非字符串字面量与非裸调用忽略；成员访问/链式调用后缀不影响内层调用命中"
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
