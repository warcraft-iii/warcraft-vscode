//! debug/release 编译管线编排（TS DebugCompiler/ReleaseCompiler.execute）。

use std::path::{Path, PathBuf};

use crate::config::BuildContext;
use crate::error::{Error, Result};
use crate::{comptime, fsutil, jass, macros, mopaq, templates};

/// 外部工具定位（CLI 层从 --res-dir 解析传入；None 时 .w3x 文件型地图不可用）。
pub struct Tools<'a> {
    pub mopaq_exe: Option<&'a Path>,
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

/// TS getOriginMapScript：目录地图直接读 `<mapdir>/war3map.lua`，文件地图经 mopaq 提取。
fn origin_map_script(ctx: &BuildContext, tools: &Tools) -> Result<PathBuf> {
    let map = ctx.map_dir()?;
    if map.is_file() {
        let exe = tools
            .mopaq_exe
            .ok_or_else(|| Error::new("error.io", "MopaqPack-rs.exe not configured"))?;
        let out = ctx.build_dir().join("origwar3map.lua.extracted");
        if !mopaq::extract_file_from_map(exe, &map, "war3map.lua", &out)? {
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
fn write_injected_jass(ctx: &BuildContext, tools: &Tools) -> Result<()> {
    let out = ctx.build_dir().join("war3map.j");
    let source = if let Some(jf) = ctx.jassfile().filter(|p| p.exists()) {
        fsutil::read_to_string(&jf)?
    } else {
        let exe = tools
            .mopaq_exe
            .ok_or_else(|| Error::new("error.io", "MopaqPack-rs.exe not configured"))?;
        let map = ctx.map_dir()?;
        if !mopaq::extract_file_from_map(exe, &map, "war3map.j", &out)?
            && !mopaq::extract_file_from_map(exe, &map, "scripts\\war3map.j", &out)?
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
pub fn compile_debug(ctx: &BuildContext, mopaq_exe: Option<&Path>) -> Result<()> {
    let tools = Tools { mopaq_exe };
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
        let script = origin_map_script(ctx, &tools)?;
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
        write_injected_jass(ctx, &tools)?;
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::config::{BuildContext, BuildOptions, ProjectConfig};

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
        compile_debug(&ctx(&root, false, false), None).unwrap();
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
        compile_debug(&ctx(&root, false, true), None).unwrap();
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
        compile_debug(&ctx(&root, false, false), None).unwrap();
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
        let err = compile_debug(&ctx(&d, false, false), None).unwrap_err();
        assert_eq!(err.key, "error.noSrcFolder");
        std::fs::remove_dir_all(&d).unwrap();
    }
}
