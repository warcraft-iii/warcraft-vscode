//! war3map.j 主函数注入（TS injectWar3mapJass 的纯文本部分，
//! compiler.ts:113-134）：CRLF 分行，main 内 InitGlobals 后插入
//! Cheat("exec-lua:war3map")，无 InitGlobals 则在 endfunction 前插入。

use crate::error::{Error, Result};

const CHEAT: &str = "    call Cheat(\"exec-lua:war3map\")";

pub fn inject_cheat(jass: &str) -> Result<String> {
    let mut lines: Vec<String> = jass.split("\r\n").map(|s| s.to_string()).collect();
    let mut in_main = false;
    let mut done = false;
    let mut i = 0;
    while i < lines.len() {
        let line = lines[i].clone();
        if line.contains("function main takes nothing returns nothing") {
            in_main = true;
        }
        if in_main && (line.contains("call InitGlobals()") || line.contains("call InitGlobals(  )"))
        {
            lines.splice(
                i..=i,
                ["    call InitGlobals()".to_string(), CHEAT.to_string()],
            );
            done = true;
            break;
        }
        if in_main && line.contains("endfunction") {
            lines.splice(i..=i, [CHEAT.to_string(), "endfunction".to_string()]);
            done = true;
            break;
        }
        i += 1;
    }
    if !in_main || !done {
        return Err(Error::new(
            "error.noMapScriptFileMain",
            "Not found: main function in War3map.j file",
        ));
    }
    Ok(lines.join("\r\n"))
}

#[cfg(test)]
mod tests {
    use super::*;

    const J: &str = "globals\r\nendglobals\r\n\r\nfunction main takes nothing returns nothing\r\n    call InitGlobals()\r\n    call X()\r\nendfunction\r\n";

    #[test]
    fn injects_after_init_globals() {
        let out = inject_cheat(J).unwrap();
        assert!(out.contains(
            "    call InitGlobals()\r\n    call Cheat(\"exec-lua:war3map\")\r\n    call X()"
        ));
    }

    #[test]
    fn injects_before_endfunction_when_no_init_globals() {
        let j = "function main takes nothing returns nothing\r\n    call X()\r\nendfunction";
        let out = inject_cheat(j).unwrap();
        assert!(out.contains("    call X()\r\n    call Cheat(\"exec-lua:war3map\")\r\nendfunction"));
    }

    #[test]
    fn errors_without_main() {
        let err =
            inject_cheat("function foo takes nothing returns nothing\r\nendfunction").unwrap_err();
        assert_eq!(err.key, "error.noMapScriptFileMain");
    }

    #[test]
    fn does_not_touch_init_globals_outside_main() {
        let j = "function setup takes nothing returns nothing\r\n    call InitGlobals()\r\nendfunction\r\nfunction main takes nothing returns nothing\r\n    call InitGlobals()\r\nendfunction";
        let out = inject_cheat(j).unwrap();
        let first = out.find("call Cheat").unwrap();
        assert!(first > out.find("function main").unwrap());
        assert_eq!(out.matches("call Cheat").count(), 1);
    }

    #[test]
    fn matches_golden_war3map_j() {
        // 黄金对照：fixture war3map.j 经注入应与 TS 产物字节一致
        let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../..");
        let src = std::fs::read_to_string(root.join("testdata/fixtures/basic/war3map.j")).unwrap();
        let golden =
            std::fs::read_to_string(root.join("testdata/golden/basic/debug-classic/war3map.j"))
                .unwrap();
        assert_eq!(inject_cheat(&src).unwrap(), golden);
    }
}
