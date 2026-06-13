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
//! Node::tokens() 由 derive 对每个字段穷举生成（full_moon_derive，full_range
//! 仅影响 range()），故无 token 会被遗漏；Ast 的 eof token 不在 nodes() 内
//! （其文本为空，无影响）。
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
/// - 数字字面量 token + `.`/词字符开头：`1. and` 拼成 `1.and`、`0xff ..`
///   拼成 `0xff..`（Lua ≥5.2 数字读取器在十六进制里也吞 `.`）都成非法
///   数字——按 token 种类判定，不依赖尾字符（`1.` 尾是 `.`、`0xff` 尾是
///   字母，纯字符规则覆盖不到）；
/// - 词字符 + 词字符：`and b`、`return x`（标识符/关键字/数字粘连）；
/// - `-` + `-`：拼成行注释 `--`；
/// - 数字 + `.`：`1 ..` 拼成 `1..` 会被吞进数字字面量（保守保留）；
/// - `.` + `.`：`..`/`...` 歧义（如 `1. .. x`）；
/// - `[` + `[`/`=`：`t[ [[s]] ]` 拼成 `[[[s]]` 会开长括号串（`[=` 同防
///   `[=[`）。`]` + `]` 无歧义——长括号只由 `[` 开启，`]]` 恒为两个右括号。
///
/// 后五条字符级规则与首条 token 级规则有重叠，保留无害（多余单空格
/// 不改变词法），不删。
fn needs_space(prev_kind: Option<TokenKind>, prev_last: Option<char>, next: &str) -> bool {
    let (Some(a), Some(b)) = (prev_last, next.chars().next()) else {
        return false;
    };
    if prev_kind == Some(TokenKind::Number) && (b == '.' || is_word_char(b)) {
        return true;
    }
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
        // 尝试从 full-moon 错误消息提取行号（格式 "starting from line X, character Y"）
        let line = errors.first().and_then(|e| {
            let s = e.to_string();
            s.find("line ").and_then(|i| {
                s[i + 5..]
                    .split(|c: char| !c.is_ascii_digit())
                    .next()
                    .and_then(|n| n.parse::<u32>().ok())
            })
        });
        let mut err = Error::new("error.processFilesFailure", format!("minify: {msg}"));
        err.line = line;
        err
    })?;
    // 反向迭代规避 full-moon Tokens::next() 的 remove(0) O(n²)（node.rs:84）；随后按字节位置排序恢复源序。
    let mut tokens: Vec<_> = ast
        .tokens()
        .rev()
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
    let mut prev_kind: Option<TokenKind> = None;
    let mut last_char: Option<char> = None;
    for token in tokens {
        let text = token.to_string();
        if needs_space(prev_kind, last_char, &text) {
            out.push(' ');
        }
        out.push_str(&text);
        prev_kind = Some(token.token_kind());
        last_char = text.chars().next_back().or(last_char);
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
    fn number_token_boundaries_stay_lexable() {
        let cases = [
            "local x = 1. and 2\nreturn x",
            "if 2 > 1. then return 'big' end",
            "return 0xff .. 'x'",
            "return 1 .. '2'",
            "return 2.5e-1 and 1",
            "return 0x1p+4 and 1",
        ];
        let lua = mlua::Lua::new();
        for src in cases {
            let min = minify(src).unwrap();
            // 语义等价：原文与压缩文求值结果一致
            let a: mlua::Value = lua.load(src).eval().unwrap();
            let b: mlua::Value = lua.load(&min).eval().unwrap();
            assert_eq!(format!("{a:?}"), format!("{b:?}"), "case: {src} -> {min}");
        }
    }

    #[test]
    fn semicolons_and_shebang() {
        assert_eq!(
            minify("local x = 1; return x").unwrap(),
            "local x=1;return x"
        );
        let out = minify("#!/usr/bin/lua\nreturn 1").unwrap();
        assert_eq!(out, "return 1", "shebang 作为首 token 前导 trivia 被丢弃");
    }

    #[test]
    fn rejects_invalid_source() {
        assert!(minify("local = =").is_err());
    }
}
