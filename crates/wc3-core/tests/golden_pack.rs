//! pack 黄金对照：Rust packer 产物 vs TS 管线归档（testdata/golden/basic/*-pack）。
//! 内容级比较（spec 阶段 2 §6）：debug 双侧带 (listfile) 可全集比对；
//! release 无 listfile，按 Rust packlist 名逐文件比对。
//! war3map.lua 仅存在性校验（release 的 minify 是 DV3 语义级，由 golden.rs 覆盖）。

use std::collections::BTreeSet;
use std::path::{Path, PathBuf};

use wc3_core::compiler::{compile_debug, compile_release, Tools};
use wc3_core::config::{BuildContext, BuildOptions, ProjectConfig};
use wc3_core::{mpq, packer};

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

/// fixture 复制 → compile → pack，返回 (工程目录, 产物路径, packlist)。
fn build_and_pack(release: bool) -> (PathBuf, PathBuf, Vec<packer::PackItem>) {
    static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
    let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    let src = repo_root().join("testdata/fixtures/basic");
    let dst = std::env::temp_dir().join(format!("wc3-gpack-{release}-{n}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dst);
    copy_dir(&src, &dst);
    let cfg = ProjectConfig::load(&dst).unwrap();
    let ctx = BuildContext::new(
        &dst,
        cfg,
        BuildOptions {
            release,
            ..Default::default()
        },
    );
    if release {
        compile_release(&ctx, &Tools { confuse_exe: None }).unwrap();
    } else {
        compile_debug(&ctx).unwrap();
    }
    let items = packer::generate_packlist(&ctx).unwrap();
    let out = packer::pack(&ctx).unwrap();
    (dst, out, items)
}

fn golden(quad: &str, file: &str) -> PathBuf {
    repo_root()
        .join("testdata/golden/basic")
        .join(quad)
        .join(file)
}

/// listfile → 去内部文件的名集合。
fn names_of(map: &Path) -> BTreeSet<String> {
    mpq::read_listfile(map)
        .unwrap()
        .expect("listfile required")
        .into_iter()
        .filter(|n| !n.starts_with('('))
        .collect()
}

#[test]
fn pack_debug_reforge_matches_golden() {
    let (root, ours, items) = build_and_pack(false);
    let theirs = golden("debug-reforge-pack", "_warcraft_vscode_test");
    let ours_names = names_of(&ours);
    let theirs_names = names_of(&theirs);
    assert_eq!(ours_names, theirs_names, "归档文件名集合一致");
    let expect: BTreeSet<String> = items.into_iter().map(|(n, _)| n).collect();
    assert_eq!(ours_names, expect, "归档与 packlist 一致");
    for name in &ours_names {
        let our_bytes = mpq::extract_file(&ours, name).unwrap().unwrap();
        let their_bytes = mpq::extract_file(&theirs, name).unwrap().unwrap();
        assert_eq!(our_bytes, their_bytes, "{name} 字节一致");
    }
    std::fs::remove_dir_all(&root).unwrap();
}

#[test]
fn pack_release_reforge_matches_golden() {
    let (root, ours, items) = build_and_pack(true);
    let theirs = golden("release-reforge-pack", "release");
    assert_eq!(
        mpq::read_listfile(&ours).unwrap(),
        None,
        "release 无 listfile（TS 无 -f）"
    );
    assert_eq!(mpq::read_listfile(&theirs).unwrap(), None);
    for (name, _) in &items {
        if name == "war3map.lua" {
            // DV3：minify 字节不可比，存在性即可；语义对照见 golden.rs
            assert!(mpq::extract_file(&theirs, name).unwrap().is_some());
            continue;
        }
        let our_bytes = mpq::extract_file(&ours, name).unwrap().unwrap();
        let their_bytes = mpq::extract_file(&theirs, name)
            .unwrap()
            .unwrap_or_else(|| panic!("{name} 应存在于 TS 归档"));
        assert_eq!(our_bytes, their_bytes, "{name} 字节一致");
    }
    std::fs::remove_dir_all(&root).unwrap();
}
