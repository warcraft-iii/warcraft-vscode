use std::path::Path;

/// 错误携带本地化 key（沿用 package.nls.json 命名空间）+ 参数，
/// CLI 层序列化为 NDJSON，TS 侧用 vscode-nls 渲染。
#[derive(Debug, thiserror::Error)]
#[error("{key}: {message}")]
pub struct Error {
    pub key: &'static str,
    pub message: String,
    pub args: Vec<String>,
}

impl Error {
    pub fn new(key: &'static str, message: impl Into<String>) -> Self {
        Self {
            key,
            message: message.into(),
            args: vec![],
        }
    }
    pub fn with_args(key: &'static str, message: impl Into<String>, args: Vec<String>) -> Self {
        Self {
            key,
            message: message.into(),
            args,
        }
    }
    pub fn io(path: &Path, e: std::io::Error) -> Self {
        Self::with_args(
            "error.io",
            format!("{}: {e}", path.display()),
            vec![path.display().to_string()],
        )
    }
}

pub type Result<T> = std::result::Result<T, Error>;
