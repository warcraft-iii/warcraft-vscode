//! compiletime 求值 + 原文区间替换，移植自 TS BaseCompiler.checkCompileTime
//! （src/app/compiler/compiler.ts:252-269）与 initLuaEngine（148-174）。
//!
//! 策略（计划 DV2）：full-moon 仅用于定位每个 `compiletime(...)` 调用与其实参的
//! 字节区间；求值走 mlua，替换是对原文做区间替换——不重打印 AST，原始排版保留。
//! 求值顺序与 TS（luaparse onCreateNode 源码顺序）一致：先自顶向下逐个求值，
//! 再按区间倒序应用替换（避免替换使后续字节偏移失效）。
//!
//! Lua 引擎由调用方注入（DV6）：TS 在一次构建内跨文件共享同一引擎
//! （compiler.ts:148-151 惰性单例），调用方应每次构建用 [`make_lua`] 创建一个
//! 引擎并贯穿所有文件；与 TS 的差异在于 TS 单例是 VSCode 会话级持久（跨构建
//! 残留全局），Rust 端每次构建全新，保证构建可复现。
//!
//! full-moon 1.2.0 API 适配说明（已对照 crate 源码验证）：
//! - `FunctionCall` 派生 `Node`，其末字段 `suffixes` 最终落在
//!   `FunctionArgs::Parentheses { parentheses: ContainedSpan #[node(full_range)], .. }`，
//!   故 `end_position()` 覆盖右括号 `)`；
//! - 词法器以"消费完该 token 后的位置"作为 `Token::end_position`（排他字节偏移），
//!   因此 `&src[start.bytes()..end.bytes()]` 即完整调用原文，无需再找末 token 补偿；
//! - `Node::start_position/end_position` 不含前后 trivia，故实参
//!   `Expression::Function` 的区间恰为 `function ... end` 本体，
//!   `compiletime(--[[c]] function() end)` 的前导注释不混入实参源码。

use full_moon::ast::{Call, Expression, FunctionArgs, Prefix, Suffix};
use full_moon::node::Node;
use full_moon::visitors::Visitor;

use crate::error::{Error, Result};
use crate::luastr::to_lua;

struct CallSpan {
    start: usize,
    end: usize,
    /// 唯一匿名函数实参的字节区间；None 表示实参数量/类型不符，
    /// `process` 据此报 TS 对齐的 bad-arg 错误（含行号）。
    arg: Option<(usize, usize)>,
}

#[derive(Default)]
struct Finder {
    spans: Vec<CallSpan>,
}

impl Visitor for Finder {
    fn visit_function_call(&mut self, node: &full_moon::ast::FunctionCall) {
        // TS 端（luaparse）仅匹配 `CallExpression` 且 base 为 `Identifier`，即裸圆括号
        // 调用 `compiletime(...)`。成员/方法/字符串糖形式（compiletime.foo(42)、
        // compiletime:foo(42)、compiletime"s"）不命中，必须原样放行。
        // 等价判定：prefix 为 Name("compiletime")，且后缀恰好一个、为
        // Suffix::Call(Call::AnonymousCall(FunctionArgs::Parentheses))。
        //
        // 已认可的剩余偏差：链式 `compiletime(fn)(x)`（两个调用后缀）在 Rust 端
        // 整体跳过，而 TS 会求值内层调用——属病态写法，接受该差异。
        let Prefix::Name(name) = node.prefix() else {
            return;
        };
        // TokenReference::token() 不含 trivia，区间从标识符首字节起算。
        if name.token().to_string() != "compiletime" {
            return;
        }
        let mut suffixes = node.suffixes();
        let (Some(first), None) = (suffixes.next(), suffixes.next()) else {
            return;
        };
        let Suffix::Call(Call::AnonymousCall(FunctionArgs::Parentheses { arguments, .. })) = first
        else {
            return;
        };
        // TS 实参校验（compiler.ts:256）：arguments.length != 1 或
        // arguments[0].type != 'FunctionDeclaration' → "Incorrect compiletime argument"。
        // 因此 `compiletime(functional)`（标识符实参）、`compiletime(function() end, 2)`
        // （多实参）均报 bad-arg（与 TS 同）；`compiletime(--[[c]] function() end)`
        // 经 AST 取实参区间可正常求值（与 TS 接受一致，优于旧的字符串切割）。
        let arg = match (arguments.len(), arguments.iter().next()) {
            (1, Some(expr @ Expression::Function(..))) => {
                match (expr.start_position(), expr.end_position()) {
                    (Some(s), Some(e)) => Some((s.bytes(), e.bytes())),
                    _ => None,
                }
            }
            _ => None,
        };
        if let (Some(s), Some(e)) = (node.start_position(), node.end_position()) {
            self.spans.push(CallSpan {
                start: s.bytes(),
                end: e.bytes(),
                arg,
            });
        }
    }
}

/// TS BaseCompiler.checkCompileTime 的 bad-arg 错误（compiler.ts:256 消息格式镜像）。
fn bad_arg(file: &str, line: usize) -> Error {
    Error::with_args(
        "error.processFilesFailure",
        format!("File: {file}\nLine: {line}\nError: Incorrect compiletime argument"),
        vec![file.to_string()],
    )
}

/// TS initLuaEngine：在标准 io 库上注入 readFile/writeFile。
/// 调用方（构建管线）每次构建创建一个引擎并贯穿所有文件（DV6）。
pub fn make_lua() -> Result<mlua::Lua> {
    let lua = mlua::Lua::new();
    let io: mlua::Table = lua.globals().get("io").map_err(|e| lua_err(e, "<init>"))?;
    io.set(
        "readFile",
        lua.create_function(|_, path: String| {
            std::fs::read_to_string(&path)
                .map_err(|e| mlua::Error::external(format!("{path}: {e}")))
        })
        .map_err(|e| lua_err(e, "<init>"))?,
    )
    .map_err(|e| lua_err(e, "<init>"))?;
    io.set(
        "writeFile",
        lua.create_function(|_, (path, content): (String, String)| {
            std::fs::write(&path, content)
                .map_err(|e| mlua::Error::external(format!("{path}: {e}")))
        })
        .map_err(|e| lua_err(e, "<init>"))?,
    )
    .map_err(|e| lua_err(e, "<init>"))?;
    Ok(lua)
}

fn lua_err(e: mlua::Error, file: &str) -> Error {
    Error::with_args(
        "error.processFilesFailure",
        format!("File: {file}\nError: {e}"),
        vec![file.to_string()],
    )
}

/// 对含 compiletime 的源码做求值替换（DV2：区间替换，不重打印 AST）。
/// 多返回值以 ',' 连接；零返回值替换为空串（TS raw='' 对齐）。
/// 嵌套 compiletime 仅处理最外层（与 TS 自底向上行为不同——见计划 DV 注记）：
/// 按 start 排序后丢弃被已保留区间包含的区间。
/// 求值自顶向下（源码顺序，TS 对齐），替换按区间倒序应用。
pub fn process(lua: &mlua::Lua, source: &str, file: &str) -> Result<String> {
    let ast = full_moon::parse(source).map_err(|errors| {
        let msg = errors
            .iter()
            .map(|e| e.to_string())
            .collect::<Vec<_>>()
            .join("; ");
        Error::new(
            "error.processFilesFailure",
            format!("File: {file}\nError: {msg}"),
        )
    })?;
    let mut finder = Finder::default();
    finder.visit_ast(&ast);
    if finder.spans.is_empty() {
        return Ok(source.to_string());
    }
    let mut spans = finder.spans;
    spans.sort_by_key(|s| s.start);
    // 最外层过滤：丢弃被前一保留 span 包含的 span。
    let mut outer: Vec<CallSpan> = Vec::new();
    for s in spans {
        if outer.last().is_some_and(|o| s.start < o.end) {
            continue;
        }
        outer.push(s);
    }
    // 第一遍：自顶向下求值（compiletime 函数可读写共享 Lua 全局，顺序可观测）。
    let mut literals: Vec<String> = Vec::with_capacity(outer.len());
    for span in &outer {
        let Some((arg_start, arg_end)) = span.arg else {
            let line = source[..span.start].matches('\n').count() + 1;
            return Err(bad_arg(file, line));
        };
        let arg_src = &source[arg_start..arg_end];
        // 防御性 '\n'：终止实参源码内可能的行尾注释，再闭合括号。
        let results: mlua::MultiValue = lua
            .load(format!("return ({arg_src}\n)()"))
            .set_name(file)
            .eval()
            .map_err(|e| lua_err(e, file))?;
        literals.push(
            results
                .iter()
                .map(to_lua)
                .collect::<Result<Vec<_>>>()?
                .join(","),
        );
    }
    // 第二遍：倒序替换，保证未处理区间的字节偏移不被前面的替换破坏。
    let mut out = source.to_string();
    for (span, literal) in outer.iter().zip(&literals).rev() {
        out.replace_range(span.start..span.end, literal);
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn substitutes_table_result() {
        let lua = make_lua().unwrap();
        let src = "local t = compiletime(function()\n    return { name = 'wc3', count = 3 }\nend)\nreturn t";
        let out = process(&lua, src, "main.lua").unwrap();
        assert_eq!(out, "local t = {count=3,name=[[wc3]]}\nreturn t");
    }

    #[test]
    fn substitutes_multiple_returns_and_scalars() {
        let lua = make_lua().unwrap();
        let out = process(
            &lua,
            "local a, b = compiletime(function() return 1, 'x' end)",
            "f.lua",
        )
        .unwrap();
        assert_eq!(out, "local a, b = 1,[[x]]");
        let out = process(
            &lua,
            "local n = compiletime(function() return 40 + 2 end)",
            "f.lua",
        )
        .unwrap();
        assert_eq!(out, "local n = 42");
        let out = process(
            &lua,
            "local f = compiletime(function() return -0.5 end)",
            "f.lua",
        )
        .unwrap();
        assert_eq!(out, "local f = -0.5");
    }

    #[test]
    fn empty_return_becomes_empty() {
        let lua = make_lua().unwrap();
        let out = process(&lua, "compiletime(function() end)\nreturn 1", "f.lua").unwrap();
        assert_eq!(out, "\nreturn 1");
    }

    #[test]
    fn multiple_calls_replaced_independently() {
        let lua = make_lua().unwrap();
        let src =
            "a = compiletime(function() return 1 end)\nb = compiletime(function() return 2 end)";
        let out = process(&lua, src, "f.lua").unwrap();
        assert_eq!(out, "a = 1\nb = 2");
    }

    #[test]
    fn evaluation_order_is_top_to_bottom() {
        let lua = make_lua().unwrap();
        let src = "a = compiletime(function() x = (x or 0) + 1 return x end)\nb = compiletime(function() x = (x or 0) + 1 return x end)";
        assert_eq!(process(&lua, src, "f.lua").unwrap(), "a = 1\nb = 2");
    }

    #[test]
    fn shared_engine_state_persists_across_files() {
        let lua = make_lua().unwrap();
        process(&lua, "compiletime(function() SHARED = 7 end)", "a.lua").unwrap();
        let out = process(
            &lua,
            "v = compiletime(function() return SHARED end)",
            "b.lua",
        )
        .unwrap();
        assert_eq!(out, "v = 7");
    }

    #[test]
    fn same_line_multiple_calls() {
        let lua = make_lua().unwrap();
        let out = process(&lua, "local a, b = compiletime(function() return 1 end), compiletime(function() return 2 end)", "f.lua").unwrap();
        assert_eq!(out, "local a, b = 1, 2");
    }

    #[test]
    fn leading_comment_in_arg_accepted() {
        let lua = make_lua().unwrap();
        let out = process(
            &lua,
            "x = compiletime(--[[c]] function() return 1 end)",
            "f.lua",
        )
        .unwrap();
        assert_eq!(out, "x = 1");
    }

    #[test]
    fn rejects_non_function_argument() {
        let lua = make_lua().unwrap();
        let err = process(&lua, "local x = compiletime(42)", "bad.lua").unwrap_err();
        assert_eq!(err.key, "error.processFilesFailure");
        assert_eq!(
            err.message,
            "File: bad.lua\nLine: 1\nError: Incorrect compiletime argument"
        );
        assert_eq!(err.args, vec!["bad.lua".to_string()]);
    }

    #[test]
    fn wrong_arg_count_rejected_with_line() {
        let lua = make_lua().unwrap();
        let err = process(&lua, "y = 1\nx = compiletime(function() end, 2)", "f.lua").unwrap_err();
        assert_eq!(err.key, "error.processFilesFailure");
        assert!(err.message.contains("Line: 2"), "{}", err.message);
    }

    #[test]
    fn io_api_is_available() {
        let lua = make_lua().unwrap();
        let dir = std::env::temp_dir().join(format!("wc3-ct-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let f = dir.join("data.txt");
        std::fs::write(&f, "from-disk").unwrap();
        let src = format!(
            "local s = compiletime(function() return io.readFile([[{}]]) end)",
            f.display().to_string().replace('\\', "/")
        );
        let out = process(&lua, &src, "f.lua").unwrap();
        assert_eq!(out, "local s = [[from-disk]]");
        std::fs::remove_dir_all(&dir).unwrap();
    }

    #[test]
    fn untouched_when_no_compiletime() {
        let lua = make_lua().unwrap();
        let src = "local x = 1\nreturn x";
        assert_eq!(process(&lua, src, "f.lua").unwrap(), src);
    }

    #[test]
    fn non_bare_call_forms_left_untouched() {
        let lua = make_lua().unwrap();
        for src in [
            "compiletime.foo(42)",
            "compiletime:foo(42)",
            "compiletime\"s\"",
            "compiletime(function() return 1 end)(2)",
        ] {
            assert_eq!(process(&lua, src, "f.lua").unwrap(), src, "{src}");
        }
    }

    #[test]
    fn runtime_error_in_compiletime_fn_is_reported() {
        let lua = make_lua().unwrap();
        let err = process(&lua, "compiletime(function() error('boom') end)", "f.lua").unwrap_err();
        assert_eq!(err.key, "error.processFilesFailure");
        assert_eq!(err.args, vec!["f.lua".to_string()]);
    }
}
