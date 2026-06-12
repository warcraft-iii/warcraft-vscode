//! Lua 字面量辅助函数，移植自 TS compiler.ts 的静态方法
//! （getCommentEqual/toLuaString/isValidWord/makeLuaKey/toLua）。

use std::collections::{BTreeMap, HashSet};

/// TS getCommentEqual：扫描 [=*[ 与 ]=*]，返回第一个未被占用的等号层级。
pub fn comment_equal(code: &str) -> String {
    let re = regex::Regex::new(r"\[(=*)\[|\](=*)\]").unwrap();
    let mut exists: HashSet<usize> = HashSet::new();
    for m in re.find_iter(code) {
        exists.insert(m.as_str().len() - 2);
    }
    let mut level = 0;
    while exists.contains(&level) {
        level += 1;
    }
    "=".repeat(level)
}

/// TS toLuaString。
pub fn to_lua_string(s: &str) -> String {
    let eq = comment_equal(s);
    format!("[{eq}[{s}]{eq}]")
}

fn is_valid_word(s: &str) -> bool {
    let mut chars = s.chars();
    match chars.next() {
        Some(c) if c.is_ascii_alphabetic() || c == '_' => {}
        _ => return false,
    }
    chars.all(|c| c.is_ascii_alphanumeric() || c == '_')
}

/// TS makeLuaKey：parseInt(s).toString() == s 判定整数键；否则合法单词原样；否则单引号包裹（仅转义首个引号，与 TS replace 一致）。
pub fn make_lua_key(s: &str) -> String {
    if s.parse::<i64>()
        .map(|n| n.to_string() == s)
        .unwrap_or(false)
    {
        format!("[{s}]")
    } else if is_valid_word(s) {
        s.to_string()
    } else {
        format!("['{}']", s.replacen('\'', "\\'", 1))
    }
}

/// TS toLua（非 pretty 路径）；表键序按 DV1 确定性化：数组部分在前，整数键升序，字符串键字典序。
pub fn to_lua(value: &mlua::Value) -> String {
    match value {
        mlua::Value::Nil => "nil".into(),
        mlua::Value::Boolean(b) => b.to_string(),
        mlua::Value::Integer(i) => i.to_string(),
        mlua::Value::Number(n) => {
            // 对齐 JS Number.prototype.toString：整数值不带小数点
            if n.fract() == 0.0 && n.is_finite() && n.abs() < 9.007_199_254_740_992e15 {
                format!("{}", *n as i64)
            } else {
                n.to_string()
            }
        }
        mlua::Value::String(s) => to_lua_string(&s.to_string_lossy()),
        mlua::Value::Table(t) => {
            let mut parts: Vec<String> = Vec::new();
            let len = t.raw_len();
            for i in 1..=len {
                let v: mlua::Value = t.raw_get(i).unwrap_or(mlua::Value::Nil);
                parts.push(to_lua(&v));
            }
            let mut int_keys: BTreeMap<i64, mlua::Value> = BTreeMap::new();
            let mut str_keys: BTreeMap<String, mlua::Value> = BTreeMap::new();
            for pair in t.clone().pairs::<mlua::Value, mlua::Value>() {
                let Ok((k, v)) = pair else { continue };
                match &k {
                    mlua::Value::Integer(i) if *i >= 1 && (*i as usize) <= len => {}
                    mlua::Value::Integer(i) => {
                        int_keys.insert(*i, v);
                    }
                    mlua::Value::String(s) => {
                        str_keys.insert(s.to_string_lossy().to_string(), v);
                    }
                    _ => {}
                }
            }
            for (k, v) in int_keys {
                parts.push(format!("{}={}", make_lua_key(&k.to_string()), to_lua(&v)));
            }
            for (k, v) in str_keys {
                parts.push(format!("{}={}", make_lua_key(&k), to_lua(&v)));
            }
            format!("{{{}}}", parts.join(","))
        }
        _ => "nil".into(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn comment_equal_picks_first_free_level() {
        assert_eq!(comment_equal("no brackets"), "");
        assert_eq!(comment_equal("x = [[s]]"), "=");
        assert_eq!(comment_equal("a [[b]] c [=[d]=]"), "==");
        assert_eq!(comment_equal("a [=[b]=]"), ""); // 0 级未被占用
    }

    #[test]
    fn to_lua_string_wraps_with_free_level() {
        assert_eq!(to_lua_string("plain"), "[[plain]]");
        assert_eq!(to_lua_string("has ]] inside"), "[=[has ]] inside]=]");
    }

    #[test]
    fn make_lua_key_rules() {
        assert_eq!(make_lua_key("3"), "[3]");
        assert_eq!(make_lua_key("name"), "name");
        assert_eq!(make_lua_key("_ok2"), "_ok2");
        assert_eq!(make_lua_key("2x"), "['2x']");
        assert_eq!(make_lua_key("a-b"), "['a-b']");
    }

    #[test]
    fn to_lua_serializes_values_deterministically() {
        let lua = mlua::Lua::new();
        let v: mlua::Value = lua
            .load("return { name = 'wc3', count = 3, list = { 'a', 'b' }, flag = true }")
            .eval()
            .unwrap();
        assert_eq!(
            to_lua(&v),
            "{count=3,flag=true,list={[[a]],[[b]]},name=[[wc3]]}"
        );
        let s: mlua::Value = lua.load("return 'hello ]] world'").eval().unwrap();
        assert_eq!(to_lua(&s), "[=[hello ]] world]=]");
        let n: mlua::Value = lua.load("return 42").eval().unwrap();
        assert_eq!(to_lua(&n), "42");
        let f: mlua::Value = lua.load("return -0.5").eval().unwrap();
        assert_eq!(to_lua(&f), "-0.5");
        let nil: mlua::Value = lua.load("return nil").eval().unwrap();
        assert_eq!(to_lua(&nil), "nil");
        let multi: mlua::Value = lua.load("return 1.0").eval().unwrap();
        assert_eq!(
            to_lua(&multi),
            "1",
            "JS Number.toString parity: 1.0 prints as 1"
        );
    }
}
