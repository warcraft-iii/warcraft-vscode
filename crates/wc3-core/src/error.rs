use std::path::Path;

/// 错误携带本地化 key（与 TS 端 vscode-nls localize(key, default) 的 key 命名一致）+ 参数，
/// CLI 层序列化为 NDJSON，TS 侧用 vscode-nls 渲染。
/// `file` / `line` 可选字段：当错误源于特定源文件时填充，插件侧可用于 Diagnostics 定位。
#[derive(Debug, thiserror::Error)]
#[error("{key}: {message}")]
pub struct Error {
    pub key: &'static str,
    pub message: String,
    pub args: Vec<String>,
    /// 报错关联的源文件路径（相对于工程根目录，如 "src/main.lua"）
    pub file: Option<String>,
    /// 报错关联的行号（1-based）
    pub line: Option<u32>,
}

impl Error {
    pub fn new(key: &'static str, message: impl Into<String>) -> Self {
        Self {
            key,
            message: message.into(),
            args: vec![],
            file: None,
            line: None,
        }
    }
    pub fn with_args(key: &'static str, message: impl Into<String>, args: Vec<String>) -> Self {
        Self {
            key,
            message: message.into(),
            args,
            file: None,
            line: None,
        }
    }
    pub fn io(path: &Path, e: std::io::Error) -> Self {
        Self {
            key: "error.io",
            message: format!("{}: {e}", path.display()),
            args: vec![path.display().to_string(), e.to_string()],
            file: None,
            line: None,
        }
    }
    /// 附加源文件定位信息（链式调用）。
    pub fn with_location(mut self, file: impl Into<String>, line: Option<u32>) -> Self {
        self.file = Some(file.into());
        self.line = line;
        self
    }
}

pub type Result<T> = std::result::Result<T, Error>;
