use std::path::{Path, PathBuf};

use crate::error::{Error, Result};

/// TS isLuaFile：扩展名 .lua（大小写不敏感）。
pub fn is_lua_file(p: &Path) -> bool {
    p.extension()
        .map(|e| e.eq_ignore_ascii_case("lua"))
        .unwrap_or(false)
}

/// TS isHiddenFile：`.` 前缀；或 .lua 且 `@` 前缀。
pub fn is_hidden_file(p: &Path) -> bool {
    let name = p.file_name().and_then(|n| n.to_str()).unwrap_or("");
    name.starts_with('.') || (is_lua_file(p) && name.starts_with('@'))
}

/// TS posixCase(path.relative(root, file))。
pub fn posix_relative(root: &Path, file: &Path) -> Result<String> {
    let rel = file.strip_prefix(root).map_err(|_| {
        Error::new(
            "error.io",
            format!("{} not under {}", file.display(), root.display()),
        )
    })?;
    Ok(rel
        .components()
        .map(|c| c.as_os_str().to_string_lossy())
        .collect::<Vec<_>>()
        .join("/"))
}

/// TS path.relative 原生分隔符版：MPQ 归档内名用 `\`（spec 阶段 2 §7 风险 4）。
pub fn windows_relative(root: &Path, file: &Path) -> Result<String> {
    let rel = file.strip_prefix(root).map_err(|_| {
        Error::new(
            "error.io",
            format!("{} not under {}", file.display(), root.display()),
        )
    })?;
    Ok(rel
        .components()
        .map(|c| c.as_os_str().to_string_lossy())
        .collect::<Vec<_>>()
        .join("\\"))
}

/// walkdir 遍历错误 → 带路径的 Error（collect_* 共用）。
fn walk_error(root: &Path, e: walkdir::Error) -> Error {
    let p = e.path().unwrap_or(root).to_path_buf();
    match e.into_io_error() {
        Some(io) => Error::io(&p, io),
        None => Error::new("error.io", format!("{}: walk error", p.display())),
    }
}

/// 递归收集 root 下非隐藏 .lua 文件，按 posix 相对路径字典序（DV5）。
/// 遍历错误（权限/IO）直接上抛——静默丢文件会产出缺模块的坏地图（与 TS 抛错对齐）。
pub fn collect_source_lua_files(root: &Path) -> Result<Vec<PathBuf>> {
    let mut files: Vec<PathBuf> = Vec::new();
    for entry in walkdir::WalkDir::new(root) {
        let entry = entry.map_err(|e| walk_error(root, e))?;
        if !entry.file_type().is_file() {
            continue;
        }
        let p = entry.into_path();
        if is_lua_file(&p) && !is_hidden_file(&p) {
            files.push(p);
        }
    }
    files.sort_by_cached_key(|p| {
        posix_relative(root, p).expect("walkdir entry is always under root")
    });
    Ok(files)
}

/// 递归收集 root 下全部非隐藏文件（packer 用）；root 不存在或非目录返回空
/// （TS generatePackItems）。按 posix 相对路径字典序（DV5）。
pub fn collect_pack_files(root: &Path) -> Result<Vec<PathBuf>> {
    if !root.is_dir() {
        return Ok(Vec::new());
    }
    let mut files: Vec<PathBuf> = Vec::new();
    for entry in walkdir::WalkDir::new(root) {
        let entry = entry.map_err(|e| walk_error(root, e))?;
        if !entry.file_type().is_file() {
            continue;
        }
        let p = entry.into_path();
        if !is_hidden_file(&p) {
            files.push(p);
        }
    }
    files.sort_by_cached_key(|p| {
        posix_relative(root, p).expect("walkdir entry is always under root")
    });
    Ok(files)
}

/// 读文件为字符串（错误带路径）。
pub fn read_to_string(p: &Path) -> Result<String> {
    std::fs::read_to_string(p).map_err(|e| Error::io(p, e))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn hidden_rules() {
        assert!(is_hidden_file(std::path::Path::new("a/.git")));
        assert!(is_hidden_file(std::path::Path::new("a/@gen.lua")));
        assert!(
            !is_hidden_file(std::path::Path::new("a/@gen.txt")),
            "@ 前缀仅对 .lua 生效"
        );
        assert!(!is_hidden_file(std::path::Path::new("a/main.lua")));
        assert!(is_lua_file(std::path::Path::new("x/Main.LUA")));
        assert!(!is_lua_file(std::path::Path::new("x/Main.txt")));
    }

    #[test]
    fn posix_relative_path() {
        let root = std::path::Path::new("C:/p/src");
        let f = std::path::Path::new("C:/p/src/lib/util.lua");
        assert_eq!(posix_relative(root, f).unwrap(), "lib/util.lua");
    }

    #[test]
    fn collects_lua_files_sorted() {
        let dir = tempdir();
        std::fs::create_dir_all(dir.join("lib")).unwrap();
        std::fs::write(dir.join("main.lua"), "x").unwrap();
        std::fs::write(dir.join("lib/util.lua"), "x").unwrap();
        std::fs::write(dir.join("@skip.lua"), "x").unwrap();
        std::fs::write(dir.join(".skip.lua"), "x").unwrap();
        std::fs::write(dir.join("note.txt"), "x").unwrap();
        let files = collect_source_lua_files(&dir).unwrap();
        let rel: Vec<String> = files
            .iter()
            .map(|f| posix_relative(&dir, f).unwrap())
            .collect();
        assert_eq!(rel, vec!["lib/util.lua", "main.lua"]);
        std::fs::remove_dir_all(&dir).unwrap();
    }

    #[test]
    fn windows_relative_uses_backslash() {
        let root = std::path::Path::new("C:/p");
        let f = std::path::Path::new("C:/p/imports/sub/a.txt");
        assert_eq!(windows_relative(root, f).unwrap(), r"imports\sub\a.txt");
    }

    #[test]
    fn collects_all_pack_files_sorted_nonhidden() {
        let dir = tempdir();
        std::fs::create_dir_all(dir.join("sub")).unwrap();
        std::fs::write(dir.join("b.txt"), "x").unwrap();
        std::fs::write(dir.join("a.lua"), "x").unwrap(); // pack 不排 lua（map 目录的排除在 packer 层）
        std::fs::write(dir.join(".hidden.txt"), "x").unwrap();
        std::fs::write(dir.join("@gen.lua"), "x").unwrap(); // @ 前缀 lua 隐藏
        std::fs::write(dir.join("sub/c.txt"), "x").unwrap();
        // 点目录本身不算隐藏文件（TS isHiddenFile 只看 basename）——其内普通文件仍被收集
        std::fs::create_dir_all(dir.join(".dot")).unwrap();
        std::fs::write(dir.join(".dot/inside.txt"), "x").unwrap();
        let files = collect_pack_files(&dir).unwrap();
        let rel: Vec<String> = files
            .iter()
            .map(|f| posix_relative(&dir, f).unwrap())
            .collect();
        assert_eq!(rel, vec![".dot/inside.txt", "a.lua", "b.txt", "sub/c.txt"]);
        // 不存在/非目录 → 空（TS generatePackItems 行为）
        assert!(collect_pack_files(&dir.join("nope")).unwrap().is_empty());
        assert!(collect_pack_files(&dir.join("b.txt")).unwrap().is_empty());
        std::fs::remove_dir_all(&dir).unwrap();
    }

    fn tempdir() -> std::path::PathBuf {
        static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
        let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let d = std::env::temp_dir().join(format!("wc3-fsutil-{}-{n}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }
}
