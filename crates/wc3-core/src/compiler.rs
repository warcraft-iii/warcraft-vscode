//! debug/release 编译管线编排（TS DebugCompiler/ReleaseCompiler.execute）。

use std::path::{Path, PathBuf};

use indexmap::IndexMap;

use crate::config::{BuildContext, Confusion};
use crate::error::{Error, Result};
use crate::{comptime, fsutil, jass, macros, minify, mpq, require_graph, templates};

/// 外部工具定位（CLI 层从 --res-dir 解析传入；None 时对应功能不可用）。
pub struct Tools<'a> {
    pub confuse_exe: Option<&'a Path>,
}

impl<'a> Tools<'a> {
    pub fn confuse(&self) -> Result<&'a Path> {
        self.confuse_exe
            .ok_or_else(|| Error::new("error.io", "wc3-confuse.exe not configured"))
    }
}

fn ensure_source_dir(ctx: &BuildContext) -> Result<PathBuf> {
    let src = ctx.source_dir();
    if !src.is_dir() {
        return Err(Error::new("error.noSrcFolder", "Not found: source folder"));
    }
    Ok(src)
}

/// TS DebugCompiler.genFile：宏 → compiletime（含则替换，DV2 不 minify）→ 模板单文件项。
fn gen_debug_file(ctx: &BuildContext, lua: &mlua::Lua, file: &Path, name: &str) -> Result<String> {
    let raw = fsutil::read_to_string(file)?;
    let mut body = macros::process_code_macros(&raw, ctx.opts.release, ctx.opts.classic);
    if body.contains("compiletime") {
        body = comptime::process(lua, &body, name)?;
    }
    Ok(templates::render_debug_file(name, &body))
}

/// TS getOriginMapScript：目录地图直接读 `<mapdir>/war3map.lua`，文件地图经 mpq 提取。
fn origin_map_script(ctx: &BuildContext) -> Result<PathBuf> {
    let map = ctx.map_dir()?;
    if map.is_file() {
        // 有意改名（TS 用 .build/origwar3map.lua）：加 .extracted 后缀防误认构建产物；packer 不扫 .build，安全。
        let out = ctx.build_dir().join("origwar3map.lua.extracted");
        // 与 TS 一致：提取前先删旧产物，失败构建不留陈旧文件
        let _ = std::fs::remove_file(&out);
        // TS extractWar3mapJass：先 war3map.lua 再 scripts\ 回退
        if !mpq::extract_to(&map, "war3map.lua", &out)?
            && !mpq::extract_to(&map, "scripts\\war3map.lua", &out)?
        {
            return Err(Error::new(
                "error.noMapScriptFile",
                "Not found: war3map.lua file",
            ));
        }
        Ok(out)
    } else {
        Ok(map.join("war3map.lua"))
    }
}

/// TS injectWar3mapJass 的 IO 编排：jassfile 优先，否则地图提取（含 scripts\ 回退）。
fn write_injected_jass(ctx: &BuildContext) -> Result<()> {
    let out = ctx.build_dir().join("war3map.j");
    let source = if let Some(jf) = ctx.jassfile().filter(|p| p.exists()) {
        fsutil::read_to_string(&jf)?
    } else {
        // 与 TS 一致：提取前先删旧产物，失败构建不留陈旧文件
        let _ = std::fs::remove_file(&out);
        let map = ctx.map_dir()?;
        if !mpq::extract_to(&map, "war3map.j", &out)?
            && !mpq::extract_to(&map, "scripts\\war3map.j", &out)?
        {
            return Err(Error::new(
                "error.noMapScriptFile",
                "Not found: war3map.j file",
            ));
        }
        fsutil::read_to_string(&out)?
    };
    std::fs::write(&out, jass::inject_cheat(&source)?).map_err(|e| Error::io(&out, e))?;
    Ok(())
}

/// TS DebugCompiler.execute。
pub fn compile_debug(ctx: &BuildContext) -> Result<()> {
    let src = ensure_source_dir(ctx)?;
    std::fs::create_dir_all(ctx.build_dir()).map_err(|e| Error::io(&ctx.build_dir(), e))?;
    // 一次构建一个共享引擎（DV6）；创建成本微秒级，无懒加载必要
    let lua = comptime::make_lua()?;

    let mut entries: Vec<String> = Vec::new();
    for file in fsutil::collect_source_lua_files(&src)? {
        let name = fsutil::posix_relative(&src, &file)?;
        entries.push(gen_debug_file(ctx, &lua, &file, &name)?);
    }
    if !ctx.opts.classic {
        let script = origin_map_script(ctx)?;
        entries.push(gen_debug_file(ctx, &lua, &script, "origwar3map.lua")?);
    }

    let code = entries.join("\n");
    let out = templates::render_main(
        templates::Kind::Debug,
        &code,
        &ctx.config.lua_package_path,
        ctx.opts.classic,
    );
    let out_path = ctx.build_dir().join("war3map.lua");
    std::fs::write(&out_path, out).map_err(|e| Error::io(&out_path, e))?;

    if ctx.opts.classic {
        write_injected_jass(ctx)?;
    }
    Ok(())
}

/// TS ReleaseCompiler.processFiles 的确定性 DFS 版（DV4）：resolve 模块路径并派生 posix 名，
/// 委托 process_file。
fn process_module(
    ctx: &BuildContext,
    lua: &mlua::Lua,
    src: &Path,
    files: &mut IndexMap<String, String>,
    item: &require_graph::RequireItem,
    depth: usize,
) -> Result<()> {
    let Some(file) =
        require_graph::resolve(src, &ctx.config.lua_package_path, item, ctx.opts.classic)?
    else {
        return Ok(());
    };
    let name = fsutil::posix_relative(src, &file)?;
    process_file(ctx, lua, src, files, &file, name, depth)
}

/// 单文件处理：去重 → 读 → 宏 → compiletime → 扫 require → minify 注册 → 递归子模块。
fn process_file(
    ctx: &BuildContext,
    lua: &mlua::Lua,
    src: &Path,
    files: &mut IndexMap<String, String>,
    file: &Path,
    name: String,
    depth: usize,
) -> Result<()> {
    if depth > 500 {
        return Err(Error::new(
            "error.processFilesFailure",
            format!("require chain too deep at {name} (>500); cycle without dedup?"),
        ));
    }
    if files.contains_key(&name) {
        return Ok(());
    }
    let raw = fsutil::read_to_string(file)?;
    let mut body = macros::process_code_macros(&raw, ctx.opts.release, ctx.opts.classic);
    drop(raw);
    if body.contains("compiletime") {
        body = comptime::process(lua, &body, &name)?;
    }
    let required = require_graph::scan_requires(&body);
    let minified = minify::minify(&body).map_err(|mut e| {
        e.file = Some(name.clone());
        e
    })?;
    drop(body); // 递归前释放未压缩源码，避免深链上持有大字符串
    files.insert(name.clone(), minified);
    for item in required {
        process_module(ctx, lua, src, files, &item, depth + 1).map_err(|mut e| {
            // 若子模块解析失败且无 file 定位，附加「引用自」上下文
            if e.file.is_none() {
                e.file = Some(name.clone());
            }
            e
        })?;
    }
    Ok(())
}

/// TS ReleaseCompiler.execute。
pub fn compile_release(ctx: &BuildContext, tools: &Tools) -> Result<()> {
    let src = ensure_source_dir(ctx)?;
    std::fs::create_dir_all(ctx.build_dir()).map_err(|e| Error::io(&ctx.build_dir(), e))?;
    let lua = comptime::make_lua()?;

    let mut files: IndexMap<String, String> = IndexMap::new();
    process_module(
        ctx,
        &lua,
        &src,
        &mut files,
        &require_graph::RequireItem {
            module: "main.lua".into(),
            is_require: false,
        },
        0,
    )?;
    for f in &ctx.config.files {
        process_module(
            ctx,
            &lua,
            &src,
            &mut files,
            &require_graph::RequireItem {
                module: f.clone(),
                is_require: false,
            },
            0,
        )?;
    }
    if !ctx.opts.classic {
        let script = origin_map_script(ctx)?;
        process_file(
            ctx,
            &lua,
            &src,
            &mut files,
            &script,
            "origwar3map.lua".into(),
            0,
        )?;
    }

    let code = files
        .iter()
        .map(|(name, body)| templates::render_release_file(name, body))
        .collect::<Vec<_>>()
        .join("\n");
    let out = templates::render_main(
        templates::Kind::Release,
        &code,
        &ctx.config.lua_package_path,
        ctx.opts.classic,
    );
    let out_path = ctx.build_dir().join("war3map.lua");

    // 真实 exe 的 argv 验证延后到 Task 18 spike
    if ctx.opts.confusion != Confusion::Disable {
        std::fs::write(&out_path, &out).map_err(|e| Error::io(&out_path, e))?;
        let exe = tools.confuse()?;
        let preset = match ctx.opts.confusion {
            Confusion::Minify => "Minify",
            Confusion::Weak => "Weak",
            Confusion::Medium => "Medium",
            Confusion::Strong => "Strong",
            Confusion::Disable => unreachable!(),
        };
        let status = std::process::Command::new(exe)
            .args(["--preset", preset, "--out"])
            .arg(&out_path)
            .arg(&out_path)
            .status()
            .map_err(|e| Error::new("error.io", format!("{}: {e}", exe.display())))?;
        if !status.success() {
            return Err(Error::new(
                "error.processFilesFailure",
                "lua confusion failed",
            ));
        }
    } else {
        let minified = minify::minify(&out)?;
        std::fs::write(&out_path, minified).map_err(|e| Error::io(&out_path, e))?;
    }

    if ctx.opts.classic {
        write_injected_jass(ctx)?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::config::{BuildContext, BuildOptions, ProjectConfig};

    const NO_TOOLS: Tools<'static> = Tools { confuse_exe: None };

    fn synth_project() -> std::path::PathBuf {
        static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
        let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let d = std::env::temp_dir().join(format!("wc3-dbg-{}-{n}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(d.join("src/lib")).unwrap();
        std::fs::create_dir_all(d.join("map")).unwrap();
        std::fs::write(
            d.join("warcraft.json"),
            r#"{ "mapdir": "map", "jassfile": "war3map.j" }"#,
        )
        .unwrap();
        std::fs::write(
            d.join("src/main.lua"),
            "--@debug@\nD=1\n--@end-debug@\nreturn require('lib.util')",
        )
        .unwrap();
        std::fs::write(d.join("src/lib/util.lua"), "return 7").unwrap();
        std::fs::write(d.join("map/war3map.lua"), "function main() end").unwrap();
        std::fs::write(
            d.join("war3map.j"),
            "function main takes nothing returns nothing\r\n    call InitGlobals()\r\nendfunction",
        )
        .unwrap();
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

    #[test]
    fn debug_reforge_bundles_sources_and_orig() {
        let root = synth_project();
        compile_debug(&ctx(&root, false, false)).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['main.lua'] = "));
        assert!(out.contains("P['lib/util.lua'] = "));
        assert!(out.contains("P['origwar3map.lua'] = "));
        assert!(
            out.contains("--@debug@\nD=1\n--@end-debug@"),
            "debug 宏启用"
        );
        assert!(!root.join(".build/war3map.j").exists());
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn debug_classic_skips_orig_and_injects_jass() {
        let root = synth_project();
        compile_debug(&ctx(&root, false, true)).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(!out.contains("P['origwar3map.lua']"));
        let j = std::fs::read_to_string(root.join(".build/war3map.j")).unwrap();
        assert!(j.contains("call Cheat(\"exec-lua:war3map\")"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn debug_comptime_substituted_without_minify() {
        let root = synth_project();
        std::fs::write(
            root.join("src/main.lua"),
            "local v = compiletime(function()\n    return 6 * 7\nend)\nreturn v",
        )
        .unwrap();
        compile_debug(&ctx(&root, false, false)).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(
            out.contains("local v = 42\nreturn v"),
            "DV2：区间替换保持排版，不 minify"
        );
        assert!(!out.contains("compiletime"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn missing_src_folder_errors() {
        let d = std::env::temp_dir().join(format!("wc3-nosrc-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        let err = compile_debug(&ctx(&d, false, false)).unwrap_err();
        assert_eq!(err.key, "error.noSrcFolder");
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn release_reforge_resolves_require_graph() {
        let root = synth_project();
        compile_release(&ctx(&root, true, false), &NO_TOOLS).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['main.lua']"));
        assert!(out.contains("P['lib/util.lua']"), "require 链被打包");
        assert!(out.contains("P['origwar3map.lua']"));
        assert!(!out.contains("--@debug@"), "整体 minify 后无注释");
        assert!(!out.contains("D=1"), "debug 宏在 release 被注释剔除");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn release_files_roots_are_bundled() {
        let root = synth_project();
        std::fs::write(
            root.join("warcraft.json"),
            r#"{ "mapdir": "map", "jassfile": "war3map.j", "files": ["extra.lua"] }"#,
        )
        .unwrap();
        std::fs::write(root.join("src/extra.lua"), "EXTRA = 1").unwrap();
        compile_release(&ctx(&root, true, false), &NO_TOOLS).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(
            out.contains("P['extra.lua']"),
            "warcraft.json files[] 根被打包"
        );
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn release_classic_allows_builtin_modules() {
        let root = synth_project();
        std::fs::write(
            root.join("src/main.lua"),
            "require('jass.common')\nreturn require('lib.util')",
        )
        .unwrap();
        compile_release(&ctx(&root, true, true), &NO_TOOLS).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['lib/util.lua']"));
        assert!(!out.contains("P['jass/common"), "classic 内置包跳过");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn release_reforge_missing_module_errors() {
        let root = synth_project();
        std::fs::write(root.join("src/main.lua"), "require('no.such')").unwrap();
        let err = compile_release(&ctx(&root, true, false), &NO_TOOLS).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn release_dedup_and_transitive() {
        let root = synth_project();
        std::fs::write(
            root.join("src/main.lua"),
            "require('lib.util')\nrequire('lib.util')\nreturn 1",
        )
        .unwrap();
        std::fs::write(root.join("src/lib/util.lua"), "return require('lib.deep')").unwrap();
        std::fs::write(root.join("src/lib/deep.lua"), "return 9").unwrap();
        compile_release(&ctx(&root, true, false), &NO_TOOLS).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert_eq!(out.matches("P['lib/util.lua']").count(), 1, "去重");
        assert!(out.contains("P['lib/deep.lua']"), "传递依赖");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn release_confusion_without_exe_errors() {
        let root = synth_project();
        let opts = BuildOptions {
            release: true,
            confusion: crate::config::Confusion::Minify,
            ..Default::default()
        };
        let cfg = ProjectConfig::load(&root).unwrap();
        let ctx = BuildContext::new(&root, cfg, opts);
        let err = compile_release(&ctx, &NO_TOOLS).unwrap_err();
        assert_eq!(err.key, "error.io");
        assert!(err.message.contains("wc3-confuse"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn debug_reforge_extracts_orig_from_file_map() {
        let root = synth_project();
        let map_file = root.join("map.w3x");
        crate::mpq::create_archive(
            &map_file,
            &[("war3map.lua".into(), root.join("map/war3map.lua"))],
            true,
        )
        .unwrap();
        std::fs::write(
            root.join("warcraft.json"),
            r#"{ "mapdir": "map.w3x", "jassfile": "war3map.j" }"#,
        )
        .unwrap();
        compile_debug(&ctx(&root, false, false)).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['origwar3map.lua'] = [[function main() end]]"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn debug_reforge_falls_back_to_scripts_war3map_lua() {
        let root = synth_project();
        let map_file = root.join("map.w3x");
        crate::mpq::create_archive(
            &map_file,
            &[("scripts\\war3map.lua".into(), root.join("map/war3map.lua"))],
            true,
        )
        .unwrap();
        std::fs::write(
            root.join("warcraft.json"),
            r#"{ "mapdir": "map.w3x", "jassfile": "war3map.j" }"#,
        )
        .unwrap();
        compile_debug(&ctx(&root, false, false)).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['origwar3map.lua'] = [[function main() end]]"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn classic_falls_back_to_scripts_war3map_j() {
        let root = synth_project();
        let map_file = root.join("map.w3x");
        crate::mpq::create_archive(
            &map_file,
            &[("scripts\\war3map.j".into(), root.join("war3map.j"))],
            true,
        )
        .unwrap();
        // 无 jassfile 字段 → 走地图提取的 scripts\ 回退
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map.w3x" }"#).unwrap();
        compile_debug(&ctx(&root, false, true)).unwrap();
        let j = std::fs::read_to_string(root.join(".build/war3map.j")).unwrap();
        assert!(j.contains("call Cheat(\"exec-lua:war3map\")"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn file_map_without_scripts_errors() {
        let root = synth_project();
        let map_file = root.join("map.w3x");
        crate::mpq::create_archive(
            &map_file,
            &[("dummy.txt".into(), root.join("war3map.j"))],
            true,
        )
        .unwrap();
        std::fs::write(
            root.join("warcraft.json"),
            r#"{ "mapdir": "map.w3x", "jassfile": "war3map.j" }"#,
        )
        .unwrap();
        // 预置陈旧产物，使下方 !exists 断言真正验证预删除逻辑（非空洞断言）
        std::fs::create_dir_all(root.join(".build")).unwrap();
        std::fs::write(root.join(".build/origwar3map.lua.extracted"), "stale").unwrap();
        let err = compile_debug(&ctx(&root, false, false)).unwrap_err();
        assert_eq!(err.key, "error.noMapScriptFile");
        // 验证失败构建不留陈旧提取产物
        assert!(!root.join(".build/origwar3map.lua.extracted").exists());
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn classic_failed_extraction_removes_stale_jass() {
        let root = synth_project();
        // 预置陈旧 war3map.j，验证提取失败时被预删除
        std::fs::create_dir_all(root.join(".build")).unwrap();
        std::fs::write(root.join(".build/war3map.j"), "stale").unwrap();
        crate::mpq::create_archive(
            &root.join("map.w3x"),
            &[("dummy.txt".into(), root.join("map/war3map.lua"))],
            true,
        )
        .unwrap();
        // 无 jassfile 字段 → 走地图提取
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map.w3x" }"#).unwrap();
        let err = compile_debug(&ctx(&root, false, true)).unwrap_err();
        assert_eq!(err.key, "error.noMapScriptFile");
        assert!(!root.join(".build/war3map.j").exists(), "陈旧产物被预删除");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn classic_extracts_jass_from_file_map_when_no_jassfile() {
        let root = synth_project();
        let map_file = root.join("map.w3x");
        crate::mpq::create_archive(
            &map_file,
            &[("war3map.j".into(), root.join("war3map.j"))],
            true,
        )
        .unwrap();
        // 无 jassfile 字段 → 走地图提取
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map.w3x" }"#).unwrap();
        compile_debug(&ctx(&root, false, true)).unwrap();
        let j = std::fs::read_to_string(root.join(".build/war3map.j")).unwrap();
        assert!(j.contains("call Cheat(\"exec-lua:war3map\")"));
        std::fs::remove_dir_all(&root).unwrap();
    }
}
