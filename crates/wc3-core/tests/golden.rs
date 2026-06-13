//! 四象限黄金对照：Rust 管线产物 vs TS 管线存档（testdata/golden）。
//! 对照规则见 docs/superpowers/specs/2026-06-12-rust-core-split-design.md §5
//! 与计划 DV1-DV7。debug-basic 两象限字节级；其余语义级（mlua 沙箱执行对比 RESULT）。

use std::path::{Path, PathBuf};

use wc3_core::compiler::{compile_debug, compile_release, Tools};
use wc3_core::config::{BuildContext, BuildOptions, ProjectConfig};

const NO_TOOLS: Tools<'static> = Tools { confuse_exe: None };

fn repo_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("../..")
        .canonicalize()
        .unwrap()
}

fn copy_dir(src: &Path, dst: &Path) {
    std::fs::create_dir_all(dst).unwrap();
    for e in std::fs::read_dir(src).unwrap() {
        let e = e.unwrap();
        let to = dst.join(e.file_name());
        if e.file_type().unwrap().is_dir() {
            copy_dir(&e.path(), &to);
        } else {
            std::fs::copy(e.path(), &to).unwrap();
        }
    }
}

/// fixture 复制到临时目录构建，避免污染 testdata。
fn build(fixture: &str, release: bool, classic: bool) -> PathBuf {
    static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
    let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    let src = repo_root().join("testdata/fixtures").join(fixture);
    let dst = std::env::temp_dir().join(format!("wc3-golden-{fixture}-{n}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dst);
    copy_dir(&src, &dst);
    let cfg = ProjectConfig::load(&dst).unwrap();
    let ctx = BuildContext::new(
        &dst,
        cfg,
        BuildOptions {
            release,
            classic,
            ..Default::default()
        },
    );
    if release {
        compile_release(&ctx, &NO_TOOLS).unwrap();
    } else {
        compile_debug(&ctx).unwrap();
    }
    dst
}

fn golden(fixture: &str, quad: &str, file: &str) -> String {
    let p = repo_root()
        .join("testdata/golden")
        .join(fixture)
        .join(quad)
        .join(file);
    std::fs::read_to_string(&p).unwrap_or_else(|e| panic!("{}: {e}", p.display()))
}

/// 干净沙箱执行 war3map.lua；reforge 需手动调 main()，classic 加载即自跑。
/// 返回 to_lua(RESULT) 规范化串。
fn exec_result(code: &str, classic: bool) -> String {
    let lua = mlua::Lua::new();
    lua.load(code).exec().unwrap();
    if !classic {
        let main: mlua::Function = lua.globals().get("main").unwrap();
        main.call::<()>(()).unwrap();
    }
    let result: mlua::Value = lua.globals().get("RESULT").unwrap();
    wc3_core::luastr::to_lua(&result).unwrap()
}

fn first_diff(a: &str, b: &str) -> String {
    let pos = a
        .bytes()
        .zip(b.bytes())
        .position(|(x, y)| x != y)
        .unwrap_or(a.len().min(b.len()));
    let ctx = |s: &str| {
        let lo = pos.saturating_sub(60);
        let hi = (pos + 60).min(s.len());
        // 避开 UTF-8 边界
        let lo = (lo..=pos).find(|i| s.is_char_boundary(*i)).unwrap_or(pos);
        let hi = (pos..=hi)
            .rev()
            .find(|i| s.is_char_boundary(*i))
            .unwrap_or(pos);
        s[lo..hi].to_string()
    };
    format!(
        "first diff at byte {pos}:\n  ours:   {:?}\n  golden: {:?}",
        ctx(a),
        ctx(b)
    )
}

#[test]
fn basic_debug_quadrants_byte_identical() {
    for classic in [false, true] {
        let quad = if classic {
            "debug-classic"
        } else {
            "debug-reforge"
        };
        let out_dir = build("basic", false, classic);
        let ours = std::fs::read_to_string(out_dir.join(".build/war3map.lua")).unwrap();
        let gold = golden("basic", quad, "war3map.lua");
        assert!(
            ours == gold,
            "{quad} war3map.lua 必须字节一致\n{}",
            first_diff(&ours, &gold)
        );
        if classic {
            let j = std::fs::read_to_string(out_dir.join(".build/war3map.j")).unwrap();
            let jg = golden("basic", quad, "war3map.j");
            assert!(
                j == jg,
                "{quad} war3map.j 必须字节一致\n{}",
                first_diff(&j, &jg)
            );
        }
        std::fs::remove_dir_all(&out_dir).unwrap();
    }
}

#[test]
fn semantic_quadrants_match_golden() {
    let cases: &[(&str, bool, bool, &str)] = &[
        ("basic", true, false, "mode=[[common]]"),
        ("basic", true, true, "mode=[[common]]"),
        ("comptime", false, false, "num=42"),
        ("comptime", false, true, "num=42"),
        ("comptime", true, false, "num=42"),
        ("comptime", true, true, "num=42"),
    ];
    for (fixture, release, classic, sentinel) in cases {
        let quad = format!(
            "{}-{}",
            if *release { "release" } else { "debug" },
            if *classic { "classic" } else { "reforge" }
        );
        let out_dir = build(fixture, *release, *classic);
        let ours_src = std::fs::read_to_string(out_dir.join(".build/war3map.lua")).unwrap();
        let golden_src = golden(fixture, &quad, "war3map.lua");
        let ours = exec_result(&ours_src, *classic);
        let theirs = exec_result(&golden_src, *classic);
        assert_eq!(ours, theirs, "{fixture}/{quad} RESULT 语义必须一致");
        assert!(
            ours.contains(sentinel),
            "{fixture}/{quad} 哨兵缺失（防 xpcall 吞错导致的空跑假阳性）: {ours}"
        );
        std::fs::remove_dir_all(&out_dir).unwrap();
    }
}
