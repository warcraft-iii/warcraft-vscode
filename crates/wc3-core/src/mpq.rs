//! stormlib（MopaqPack-rs crate）封装：MPQ 读写。
//! 替代阶段 1 的 mopaq.rs 子进程（设计决策 P1/P2，spec 阶段 2 §3）。

use std::path::{Path, PathBuf};

use crate::error::{Error, Result};

fn mpq_err(ctx: &std::path::Path, what: &str, e: stormlib::error::StormError) -> Error {
    Error::new("error.io", format!("{} ({what}): {e}", ctx.display()))
}

/// 读地图内单个文件；不存在返回 None。
pub fn extract_file(map: &Path, name_in_map: &str) -> Result<Option<Vec<u8>>> {
    let mut ar = stormlib::Archive::open(map, stormlib::OpenArchiveFlags::MPQ_OPEN_READ_ONLY)
        .map_err(|e| mpq_err(map, "open", e))?;
    if !ar
        .has_file(name_in_map)
        .map_err(|e| mpq_err(map, name_in_map, e))?
    {
        return Ok(None);
    }
    let mut f = ar
        .open_file(name_in_map)
        .map_err(|e| mpq_err(map, name_in_map, e))?;
    Ok(Some(
        f.read_all().map_err(|e| mpq_err(map, name_in_map, e))?,
    ))
}

/// 提取到磁盘，返回是否存在（compiler 的文件地图提取用）。
pub fn extract_to(map: &Path, name_in_map: &str, out: &Path) -> Result<bool> {
    match extract_file(map, name_in_map)? {
        Some(data) => {
            if let Some(dir) = out.parent() {
                std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
            }
            std::fs::write(out, data).map_err(|e| Error::io(out, e))?;
            Ok(true)
        }
        None => Ok(false),
    }
}

/// 全新归档（TS MopaqPack generate）：容量 = 文件数；debug 配置带 (listfile)（TS -f）。
pub fn create_archive(out: &Path, files: &[(String, PathBuf)], with_filelist: bool) -> Result<()> {
    if out.is_file() {
        std::fs::remove_file(out).map_err(|e| Error::io(out, e))?;
    }
    let ar = stormlib::Archive::create(out, files.len(), with_filelist)
        .map_err(|e| mpq_err(out, "create", e))?;
    for (name, path) in files {
        let data = std::fs::read(path).map_err(|e| Error::io(path, e))?;
        ar.write_file(name, &data)
            .map_err(|e| mpq_err(out, name, e))?;
    }
    Ok(())
}

/// 向现有归档追加（TS MopaqPack pack）：扩容 + add_file（同名覆盖）+ compact。
pub fn add_files(map: &Path, files: &[(String, PathBuf)]) -> Result<()> {
    // add_file 失败时原条目已被删除（先删后加）——开档前先校验全部源文件，失败不碰归档
    for (name, path) in files {
        if !path.is_file() {
            return Err(Error::new(
                "error.io",
                format!("{} ({name}): source file missing", path.display()),
            ));
        }
    }
    let mut ar = stormlib::Archive::open(map, stormlib::OpenArchiveFlags::MPQ_OPEN_NO_FLAG)
        .map_err(|e| mpq_err(map, "open", e))?;
    let count = ar
        .get_max_files()
        .map_err(|e| mpq_err(map, "max_files", e))?;
    ar.set_max_files(count + files.len() as u32)
        .map_err(|e| mpq_err(map, "max_files", e))?;
    for (name, path) in files {
        let local = path
            .to_str()
            .ok_or_else(|| Error::new("error.io", format!("non-utf8 path: {}", path.display())))?;
        ar.add_file(name, local)
            .map_err(|e| mpq_err(map, name, e))?;
    }
    ar.compact().map_err(|e| mpq_err(map, "compact", e))?;
    Ok(())
}

/// 读 (listfile)（按行，去 \r 与空行）；无 listfile 返回 None。黄金对照与测试用。
pub fn read_listfile(map: &Path) -> Result<Option<Vec<String>>> {
    Ok(extract_file(map, "(listfile)")?.map(|data| {
        String::from_utf8_lossy(&data)
            .lines()
            .map(|s| s.trim_end_matches('\r').to_string())
            .filter(|s| !s.is_empty())
            .collect()
    }))
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::path::PathBuf;

    fn tempdir() -> PathBuf {
        static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
        let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let d = std::env::temp_dir().join(format!("wc3-mpq-{}-{n}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }

    fn src_files(dir: &std::path::Path) -> Vec<(String, PathBuf)> {
        std::fs::write(dir.join("a.txt"), "alpha").unwrap();
        std::fs::write(dir.join("b.bin"), "中文内容").unwrap();
        vec![
            ("a.txt".into(), dir.join("a.txt")),
            (r"sub\b.bin".into(), dir.join("b.bin")),
        ]
    }

    #[test]
    fn create_extract_roundtrip_with_listfile() {
        let d = tempdir();
        let files = src_files(&d);
        let out = d.join("map.w3x");
        create_archive(&out, &files, true).unwrap();
        assert_eq!(extract_file(&out, "a.txt").unwrap().unwrap(), b"alpha");
        assert_eq!(
            extract_file(&out, r"sub\b.bin").unwrap().unwrap(),
            "中文内容".as_bytes()
        );
        assert_eq!(extract_file(&out, "missing").unwrap(), None);
        let names = read_listfile(&out).unwrap().unwrap();
        assert!(names.contains(&"a.txt".to_string()));
        assert!(names.contains(&r"sub\b.bin".to_string()));
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn create_without_listfile_has_none() {
        let d = tempdir();
        let files = src_files(&d);
        let out = d.join("map.w3x");
        create_archive(&out, &files, false).unwrap();
        assert_eq!(read_listfile(&out).unwrap(), None);
        assert_eq!(extract_file(&out, "a.txt").unwrap().unwrap(), b"alpha");
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn add_files_appends_and_replaces() {
        let d = tempdir();
        let files = src_files(&d);
        let out = d.join("map.w3x");
        create_archive(&out, &files, true).unwrap();
        std::fs::write(d.join("a2.txt"), "ALPHA-NEW").unwrap();
        std::fs::write(d.join("c.txt"), "gamma").unwrap();
        add_files(
            &out,
            &[
                ("a.txt".into(), d.join("a2.txt")), // 覆盖
                ("c.txt".into(), d.join("c.txt")),  // 新增
            ],
        )
        .unwrap();
        assert_eq!(extract_file(&out, "a.txt").unwrap().unwrap(), b"ALPHA-NEW");
        assert_eq!(extract_file(&out, "c.txt").unwrap().unwrap(), b"gamma");
        assert_eq!(
            extract_file(&out, r"sub\b.bin").unwrap().unwrap(),
            "中文内容".as_bytes(),
            "原文件保留"
        );
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn add_files_with_missing_source_leaves_archive_untouched() {
        let d = tempdir();
        let files = src_files(&d);
        let out = d.join("map.w3x");
        create_archive(&out, &files, true).unwrap();
        // 不同内容的源文件：若预检缺失导致 a.txt 被部分覆盖，最终断言必然失败
        std::fs::write(d.join("a2.txt"), "ALPHA-NEW").unwrap();
        let err = add_files(
            &out,
            &[
                ("a.txt".into(), d.join("a2.txt")),        // 存在（内容不同）
                ("ghost.txt".into(), d.join("ghost.txt")), // 不存在 → 预检失败
            ],
        )
        .unwrap_err();
        assert_eq!(err.key, "error.io");
        // 预检在开档前触发，归档原条目不受影响
        assert_eq!(extract_file(&out, "a.txt").unwrap().unwrap(), b"alpha");
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn extract_to_writes_file_or_reports_missing() {
        let d = tempdir();
        let files = src_files(&d);
        let map = d.join("map.w3x");
        create_archive(&map, &files, true).unwrap();
        let out = d.join("nested/out.txt");
        assert!(extract_to(&map, "a.txt", &out).unwrap());
        assert_eq!(std::fs::read(&out).unwrap(), b"alpha");
        assert!(!extract_to(&map, "nope", &d.join("x")).unwrap());
        assert!(!d.join("x").exists());
        std::fs::remove_dir_all(&d).unwrap();
    }
}
