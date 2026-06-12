//! MopaqPack-rs.exe 子进程薄封装（TS utils.extractFileFromMap，
//! utils.ts:148-161）。阶段 2 将以 crate 依赖替换（设计决策 D3）。

use std::path::Path;

use crate::error::{Error, Result};

/// 从地图提取单个文件。退出码被忽略（与 TS 一致），以输出文件是否存在为准。
pub fn extract_file_from_map(
    exe: &Path,
    map: &Path,
    file_in_map: &str,
    out: &Path,
) -> Result<bool> {
    if out.exists() {
        std::fs::remove_file(out).map_err(|e| Error::io(out, e))?;
    }
    if let Some(dir) = out.parent() {
        std::fs::create_dir_all(dir).map_err(|e| Error::io(dir, e))?;
    }
    let status = std::process::Command::new(exe)
        .args(["extract", "-o"])
        .arg(out)
        .arg("-m")
        .arg(map)
        .args(["-f", file_in_map])
        .status()
        .map_err(|e| Error::new("error.io", format!("{}: {e}", exe.display())))?;
    let _ = status;
    Ok(out.exists())
}
