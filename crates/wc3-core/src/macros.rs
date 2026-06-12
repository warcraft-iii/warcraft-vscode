//! 注释宏处理，移植自 TS compiler.ts BaseCompiler.processCodeMacros。
//! accepts 解注释（启用块），ignores 注释化（禁用块），EQ 每 key 重算导致括号层级逐级升级。

use crate::luastr::comment_equal;

/// release/classic 标志 → (accepts, ignores) key 集（顺序与 TS push 顺序一致）。
fn macro_keys(release: bool, classic: bool) -> (Vec<&'static str>, Vec<&'static str>) {
    let mut ignores = vec!["remove"];
    let mut accepts = vec![];
    if release {
        ignores.extend(["debug", "non-release"]);
        accepts.extend(["release", "non-debug"]);
    } else {
        ignores.extend(["release", "non-debug"]);
        accepts.extend(["debug", "non-release"]);
    }
    if classic {
        ignores.extend(["reforge", "non-classic"]);
        accepts.extend(["classic", "non-reforge"]);
    } else {
        ignores.extend(["classic", "non-reforge"]);
        accepts.extend(["reforge", "non-classic"]);
    }
    (accepts, ignores)
}

/// TS BaseCompiler.processCodeMacros：accepts 先解注释，ignores 逐 key 注释化（EQ 每 key 重算）。
pub fn process_code_macros(code: &str, release: bool, classic: bool) -> String {
    let (accepts, ignores) = macro_keys(release, classic);
    let mut code = code.trim_end().to_string();

    for key in accepts {
        let open = regex::Regex::new(&format!(r"(?m)--\[=*\[@{key}@")).unwrap();
        code = open.replace_all(&code, format!("--@{key}@")).into_owned();
        let close = regex::Regex::new(&format!(r"(?m)--\s*@end-{key}@\]=*\]")).unwrap();
        code = close
            .replace_all(&code, format!("--@end-{key}@"))
            .into_owned();
    }

    for key in ignores {
        let eq = comment_equal(&code); // 与 TS 一致：每个 key 处理前重算
        let open = regex::Regex::new(&format!(r"(?m)--\s*@{key}@")).unwrap();
        code = open
            .replace_all(&code, format!("--[{eq}[@{key}@"))
            .into_owned();
        let close = regex::Regex::new(&format!(r"(?m)--\s*@end-{key}@\s*$")).unwrap();
        code = close
            .replace_all(&code, format!("--@end-{key}@]{eq}]"))
            .into_owned();
    }

    code
}

#[cfg(test)]
mod tests {
    use super::*;

    const SRC: &str = "a()\n--@debug@\nd()\n--@end-debug@\n--@release@\nr()\n--@end-release@\n--@remove@\nx()\n--@end-remove@\n";

    #[test]
    fn debug_reforge_comments_out_release_and_remove() {
        let out = process_code_macros(SRC, false, false);
        assert!(
            out.contains("--@debug@\nd()\n--@end-debug@"),
            "debug 区保持启用"
        );
        assert!(out.contains("--[[@remove@"), "remove 先注释化，层级 [[");
        assert!(out.contains("--@end-remove@]]"));
        assert!(
            out.contains("--[=[@release@"),
            "release 第二个注释化，层级因 remove 升为 [=["
        );
        assert!(out.contains("--@end-release@]=]"));
        assert!(!out.ends_with('\n'), "trimEnd 语义");
    }

    #[test]
    fn release_uncomments_previously_disabled_block() {
        let src = "--[[@release@\nr()\n--@end-release@]]";
        let out = process_code_macros(src, true, false);
        assert!(out.contains("--@release@\nr()\n--@end-release@"));
        assert!(!out.contains("--[[@release@"));
    }

    #[test]
    fn nested_brackets_bump_comment_level() {
        // TS 真相：remove 是第一个 ignore key 但源中无匹配；处理 release 时
        // comment_equal 因 [[str]] 已占 0 级而返回 "="，故 release 直接用 [=[。
        let src = "s = [[str]]\n--@release@\nr()\n--@end-release@";
        let out = process_code_macros(src, false, false);
        assert!(
            out.contains("--[=[@release@"),
            "源中已有 [[ ]]，release 注释化层级为 [=["
        );
        assert!(out.contains("--@end-release@]=]"));
    }

    #[test]
    fn escalation_matches_golden_order() {
        // 全 8 组宏 + remove，复刻 basic fixture 的逐级升级行为
        let src = "--@debug@\na\n--@end-debug@\n--@release@\nb\n--@end-release@\n--@non-debug@\nc\n--@end-non-debug@\n--@non-release@\nd\n--@end-non-release@\n--@classic@\ne\n--@end-classic@\n--@reforge@\nf\n--@end-reforge@\n--@non-classic@\ng\n--@end-non-classic@\n--@non-reforge@\nh\n--@end-non-reforge@\n--@remove@\ni\n--@end-remove@";
        let out = process_code_macros(src, false, false);
        assert!(out.contains("--[[@remove@"));
        assert!(out.contains("--[=[@release@"));
        assert!(out.contains("--[==[@non-debug@"));
        assert!(out.contains("--[===[@classic@"));
        assert!(out.contains("--[====[@non-reforge@"));
        // accepts 保持原样
        assert!(out.contains("--@debug@\na\n--@end-debug@"));
        assert!(out.contains("--@non-release@\nd\n--@end-non-release@"));
        assert!(out.contains("--@reforge@\nf\n--@end-reforge@"));
        assert!(out.contains("--@non-classic@\ng\n--@end-non-classic@"));
    }
}
