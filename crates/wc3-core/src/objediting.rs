//! TS ObjEditing 移植（src/app/objediting/objediting.ts）：def 资源管理、
//! 物编源文件准备、ObjEditing.exe 编排（spec 阶段 2 §4.3，偏差 DV9）。

use std::path::{Path, PathBuf};

use crate::config::BuildContext;
use crate::error::{Error, Result};
use crate::{fsutil, mpq};

const OBJ_EXTS: [&str; 7] = ["w3u", "w3t", "w3b", "w3h", "w3d", "w3a", "w3q"];

/// TS checkDefine（DV9：执行时检查而非会话启动时）。res 资源缺失静默跳过。
pub fn check_define(root: &Path, res_dir: &Path) -> Result<()> {
    let version_file = res_dir.join(".version.json");
    let def_zip = res_dir.join("def.zip");
    if !version_file.is_file() || !def_zip.is_file() {
        return Ok(());
    }
    let json: serde_json::Value = serde_json::from_str(&fsutil::read_to_string(&version_file)?)
        .map_err(|e| Error::new("error.io", format!("{}: {e}", version_file.display())))?;
    let current = json.get("def").and_then(|v| v.as_str()).unwrap_or("");
    let local = std::fs::read_to_string(root.join(".def/.version"))
        .map(|s| s.trim().to_string())
        .unwrap_or_default();
    if !current.is_empty() && current == local {
        return Ok(());
    }
    let file = std::fs::File::open(&def_zip).map_err(|e| Error::io(&def_zip, e))?;
    let mut zip = zip::ZipArchive::new(file)
        .map_err(|e| Error::new("error.io", format!("{}: {e}", def_zip.display())))?;
    zip.extract(root.join(".def"))
        .map_err(|e| Error::new("error.io", format!("def.zip extract: {e}")))?;
    Ok(())
}

/// TS 脚本发现：objediting.{reforge|classic}/main.lua → objediting/main.lua。
pub fn find_script(root: &Path, classic: bool) -> Option<PathBuf> {
    let version = if classic { "classic" } else { "reforge" };
    let versioned = root.join(format!("objediting.{version}")).join("main.lua");
    if versioned.is_file() {
        return Some(versioned);
    }
    let common = root.join("objediting").join("main.lua");
    common.is_file().then_some(common)
}

fn recreate_dir(dir: &Path) -> Result<()> {
    if dir.exists() {
        std::fs::remove_dir_all(dir).map_err(|e| Error::io(dir, e))?;
    }
    std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
    Ok(())
}

/// TS prepareObjectFiles：7 类物编文件 → .build/objediting.source（清空重建）。
fn prepare_object_files(ctx: &BuildContext) -> Result<PathBuf> {
    let out_dir = ctx.build_dir().join("objediting.source");
    recreate_dir(&out_dir)?;
    let map = ctx.map_dir()?;
    for ext in OBJ_EXTS {
        let file = format!("war3map.{ext}");
        if ctx.opts.classic {
            mpq::extract_to(&map, &file, &out_dir.join(&file))?;
        } else {
            let p = map.join(&file);
            if p.is_file() {
                std::fs::copy(&p, out_dir.join(&file)).map_err(|e| Error::io(&p, e))?;
            }
        }
    }
    Ok(out_dir)
}

/// TS ObjEditing.execute：def 检查 → 脚本发现（无则跳过）→ classic 地图校验 →
/// 清空产物目录 → 源准备 → ObjEditing.exe。
pub fn execute(ctx: &BuildContext, res_dir: &Path) -> Result<()> {
    check_define(&ctx.root, res_dir)?;
    let Some(script) = find_script(&ctx.root, ctx.opts.classic) else {
        return Ok(());
    };
    let map = ctx.map_dir()?;
    if ctx.opts.classic && !map.is_file() {
        return Err(Error::new(
            "error.invalidMapFile",
            "Classic version ONLY support .w3x/.w3m format map file.",
        ));
    }
    let out_dir = ctx.build_dir().join("objediting");
    recreate_dir(&out_dir)?;
    let source_dir = prepare_object_files(ctx)?;
    let exe = res_dir.join("ObjEditing.exe");
    if !exe.is_file() {
        return Err(Error::with_args(
            "error.notFound",
            "Not found ObjEditing.exe",
            vec!["ObjEditing.exe".into()],
        ));
    }
    let output = std::process::Command::new(&exe)
        .arg("-m")
        .arg(&source_dir)
        .arg("-o")
        .arg(&out_dir)
        .arg(&script)
        .output()
        .map_err(|e| Error::new("error.io", format!("{}: {e}", exe.display())))?;
    let stderr = String::from_utf8_lossy(&output.stderr);
    // TS utils.execFile 语义：非零退出或 stderr 非空均视为失败
    if !output.status.success() || !stderr.trim().is_empty() {
        return Err(Error::new(
            "error.processFilesFailure",
            format!("ObjEditing failed: {}", stderr.trim()),
        ));
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::config::{BuildContext, BuildOptions, ProjectConfig};
    use std::io::Write;

    fn tempdir() -> PathBuf {
        static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
        let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let d = std::env::temp_dir().join(format!("wc3-obj-{}-{n}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }

    fn make_def_zip(path: &Path, version: &str) {
        let f = std::fs::File::create(path).unwrap();
        let mut w = zip::ZipWriter::new(f);
        let opt: zip::write::SimpleFileOptions = Default::default();
        w.start_file(".version", opt).unwrap();
        w.write_all(version.as_bytes()).unwrap();
        w.start_file("def/a.lua", opt).unwrap();
        w.write_all(b"return 1").unwrap();
        w.finish().unwrap();
    }

    fn make_res(dir: &Path, version: &str) -> PathBuf {
        let res = dir.join("res");
        std::fs::create_dir_all(&res).unwrap();
        std::fs::write(
            res.join(".version.json"),
            format!(r#"{{"def":"{version}"}}"#),
        )
        .unwrap();
        make_def_zip(&res.join("def.zip"), version);
        res
    }

    #[test]
    fn check_define_extracts_when_missing_or_stale() {
        let d = tempdir();
        let res = make_res(&d, "v2");
        // 无 .def → 解压
        check_define(&d, &res).unwrap();
        assert_eq!(
            std::fs::read_to_string(d.join(".def/.version")).unwrap(),
            "v2"
        );
        assert!(d.join(".def/def/a.lua").is_file());
        // 版本一致 → 跳过（删掉 a.lua 作探针，不应重新出现）
        std::fs::remove_file(d.join(".def/def/a.lua")).unwrap();
        check_define(&d, &res).unwrap();
        assert!(!d.join(".def/def/a.lua").exists());
        // 版本过期 → 重新解压
        std::fs::write(d.join(".def/.version"), "v1").unwrap();
        check_define(&d, &res).unwrap();
        assert!(d.join(".def/def/a.lua").is_file());
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn check_define_skips_when_res_missing() {
        let d = tempdir();
        check_define(&d, &d.join("no-res")).unwrap();
        assert!(!d.join(".def").exists());
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn script_discovery_priority() {
        let d = tempdir();
        assert_eq!(find_script(&d, false), None);
        std::fs::create_dir_all(d.join("objediting")).unwrap();
        std::fs::write(d.join("objediting/main.lua"), "x").unwrap();
        assert!(find_script(&d, false)
            .unwrap()
            .ends_with("objediting/main.lua"));
        std::fs::create_dir_all(d.join("objediting.reforge")).unwrap();
        std::fs::write(d.join("objediting.reforge/main.lua"), "x").unwrap();
        assert!(find_script(&d, false)
            .unwrap()
            .ends_with("objediting.reforge/main.lua"));
        assert!(
            find_script(&d, true)
                .unwrap()
                .ends_with("objediting/main.lua"),
            "classic 不取 reforge 版"
        );
        std::fs::remove_dir_all(&d).unwrap();
    }

    fn ctx(root: &Path, classic: bool) -> BuildContext {
        let cfg = ProjectConfig::load(root).unwrap();
        BuildContext::new(
            root,
            cfg,
            BuildOptions {
                classic,
                ..Default::default()
            },
        )
    }

    #[test]
    fn prepare_copies_reforge_object_files() {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(d.join("map")).unwrap();
        std::fs::write(d.join("map/war3map.w3u"), "units").unwrap();
        std::fs::write(d.join("map/war3map.w3t"), "items").unwrap();
        let out = prepare_object_files(&ctx(&d, false)).unwrap();
        assert_eq!(
            std::fs::read_to_string(out.join("war3map.w3u")).unwrap(),
            "units"
        );
        assert_eq!(
            std::fs::read_to_string(out.join("war3map.w3t")).unwrap(),
            "items"
        );
        assert!(!out.join("war3map.w3b").exists(), "缺失类型跳过");
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn prepare_extracts_classic_object_files() {
        let d = tempdir();
        std::fs::write(d.join("u.bin"), "units").unwrap();
        let map = d.join("the.w3x");
        crate::mpq::create_archive(&map, &[("war3map.w3u".into(), d.join("u.bin"))], true).unwrap();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "the.w3x" }"#).unwrap();
        let out = prepare_object_files(&ctx(&d, true)).unwrap();
        assert_eq!(
            std::fs::read_to_string(out.join("war3map.w3u")).unwrap(),
            "units"
        );
        assert!(!out.join("war3map.w3t").exists());
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn execute_skips_silently_without_script() {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        let res = make_res(&d, "v1");
        execute(&ctx(&d, false), &res).unwrap();
        assert!(!d.join(".build/objediting").exists(), "无脚本不建产物目录");
        assert!(d.join(".def/.version").is_file(), "def 检查仍执行（DV9）");
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn execute_classic_dir_map_rejected_and_exe_missing_reported() {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(d.join("map")).unwrap();
        std::fs::create_dir_all(d.join("objediting")).unwrap();
        std::fs::write(d.join("objediting/main.lua"), "x").unwrap();
        let res = make_res(&d, "v1");
        let err = execute(&ctx(&d, true), &res).unwrap_err();
        assert_eq!(err.key, "error.invalidMapFile");
        // reforge + 脚本存在 + exe 缺失
        let err = execute(&ctx(&d, false), &res).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        assert!(err.message.contains("ObjEditing.exe"));
        std::fs::remove_dir_all(&d).unwrap();
    }
}
