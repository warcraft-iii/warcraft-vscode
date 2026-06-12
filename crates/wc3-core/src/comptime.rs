//! compiletime 求值 + 原文区间替换，移植自 TS BaseCompiler.checkCompileTime
//! （src/app/compiler/compiler.ts:252-269）与 initLuaEngine（148-174）。
//!
//! 策略（计划 DV2）：full-moon 仅用于定位每个 `compiletime(...)` 调用的字节区间；
//! 求值走 mlua，替换是对原文做区间替换并按区间倒序应用——不重打印 AST，原始排版保留。
//!
//! full-moon 1.2.0 API 适配说明（已对照 crate 源码验证）：
//! - `FunctionCall` 派生 `Node`，其末字段 `suffixes` 最终落在
//!   `FunctionArgs::Parentheses { parentheses: ContainedSpan #[node(full_range)], .. }`，
//!   故 `end_position()` 覆盖右括号 `)`；
//! - 词法器以"消费完该 token 后的位置"作为 `Token::end_position`（排他字节偏移），
//!   因此 `&src[start.bytes()..end.bytes()]` 即完整调用原文，无需再找末 token 补偿。

use full_moon::node::Node;
use full_moon::visitors::Visitor;

use crate::error::{Error, Result};
use crate::luastr::to_lua;

struct CallSpan {
    start: usize,
    end: usize,
}

#[derive(Default)]
struct Finder {
    spans: Vec<CallSpan>,
}

impl Visitor for Finder {
    fn visit_function_call(&mut self, node: &full_moon::ast::FunctionCall) {
        if let full_moon::ast::Prefix::Name(name) = node.prefix() {
            // TokenReference::token() 不含 trivia，区间从标识符首字节起算。
            if name.token().to_string() == "compiletime" {
                if let (Some(s), Some(e)) = (node.start_position(), node.end_position()) {
                    self.spans.push(CallSpan {
                        start: s.bytes(),
                        end: e.bytes(),
                    });
                }
            }
        }
    }
}

/// 从调用原文中取出唯一的匿名函数实参文本（TS 端要求单一 FunctionDeclaration 实参）。
fn extract_arg<'a>(call_src: &'a str, file: &str) -> Result<&'a str> {
    let open = call_src.find('(').ok_or_else(|| bad_arg(file))?;
    let close = call_src.rfind(')').ok_or_else(|| bad_arg(file))?;
    let arg = call_src[open + 1..close].trim();
    if !arg.starts_with("function") {
        return Err(bad_arg(file));
    }
    Ok(arg)
}

fn bad_arg(file: &str) -> Error {
    Error::with_args(
        "error.processFilesFailure",
        format!("File: {file}\nError: Incorrect compiletime argument"),
        vec![file.to_string()],
    )
}

/// TS initLuaEngine：在标准 io 库上注入 readFile/writeFile。
fn make_lua() -> Result<mlua::Lua> {
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
    Error::new(
        "error.processFilesFailure",
        format!("File: {file}\nError: {e}"),
    )
}

/// 对含 compiletime 的源码做求值替换（DV2：区间替换，不重打印 AST）。
/// 多返回值以 ',' 连接；零返回值替换为空串（TS raw='' 对齐）。
/// 嵌套 compiletime 仅处理最外层（与 TS 自底向上行为不同——见计划 DV 注记）：
/// 按 start 排序后丢弃被已保留区间包含的区间，再倒序应用替换。
pub fn process(source: &str, file: &str) -> Result<String> {
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
    let lua = make_lua()?;
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
    let mut out = source.to_string();
    for span in outer.iter().rev() {
        let call_src = &source[span.start..span.end];
        let arg = extract_arg(call_src, file)?;
        let results: mlua::MultiValue = lua
            .load(format!("return ({arg})()"))
            .set_name(file)
            .eval()
            .map_err(|e| lua_err(e, file))?;
        let literal = results
            .iter()
            .map(to_lua)
            .collect::<Result<Vec<_>>>()?
            .join(",");
        out.replace_range(span.start..span.end, &literal);
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn substitutes_table_result() {
        let src = "local t = compiletime(function()\n    return { name = 'wc3', count = 3 }\nend)\nreturn t";
        let out = process(src, "main.lua").unwrap();
        assert_eq!(out, "local t = {count=3,name=[[wc3]]}\nreturn t");
    }

    #[test]
    fn substitutes_multiple_returns_and_scalars() {
        let out = process(
            "local a, b = compiletime(function() return 1, 'x' end)",
            "f.lua",
        )
        .unwrap();
        assert_eq!(out, "local a, b = 1,[[x]]");
        let out = process(
            "local n = compiletime(function() return 40 + 2 end)",
            "f.lua",
        )
        .unwrap();
        assert_eq!(out, "local n = 42");
        let out = process("local f = compiletime(function() return -0.5 end)", "f.lua").unwrap();
        assert_eq!(out, "local f = -0.5");
    }

    #[test]
    fn empty_return_becomes_empty() {
        let out = process("compiletime(function() end)\nreturn 1", "f.lua").unwrap();
        assert_eq!(out, "\nreturn 1");
    }

    #[test]
    fn multiple_calls_replaced_independently() {
        let src =
            "a = compiletime(function() return 1 end)\nb = compiletime(function() return 2 end)";
        let out = process(src, "f.lua").unwrap();
        assert_eq!(out, "a = 1\nb = 2");
    }

    #[test]
    fn rejects_non_function_argument() {
        let err = process("local x = compiletime(42)", "bad.lua").unwrap_err();
        assert_eq!(err.key, "error.processFilesFailure");
        assert!(err.message.contains("bad.lua"));
    }

    #[test]
    fn io_api_is_available() {
        let dir = std::env::temp_dir().join(format!("wc3-ct-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let f = dir.join("data.txt");
        std::fs::write(&f, "from-disk").unwrap();
        let src = format!(
            "local s = compiletime(function() return io.readFile([[{}]]) end)",
            f.display().to_string().replace('\\', "/")
        );
        let out = process(&src, "f.lua").unwrap();
        assert_eq!(out, "local s = [[from-disk]]");
        std::fs::remove_dir_all(&dir).unwrap();
    }

    #[test]
    fn untouched_when_no_compiletime() {
        let src = "local x = 1\nreturn x";
        assert_eq!(process(src, "f.lua").unwrap(), src);
    }

    #[test]
    fn runtime_error_in_compiletime_fn_is_reported() {
        let err = process("compiletime(function() error('boom') end)", "f.lua").unwrap_err();
        assert_eq!(err.key, "error.processFilesFailure");
    }
}
