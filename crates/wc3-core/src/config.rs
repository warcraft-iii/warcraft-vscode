use std::path::{Path, PathBuf};

use serde::Deserialize;

use crate::error::{Error, Result};

#[derive(Debug, Clone, Deserialize)]
struct RawConfig {
    mapdir: Option<String>,
    files: Option<Vec<String>>,
    jassfile: Option<String>,
    lua: Option<RawLua>,
}

#[derive(Debug, Clone, Deserialize)]
struct RawLua {
    package: Option<RawPackage>,
}

#[derive(Debug, Clone, Deserialize)]
struct RawPackage {
    path: Option<Vec<String>>,
}

#[derive(Debug, Clone)]
pub struct ProjectConfig {
    pub mapdir: Option<String>,
    pub files: Vec<String>,
    pub jassfile: Option<String>,
    pub lua_package_path: Vec<String>,
}

impl ProjectConfig {
    /// 比 TS 更严格：根节点非对象时报错（TS 静默回退默认配置）。
    pub fn from_json(json: &str) -> Result<Self> {
        let raw: RawConfig = serde_json::from_str(json)
            .map_err(|e| Error::new("error.invalidProjectConfig", format!("warcraft.json: {e}")))?;
        Ok(Self {
            mapdir: raw.mapdir,
            files: raw.files.unwrap_or_default(),
            jassfile: raw.jassfile,
            lua_package_path: raw
                .lua
                .and_then(|l| l.package)
                .and_then(|p| p.path)
                .unwrap_or_else(|| vec!["./?.lua".into(), "./?/init.lua".into()]),
        })
    }

    pub fn load(project_root: &Path) -> Result<Self> {
        let file = project_root.join("warcraft.json");
        let text = std::fs::read_to_string(&file).map_err(|e| Error::io(&file, e))?;
        Self::from_json(&text)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum Confusion {
    #[default]
    Disable,
    Minify,
    Weak,
    Medium,
    Strong,
}

#[derive(Debug, Clone, Default)]
pub struct BuildOptions {
    pub release: bool,
    pub classic: bool,
    /// 覆盖 warcraft.json 的 mapdir（对应 TS cli 的 -t/--target）
    pub map: Option<PathBuf>,
    pub confusion: Confusion,
}

#[derive(Debug, Clone)]
pub struct BuildContext {
    pub root: PathBuf,
    pub config: ProjectConfig,
    pub opts: BuildOptions,
}

impl BuildContext {
    pub fn new(root: &Path, config: ProjectConfig, opts: BuildOptions) -> Self {
        Self {
            root: root.to_path_buf(),
            config,
            opts,
        }
    }

    pub fn source_dir(&self) -> PathBuf {
        self.root.join("src")
    }
    pub fn build_dir(&self) -> PathBuf {
        self.root.join(".build")
    }
    pub fn map_dir(&self) -> Result<PathBuf> {
        if let Some(m) = &self.opts.map {
            return Ok(if m.is_absolute() {
                m.clone()
            } else {
                self.root.join(m)
            });
        }
        match &self.config.mapdir {
            Some(d) => Ok(self.root.join(d)),
            None => Err(Error::new("error.noMapFolder", "Not found: map folder")),
        }
    }
    pub fn jassfile(&self) -> Option<PathBuf> {
        self.config.jassfile.as_ref().map(|j| self.root.join(j))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parses_project_config_with_defaults() {
        let json = r#"{ "mapdir": "map", "files": ["extra.lua"], "jassfile": "war3map.j" }"#;
        let cfg = ProjectConfig::from_json(json).unwrap();
        assert_eq!(cfg.mapdir.as_deref(), Some("map"));
        assert_eq!(cfg.files, vec!["extra.lua"]);
        assert_eq!(cfg.jassfile.as_deref(), Some("war3map.j"));
        assert_eq!(cfg.lua_package_path, vec!["./?.lua", "./?/init.lua"]);
    }

    #[test]
    fn build_context_paths() {
        let cfg = ProjectConfig::from_json(r#"{ "mapdir": "map" }"#).unwrap();
        let ctx = BuildContext::new(
            std::path::Path::new("/proj"),
            cfg,
            BuildOptions::default(),
        );
        assert_eq!(ctx.source_dir(), std::path::Path::new("/proj/src"));
        assert_eq!(ctx.build_dir(), std::path::Path::new("/proj/.build"));
        assert_eq!(ctx.map_dir().unwrap(), std::path::Path::new("/proj/map"));
    }

    #[test]
    fn files_null_falls_back_to_empty() {
        let cfg = ProjectConfig::from_json(r#"{ "files": null }"#).unwrap();
        assert!(cfg.files.is_empty());
    }

    #[test]
    fn map_dir_override_precedence() {
        let cfg = ProjectConfig::from_json(r#"{ "mapdir": "map" }"#).unwrap();
        let opts = BuildOptions {
            map: Some(std::path::PathBuf::from("other")),
            ..Default::default()
        };
        let ctx = BuildContext::new(std::path::Path::new("/proj"), cfg.clone(), opts);
        assert_eq!(ctx.map_dir().unwrap(), std::path::Path::new("/proj/other"));
        let opts = BuildOptions {
            map: Some(std::path::PathBuf::from("/abs/map.w3x")),
            ..Default::default()
        };
        let ctx = BuildContext::new(std::path::Path::new("/proj"), cfg, opts);
        assert_eq!(
            ctx.map_dir().unwrap(),
            std::path::Path::new("/abs/map.w3x")
        );
    }

    #[test]
    fn missing_mapdir_errors_with_key() {
        let cfg = ProjectConfig::from_json("{}").unwrap();
        let ctx = BuildContext::new(
            std::path::Path::new("/proj"),
            cfg,
            BuildOptions::default(),
        );
        assert_eq!(ctx.map_dir().unwrap_err().key, "error.noMapFolder");
    }
}
