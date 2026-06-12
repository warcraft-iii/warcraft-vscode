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

/// 递归收集 root 下非隐藏 .lua 文件，按 posix 相对路径字典序（DV5）。
pub fn collect_source_lua_files(root: &Path) -> Result<Vec<PathBuf>> {
    let mut files: Vec<PathBuf> = walkdir::WalkDir::new(root)
        .into_iter()
        .filter_map(|e| e.ok())
        .filter(|e| e.file_type().is_file())
        .map(|e| e.into_path())
        .filter(|p| is_lua_file(p) && !is_hidden_file(p))
        .collect();
    files.sort_by_key(|p| posix_relative(root, p).unwrap_or_default());
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

    fn tempdir() -> std::path::PathBuf {
        let d = std::env::temp_dir().join(format!("wc3-fsutil-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }
}
