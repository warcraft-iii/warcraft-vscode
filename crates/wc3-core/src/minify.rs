//! token 级 Lua minify，替代 TS luamin（计划偏差 DV3）：仅去注释/空白，
//! 不重命名局部变量。语义等价是契约；与 luamin 字节级一致不是目标
//! （release 四象限 golden 对比为语义对比，Task 15 使用本模块做
//! 逐文件 minify 与整包输出 minify）。
//!
//! 实现：`full_moon::parse` 取得 Ast（顺带语法校验，非法源报错），经
//! `full_moon::node::Node::tokens()` 迭代 TokenReference，只取核心
//! `token()`（空白/注释/shebang 在 full-moon 1.2.0 中均为 trivia，挂在
//! TokenReference 的 leading/trailing 上，核心 token 永远不是这些 kind，
//! 取核心即自动剔除；防御性仍按 TokenKind 过滤）。
//!
//! 注意：派生的 `Node::tokens()` 按结构体字段声明序产出，含 ContainedSpan
//! 的节点（如 `FunctionArgs::Parentheses` 的括号对先于实参）并非源序——
//! 红阶段实测 `f(a,b)` 产出 `f()a,b`。故收集后按 token 起始字节位置排序
//! 还原源序（AST 覆盖每个非 trivia token 恰一次，位置互异）。
//! token 文本经 `Token: Display` 还原（structs.rs:437-466，字符串保留
//! 原引号/长括号层级）。拼接时仅在直接相邻会改变词法处补一个空格
//! （见 [`needs_space`]）。

use full_moon::node::Node;
use full_moon::tokenizer::TokenKind;

use crate::error::{Error, Result};

fn is_word_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

/// prev 尾字符与 next 首字符直接相邻是否会改变词法，需要补空格：
/// - 词字符 + 词字符：`and b`、`return x`（标识符/关键字/数字粘连）；
/// - `-` + `-`：拼成行注释 `--`；
/// - 数字 + `.`：`1 ..` 拼成 `1..` 会被吞进数字字面量（保守保留）；
/// - `.` + `.`：`..`/`...` 歧义（如 `1. .. x`）；
/// - `[` + `[`/`=`：`t[ [[s]] ]` 拼成 `[[[s]]` 会开长括号串（`[=` 同防
///   `[=[`）。`]` + `]` 无歧义——长括号只由 `[` 开启，`]]` 恒为两个右括号。
fn needs_space(prev: &str, next: &str) -> bool {
    let (Some(a), Some(b)) = (prev.chars().last(), next.chars().next()) else {
        return false;
    };
    if is_word_char(a) && is_word_char(b) {
        return true;
    }
    if a == '-' && b == '-' {
        return true;
    }
    if a.is_ascii_digit() && b == '.' {
        return true;
    }
    if a == '.' && b == '.' {
        return true;
    }
    if a == '[' && (b == '[' || b == '=') {
        return true; // '[' + 长括号串拼接会改变词法
    }
    false
}

/// token 级 minify：去注释/空白，必要处补单空格；不重命名（DV3）。
/// 非法 Lua 源返回 Err（error.processFilesFailure，与 comptime 的 parse 报错对齐）。
pub fn minify(source: &str) -> Result<String> {
    let ast = full_moon::parse(source).map_err(|errors| {
        let msg = errors
            .iter()
            .map(|e| e.to_string())
            .collect::<Vec<_>>()
            .join("; ");
        Error::new("error.processFilesFailure", format!("minify: {msg}"))
    })?;
    let mut tokens: Vec<_> = ast
        .tokens()
        .map(|tok| tok.token())
        .filter(|token| {
            !matches!(
                token.token_kind(),
                TokenKind::Eof
                    | TokenKind::Whitespace
                    | TokenKind::SingleLineComment
                    | TokenKind::MultiLineComment
                    | TokenKind::Shebang
            )
        })
        .collect();
    // 还原源序（见模块顶部说明：字段声明序 ≠ 源序）。
    tokens.sort_by_key(|token| token.start_position().bytes());
    let mut out = String::with_capacity(source.len());
    for token in tokens {
        let text = token.to_string();
        if needs_space(&out, &text) {
            out.push(' ');
        }
        out.push_str(&text);
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn strips_comments_and_whitespace() {
        let out = minify("-- comment\nlocal x = 1  +  2\n--[[ block ]]\nreturn x\n").unwrap();
        assert_eq!(out, "local x=1+2 return x");
    }

    #[test]
    fn preserves_word_boundaries_and_strings() {
        let out = minify("local function f(a, b)\n    return a and b\nend\nreturn f(1, 2), 'a  b'")
            .unwrap();
        assert_eq!(
            out,
            "local function f(a,b)return a and b end return f(1,2),'a  b'"
        );
    }

    #[test]
    fn keeps_ambiguous_minus_apart() {
        let out = minify("local a = 1 - -2").unwrap();
        assert_eq!(out, "local a=1- -2");
    }

    #[test]
    fn long_bracket_adjacency_is_safe() {
        // t[ [[s]] ]：去空白后 '[' 与 '[[s]]' 直接拼接会变长括号——必须保空格
        let out = minify("local t = { }\nlocal v = t[ [[s]] ]").unwrap();
        assert!(out.contains("[ [[s]]"), "{out}");
        // 关闭括号拼接无歧义
        let out2 = minify("local u = { [1] = { 2 } }").unwrap();
        assert_eq!(out2, "local u={[1]={2}}");
    }

    #[test]
    fn output_still_parses_and_means_the_same() {
        let src = "local function add(a, b)\n    -- doc\n    return a + b\nend\nreturn add(40, 2)";
        let min = minify(src).unwrap();
        let lua = mlua::Lua::new();
        let orig: i64 = lua.load(src).eval().unwrap();
        let mined: i64 = lua.load(&min).eval().unwrap();
        assert_eq!(orig, mined);
        assert_eq!(mined, 42);
    }

    #[test]
    fn rejects_invalid_source() {
        assert!(minify("local = =").is_err());
    }
}
