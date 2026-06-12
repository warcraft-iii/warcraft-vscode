# Rust 核心拆分 — 阶段 2 实施计划（pack / objediting / build）

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现 `wc3 pack` / `wc3 objediting` / `wc3 build` 子命令，MopaqPack-rs 以 stormlib crate 形式集成（git 依赖），compile 管线的地图提取同步改库调用并删除 mopaq.rs 子进程封装。

**Architecture:** wc3-core 新增 mpq.rs（stormlib 封装）、packer.rs（packlist 生成 + 归档）、objediting.rs（def 管理 + 物编编排）；compiler.rs 的 `Tools` 收缩为仅 confuse_exe。测试 = 单测 + TS 对照归档（内容级：文件名集合 + 逐文件字节）。

**Tech Stack:** stormlib（git dep `warcraft-iii/MopaqPack-rs` rev `06ceb1de710177140ade76bfbb9fff0ec3a1ce16`）、zip crate、既有 full-moon/mlua/walkdir 等。

**Spec:** `docs/superpowers/specs/2026-06-12-rust-core-phase2-pack-objediting-design.md`（决策 P1-P4、偏差 DV8-DV11）

---

## 约定

- **先切分支**：`git checkout -b rust-core-phase2`（main 上不直接实施）。
- 所有 Rust 命令在仓库根执行；提交信息用 conventional commits，每条以 `Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>` 结尾（下文从略，执行时必须带上）。
- 沿用阶段 1 测试惯例：tempdir 用「进程 id + 静态计数器」防并发冲突，测试尾部清理。
- stormlib 构建需 cmake（本机 4.2.3 已确认）+ MSVC；GitHub windows-latest 自带。

## 文件结构（本阶段新增/修改）

```
Cargo.toml                          # [修改] workspace.dependencies 加 stormlib(git)、zip
crates/wc3-core/
  Cargo.toml                        # [修改] 引入 stormlib、zip
  src/lib.rs                        # [修改] mopaq → mpq；加 packer、objediting
  src/mpq.rs                        # [新增] stormlib 封装
  src/mopaq.rs                      # [删除]
  src/fsutil.rs                     # [修改] windows_relative + collect_pack_files
  src/compiler.rs                   # [修改] Tools 收缩；提取走 mpq
  src/packer.rs                     # [新增]
  src/objediting.rs                 # [新增]
  tests/golden.rs                   # [修改] Tools 适配
  tests/golden_pack.rs              # [新增] pack 黄金对照
crates/wc3-cli/src/main.rs          # [修改] objediting/pack/build 子命令
testdata/fixtures/basic/            # [修改] 补 imports 矩阵样例（全部非 .lua，阶段 1 黄金不变）
testdata/golden/basic/{debug,release}-reforge-pack/   # [生成] TS 归档黄金
scripts/make-golden.ps1             # [修改] 追加 pack 黄金步
bin/MopaqPack-rs.exe                # [本地构建产物，供 make-golden 用，不入库（.gitignore 不管 bin/，确认勿 git add）]
```

---

### Task 1: stormlib git 依赖 + mpq.rs（含 cmake spike）

**Files:**
- Modify: `Cargo.toml`、`crates/wc3-core/Cargo.toml`、`crates/wc3-core/src/lib.rs`
- Create: `crates/wc3-core/src/mpq.rs`

- [ ] **Step 0: 切分支**

```bash
git checkout -b rust-core-phase2
```

- [ ] **Step 1: 声明依赖**

根 `Cargo.toml` 的 `[workspace.dependencies]` 追加：

```toml
stormlib = { git = "https://github.com/warcraft-iii/MopaqPack-rs", rev = "06ceb1de710177140ade76bfbb9fff0ec3a1ce16" }
zip = { version = "2", default-features = false, features = ["deflate"] }
```

`crates/wc3-core/Cargo.toml` 的 `[dependencies]` 追加：

```toml
stormlib.workspace = true
zip.workspace = true
```

`crates/wc3-core/src/lib.rs`：`pub mod mopaq;` 之后临时并存加 `pub mod mpq;`（mopaq 在 Task 2 删除）。

- [ ] **Step 2: 写失败测试（mpq.rs 尾部）**

```rust
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
```

- [ ] **Step 3: 构建确认失败（同时是 cmake spike）**

Run: `cargo test -p wc3-core mpq`
Expected: 先经历 stormlib git 拉取（含 StormLib 子模块）+ cmake 构建。两种结果：
- 编译失败仅因 mpq 函数未定义 → spike 通过，继续 Step 4。
- **cmake 配置报错**（典型：`Compatibility with CMake < 3.5 has been removed`）→ 执行兜底：在 `../MopaqPack-rs/crates/stormlib-sys/build.rs` 的 `cmake::Config::new(&stormlib_path)` 后链式追加 `.define("CMAKE_POLICY_VERSION_MINIMUM", "3.5")`（放进现有 `let mut cfg = ...;` 之后：`cfg.define("CMAKE_POLICY_VERSION_MINIMUM", "3.5");`），在该仓库提交 `fix(sys): cmake 4.x compatibility (CMAKE_POLICY_VERSION_MINIMUM)` 并 `git push origin master`（决策 P3 已授权），然后把本仓库 `Cargo.toml` 的 `rev` 更新为新 sha，`cargo update -p stormlib` 后重试本 Step。

- [ ] **Step 4: 实现 mpq.rs（tests 之前）**

```rust
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
    if !ar.has_file(name_in_map).map_err(|e| mpq_err(map, name_in_map, e))? {
        return Ok(None);
    }
    let mut f = ar
        .open_file(name_in_map)
        .map_err(|e| mpq_err(map, name_in_map, e))?;
    Ok(Some(f.read_all().map_err(|e| mpq_err(map, name_in_map, e))?))
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
        ar.write_file(name, &data).map_err(|e| mpq_err(out, name, e))?;
    }
    Ok(())
}

/// 向现有归档追加（TS MopaqPack pack）：扩容 + add_file（同名覆盖）+ compact。
pub fn add_files(map: &Path, files: &[(String, PathBuf)]) -> Result<()> {
    let mut ar = stormlib::Archive::open(map, stormlib::OpenArchiveFlags::MPQ_OPEN_NO_FLAG)
        .map_err(|e| mpq_err(map, "open", e))?;
    let count = ar.get_max_files().map_err(|e| mpq_err(map, "max_files", e))?;
    ar.set_max_files(count + files.len() as u32)
        .map_err(|e| mpq_err(map, "max_files", e))?;
    for (name, path) in files {
        let local = path
            .to_str()
            .ok_or_else(|| Error::new("error.io", format!("non-utf8 path: {}", path.display())))?;
        ar.add_file(name, local).map_err(|e| mpq_err(map, name, e))?;
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
```

实现备注：stormlib 的 `Archive::open/create` 在 Windows 走宽字符（中文路径 OK）；`add_file` 的 local path 是 `&str`（UTF-8 → U16CString）。`add_file` 内部先 `remove_file` 再添加，即同名覆盖。若 `has_file` 对 `(listfile)` 行为异常（内部文件），`read_listfile` 测试会暴露——届时改为直接 `open_file` 并把错误码 `ERROR_FILE_NOT_FOUND` 映射为 None。

- [ ] **Step 5: 测试通过**

Run: `cargo test -p wc3-core mpq`
Expected: 4 个测试 PASS。

- [ ] **Step 6: 全量回归 + Commit**

Run: `cargo fmt --all -- --check && cargo clippy --workspace --all-targets -- -D warnings && cargo test --workspace`
Expected: 全绿（Cargo.lock 因新依赖更新，一并提交）。

```bash
git add Cargo.toml Cargo.lock crates/wc3-core
git commit -m "feat(core): mpq module backed by stormlib crate (git dep)"
```

### Task 2: compiler.rs 切换 mpq、删除 mopaq.rs

**Files:**
- Modify: `crates/wc3-core/src/compiler.rs`、`crates/wc3-core/src/lib.rs`、`crates/wc3-core/tests/golden.rs`、`crates/wc3-cli/src/main.rs`
- Delete: `crates/wc3-core/src/mopaq.rs`

- [ ] **Step 1: 写失败测试（compiler.rs tests 追加）**

```rust
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
```

- [ ] **Step 2: 编译确认失败**

Run: `cargo test -p wc3-core compiler`
Expected: 编译失败（`compile_debug` 还要 Tools 参数）。

- [ ] **Step 3: 改造 compiler.rs**

1. `Tools` 收缩并删 `mopaq()`：

```rust
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
```

2. 头部 use：`mopaq` → `mpq`。
3. `origin_map_script(ctx: &BuildContext)`（去掉 tools 参）：

```rust
fn origin_map_script(ctx: &BuildContext) -> Result<PathBuf> {
    let map = ctx.map_dir()?;
    if map.is_file() {
        let out = ctx.build_dir().join("origwar3map.lua.extracted");
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
```

4. `write_injected_jass(ctx: &BuildContext)` 同法（`mopaq::extract_file_from_map(exe, ...)` 两处换 `mpq::extract_to(&map, ...)`，去掉 `let exe = tools.mopaq()?;`）。
5. 签名：`compile_debug(ctx: &BuildContext) -> Result<()>`（不再收 tools）；`compile_release(ctx: &BuildContext, tools: &Tools) -> Result<()>`。函数体内对 `origin_map_script(ctx)`/`write_injected_jass(ctx)` 的调用同步去掉 tools 实参。
6. tests 模块：`NO_TOOLS` 改为 `Tools { confuse_exe: None }`；所有 `compile_debug(..., &NO_TOOLS)` 改为 `compile_debug(...)`。
7. `lib.rs`：删除 `pub mod mopaq;`；删除文件 `src/mopaq.rs`。
8. `tests/golden.rs`：`NO_TOOLS` 同步收缩；`compile_debug(&ctx, &NO_TOOLS)` → `compile_debug(&ctx)`。
9. `crates/wc3-cli/src/main.rs`：删除 `let mopaq = ...` 两行与 `mopaq_exe` 字段；`compile_debug(&ctx, &tools)` → `compile_debug(&ctx)`；`--res-dir` 的 doc 注释改为 `/// Directory containing wc3-confuse.exe (defaults next to wc3.exe)`。

- [ ] **Step 4: 测试通过 + 黄金回归**

Run: `cargo test -p wc3-core`
Expected: 全部 PASS（含新 2 测试、golden 2 测试——fixtures 走目录地图与 jassfile，提取路径变化不影响）。

- [ ] **Step 5: Commit**

```bash
git rm crates/wc3-core/src/mopaq.rs
git add crates
git commit -m "refactor(core): map extraction via stormlib, drop MopaqPack-rs.exe dependency"
```

### Task 3: fsutil — windows_relative 与 collect_pack_files

**Files:**
- Modify: `crates/wc3-core/src/fsutil.rs`

- [ ] **Step 1: 写失败测试（fsutil tests 追加）**

```rust
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
        let files = collect_pack_files(&dir).unwrap();
        let rel: Vec<String> = files
            .iter()
            .map(|f| posix_relative(&dir, f).unwrap())
            .collect();
        assert_eq!(rel, vec!["a.lua", "b.txt", "sub/c.txt"]);
        // 不存在/非目录 → 空（TS generatePackItems 行为）
        assert!(collect_pack_files(&dir.join("nope")).unwrap().is_empty());
        assert!(collect_pack_files(&dir.join("b.txt")).unwrap().is_empty());
        std::fs::remove_dir_all(&dir).unwrap();
    }
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core fsutil`
Expected: 编译失败（函数未定义）。

- [ ] **Step 3: 实现（posix_relative 旁）**

```rust
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

/// 递归收集 root 下全部非隐藏文件（packer 用）；root 不存在或非目录返回空
/// （TS generatePackItems）。按 posix 相对路径字典序（DV5）。
pub fn collect_pack_files(root: &Path) -> Result<Vec<PathBuf>> {
    if !root.is_dir() {
        return Ok(Vec::new());
    }
    let mut files: Vec<PathBuf> = Vec::new();
    for entry in walkdir::WalkDir::new(root) {
        let entry = entry.map_err(|e| {
            let p = e.path().unwrap_or(root).to_path_buf();
            match e.into_io_error() {
                Some(io) => Error::io(&p, io),
                None => Error::new("error.io", format!("{}: walk error", p.display())),
            }
        })?;
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
```

- [ ] **Step 4: 测试通过 + Commit**

Run: `cargo test -p wc3-core fsutil`
Expected: 5 个测试 PASS（含原 3 个）。

```bash
git add crates/wc3-core
git commit -m "feat(core): pack file collection and windows-style relative names"
```

### Task 4: packer.rs — packlist 生成

**Files:**
- Create: `crates/wc3-core/src/packer.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod packer;`）

- [ ] **Step 1: 写失败测试（packer.rs 尾部）**

```rust
#[cfg(test)]
mod tests {
    use super::*;
    use crate::config::{BuildContext, BuildOptions, ProjectConfig};

    fn tempdir() -> std::path::PathBuf {
        static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
        let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        let d = std::env::temp_dir().join(format!("wc3-packer-{}-{n}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }

    /// 覆盖 packlist 全部来源与同名覆盖的合成工程。
    fn synth_project() -> std::path::PathBuf {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        // map 目录：lua 排除、子目录、与 imports 同名（imports 应胜出）
        std::fs::create_dir_all(d.join("map/icons")).unwrap();
        std::fs::write(d.join("map/war3map.lua"), "lua").unwrap();
        std::fs::write(d.join("map/data.txt"), "map-data").unwrap();
        std::fs::write(d.join("map/icons/i.txt"), "icon").unwrap();
        // lib imports：common + override（root 应胜出）
        std::fs::create_dir_all(d.join("src/lib/console/imports")).unwrap();
        std::fs::write(d.join("src/lib/console/imports/common.txt"), "lib-common").unwrap();
        std::fs::write(d.join("src/lib/console/imports/override.txt"), "from-lib").unwrap();
        std::fs::create_dir_all(d.join("src/lib/console/imports.debug")).unwrap();
        std::fs::write(d.join("src/lib/console/imports.debug/libdbg.txt"), "x").unwrap();
        // 根 imports：override 同名 + data.txt 与 map 同名 + 隐藏排除
        std::fs::create_dir_all(d.join("imports")).unwrap();
        std::fs::write(d.join("imports/override.txt"), "from-root").unwrap();
        std::fs::write(d.join("imports/data.txt"), "imports-data").unwrap();
        std::fs::write(d.join("imports/.hidden.txt"), "x").unwrap();
        std::fs::create_dir_all(d.join("imports.release")).unwrap();
        std::fs::write(d.join("imports.release/rel.txt"), "x").unwrap();
        std::fs::create_dir_all(d.join("imports.reforge/sub")).unwrap();
        std::fs::write(d.join("imports.reforge/sub/rf.txt"), "x").unwrap();
        std::fs::create_dir_all(d.join("imports.classic")).unwrap();
        std::fs::write(d.join("imports.classic/cls.txt"), "x").unwrap();
        // objediting 产物
        std::fs::create_dir_all(d.join(".build/objediting")).unwrap();
        std::fs::write(d.join(".build/objediting/war3map.w3u"), "obj").unwrap();
        std::fs::write(d.join(".build/war3map.lua"), "entry").unwrap();
        std::fs::write(d.join(".build/war3map.j"), "jass").unwrap();
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

    fn names(items: &[PackItem]) -> Vec<&str> {
        items.iter().map(|(n, _)| n.as_str()).collect()
    }

    #[test]
    fn packlist_debug_reforge_order_and_dedup() {
        let root = synth_project();
        let items = generate_packlist(&ctx(&root, false, false)).unwrap();
        // 推入序：map(data.txt, icons\i.txt) → imports(lib: common,override；root: .hidden 排除,
        // data,override) → imports.debug(lib: libdbg) → imports.reforge(sub\rf) → objediting → war3map.lua
        // reduceRight：反序 + 同名后者优先
        assert_eq!(
            names(&items),
            vec![
                "war3map.lua",
                r"war3map.w3u",
                r"sub\rf.txt",
                "libdbg.txt",
                "override.txt",
                "data.txt",
                "common.txt",
                r"icons\i.txt",
            ]
        );
        // 同名覆盖：override 取根 imports，data 取 imports
        let get = |n: &str| {
            std::fs::read_to_string(&items.iter().find(|(name, _)| name == n).unwrap().1).unwrap()
        };
        assert_eq!(get("override.txt"), "from-root");
        assert_eq!(get("data.txt"), "imports-data");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn packlist_release_classic_variant() {
        let root = synth_project();
        let items = generate_packlist(&ctx(&root, true, true)).unwrap();
        let n = names(&items);
        assert_eq!(n[0], "war3map.j", "classic 追加 war3map.j（反序后最前）");
        assert_eq!(n[1], "war3map.lua");
        assert!(n.contains(&"cls.txt"), "imports.classic 启用");
        assert!(n.contains(&"rel.txt"), "imports.release 启用");
        assert!(!n.contains(&"libdbg.txt"), "imports.debug 关闭");
        assert!(!n.contains(&r"sub\rf.txt"), "imports.reforge 关闭");
        // classic：map 目录是 dir 时其文件仍收集（packByPackList 阶段才报错，与 TS 一致）
        assert!(n.contains(&r"icons\i.txt"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn packlist_missing_lib_dir_is_empty_list() {
        // DV11：无 src/lib 不报错。war3map.lua 条目是无条件 push 的，无需真实文件。
        let root = tempdir();
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(root.join("map")).unwrap();
        let items = generate_packlist(&ctx(&root, false, false)).unwrap();
        assert_eq!(names(&items), vec!["war3map.lua"]);
        std::fs::remove_dir_all(&root).unwrap();
    }
}
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core packer`
Expected: 编译失败。

- [ ] **Step 3: 实现（packer.rs 头部）**

```rust
//! TS Packer 移植（src/app/packer/packer.ts）：packlist 生成与 MPQ 打包。
//! 顺序/去重语义复刻 TS（spec 阶段 2 §4.1-§4.2，偏差 DV8/DV10/DV11）。

use std::collections::HashSet;
use std::path::{Path, PathBuf};

use crate::config::BuildContext;
use crate::error::{Error, Result};
use crate::{fsutil, mpq};

/// (归档内相对名（`\` 分隔）, 源文件绝对路径)
pub type PackItem = (String, PathBuf);

/// TS generatePackItems：单根目录 → 条目；root 非目录返回空。
fn pack_items_from(root: &Path, exclude_lua: bool) -> Result<Vec<PackItem>> {
    let mut items = Vec::new();
    for f in fsutil::collect_pack_files(root)? {
        if exclude_lua && fsutil::is_lua_file(&f) {
            continue;
        }
        items.push((fsutil::windows_relative(root, &f)?, f));
    }
    Ok(items)
}

/// src/lib 下一级条目名（含文件——TS readdir 同语义，文件名拼 imports 路径后自然不存在）。
/// DV11：目录缺失按空；DV5：字典序。
fn lib_names(ctx: &BuildContext) -> Result<Vec<String>> {
    let lib_dir = ctx.source_dir().join("lib");
    if !lib_dir.is_dir() {
        return Ok(Vec::new());
    }
    let mut names: Vec<String> = std::fs::read_dir(&lib_dir)
        .map_err(|e| Error::io(&lib_dir, e))?
        .filter_map(|e| e.ok())
        .map(|e| e.file_name().to_string_lossy().into_owned())
        .collect();
    names.sort();
    Ok(names)
}

/// TS Packer.generatePackList：收集 + reduceRight 去重（同名后写入者优先，结果反序）。
pub fn generate_packlist(ctx: &BuildContext) -> Result<Vec<PackItem>> {
    let mut items: Vec<PackItem> = Vec::new();

    items.extend(pack_items_from(&ctx.map_dir()?, true)?);

    let imports = [
        "imports".to_string(),
        format!(
            "imports.{}",
            if ctx.opts.release { "release" } else { "debug" }
        ),
        format!(
            "imports.{}",
            if ctx.opts.classic { "classic" } else { "reforge" }
        ),
    ];
    let libs = lib_names(ctx)?;
    for imp in &imports {
        for lib in &libs {
            items.extend(pack_items_from(
                &ctx.source_dir().join("lib").join(lib).join(imp),
                false,
            )?);
        }
        items.extend(pack_items_from(&ctx.root.join(imp), false)?);
    }

    items.extend(pack_items_from(&ctx.build_dir().join("objediting"), false)?);

    items.push(("war3map.lua".into(), ctx.build_dir().join("war3map.lua")));
    if ctx.opts.classic {
        items.push(("war3map.j".into(), ctx.build_dir().join("war3map.j")));
    }

    let mut seen: HashSet<String> = HashSet::new();
    let mut out: Vec<PackItem> = Vec::new();
    for item in items.into_iter().rev() {
        if seen.insert(item.0.clone()) {
            out.push(item);
        }
    }
    Ok(out)
}
```

- [ ] **Step 4: 测试通过 + Commit**

Run: `cargo test -p wc3-core packer`
Expected: 3 个测试 PASS。

```bash
git add crates/wc3-core
git commit -m "feat(core): packlist generation replicating TS order and dedup"
```

### Task 5: packer.rs — pack 编排与产物路径

**Files:**
- Modify: `crates/wc3-core/src/packer.rs`

- [ ] **Step 1: 写失败测试（packer tests 追加）**

```rust
    #[test]
    fn out_file_name_by_config_and_ext() {
        let root = synth_project();
        assert!(out_file_path(&ctx(&root, false, false))
            .unwrap()
            .ends_with(".build/_warcraft_vscode_test"));
        assert!(out_file_path(&ctx(&root, true, false))
            .unwrap()
            .ends_with(".build/release"));
        // mapdir 带扩展名 → 产物带扩展名
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "map.w3x" }"#).unwrap();
        assert!(out_file_path(&ctx(&root, true, false))
            .unwrap()
            .ends_with(".build/release.w3x"));
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_reforge_dir_creates_archive() {
        let root = synth_project();
        // debug：带 listfile
        let out = pack(&ctx(&root, false, false)).unwrap();
        assert!(out.ends_with(".build/_warcraft_vscode_test"));
        let names = mpq::read_listfile(&out).unwrap().unwrap();
        assert!(names.contains(&"war3map.lua".to_string()));
        assert_eq!(
            mpq::extract_file(&out, "override.txt").unwrap().unwrap(),
            b"from-root"
        );
        assert_eq!(
            mpq::extract_file(&out, "war3map.lua").unwrap().unwrap(),
            b"entry"
        );
        // release：无 listfile
        let out = pack(&ctx(&root, true, false)).unwrap();
        assert!(mpq::read_listfile(&out).unwrap().is_none());
        assert_eq!(
            mpq::extract_file(&out, "rel.txt").unwrap().unwrap(),
            b"x"
        );
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_classic_file_map_copies_then_appends() {
        let root = synth_project();
        // 自造基底地图：含将被覆盖的 war3map.j 与应保留的 base.txt
        std::fs::write(root.join("orig-j.txt"), "orig-jass").unwrap();
        std::fs::write(root.join("base.txt"), "base").unwrap();
        let map = root.join("the.w3x");
        mpq::create_archive(
            &map,
            &[
                ("war3map.j".into(), root.join("orig-j.txt")),
                ("base.txt".into(), root.join("base.txt")),
            ],
            true,
        )
        .unwrap();
        std::fs::write(root.join("warcraft.json"), r#"{ "mapdir": "the.w3x" }"#).unwrap();
        let out = pack(&ctx(&root, false, true)).unwrap();
        assert!(out.ends_with(".build/_warcraft_vscode_test.w3x"));
        assert_eq!(mpq::extract_file(&out, "base.txt").unwrap().unwrap(), b"base");
        assert_eq!(
            mpq::extract_file(&out, "war3map.j").unwrap().unwrap(),
            b"jass",
            ".build/war3map.j 覆盖原图"
        );
        assert_eq!(
            mpq::extract_file(&out, "cls.txt").unwrap().unwrap(),
            b"x",
            "imports.classic 进包"
        );
        assert_eq!(
            mpq::extract_file(&map, "war3map.j").unwrap().unwrap(),
            b"orig-jass",
            "原地图不被修改"
        );
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_classic_dir_map_rejected() {
        // DV10
        let root = synth_project();
        let err = pack(&ctx(&root, false, true)).unwrap_err();
        assert_eq!(err.key, "error.invalidMapFile");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn pack_requires_compiled_entry() {
        let root = synth_project();
        std::fs::remove_file(root.join(".build/war3map.lua")).unwrap();
        let err = pack(&ctx(&root, false, false)).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        std::fs::remove_dir_all(&root).unwrap();
    }
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core packer`
Expected: 编译失败（`pack`/`out_file_path` 未定义）。

- [ ] **Step 3: 实现（generate_packlist 之后）**

```rust
/// TS env.outFilePath：.build/{_warcraft_vscode_test|release}<mapdir 扩展名>。
pub fn out_file_path(ctx: &BuildContext) -> Result<PathBuf> {
    let map = ctx.map_dir()?;
    let ext = map
        .extension()
        .map(|e| format!(".{}", e.to_string_lossy()))
        .unwrap_or_default();
    let name = if ctx.opts.release {
        "release"
    } else {
        "_warcraft_vscode_test"
    };
    Ok(ctx.build_dir().join(format!("{name}{ext}")))
}

/// TS Packer.execute（generatePackList + packByPackList）。返回产物路径（--output 复制用）。
pub fn pack(ctx: &BuildContext) -> Result<PathBuf> {
    let entry = ctx.build_dir().join("war3map.lua");
    if !entry.is_file() {
        return Err(Error::with_args(
            "error.notFound",
            "Not found .build/war3map.lua (run compile first)",
            vec!["war3map.lua".into()],
        ));
    }
    if ctx.opts.classic && !ctx.build_dir().join("war3map.j").is_file() {
        return Err(Error::with_args(
            "error.notFound",
            "Not found .build/war3map.j (run compile first)",
            vec!["war3map.j".into()],
        ));
    }
    let map = ctx.map_dir()?;
    if ctx.opts.classic && map.is_dir() {
        // DV10：TS 同场景为隐性崩溃，这里显式化
        return Err(Error::new(
            "error.invalidMapFile",
            "Classic version ONLY support .w3x/.w3m format map file.",
        ));
    }
    let items = generate_packlist(ctx)?;
    let out = out_file_path(ctx)?;
    if map.is_dir() {
        mpq::create_archive(&out, &items, !ctx.opts.release)?;
    } else if map.is_file() {
        std::fs::copy(&map, &out).map_err(|e| Error::io(&out, e))?;
        mpq::add_files(&out, &items)?;
    } else {
        return Err(Error::new("error.noMapFolder", "Not found: map folder"));
    }
    Ok(out)
}
```

- [ ] **Step 4: 测试通过 + Commit**

Run: `cargo test -p wc3-core packer`
Expected: 8 个测试 PASS（含 Task 4 的 3 个）。

```bash
git add crates/wc3-core
git commit -m "feat(core): map packing via stormlib (generate and copy-append paths)"
```

### Task 6: objediting.rs

**Files:**
- Create: `crates/wc3-core/src/objediting.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod objediting;`）

- [ ] **Step 1: 写失败测试（objediting.rs 尾部）**

```rust
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
        std::fs::write(res.join(".version.json"), format!(r#"{{"def":"{version}"}}"#)).unwrap();
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
        assert!(find_script(&d, false).unwrap().ends_with("objediting/main.lua"));
        std::fs::create_dir_all(d.join("objediting.reforge")).unwrap();
        std::fs::write(d.join("objediting.reforge/main.lua"), "x").unwrap();
        assert!(find_script(&d, false)
            .unwrap()
            .ends_with("objediting.reforge/main.lua"));
        assert!(
            find_script(&d, true).unwrap().ends_with("objediting/main.lua"),
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
        assert_eq!(std::fs::read_to_string(out.join("war3map.w3u")).unwrap(), "units");
        assert_eq!(std::fs::read_to_string(out.join("war3map.w3t")).unwrap(), "items");
        assert!(!out.join("war3map.w3b").exists(), "缺失类型跳过");
        std::fs::remove_dir_all(&d).unwrap();
    }

    #[test]
    fn prepare_extracts_classic_object_files() {
        let d = tempdir();
        std::fs::write(d.join("u.bin"), "units").unwrap();
        let map = d.join("the.w3x");
        crate::mpq::create_archive(&map, &[("war3map.w3u".into(), d.join("u.bin"))], true)
            .unwrap();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "the.w3x" }"#).unwrap();
        let out = prepare_object_files(&ctx(&d, true)).unwrap();
        assert_eq!(std::fs::read_to_string(out.join("war3map.w3u")).unwrap(), "units");
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
    fn execute_classic_dir_map_rejected_and_exe_missing_reported() {
        let d = tempdir();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map" }"#).unwrap();
        std::fs::create_dir_all(d.join("map")).unwrap();
        std::fs::create_dir_all(d.join("objediting")).unwrap();
        std::fs::write(d.join("objediting/main.lua"), "x").unwrap();
        let res = make_res(&d, "v1");
        let err = execute(&ctx(&d, true), &res).unwrap_err();
        assert_eq!(err.key, "error.invalidMapFile");
        // reforge + 脚本存在 + exe 缺失
        let err = execute(&ctx(&d, false), &res).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        assert!(err.message.contains("ObjEditing.exe"));
        std::fs::remove_dir_all(&d).unwrap();
    }
}
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core objediting`
Expected: 编译失败。

- [ ] **Step 3: 实现（objediting.rs 头部）**

```rust
//! TS ObjEditing 移植（src/app/objediting/objediting.ts）：def 资源管理、
//! 物编源文件准备、ObjEditing.exe 编排（spec 阶段 2 §4.3，偏差 DV9）。

use std::path::{Path, PathBuf};

use crate::config::BuildContext;
use crate::error::{Error, Result};
use crate::{fsutil, mpq};

const OBJ_EXTS: [&str; 7] = ["w3u", "w3t", "w3b", "w3h", "w3d", "w3a", "w3q"];

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
/// 清空产物目录 → 源准备 → ObjEditing.exe。
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
    let exe = res_dir.join("ObjEditing.exe");
    if !exe.is_file() {
        return Err(Error::with_args(
            "error.notFound",
            "Not found ObjEditing.exe",
            vec!["ObjEditing.exe".into()],
        ));
    }
    let output = std::process::Command::new(&exe)
        .arg("-m")
        .arg(&source_dir)
        .arg("-o")
        .arg(&out_dir)
        .arg(&script)
        .output()
        .map_err(|e| Error::new("error.io", format!("{}: {e}", exe.display())))?;
    let stderr = String::from_utf8_lossy(&output.stderr);
    // TS utils.execFile 语义：非零退出或 stderr 非空均视为失败
    if !output.status.success() || !stderr.trim().is_empty() {
        return Err(Error::new(
            "error.processFilesFailure",
            format!("ObjEditing failed: {}", stderr.trim()),
        ));
    }
    Ok(())
}
```

实现备注：真实 ObjEditing.exe 的编排不写自动化集成测试（需有效 .def 与物编脚本，外部依赖过深）——由阶段验收的真实工程人工抽验覆盖。

- [ ] **Step 4: 测试通过 + Commit**

Run: `cargo test -p wc3-core objediting`
Expected: 7 个测试 PASS。

```bash
git add crates/wc3-core
git commit -m "feat(core): objediting orchestration (def management, source prep, exe wrapper)"
```

### Task 7: wc3-cli — objediting / pack / build 子命令

**Files:**
- Modify: `crates/wc3-cli/src/main.rs`

- [ ] **Step 1: 实现**

在 `Command` 枚举追加三个变体（`Compile` 之后）：

```rust
    /// Run object editing (requires ObjEditing.exe in --res-dir)
    Objediting {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        /// Directory containing ObjEditing.exe / def.zip (defaults next to wc3.exe)
        #[arg(long)]
        res_dir: Option<PathBuf>,
    },
    /// Pack .build outputs and imports into a map archive (requires prior compile)
    Pack {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        release: bool,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        /// Copy resulting archive to this path
        #[arg(short, long)]
        output: Option<PathBuf>,
    },
    /// objediting + compile + pack in one go
    Build {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        release: bool,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        /// Copy resulting archive to this path
        #[arg(short, long)]
        output: Option<PathBuf>,
        #[arg(long, value_enum, default_value = "disable")]
        confusion: ConfusionArg,
        /// Directory containing ObjEditing.exe / def.zip / wc3-confuse.exe (defaults next to wc3.exe)
        #[arg(long)]
        res_dir: Option<PathBuf>,
    },
```

公共辅助（`res_dir_or_exe_dir` 旁）与统一的错误出口改造——`main` 重构为每个分支构造 `run` 闭包后走同一个 `finish` 函数：

```rust
fn make_ctx(
    project: &std::path::Path,
    release: bool,
    classic: bool,
    map: Option<PathBuf>,
    confusion: Confusion,
) -> wc3_core::error::Result<BuildContext> {
    let config = ProjectConfig::load(project)?;
    Ok(BuildContext::new(
        project,
        config,
        BuildOptions {
            release,
            classic,
            map,
            confusion,
        },
    ))
}

fn copy_output(from: &std::path::Path, to: &std::path::Path) -> wc3_core::error::Result<()> {
    if let Some(dir) = to.parent() {
        std::fs::create_dir_all(dir)
            .map_err(|e| wc3_core::error::Error::io(dir, e))?;
    }
    std::fs::copy(from, to).map_err(|e| wc3_core::error::Error::io(to, e))?;
    Ok(())
}

fn finish(result: wc3_core::error::Result<()>) -> ExitCode {
    match result {
        Ok(()) => ExitCode::SUCCESS,
        Err(e) => {
            println!(
                "{}",
                serde_json::json!({
                    "event": "error", "key": e.key, "message": e.message, "args": e.args
                })
            );
            ExitCode::FAILURE
        }
    }
}
```

`main` 各分支（Compile 分支改为复用 `make_ctx`/`finish`，行为不变）：

```rust
fn main() -> ExitCode {
    let cli = Cli::parse();
    match cli.command {
        Command::Compile { project, release, classic, map, confusion, res_dir } => {
            finish((|| {
                let ctx = make_ctx(&project, release, classic, map, confusion.into())?;
                let dir = res_dir_or_exe_dir(res_dir);
                let confuse = dir.join("wc3-confuse.exe");
                let tools = Tools {
                    confuse_exe: confuse.exists().then_some(confuse.as_path()),
                };
                progress("compile", "Compiling script");
                if release {
                    compile_release(&ctx, &tools)?;
                } else {
                    compile_debug(&ctx)?;
                }
                progress("compile", "done");
                Ok(())
            })())
        }
        Command::Objediting { project, classic, map, res_dir } => {
            finish((|| {
                let ctx = make_ctx(&project, false, classic, map, Confusion::Disable)?;
                let dir = res_dir_or_exe_dir(res_dir);
                progress("objediting", "Object editing");
                wc3_core::objediting::execute(&ctx, &dir)?;
                progress("objediting", "done");
                Ok(())
            })())
        }
        Command::Pack { project, release, classic, map, output } => {
            finish((|| {
                let ctx = make_ctx(&project, release, classic, map, Confusion::Disable)?;
                progress("pack", "Packing map");
                let out = wc3_core::packer::pack(&ctx)?;
                if let Some(o) = &output {
                    copy_output(&out, o)?;
                }
                progress("pack", "done");
                Ok(())
            })())
        }
        Command::Build { project, release, classic, map, output, confusion, res_dir } => {
            finish((|| {
                let ctx = make_ctx(&project, release, classic, map, confusion.into())?;
                let dir = res_dir_or_exe_dir(res_dir);
                progress("objediting", "Object editing");
                wc3_core::objediting::execute(&ctx, &dir)?;
                progress("compile", "Compiling script");
                let confuse = dir.join("wc3-confuse.exe");
                let tools = Tools {
                    confuse_exe: confuse.exists().then_some(confuse.as_path()),
                };
                if release {
                    compile_release(&ctx, &tools)?;
                } else {
                    compile_debug(&ctx)?;
                }
                progress("pack", "Packing map");
                let out = wc3_core::packer::pack(&ctx)?;
                if let Some(o) = &output {
                    copy_output(&out, o)?;
                }
                progress("build", "done");
                Ok(())
            })())
        }
    }
}
```

- [ ] **Step 2: 冒烟验证**

```bash
cargo run -p wc3-cli -- build testdata/fixtures/basic
```
Expected: objediting/compile/pack 各 progress NDJSON、退出码 0、`testdata/fixtures/basic/.build/_warcraft_vscode_test` 生成（无扩展名：mapdir "map" 无 extname）。

```bash
cargo run -p wc3-cli -- pack testdata/fixtures/basic -r
```
Expected: 复用已编译产物报错？否——此时 `.build/war3map.lua` 仍在（debug 产物），pack 直接成功生成 `.build/release`。再验证失败路径：删除 `.build` 后 `cargo run -p wc3-cli -- pack testdata/fixtures/basic` 输出 `error.notFound` 事件、退出码 1。

验证后清理：`Remove-Item -Recurse -Force testdata/fixtures/basic/.build`

- [ ] **Step 3: 全量回归 + Commit**

Run: `cargo fmt --all -- --check && cargo clippy --workspace --all-targets -- -D warnings && cargo test --workspace`
Expected: 全绿。

```bash
git add crates/wc3-cli
git commit -m "feat(cli): objediting, pack and build subcommands"
```

### Task 8: fixture 扩充 + MopaqPack-rs.exe 本地构建 + make-golden pack 步

**Files:**
- Create: `testdata/fixtures/basic/` 下 imports 矩阵文件（见 Step 1）
- Modify: `scripts/make-golden.ps1`、`testdata/golden/README.md`
- Create(生成): `testdata/golden/basic/{debug,release}-reforge-pack/`

- [ ] **Step 1: 扩充 basic fixture（全部非 .lua 文件，阶段 1 compile 黄金不受影响）**

创建以下文件（内容 = 引号内字面量，无换行）：

| 文件 | 内容 |
|---|---|
| `testdata/fixtures/basic/map/icons/icon.txt` | `map-icon` |
| `testdata/fixtures/basic/map/data.txt` | `map-data` |
| `testdata/fixtures/basic/src/lib/console/imports/common.txt` | `lib-common` |
| `testdata/fixtures/basic/src/lib/console/imports/override.txt` | `from-lib` |
| `testdata/fixtures/basic/src/lib/console/imports.debug/libdbg.txt` | `lib-debug` |
| `testdata/fixtures/basic/src/lib/console/imports.release/librel.txt` | `lib-release` |
| `testdata/fixtures/basic/src/lib/console/imports.reforge/librf.txt` | `lib-reforge` |
| `testdata/fixtures/basic/src/lib/console/imports.classic/libcls.txt` | `lib-classic` |
| `testdata/fixtures/basic/imports/override.txt` | `from-root` |
| `testdata/fixtures/basic/imports/data.txt` | `imports-data` |
| `testdata/fixtures/basic/imports/.hidden.txt` | `must-not-pack` |
| `testdata/fixtures/basic/imports.debug/sub/dbg.txt` | `root-debug-nested` |
| `testdata/fixtures/basic/imports.release/rel.txt` | `root-release` |
| `testdata/fixtures/basic/imports.reforge/rf.txt` | `root-reforge` |
| `testdata/fixtures/basic/imports.classic/cls.txt` | `root-classic` |

注意 `src/lib/console/` 是新目录，内部全为 .txt——`collect_source_lua_files` 只收 .lua，compile 产物不变（Step 4 的全量回归会复核 golden 测试仍过）。

- [ ] **Step 2: 本地构建 MopaqPack-rs.exe（TS 黄金生成的前置）**

```bash
cargo build --release --manifest-path ../MopaqPack-rs/Cargo.toml
cp ../MopaqPack-rs/target/release/MopaqPack-rs.exe bin/
```

Expected: 构建成功（Task 1 已验证 cmake 链路；若 Task 1 走了兜底修复，此处构建同样受益）。`bin/MopaqPack-rs.exe` 就位。**不要 git add bin/**（运行时资源由 prepare.js 管理）。

- [ ] **Step 3: make-golden.ps1 追加 pack 步（文件末尾 `Write-Host` 之前）**

```powershell
# pack 黄金：仅 basic × reforge 两象限（classic 需真实 .w3x 基底，由 Rust 侧 packer 单测自洽覆盖）。
# TS cli 的 pack 子命令对空 -t 会把 mapdir 重置为工程根（无 guard），必须显式传 -t map。
if (-not (Test-Path (Join-Path $root 'bin/MopaqPack-rs.exe'))) {
    throw 'bin/MopaqPack-rs.exe missing - build: cargo build --release --manifest-path ../MopaqPack-rs/Cargo.toml; cp to bin/'
}
$packQuads = @(
    @{ name = 'debug-reforge';   args = @();     out = '_warcraft_vscode_test' },
    @{ name = 'release-reforge'; args = @('-r'); out = 'release' }
)
$proj = Join-Path $root 'testdata/fixtures/basic'
foreach ($q in $packQuads) {
    if (Test-Path "$proj/.build") { Remove-Item -Recurse -Force "$proj/.build" }
    node (Join-Path $root 'bin/cli.js') pack $proj -t map @($q.args)
    if ($LASTEXITCODE -ne 0) { throw "pack failed: $($q.name)" }
    $src = "$proj/.build/$($q.out)"
    if (-not (Test-Path $src)) { throw "missing archive: $($q.name)" }
    $dst = Join-Path $root "testdata/golden/basic/$($q.name)-pack"
    if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
    New-Item -ItemType Directory -Force $dst | Out-Null
    Copy-Item $src $dst -Force
    Remove-Item -Recurse -Force "$proj/.build"
}
```

- [ ] **Step 4: 生成黄金并验证无回归**

```bash
npm run compile   # 如 out/cli.js 已是最新可跳过
pwsh scripts/make-golden.ps1
git status --short testdata
```

Expected:
- 脚本成功；`testdata/golden/basic/{debug,release}-reforge-pack/` 各含一个归档文件。
- **compile 黄金（8 个象限目录）无 diff**——fixture 扩充只加了非 lua 文件。若有 diff 即 fixture 改坏了，回查 Step 1。
- Run `cargo test -p wc3-core --test golden`：2 个测试仍 PASS。

- [ ] **Step 5: 更新 golden README 并 Commit**

`testdata/golden/README.md` 追加一行：

```markdown
`<quad>-pack/` 为 TS 管线（node bin/cli.js pack）产出的 .w3x 归档（需 bin/MopaqPack-rs.exe，本地构建见 plan 阶段 2 Task 8）；对照为内容级（文件名集合 + 逐文件字节），见 specs/2026-06-12-rust-core-phase2-pack-objediting-design.md §6。
```

```bash
git add testdata scripts/make-golden.ps1
git commit -m "test: pack fixtures (imports matrix) and TS golden archives"
```

### Task 9: pack 黄金对照测试

**Files:**
- Create: `crates/wc3-core/tests/golden_pack.rs`

- [ ] **Step 1: 编写测试**

```rust
//! pack 黄金对照：Rust packer 产物 vs TS 管线归档（testdata/golden/basic/*-pack）。
//! 内容级比较（spec 阶段 2 §6）：debug 双侧带 (listfile) 可全集比对；
//! release 无 listfile，按 Rust packlist 名逐文件比对。
//! war3map.lua 仅 debug 参与字节比对（release 的 minify 是 DV3 语义级，由 golden.rs 覆盖）。

use std::collections::BTreeSet;
use std::path::{Path, PathBuf};

use wc3_core::compiler::{compile_debug, compile_release, Tools};
use wc3_core::config::{BuildContext, BuildOptions, ProjectConfig};
use wc3_core::{mpq, packer};

fn repo_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("../..")
        .canonicalize()
        .unwrap()
}

fn copy_dir(src: &Path, dst: &Path) {
    std::fs::create_dir_all(dst).unwrap();
    for e in std::fs::read_dir(src).unwrap() {
        let e = e.unwrap();
        let to = dst.join(e.file_name());
        if e.file_type().unwrap().is_dir() {
            copy_dir(&e.path(), &to);
        } else {
            std::fs::copy(e.path(), &to).unwrap();
        }
    }
}

/// fixture 复制 → compile → pack，返回 (工程目录, 产物, packlist)。
fn build_and_pack(release: bool) -> (PathBuf, PathBuf, Vec<packer::PackItem>) {
    static COUNTER: std::sync::atomic::AtomicUsize = std::sync::atomic::AtomicUsize::new(0);
    let n = COUNTER.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
    let src = repo_root().join("testdata/fixtures/basic");
    let dst = std::env::temp_dir().join(format!("wc3-gpack-{release}-{n}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dst);
    copy_dir(&src, &dst);
    let cfg = ProjectConfig::load(&dst).unwrap();
    let ctx = BuildContext::new(
        &dst,
        cfg,
        BuildOptions {
            release,
            ..Default::default()
        },
    );
    if release {
        compile_release(&ctx, &Tools { confuse_exe: None }).unwrap();
    } else {
        compile_debug(&ctx).unwrap();
    }
    let out = packer::pack(&ctx).unwrap();
    let items = packer::generate_packlist(&ctx).unwrap();
    (dst, out, items)
}

fn golden(quad: &str, file: &str) -> PathBuf {
    repo_root()
        .join("testdata/golden/basic")
        .join(quad)
        .join(file)
}

/// listfile → 去内部文件的名集合。
fn names_of(map: &Path) -> BTreeSet<String> {
    mpq::read_listfile(map)
        .unwrap()
        .expect("listfile required")
        .into_iter()
        .filter(|n| !n.starts_with('('))
        .collect()
}

#[test]
fn pack_debug_reforge_matches_golden() {
    let (root, ours, items) = build_and_pack(false);
    let theirs = golden("debug-reforge-pack", "_warcraft_vscode_test");
    let ours_names = names_of(&ours);
    assert_eq!(ours_names, names_of(&theirs), "归档文件名集合一致");
    let expect: BTreeSet<String> = items.into_iter().map(|(n, _)| n).collect();
    assert_eq!(ours_names, expect, "归档与 packlist 一致");
    for name in &ours_names {
        assert_eq!(
            mpq::extract_file(&ours, name).unwrap().unwrap(),
            mpq::extract_file(&theirs, name).unwrap().unwrap(),
            "{name} 字节一致（debug war3map.lua 受阶段 1 字节级黄金保障）"
        );
    }
    std::fs::remove_dir_all(&root).unwrap();
}

#[test]
fn pack_release_reforge_matches_golden() {
    let (root, ours, items) = build_and_pack(true);
    let theirs = golden("release-reforge-pack", "release");
    assert_eq!(mpq::read_listfile(&ours).unwrap(), None, "release 无 listfile（TS 无 -f）");
    assert_eq!(mpq::read_listfile(&theirs).unwrap(), None);
    for (name, _) in &items {
        if name == "war3map.lua" {
            // DV3：minify 字节不可比，存在性即可；语义对照见 golden.rs
            assert!(mpq::extract_file(&theirs, name).unwrap().is_some());
            continue;
        }
        let our_bytes = mpq::extract_file(&ours, name).unwrap().unwrap();
        let their_bytes = mpq::extract_file(&theirs, name)
            .unwrap()
            .unwrap_or_else(|| panic!("{name} 应存在于 TS 归档"));
        assert_eq!(our_bytes, their_bytes, "{name} 字节一致");
    }
    std::fs::remove_dir_all(&root).unwrap();
}
```

- [ ] **Step 2: 运行并校准**

Run: `cargo test -p wc3-core --test golden_pack`
Expected: 2 个测试 PASS。失败排查顺序：名集合差异 → 对比 Rust packlist 与 TS `.build/packlist.json`（重跑 make-golden 时临时保留 .build 查看）；字节差异 → 多半是归档内名分隔符（`\` vs `/`）或同名覆盖优先级，黄金是裁判。

- [ ] **Step 3: 全量回归 + Commit**

Run: `cargo fmt --all -- --check && cargo clippy --workspace --all-targets -- -D warnings && cargo test --workspace`
Expected: 全绿。

```bash
git add crates/wc3-core
git commit -m "test(core): pack golden comparison against TS archives"
```

### Task 10: 阶段收尾 — 文档与验收

**Files:**
- Modify: `README.md`、`docs/superpowers/specs/2026-06-12-rust-core-phase2-pack-objediting-design.md`

- [ ] **Step 1: README 的 Rust toolchain 小节更新 CLI 行**

把 `- CLI: ...` 一行替换为：

```markdown
- CLI: `cargo run -p wc3-cli -- build <project> [-r] [-c] [-o <out.w3x>]`（或单步 `compile` / `pack` / `objediting`）
- MPQ 打包经 [stormlib](https://github.com/warcraft-iii/MopaqPack-rs)（cargo git 依赖）静态链接，构建需 cmake + MSVC
```

- [ ] **Step 2: spec 记录实施结果**

在 phase2 spec「7. 风险与对策」之后追加小节：

```markdown
## 8. 实施结果（2026-06-12）

- stormlib git 依赖锁定 rev：`<最终 rev——若 Task 1 走了 cmake 兜底修复，填新 sha；否则 06ceb1de710177140ade76bfbb9fff0ec3a1ce16>`。
- cmake 4.x spike 结果：<通过 / 触发兜底修复（MopaqPack-rs commit <sha>）>。
- 人工验收（待执行）：真实工程 `wc3 build` 与 TS 管线产物互换、游戏加载各一次。
```

（执行时按实际情况填写尖括号内容。）

- [ ] **Step 3: 阶段 2 验收清单**

- `cargo fmt/clippy/test --workspace` 全绿；wc3-confuse 单列构建不受影响（`cargo clippy --manifest-path crates/wc3-confuse/Cargo.toml --all-targets -- -D warnings`）。
- golden、golden_pack 全部通过。
- CI 绿（push 后确认——首次构建含 stormlib cmake 编译，时间上升属预期）。
- 人工项（留给用户）：真实地图工程 `wc3 build` 产物与 TS `vscwarcraft pack` 产物互换加载；游戏实跑一次。

- [ ] **Step 4: Commit**

```bash
git add README.md docs
git commit -m "docs: phase 2 build notes and acceptance record"
```

---

## 后续（不在本计划内）

阶段 3（插件瘦身：TS spawn wc3.exe + NDJSON 桥、VSIX 集成、prepare.js 调整、依赖移除）在阶段 2 验收后另行出计划。
