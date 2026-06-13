//! TS ObjEditing 移植（src/app/objediting/objediting.ts）：def 资源管理、
//! 物编源文件准备、嵌入式 Lua VM 执行（替代 ObjEditing.exe 子进程）。
//! 设计决策：ObjEditing 核心逻辑为 ~19000 行 Lua，C++ 宿主仅 120 行；
//! 本模块用 mlua (Lua 5.4) 替换 C++ 宿主，Lua 逻辑通过 include_str! 嵌入。

use std::path::{Path, PathBuf};

use crate::config::BuildContext;
use crate::error::{Error, Result};
use crate::{fsutil, mpq};

const OBJ_EXTS: [&str; 7] = ["w3u", "w3t", "w3b", "w3h", "w3d", "w3a", "w3q"];

// ObjEditing Lua 源码嵌入（按 C++ 宿主 luasource.h 的加载顺序）
const LUA_BASE_STRING: &str = include_str!("../assets/objediting/base/string.lua");
const LUA_BASE_TABLE: &str = include_str!("../assets/objediting/base/table.lua");
const LUA_BASE_CLASS: &str = include_str!("../assets/objediting/base/class.lua");
const LUA_CORE_CHECKER: &str = include_str!("../assets/objediting/core/checker.lua");
const LUA_CORE_ENUM: &str = include_str!("../assets/objediting/core/enum.lua");
const LUA_CORE_OBJECT: &str = include_str!("../assets/objediting/core/object.lua");
const LUA_CORE_READBUFFER: &str = include_str!("../assets/objediting/core/readbuffer.lua");
const LUA_CORE_WRITEBUFFER: &str = include_str!("../assets/objediting/core/writebuffer.lua");
const LUA_CORE_DUMMPER: &str = include_str!("../assets/objediting/core/dummper.lua");
const LUA_CORE_OBJECTREADER: &str = include_str!("../assets/objediting/core/objectreader.lua");
const LUA_CORE_OBJECTWRITER: &str = include_str!("../assets/objediting/core/objectwriter.lua");
const LUA_OBJ_ABILITY: &str = include_str!("../assets/objediting/object/AbilityObjEditing.lua");
const LUA_OBJ_BUFF: &str = include_str!("../assets/objediting/object/BuffObjEditing.lua");
const LUA_OBJ_DESTRUCTABLE: &str =
    include_str!("../assets/objediting/object/DestructableObjEditing.lua");
const LUA_OBJ_ITEM: &str = include_str!("../assets/objediting/object/ItemObjEditing.lua");
const LUA_OBJ_UNIT: &str = include_str!("../assets/objediting/object/UnitObjEditing.lua");
const LUA_OBJ_UPGRADE: &str = include_str!("../assets/objediting/object/UpgradeObjEditing.lua");
const LUA_APPLICATION: &str = include_str!("../assets/objediting/application.lua");

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
/// 清空产物目录 → 源准备 → 嵌入式 Lua VM 执行。
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
    run_objediting_lua(&source_dir, &out_dir, &script, &ctx.root)?;
    Ok(())
}

/// 嵌入式 ObjEditing Lua VM 执行（替代 ObjEditing.exe 子进程）。
/// 复刻 C++ 宿主行为：创建带自定义 _ENV 的 Lua 5.4 VM、注册 os.chdir、
/// 依序加载内部模块、最后由 application.lua 读源文件→执行用户脚本→写产物。
fn run_objediting_lua(
    source_dir: &Path,
    out_dir: &Path,
    script: &Path,
    project_root: &Path,
) -> Result<()> {
    // 保存当前工作目录，Lua VM 执行后恢复（application.lua 通过 os.chdir 切换目录）
    let original_cwd =
        std::env::current_dir().map_err(|e| Error::new("error.io", format!("getcwd: {e}")))?;

    // ObjEditing 需要完整 stdlib（io.open 读写二进制文件、os.chdir 切目录）
    let lua = unsafe { mlua::Lua::unsafe_new() };

    // 注册 os.chdir（C++ 版用 SetCurrentDirectoryW，Rust 版用 std::env::set_current_dir）
    let os: mlua::Table = lua.globals().get("os").map_err(lua_err)?;
    os.set(
        "chdir",
        lua.create_function(|_, dir: String| {
            std::env::set_current_dir(&dir).map_err(|e| {
                mlua::Error::external(format!("unable to switch to directory '{dir}': {e}"))
            })?;
            Ok(true)
        })
        .map_err(lua_err)?,
    )
    .map_err(lua_err)?;

    // package.path 指向 .def 目录（用户脚本 require 字段定义用）
    let def_dir = project_root
        .join(".def")
        .to_string_lossy()
        .replace('\\', "/");
    lua.load(format!(
        "package.path = [[{def_dir}/?.lua;{def_dir}/?/init.lua;]] .. package.path"
    ))
    .exec()
    .map_err(lua_err)?;

    // 设置 args 表（与 C++ 宿主注入的结构一致）
    let args = lua.create_table().map_err(lua_err)?;
    args.set("map", source_dir.to_string_lossy().replace('\\', "/"))
        .map_err(lua_err)?;
    args.set("output", out_dir.to_string_lossy().replace('\\', "/"))
        .map_err(lua_err)?;
    args.set("dump", false).map_err(lua_err)?;
    let files_table = lua.create_table().map_err(lua_err)?;
    files_table
        .set(1, script.to_string_lossy().replace('\\', "/"))
        .map_err(lua_err)?;
    args.set("files", files_table).map_err(lua_err)?;
    lua.globals().set("args", args).map_err(lua_err)?;

    // 按 C++ 宿主 luasource.h 顺序加载内部模块
    let sources: &[(&str, &str)] = &[
        ("base/string.lua", LUA_BASE_STRING),
        ("base/table.lua", LUA_BASE_TABLE),
        ("base/class.lua", LUA_BASE_CLASS),
        ("core/checker.lua", LUA_CORE_CHECKER),
        ("core/enum.lua", LUA_CORE_ENUM),
        ("core/object.lua", LUA_CORE_OBJECT),
        ("core/readbuffer.lua", LUA_CORE_READBUFFER),
        ("core/writebuffer.lua", LUA_CORE_WRITEBUFFER),
        ("core/dummper.lua", LUA_CORE_DUMMPER),
        ("core/objectreader.lua", LUA_CORE_OBJECTREADER),
        ("core/objectwriter.lua", LUA_CORE_OBJECTWRITER),
        ("object/AbilityObjEditing.lua", LUA_OBJ_ABILITY),
        ("object/BuffObjEditing.lua", LUA_OBJ_BUFF),
        ("object/DestructableObjEditing.lua", LUA_OBJ_DESTRUCTABLE),
        ("object/ItemObjEditing.lua", LUA_OBJ_ITEM),
        ("object/UnitObjEditing.lua", LUA_OBJ_UNIT),
        ("object/UpgradeObjEditing.lua", LUA_OBJ_UPGRADE),
        ("application.lua", LUA_APPLICATION),
    ];
    for (name, source) in sources {
        lua.load(*source)
            .set_name(format!("@{name}"))
            .exec()
            .map_err(|e| {
                // 恢复 CWD 再报错
                let _ = std::env::set_current_dir(&original_cwd);
                let msg = e.to_string();
                // 从 Lua traceback 提取用户脚本文件和行号
                let (file, line) = extract_user_script_location(&msg);
                let mut err = Error::new("error.processFilesFailure", format!("ObjEditing: {msg}"));
                err.file = file;
                err.line = line;
                err
            })?;
    }

    // 恢复原始工作目录
    let _ = std::env::set_current_dir(&original_cwd);
    Ok(())
}

/// 从 ObjEditing Lua 错误 traceback 中提取用户脚本位置。
/// 典型格式: "runtime error: C:/.../objediting/main.lua:5: message"
fn extract_user_script_location(msg: &str) -> (Option<String>, Option<u32>) {
    // 找 .lua:数字: 模式
    for segment in msg.lines() {
        let segment = segment.trim();
        if let Some(idx) = segment.find(".lua:") {
            let after = &segment[idx + 5..];
            if let Some(colon) = after.find(':') {
                if let Ok(line) = after[..colon].trim().parse::<u32>() {
                    // 提取文件路径(取最后一个路径分隔符之后的部分)
                    let before = &segment[..idx + 4]; // 含 .lua
                    let file = before
                        .rsplit(['/', '\\', ' '])
                        .next()
                        .unwrap_or(before);
                    return (Some(file.to_string()), Some(line));
                }
            }
        }
    }
    (None, None)
}

fn lua_err(e: mlua::Error) -> Error {
    Error::new("error.processFilesFailure", format!("ObjEditing: {e}"))
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
    fn execute_classic_dir_map_rejected() {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(d.join("map")).unwrap();
        std::fs::create_dir_all(d.join("objediting")).unwrap();
        std::fs::write(d.join("objediting/main.lua"), "-- noop").unwrap();
        let res = make_res(&d, "v1");
        let err = execute(&ctx(&d, true), &res).unwrap_err();
        assert_eq!(err.key, "error.invalidMapFile");
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn execute_reforge_with_script_runs_lua_vm() {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(d.join("map")).unwrap();
        std::fs::create_dir_all(d.join("objediting")).unwrap();
        // 用户脚本不需要做任何事——验证 VM 启动并成功返回
        std::fs::write(d.join("objediting/main.lua"), "-- empty objediting script").unwrap();
        std::fs::create_dir_all(d.join(".def")).unwrap();
        let res = make_res(&d, "v1");
        execute(&ctx(&d, false), &res).unwrap();
        // application.lua 会创建产物目录并写空的 object 文件（无定义时产生空或不产生）
        assert!(d.join(".build/objediting").is_dir(), "产物目录已创建");
        std::fs::remove_dir_all(&d).unwrap();
    }
}
