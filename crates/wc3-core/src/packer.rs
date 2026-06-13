//! TS Packer 移植（src/app/packer/packer.ts）：packlist 生成与 MPQ 打包。
//! 顺序/去重语义复刻 TS（spec 阶段 2 §4.1-§4.2，偏差 DV8/DV10/DV11）。

use std::collections::HashSet;
use std::path::{Path, PathBuf};

use crate::config::BuildContext;
use crate::error::{Error, Result};
use crate::{fsutil, mpq};

/// (归档内相对名（`\` 分隔）, 源文件绝对路径)
pub type PackItem = (String, PathBuf);

/// TS generatePackItems：单根目录 → 条目；root 非目录返回空。
fn pack_items_from(root: &Path, exclude_lua: bool) -> Result<Vec<PackItem>> {
    let mut items = Vec::new();
    for f in fsutil::collect_pack_files(root)? {
        if exclude_lua && fsutil::is_lua_file(&f) {
            continue;
        }
        items.push((fsutil::windows_relative(root, &f)?, f));
    }
    Ok(items)
}

/// src/lib 下一级条目名（含文件——TS readdir 同语义，文件名拼 imports 路径后自然不存在）。
/// DV11：目录缺失按空；DV5：字典序。
fn lib_names(ctx: &BuildContext) -> Result<Vec<String>> {
    let lib_dir = ctx.source_dir().join("lib");
    if !lib_dir.is_dir() {
        return Ok(Vec::new());
    }
    let mut names: Vec<String> = std::fs::read_dir(&lib_dir)
        .map_err(|e| Error::io(&lib_dir, e))?
        .filter_map(|e| e.ok())
        .map(|e| e.file_name().to_string_lossy().into_owned())
        .collect();
    names.sort();
    Ok(names)
}

/// TS Packer.generatePackList：收集 + reduceRight 去重（同名后写入者优先，结果反序）。
pub fn generate_packlist(ctx: &BuildContext) -> Result<Vec<PackItem>> {
    let mut items: Vec<PackItem> = Vec::new();

    items.extend(pack_items_from(&ctx.map_dir()?, true)?);

    let imports = [
        "imports".to_string(),
        format!(
            "imports.{}",
            if ctx.opts.release { "release" } else { "debug" }
        ),
        format!(
            "imports.{}",
            if ctx.opts.classic {
                "classic"
            } else {
                "reforge"
            }
        ),
    ];
    let libs = lib_names(ctx)?;
    for imp in &imports {
        for lib in &libs {
            items.extend(pack_items_from(
                &ctx.source_dir().join("lib").join(lib).join(imp),
                false,
            )?);
        }
        items.extend(pack_items_from(&ctx.root.join(imp), false)?);
    }

    items.extend(pack_items_from(&ctx.build_dir().join("objediting"), false)?);

    items.push(("war3map.lua".into(), ctx.build_dir().join("war3map.lua")));
    if ctx.opts.classic {
        items.push(("war3map.j".into(), ctx.build_dir().join("war3map.j")));
    }

    let mut seen: HashSet<String> = HashSet::new();
    let mut out: Vec<PackItem> = Vec::new();
    for item in items.into_iter().rev() {
        if seen.insert(item.0.clone()) {
            out.push(item);
        }
    }
    Ok(out)
}

/// TS env.outFilePath：.build/{_warcraft_vscode_test|release}<mapdir 扩展名>。
pub fn out_file_path(ctx: &BuildContext) -> Result<PathBuf> {
    let map = ctx.map_dir()?;
    let ext = map
        .extension()
        .map(|e| format!(".{}", e.to_string_lossy()))
        .unwrap_or_default();
    let name = if ctx.opts.release {
        "release"
    } else {
        "_warcraft_vscode_test"
    };
    Ok(ctx.build_dir().join(format!("{name}{ext}")))
}

/// TS Packer.execute（generatePackList + packByPackList）。返回产物路径（--output 复制用）。
pub fn pack(ctx: &BuildContext) -> Result<PathBuf> {
    let entry = ctx.build_dir().join("war3map.lua");
    if !entry.is_file() {
        return Err(Error::with_args(
            "error.notFound",
            "Not found .build/war3map.lua (run compile first)",
            vec![".build/war3map.lua (run compile first)".into()],
        ));
    }
    if ctx.opts.classic && !ctx.build_dir().join("war3map.j").is_file() {
        return Err(Error::with_args(
            "error.notFound",
            "Not found .build/war3map.j (run compile first)",
            vec![".build/war3map.j (run compile first)".into()],
        ));
    }
    let map = ctx.map_dir()?;
    if ctx.opts.classic && map.is_dir() {
        // DV10：TS 同场景为隐性崩溃，这里显式化
        return Err(Error::new(
            "error.invalidMapFile",
            "Classic version ONLY support .w3x/.w3m format map file.",
        ));
    }
    let items = generate_packlist(ctx)?;
    let out = out_file_path(ctx)?;
    if map.is_dir() {
        mpq::create_archive(&out, &items, !ctx.opts.release)?;
    } else if map.is_file() {
        std::fs::copy(&map, &out).map_err(|e| {
            Error::new(
                "error.io",
                format!("copy {} -> {}: {e}", map.display(), out.display()),
            )
        })?;
        mpq::add_files(&out, &items)?;
    } else {
        return Err(Error::new("error.noMapFolder", "Not found: map folder"));
    }
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::config::{BuildContext, BuildOptions, ProjectConfig};

    fn tempdir() -> std::path::PathBuf {
        static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
        let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let d = std::env::temp_dir().join(format!("wc3-packer-{}-{n}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }

    /// 覆盖 packlist 全部来源与同名覆盖的合成工程。
    fn synth_project() -> std::path::PathBuf {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        // map 目录：lua 排除、子目录、与 imports 同名（imports 应胜出）
        std::fs::create_dir_all(d.join("map/icons")).unwrap();
        std::fs::write(d.join("map/war3map.lua"), "lua").unwrap();
        std::fs::write(d.join("map/data.txt"), "map-data").unwrap();
        std::fs::write(d.join("map/icons/i.txt"), "icon").unwrap();
        // lib imports：common + override（root 应胜出）
        std::fs::create_dir_all(d.join("src/lib/console/imports")).unwrap();
        std::fs::write(d.join("src/lib/console/imports/common.txt"), "lib-common").unwrap();
        std::fs::write(d.join("src/lib/console/imports/override.txt"), "from-lib").unwrap();
        std::fs::create_dir_all(d.join("src/lib/console/imports.debug")).unwrap();
        std::fs::write(d.join("src/lib/console/imports.debug/libdbg.txt"), "x").unwrap();
        // 根 imports：override 同名 + data.txt 与 map 同名 + 隐藏排除
        std::fs::create_dir_all(d.join("imports")).unwrap();
        std::fs::write(d.join("imports/override.txt"), "from-root").unwrap();
        std::fs::write(d.join("imports/data.txt"), "imports-data").unwrap();
        std::fs::write(d.join("imports/.hidden.txt"), "x").unwrap();
        std::fs::create_dir_all(d.join("imports.release")).unwrap();
        std::fs::write(d.join("imports.release/rel.txt"), "x").unwrap();
        std::fs::create_dir_all(d.join("imports.reforge/sub")).unwrap();
        std::fs::write(d.join("imports.reforge/sub/rf.txt"), "x").unwrap();
        std::fs::create_dir_all(d.join("imports.classic")).unwrap();
        std::fs::write(d.join("imports.classic/cls.txt"), "x").unwrap();
        // objediting 产物
        std::fs::create_dir_all(d.join(".build/objediting")).unwrap();
        std::fs::write(d.join(".build/objediting/war3map.w3u"), "obj").unwrap();
        std::fs::write(d.join(".build/war3map.lua"), "entry").unwrap();
        std::fs::write(d.join(".build/war3map.j"), "jass").unwrap();
        d
    }

    fn ctx(root: &std::path::Path, release: bool, classic: bool) -> BuildContext {
        let cfg = ProjectConfig::load(root).unwrap();
        BuildContext::new(
            root,
            cfg,
            BuildOptions {
                release,
                classic,
                ..Default::default()
            },
        )
    }

    fn names(items: &[PackItem]) -> Vec<&str> {
        items.iter().map(|(n, _)| n.as_str()).collect()
    }

    #[test]
    fn packlist_debug_reforge_order_and_dedup() {
        let root = synth_project();
        let items = generate_packlist(&ctx(&root, false, false)).unwrap();
        // 推入序：map(data.txt, icons\i.txt) → imports(lib: common,override；root: .hidden 排除,
        // data,override) → imports.debug(lib: libdbg) → imports.reforge(sub\rf) → objediting → war3map.lua
        // reduceRight：反序 + 同名后者优先
        assert_eq!(
            names(&items),
            vec![
                "war3map.lua",
                r"war3map.w3u",
                r"sub\rf.txt",
                "libdbg.txt",
                "override.txt",
                "data.txt",
                "common.txt",
                r"icons\i.txt",
            ]
        );
        // 同名覆盖：override 取根 imports，data 取 imports
        let get = |n: &str| {
            std::fs::read_to_string(&items.iter().find(|(name, _)| name == n).unwrap().1).unwrap()
        };
        assert_eq!(get("override.txt"), "from-root");
        assert_eq!(get("data.txt"), "imports-data");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn packlist_release_classic_variant() {
        let root = synth_project();
        let items = generate_packlist(&ctx(&root, true, true)).unwrap();
        let n = names(&items);
        assert_eq!(n[0], "war3map.j", "classic 追加 war3map.j（反序后最前）");
        assert_eq!(n[1], "war3map.lua");
        assert!(n.contains(&"cls.txt"), "imports.classic 启用");
        assert!(n.contains(&"rel.txt"), "imports.release 启用");
        assert!(!n.contains(&"libdbg.txt"), "imports.debug 关闭");
        assert!(!n.contains(&r"sub\rf.txt"), "imports.reforge 关闭");
        // classic：map 目录是 dir 时其文件仍收集（packByPackList 阶段才报错，与 TS 一致）
        assert!(n.contains(&r"icons\i.txt"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn packlist_missing_lib_dir_is_empty_list() {
        // DV11：无 src/lib 不报错。war3map.lua 条目是无条件 push 的，无需真实文件。
        let root = tempdir();
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(root.join("map")).unwrap();
        let items = generate_packlist(&ctx(&root, false, false)).unwrap();
        assert_eq!(names(&items), vec!["war3map.lua"]);
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn packlist_lib_collision_later_sorted_lib_wins() {
        // lib 间同名冲突：lib 字典序遍历、后推入者经 reduceRight 胜出
        let root = tempdir();
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(root.join("map")).unwrap();
        std::fs::create_dir_all(root.join("src/lib/aaa/imports")).unwrap();
        std::fs::write(root.join("src/lib/aaa/imports/x.txt"), "from-aaa").unwrap();
        std::fs::create_dir_all(root.join("src/lib/bbb/imports")).unwrap();
        std::fs::write(root.join("src/lib/bbb/imports/x.txt"), "from-bbb").unwrap();
        let items = generate_packlist(&ctx(&root, false, false)).unwrap();
        let (_, src) = items.iter().find(|(n, _)| n == "x.txt").unwrap();
        assert_eq!(std::fs::read_to_string(src).unwrap(), "from-bbb");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn out_file_name_by_config_and_ext() {
        let root = synth_project();
        assert!(out_file_path(&ctx(&root, false, false))
            .unwrap()
            .ends_with(".build/_warcraft_vscode_test"));
        assert!(out_file_path(&ctx(&root, true, false))
            .unwrap()
            .ends_with(".build/release"));
        // mapdir 带扩展名 → 产物带扩展名
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map.w3x" }"#).unwrap();
        assert!(out_file_path(&ctx(&root, true, false))
            .unwrap()
            .ends_with(".build/release.w3x"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_reforge_dir_creates_archive() {
        let root = synth_project();
        // debug：带 listfile
        let out = pack(&ctx(&root, false, false)).unwrap();
        assert!(out.ends_with(".build/_warcraft_vscode_test"));
        let names = mpq::read_listfile(&out).unwrap().unwrap();
        assert!(names.contains(&"war3map.lua".to_string()));
        assert_eq!(
            mpq::extract_file(&out, "override.txt").unwrap().unwrap(),
            b"from-root"
        );
        assert_eq!(
            mpq::extract_file(&out, "war3map.lua").unwrap().unwrap(),
            b"entry"
        );
        // release：无 listfile
        let out = pack(&ctx(&root, true, false)).unwrap();
        assert!(mpq::read_listfile(&out).unwrap().is_none());
        assert_eq!(mpq::extract_file(&out, "rel.txt").unwrap().unwrap(), b"x");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_classic_file_map_copies_then_appends() {
        let root = synth_project();
        // 自造基底地图：含将被覆盖的 war3map.j 与应保留的 base.txt
        std::fs::write(root.join("orig-j.txt"), "orig-jass").unwrap();
        std::fs::write(root.join("base.txt"), "base").unwrap();
        let map = root.join("the.w3x");
        mpq::create_archive(
            &map,
            &[
                ("war3map.j".into(), root.join("orig-j.txt")),
                ("base.txt".into(), root.join("base.txt")),
            ],
            true,
        )
        .unwrap();
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "the.w3x" }"#).unwrap();
        let out = pack(&ctx(&root, false, true)).unwrap();
        assert!(out.ends_with(".build/_warcraft_vscode_test.w3x"));
        assert_eq!(
            mpq::extract_file(&out, "base.txt").unwrap().unwrap(),
            b"base"
        );
        assert_eq!(
            mpq::extract_file(&out, "war3map.j").unwrap().unwrap(),
            b"jass",
            ".build/war3map.j 覆盖原图"
        );
        assert_eq!(
            mpq::extract_file(&out, "cls.txt").unwrap().unwrap(),
            b"x",
            "imports.classic 进包"
        );
        assert_eq!(
            mpq::extract_file(&map, "war3map.j").unwrap().unwrap(),
            b"orig-jass",
            "原地图不被修改"
        );
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_classic_dir_map_rejected() {
        // DV10
        let root = synth_project();
        let err = pack(&ctx(&root, false, true)).unwrap_err();
        assert_eq!(err.key, "error.invalidMapFile");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_requires_compiled_entry() {
        let root = synth_project();
        std::fs::remove_file(root.join(".build/war3map.lua")).unwrap();
        let err = pack(&ctx(&root, false, false)).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        std::fs::remove_dir_all(&root).unwrap();
    }
}
