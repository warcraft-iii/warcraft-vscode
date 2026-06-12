//! Lua 模板渲染，移植自 TS src/templates/{debug,release}/{main,file}.lua
//! （underscore-template-loader，自定义分隔符）。
//! 资产文件 assets/main-{debug,release}.lua 为 TS 模板的逐字节副本，
//! 仅将模板块替换为 %MARKER% 字符串；渲染即字符串替换。

const MAIN_DEBUG: &str = include_str!("../assets/main-debug.lua");
const MAIN_RELEASE: &str = include_str!("../assets/main-release.lua");

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Kind {
    Debug,
    Release,
}

/// TS templates/debug/file.lua：P['name'] = [eq[body]eq]
pub fn render_debug_file(name: &str, body: &str) -> String {
    let eq = crate::luastr::comment_equal(body);
    format!("P['{name}'] = [{eq}[{body}]{eq}]")
}

/// TS templates/release/file.lua：P['name'] = function(_ENV, ...) body end
pub fn render_release_file(name: &str, body: &str) -> String {
    format!("P['{name}'] = function(_ENV, ...)\n{body}\nend")
}

/// TS templates/*/main.lua：classic 控制 5 组注释开关（3 NC + 2 C）。
pub fn render_main(kind: Kind, code: &str, package_path: &[String], classic: bool) -> String {
    let tpl = match kind {
        Kind::Debug => MAIN_DEBUG,
        Kind::Release => MAIN_RELEASE,
    };
    let (nc_open, nc_close) = if classic {
        ("", "")
    } else {
        ("--[==[", "]==]--")
    };
    let (c_open, c_close) = if classic {
        ("--[==[", "]==]--")
    } else {
        ("", "")
    };
    tpl.replace("%PACKAGE_PATH%", &package_path.join(";"))
        .replace("%NC_OPEN%", nc_open)
        .replace("%NC_CLOSE%", nc_close)
        .replace("%C_OPEN%", c_open)
        .replace("%C_CLOSE%", c_close)
        .replace("%CODE%", code)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn debug_file_entry() {
        assert_eq!(
            render_debug_file("lib/util.lua", "return 1"),
            "P['lib/util.lua'] = [[return 1]]"
        );
        // body 含 ]] 时提升括号层级（层级由 body 经 comment_equal 计算，与 TS genFile 一致）
        assert_eq!(
            render_debug_file("a.lua", "s=']]'"),
            "P['a.lua'] = [=[s=']]']=]"
        );
    }

    #[test]
    fn release_file_entry() {
        assert_eq!(
            render_release_file("main.lua", "return 1"),
            "P['main.lua'] = function(_ENV, ...)\nreturn 1\nend"
        );
    }

    #[test]
    fn main_markers_replaced_and_gated() {
        let classic = render_main(Kind::Debug, "__CODE__", &["./?.lua".into()], true);
        assert!(classic.contains("__CODE__"));
        assert!(classic.contains("package.path = './?.lua'"));
        let reforge = render_main(
            Kind::Debug,
            "__CODE__",
            &["./?.lua".into(), "./?/init.lua".into()],
            false,
        );
        assert!(reforge.contains("package.path = './?.lua;./?/init.lua'"));
        for m in [
            "%PACKAGE_PATH%",
            "%NC_OPEN%",
            "%NC_CLOSE%",
            "%C_OPEN%",
            "%C_CLOSE%",
            "%CODE%",
        ] {
            assert!(!classic.contains(m), "marker {m} must be replaced");
            assert!(!reforge.contains(m), "marker {m} must be replaced");
        }
        assert_ne!(classic, reforge);
        // 5 组开关：3 组 NC + 2 组 C，分属两种配置
        let count = |s: &str| s.matches("--[==[").count();
        assert_eq!(count(&classic), 2, "classic 注释掉 2 组 C 块");
        assert_eq!(count(&reforge), 3, "reforge 注释掉 3 组 NC 块");
        // Release 与 Debug 共用同一套标记机制，仅 preload 块不同
        let release = render_main(Kind::Release, "X", &["./?.lua".into()], false);
        assert!(release.contains("preloadType = 'function'"));
        assert!(reforge.contains("preloadType = 'string'"));
    }

    /// 黄金骨架字节对照：golden = prefix + 真实code + suffix，
    /// 用 %CODE% 切分渲染骨架，golden 必须以 prefix 开头、以 suffix 结尾。
    /// 这把模板缝隙的每个字节（含空标记行的残留缩进、结尾换行）现在就钉死，
    /// 避免 Task 17 大海捞针式校准。
    #[test]
    fn golden_skeleton_matches_ts_bytes() {
        /// 首个不一致字节的偏移与上下文，便于定位缝隙问题。
        fn first_mismatch(a: &[u8], b: &[u8]) -> String {
            let pos = a
                .iter()
                .zip(b.iter())
                .position(|(x, y)| x != y)
                .unwrap_or(a.len().min(b.len()));
            let ctx = |s: &[u8]| {
                let lo = pos.saturating_sub(40);
                let hi = (pos + 10).min(s.len());
                String::from_utf8_lossy(&s[lo..hi]).into_owned()
            };
            format!(
                "first mismatch at byte {pos}: golden {:?} vs rendered {:?}",
                ctx(a),
                ctx(b)
            )
        }

        let root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../..");
        let paths = vec!["./?.lua".to_string(), "./?/init.lua".to_string()];
        for (quad, classic) in [("debug-reforge", false), ("debug-classic", true)] {
            let golden = std::fs::read_to_string(
                root.join("testdata/golden/basic")
                    .join(quad)
                    .join("war3map.lua"),
            )
            .unwrap();
            let skeleton = render_main(Kind::Debug, "%CODE-SPLIT%", &paths, classic);
            let (prefix, suffix) = skeleton.split_once("%CODE-SPLIT%").unwrap();
            assert!(
                golden.starts_with(prefix),
                "{quad}: 模板前缀与黄金不一致（{}）",
                first_mismatch(golden.as_bytes(), prefix.as_bytes())
            );
            let golden_tail = &golden.as_bytes()[golden.len().saturating_sub(suffix.len())..];
            assert!(
                golden.ends_with(suffix),
                "{quad}: 模板后缀与黄金不一致（{}）",
                first_mismatch(golden_tail, suffix.as_bytes())
            );
        }
    }
}
