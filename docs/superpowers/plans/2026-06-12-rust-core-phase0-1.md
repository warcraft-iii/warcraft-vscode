# Rust 核心拆分 — 阶段 0/1 实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 建立 `crates/` Rust workspace 与黄金基准，实现与 TS 管线等价的 `wc3 compile` 子命令（宏处理、compiletime、require 图、模板、minify、JASS 注入）。

**Architecture:** monorepo 内新增 wc3-core（库）+ wc3-cli（二进制，NDJSON 事件输出）+ wc3-confuse（Lua 5.1 独立混淆二进制，spike）。TS 侧仅为生成黄金基准追加一个 `compile` 子命令，不改插件行为。

**Tech Stack:** Rust stable、full-moon（Lua 解析）、mlua（vendored lua54；混淆器单独 crate 用 lua51）、regex、serde/serde_json、clap、indexmap、walkdir、thiserror。

**Spec:** `docs/superpowers/specs/2026-06-12-rust-core-split-design.md`

---

## 与 TS 行为的已知偏差（设计允许，测试按此校验）

| # | 偏差 | 理由 |
|---|---|---|
| DV1 | `toLua` 表序列化顺序：数组部分（1..n 连续整数键）按序在前，其余键按「整数键升序，再字符串键字典序」。TS 为 JS `Object.entries` 顺序 | mlua 表迭代无序，需确定性输出；语义等价 |
| DV2 | debug 模式含 `compiletime` 的文件不再整体 minify（TS 因 luamin 重打印而顺带 minify）；Rust 用源码区间替换，保持原排版 | 语义等价且更利调试 |
| DV3 | minify 不重命名局部变量（TS luamin 会重命名）；实现为 token 级空白压缩 | 体积略增、行为安全；混淆需求由 Prometheus 层负责 |
| DV4 | release 文件注册顺序为确定性 DFS 序（TS 为 Promise.all 完成序，本就不稳定） | 去重后注册顺序不影响语义 |
| DV5 | 目录遍历按文件名字典序排序 | 与 NTFS readdir 顺序一致，保证黄金对照可复现 |
| DV6 | compiletime 的 Lua 状态在一次构建内跨文件共享、每次构建全新；TS 为 VSCode 会话级持久（跨构建残留全局） | 构建可复现性优先；会话级残留是 TS 缺陷 |

## 文件结构（最终态）

```
Cargo.toml                          # [workspace] members = crates/*
rust-toolchain.toml
crates/
  wc3-core/
    Cargo.toml
    src/lib.rs                      # pub mod 声明
    src/error.rs                    # Error{key,args}（thiserror）
    src/config.rs                   # warcraft.json 解析 + BuildContext 路径
    src/luastr.rs                   # comment_equal/to_lua_string/make_lua_key/to_lua
    src/macros.rs                   # 注释宏处理
    src/templates.rs                # debug/release file/main 渲染
    src/comptime.rs                 # compiletime 查找+求值+区间替换
    src/require_graph.rs            # release require/dofile/loadfile 解析
    src/minify.rs                   # token 级 minify
    src/jass.rs                     # war3map.j 主函数注入
    src/mopaq.rs                    # MopaqPack-rs.exe 子进程薄封装（阶段 2 库化替换）
    src/compiler.rs                 # debug/release 管线编排
    src/fsutil.rs                   # 遍历/隐藏文件规则/posix 路径
  wc3-cli/
    Cargo.toml
    src/main.rs                     # clap + NDJSON 事件
  wc3-confuse/
    Cargo.toml                      # mlua lua51 vendored
    src/main.rs                     # Prometheus 运行器（spike）
testdata/
  fixtures/basic/                   # 无 compiletime 的样例工程
  fixtures/comptime/                # 含 compiletime 的样例工程
  golden/<fixture>/<quadrant>/      # TS 管线产物存档（war3map.lua [+ war3map.j]）
scripts/make-golden.ps1             # 黄金基准生成脚本
src/cli.ts                          # [修改] 追加 compile 子命令
.github/workflows/rust.yml          # Rust CI
```

约定：所有 Rust 命令在仓库根执行；`cargo test -p wc3-core` 运行核心单测。提交信息用 conventional commits（仓库现有惯例），每条以 `Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>` 结尾（下文从略，执行时必须带上）。

---

# 阶段 0 — 基线与脚手架

### Task 1: Cargo workspace 脚手架

**Files:**
- Create: `Cargo.toml`、`rust-toolchain.toml`、`crates/wc3-core/Cargo.toml`、`crates/wc3-core/src/lib.rs`、`crates/wc3-cli/Cargo.toml`、`crates/wc3-cli/src/main.rs`
- Modify: `.gitignore`

- [ ] **Step 1: 创建 workspace 清单**

`Cargo.toml`（仓库根）：

```toml
[workspace]
resolver = "2"
members = ["crates/wc3-core", "crates/wc3-cli"]

[workspace.package]
version = "0.1.0"
edition = "2021"
license = "MIT"

[workspace.dependencies]
full_moon = { version = "1", features = ["lua54"] }
mlua = { version = "0.10", features = ["lua54", "vendored"] }
regex = "1"
serde = { version = "1", features = ["derive"] }
serde_json = "1"
indexmap = "2"
walkdir = "2"
thiserror = "2"
clap = { version = "4", features = ["derive"] }
```

`rust-toolchain.toml`：

```toml
[toolchain]
channel = "stable"
components = ["rustfmt", "clippy"]
```

- [ ] **Step 2: 创建两个 crate 骨架**

`crates/wc3-core/Cargo.toml`：

```toml
[package]
name = "wc3-core"
version.workspace = true
edition.workspace = true
license.workspace = true

[dependencies]
full_moon.workspace = true
mlua.workspace = true
regex.workspace = true
serde.workspace = true
serde_json.workspace = true
indexmap.workspace = true
walkdir.workspace = true
thiserror.workspace = true
```

`crates/wc3-core/src/lib.rs`（模块随后续任务逐个声明，本任务保持空实现）：

```rust
// modules are declared as they are implemented (see plan tasks)
```

`crates/wc3-cli/Cargo.toml`：

```toml
[package]
name = "wc3-cli"
version.workspace = true
edition.workspace = true
license.workspace = true

[[bin]]
name = "wc3"
path = "src/main.rs"

[dependencies]
wc3-core = { path = "../wc3-core" }
clap.workspace = true
serde.workspace = true
serde_json.workspace = true
```

`crates/wc3-cli/src/main.rs`：

```rust
fn main() {
    println!("wc3 cli scaffold");
}
```

`.gitignore` 追加：

```
target/
```

- [ ] **Step 3: 构建验证**

Run: `cargo build --workspace`
Expected: 编译成功；`target/debug/wc3.exe` 存在。

Run: `cargo run -p wc3-cli`
Expected: 输出 `wc3 cli scaffold`。

- [ ] **Step 4: Commit**

```bash
git add Cargo.toml rust-toolchain.toml crates .gitignore
git commit -m "chore: scaffold Rust workspace (wc3-core, wc3-cli)"
```

### Task 2: Rust CI

**Files:**
- Create: `.github/workflows/rust.yml`

- [ ] **Step 1: 编写 workflow**

```yaml
name: Rust

on:
  push:
    paths: ["crates/**", "Cargo.toml", "Cargo.lock", "rust-toolchain.toml", ".github/workflows/rust.yml", "testdata/**"]
  pull_request:
    paths: ["crates/**", "Cargo.toml", "Cargo.lock", "rust-toolchain.toml", ".github/workflows/rust.yml", "testdata/**"]
  workflow_dispatch:

concurrency:
  group: rust-${{ github.ref }}
  cancel-in-progress: true

permissions:
  contents: read

jobs:
  rust:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: dtolnay/rust-toolchain@stable
        with:
          components: rustfmt, clippy
      - uses: Swatinem/rust-cache@v2
      - run: cargo fmt --all -- --check
      - run: cargo clippy --workspace --all-targets --locked -- -D warnings
      - run: cargo test --workspace --locked
```

- [ ] **Step 2: 本地等价验证**

Run: `cargo fmt --all -- --check && cargo clippy --workspace --all-targets -- -D warnings && cargo test --workspace`
Expected: 全部通过（当前无测试，clippy 无告警）。

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/rust.yml
git commit -m "ci: add Rust build/lint/test workflow"
```

### Task 3: TS CLI 追加 compile 子命令（黄金基准生成入口）

**Files:**
- Modify: `src/cli.ts`

仅编译不打包：跳过 objediting 与 packer，使四象限产物不依赖 MopaqPack-rs.exe/ObjEditing.exe。

- [ ] **Step 1: 在 `App.cli()` 中、`program.parse` 之前追加命令**

在 `src/cli.ts` 的 `cli()` 方法内（`program.command('pack')...` 之后、`program.parse(process.argv);` 之前）插入：

```typescript
        program
            .command('compile')
            .argument('[project path]')
            .description('Compile script only (no objediting/pack), for golden baseline')
            .option('-t --target <map>', 'Map file/folder path', '')
            .option('-c --classic', 'Compile Classic Edition', false)
            .option('-r --release', 'Compile Debug/Release?', false)
            .action(async (projectPath: string, opts: { target: string, classic: boolean, release: boolean }) => {
                if (!projectPath) {
                    console.error('Invalid arguments');
                    return;
                }
                runtime.rootPath = projectPath;
                await env.config.reload();
                env.config.isClassic = opts.classic;
                env.config.isRelease = opts.release;
                if (opts.target.length > 0) {
                    env.config.projectConfig.mapdir = path.isAbsolute(opts.target)
                        ? path.resolve(opts.target)
                        : path.resolve(projectPath, opts.target);
                }
                env.config.luaConfusion = LuaConfusionType.Disable;
                if (!opts.release) {
                    await debugCompiler.execute();
                } else {
                    await releaseCompiler.execute();
                }
                console.log('compile finished!');
            });
```

- [ ] **Step 2: 构建并冒烟**

Run: `npm run compile`
Expected: webpack 构建成功，生成 `out/cli.js`。

（冒烟在 Task 4 创建 fixture 后进行。）

- [ ] **Step 3: Commit**

```bash
git add src/cli.ts
git commit -m "feat(cli): add compile-only subcommand for golden baseline"
```

### Task 4: 测试工程 fixtures 与黄金基准

**Files:**
- Create: `testdata/fixtures/basic/**`、`testdata/fixtures/comptime/**`、`scripts/make-golden.ps1`
- Create(生成): `testdata/golden/<fixture>/<quadrant>/war3map.lua` [+ `war3map.j`]

四象限 = `{debug,release} × {classic,reforge}`。compile 流程中：reforge 读取 `<mapdir>/war3map.lua` 作为 origwar3map.lua；classic 不读地图、改走 `jassfile` 注入 —— 因此 fixture 不需要真实 .w3x。

- [ ] **Step 1: 创建 basic fixture**

`testdata/fixtures/basic/warcraft.json`：

```json
{
  "mapdir": "map",
  "files": [],
  "jassfile": "war3map.j",
  "lua": { "package": { "path": ["./?.lua", "./?/init.lua"] } }
}
```

`testdata/fixtures/basic/map/war3map.lua`（充当 reforge 原地图脚本）：

```lua
function InitGlobals()
end
function main()
    RESULT = RESULT or {}
    RESULT.orig_main = true
end
```

仓库根新增 `.gitattributes`（防止 git EOL 归一化破坏字节级黄金对照；war3map.j 必须保持 CRLF）：

```
testdata/** -text
```

`testdata/fixtures/basic/war3map.j`（classic 注入目标，行尾必须 CRLF）：

```
globals
endglobals

function InitGlobals takes nothing returns nothing
endfunction

function main takes nothing returns nothing
    call InitGlobals()
endfunction
```

`testdata/fixtures/basic/src/main.lua`（覆盖全部 8 组宏 + require 链）：

```lua
local util = require('lib.util')
RESULT = RESULT or {}
RESULT.mode = 'common'
--@debug@
RESULT.debug = true
--@end-debug@
--@release@
RESULT.release = true
--@end-release@
--@non-debug@
RESULT.non_debug = true
--@end-non-debug@
--@non-release@
RESULT.non_release = true
--@end-non-release@
--@classic@
RESULT.classic = true
--@end-classic@
--@reforge@
RESULT.reforge = true
--@end-reforge@
--@non-classic@
RESULT.non_classic = true
--@end-non-classic@
--@non-reforge@
RESULT.non_reforge = true
--@end-non-reforge@
--@remove@
RESULT.removed = true
--@end-remove@
RESULT.sum = util.add(1, 2)
RESULT.cn = require('中文目录.数据').value
return RESULT
```

`testdata/fixtures/basic/src/中文目录/数据.lua`（spec §5 要求覆盖中文路径，UTF-8 编码）：

```lua
return { value = 42 }
```

`testdata/fixtures/basic/src/lib/util.lua`：

```lua
local M = {}
function M.add(a, b)
    return a + b
end
return M
```

`testdata/fixtures/basic/src/@hidden.lua` 与 `testdata/fixtures/basic/src/.hidden.lua`（验证排除规则，内容均为）：

```lua
error('must not be bundled')
```

- [ ] **Step 2: 创建 comptime fixture**

`testdata/fixtures/comptime/warcraft.json`：同 basic（原样复制）。
`testdata/fixtures/comptime/map/war3map.lua`、`war3map.j`：同 basic（原样复制）。

`testdata/fixtures/comptime/src/main.lua`：

```lua
RESULT = RESULT or {}
RESULT.table = compiletime(function()
    return { name = 'wc3', count = 3, list = { 'a', 'b' }, flag = true }
end)
RESULT.str = compiletime(function()
    return 'hello ]] world'
end)
RESULT.num = compiletime(function()
    return 40 + 2
end)
return RESULT
```

- [ ] **Step 3: 黄金基准生成脚本**

`scripts/make-golden.ps1`：

```powershell
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
if (-not (Test-Path (Join-Path $root 'out/cli.js'))) { throw 'out/cli.js missing - run npm run compile first' }
$fixtures = @('basic', 'comptime')
$quads = @(
    @{ name = 'debug-reforge';   args = @() },
    @{ name = 'debug-classic';   args = @('-c') },
    @{ name = 'release-reforge'; args = @('-r') },
    @{ name = 'release-classic'; args = @('-r', '-c') }
)
foreach ($f in $fixtures) {
    $proj = Join-Path $root "testdata/fixtures/$f"
    foreach ($q in $quads) {
        if (Test-Path "$proj/.build") { Remove-Item -Recurse -Force "$proj/.build" }
        # bin/cli.js is the launcher shim that loads out/cli.js and invokes app.cli();
        # running out/cli.js directly is a no-op (webpack commonjs2 library, no self-invocation).
        node (Join-Path $root 'bin/cli.js') compile $proj @($q.args)
        if ($LASTEXITCODE -ne 0) { throw "compile failed: $f $($q.name)" }
        if (-not (Test-Path "$proj/.build/war3map.lua")) { throw "missing output: $f $($q.name)" }
        $dst = Join-Path $root "testdata/golden/$f/$($q.name)"
        if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
        New-Item -ItemType Directory -Force $dst | Out-Null
        Copy-Item "$proj/.build/war3map.lua" $dst -Force
        if (Test-Path "$proj/.build/war3map.j") { Copy-Item "$proj/.build/war3map.j" $dst -Force }
    }
    Remove-Item -Recurse -Force "$proj/.build"
}
Write-Host 'golden baseline updated.'
```

- [ ] **Step 4: 生成并人工抽查**

Run: `npm run compile`，然后 `pwsh scripts/make-golden.ps1`
Expected: `testdata/golden/` 下生成 8 个象限目录；抽查 `golden/basic/debug-reforge/war3map.lua`：含模板骨架、`P['main.lua']`、`P['lib/util.lua']`、`P['origwar3map.lua']`，宏区块按象限正确启停（如 debug-reforge 中 `RESULT.release` 被 `--[N[...]N]` 注释包裹）、无 `@hidden`/`.hidden` 内容；`debug-classic/war3map.j` 中 `call InitGlobals()` 后插入了 `call Cheat("exec-lua:war3map")`。

- [ ] **Step 5: 防回归说明文件**

`testdata/golden/README.md`：

```markdown
# Golden baseline

由 `scripts/make-golden.ps1` 基于 TS 管线（node bin/cli.js compile，加载 out/cli.js）生成，是 Rust 重写的对照锚点。
**禁止手改。** 仅当 TS 管线行为被有意修订时重新生成并在 PR 中说明差异。
对照规则见 docs/superpowers/specs/2026-06-12-rust-core-split-design.md §5。
```

- [ ] **Step 6: Commit**

```bash
git add .gitattributes testdata scripts/make-golden.ps1
git commit -m "test: add fixture projects and TS golden baseline (4 quadrants x 2 fixtures)"
```

---

# 阶段 1 — 编译器核心（wc3-core / wc3 compile）

### Task 5: error.rs + config.rs（warcraft.json 与 BuildContext）

**Files:**
- Create: `crates/wc3-core/src/error.rs`、`crates/wc3-core/src/config.rs`
- Modify: `crates/wc3-core/src/lib.rs`

- [ ] **Step 1: 写失败测试**

`crates/wc3-core/src/config.rs`（先只写测试骨架与 use；测试置于文件尾部 `#[cfg(test)] mod tests`）：

```rust
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
        let ctx = BuildContext::new(std::path::Path::new("C:/proj"), cfg, BuildOptions::default());
        assert_eq!(ctx.source_dir(), std::path::Path::new("C:/proj/src"));
        assert_eq!(ctx.build_dir(), std::path::Path::new("C:/proj/.build"));
        assert_eq!(ctx.map_dir().unwrap(), std::path::Path::new("C:/proj/map"));
    }
}
```

- [ ] **Step 2: 运行确认失败**

`lib.rs` 加 `pub mod error;` `pub mod config;` 后 Run: `cargo test -p wc3-core`
Expected: 编译失败（类型未定义）。

- [ ] **Step 3: 最小实现**

`crates/wc3-core/src/error.rs`：

```rust
use std::path::PathBuf;

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
        Self { key, message: message.into(), args: vec![] }
    }
    pub fn with_args(key: &'static str, message: impl Into<String>, args: Vec<String>) -> Self {
        Self { key, message: message.into(), args }
    }
    pub fn io(path: &PathBuf, e: std::io::Error) -> Self {
        Self::with_args("error.io", format!("{}: {e}", path.display()), vec![path.display().to_string()])
    }
}

pub type Result<T> = std::result::Result<T, Error>;
```

`crates/wc3-core/src/config.rs`（实现部分，置于 tests 之前）：

```rust
use std::path::{Path, PathBuf};

use serde::Deserialize;

use crate::error::{Error, Result};

#[derive(Debug, Clone, Deserialize)]
struct RawConfig {
    mapdir: Option<String>,
    #[serde(default)]
    files: Vec<String>,
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
    pub fn from_json(json: &str) -> Result<Self> {
        let raw: RawConfig = serde_json::from_str(json)
            .map_err(|e| Error::new("error.invalidProjectConfig", format!("warcraft.json: {e}")))?;
        Ok(Self {
            mapdir: raw.mapdir,
            files: raw.files,
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
        Self { root: root.to_path_buf(), config, opts }
    }

    pub fn source_dir(&self) -> PathBuf {
        self.root.join("src")
    }
    pub fn build_dir(&self) -> PathBuf {
        self.root.join(".build")
    }
    pub fn map_dir(&self) -> Result<PathBuf> {
        if let Some(m) = &self.opts.map {
            return Ok(if m.is_absolute() { m.clone() } else { self.root.join(m) });
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
```

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core`
Expected: 2 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): project config parsing and build context"
```

### Task 6: luastr.rs（Lua 字面量工具，TS BaseCompiler 静态函数移植）

**Files:**
- Create: `crates/wc3-core/src/luastr.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod luastr;`）

TS 对应：`getCommentEqual`/`toLuaString`/`isValidWord`/`makeLuaKey`/`toLua`（src/app/compiler/compiler.ts:76-250）。`to_lua` 输入为 `mlua::Value`，顺序按 DV1。

- [ ] **Step 1: 写失败测试**

`luastr.rs` 尾部：

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn comment_equal_picks_first_free_level() {
        assert_eq!(comment_equal("no brackets"), "");
        assert_eq!(comment_equal("x = [[s]]"), "=");
        assert_eq!(comment_equal("a [[b]] c [=[d]=]"), "==");
        assert_eq!(comment_equal("a [=[b]=]"), ""); // 0 级未被占用
    }

    #[test]
    fn to_lua_string_wraps_with_free_level() {
        assert_eq!(to_lua_string("plain"), "[[plain]]");
        assert_eq!(to_lua_string("has ]] inside"), "[=[has ]] inside]=]");
    }

    #[test]
    fn make_lua_key_rules() {
        assert_eq!(make_lua_key("3"), "[3]");
        assert_eq!(make_lua_key("name"), "name");
        assert_eq!(make_lua_key("_ok2"), "_ok2");
        assert_eq!(make_lua_key("2x"), "['2x']");
        assert_eq!(make_lua_key("a-b"), "['a-b']");
    }

    #[test]
    fn to_lua_serializes_values_deterministically() {
        let lua = mlua::Lua::new();
        let v: mlua::Value = lua
            .load("return { name = 'wc3', count = 3, list = { 'a', 'b' }, flag = true }")
            .eval()
            .unwrap();
        // DV1：数组部分在前，其余键整数升序后字符串字典序
        assert_eq!(
            to_lua(&v),
            "{count=3,flag=true,list={[[a]],[[b]]},name=[[wc3]]}"
        );
        let s: mlua::Value = lua.load("return 'hello ]] world'").eval().unwrap();
        assert_eq!(to_lua(&s), "[=[hello ]] world]=]");
        let n: mlua::Value = lua.load("return 42").eval().unwrap();
        assert_eq!(to_lua(&n), "42");
        let nil: mlua::Value = lua.load("return nil").eval().unwrap();
        assert_eq!(to_lua(&nil), "nil");
    }
}
```

注：`to_lua` 纯表（无数组部分）输出 `{k=v,...}`，键序见 DV1；数组部分元素无键直接展开——与 TS `toLua(obj)`（非 pretty 模式）的分隔符/无空格格式一致。

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core luastr`
Expected: 编译失败（函数未定义）。

- [ ] **Step 3: 实现**

`luastr.rs` 实现部分：

```rust
use std::collections::BTreeMap;
use std::collections::HashSet;

/// TS getCommentEqual：扫描 [=*[ 与 ]=*]，返回第一个未被占用的等号层级。
pub fn comment_equal(code: &str) -> String {
    let re = regex::Regex::new(r"\[(=*)\[|\](=*)\]").unwrap();
    let mut exists: HashSet<usize> = HashSet::new();
    for m in re.find_iter(code) {
        exists.insert(m.as_str().len() - 2);
    }
    let mut level = 0;
    while exists.contains(&level) {
        level += 1;
    }
    "=".repeat(level)
}

/// TS toLuaString。
pub fn to_lua_string(s: &str) -> String {
    let eq = comment_equal(s);
    format!("[{eq}[{s}]{eq}]")
}

fn is_valid_word(s: &str) -> bool {
    let mut chars = s.chars();
    match chars.next() {
        Some(c) if c.is_ascii_alphabetic() || c == '_' => {}
        _ => return false,
    }
    chars.all(|c| c.is_ascii_alphanumeric() || c == '_')
}

/// TS makeLuaKey：parseInt(s).toString() == s 判定整数键。
pub fn make_lua_key(s: &str) -> String {
    if s.parse::<i64>().map(|n| n.to_string() == s).unwrap_or(false) {
        format!("[{s}]")
    } else if is_valid_word(s) {
        s.to_string()
    } else {
        format!("['{}']", s.replacen('\'', "\\'", 1)) // TS 用 replace 仅替换首个
    }
}

/// TS toLua（非 pretty 路径），表键序按 DV1 确定性化。
pub fn to_lua(value: &mlua::Value) -> String {
    match value {
        mlua::Value::Nil => "nil".into(),
        mlua::Value::Boolean(b) => b.to_string(),
        mlua::Value::Integer(i) => i.to_string(),
        mlua::Value::Number(n) => {
            // 对齐 JS Number.prototype.toString：整数值不带小数点
            if n.fract() == 0.0 && n.is_finite() {
                format!("{}", *n as i64)
            } else {
                n.to_string()
            }
        }
        mlua::Value::String(s) => to_lua_string(&s.to_string_lossy()),
        mlua::Value::Table(t) => {
            let mut parts: Vec<String> = Vec::new();
            // 数组部分：1..n 连续整数键
            let len = t.raw_len();
            for i in 1..=len {
                let v: mlua::Value = t.raw_get(i).unwrap_or(mlua::Value::Nil);
                parts.push(to_lua(&v));
            }
            // 其余键：整数升序，再字符串字典序（DV1）
            let mut int_keys: BTreeMap<i64, mlua::Value> = BTreeMap::new();
            let mut str_keys: BTreeMap<String, mlua::Value> = BTreeMap::new();
            for pair in t.clone().pairs::<mlua::Value, mlua::Value>() {
                let (k, v) = pair.unwrap();
                match &k {
                    mlua::Value::Integer(i) if *i >= 1 && (*i as usize) <= len => {}
                    mlua::Value::Integer(i) => {
                        int_keys.insert(*i, v);
                    }
                    mlua::Value::String(s) => {
                        str_keys.insert(s.to_string_lossy().to_string(), v);
                    }
                    _ => {}
                }
            }
            for (k, v) in int_keys {
                parts.push(format!("{}={}", make_lua_key(&k.to_string()), to_lua(&v)));
            }
            for (k, v) in str_keys {
                parts.push(format!("{}={}", make_lua_key(&k), to_lua(&v)));
            }
            format!("{{{}}}", parts.join(","))
        }
        _ => "nil".into(),
    }
}
```

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core luastr`
Expected: 4 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): lua literal helpers (comment level, keys, value serialization)"
```

### Task 7: macros.rs（注释宏处理）

**Files:**
- Create: `crates/wc3-core/src/macros.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod macros;`）

TS 对应 `processCodeMacros`（compiler.ts:27-74）。关键语义：先 trimEnd；accepts 先「解注释」（`--[=*[@key@` → `--@key@`、`--@end-key@]=*]` → `--@end-key@`）；再对 ignores 逐 key「注释化」，且每个 key 处理前**重新计算** comment level（multiline 模式，`$` 匹配行尾）。key 顺序：ignores = `remove`、(release|debug 对)、(版本对)；accepts = (debug|release 对)、(版本对)，与 TS push 顺序一致。

- [ ] **Step 1: 写失败测试**

```rust
#[cfg(test)]
mod tests {
    use super::*;

    const SRC: &str = "a()\n--@debug@\nd()\n--@end-debug@\n--@release@\nr()\n--@end-release@\n--@remove@\nx()\n--@end-remove@\n";

    #[test]
    fn debug_reforge_comments_out_release_and_remove() {
        let out = process_code_macros(SRC, false, false);
        assert!(out.contains("--@debug@\nd()\n--@end-debug@"), "debug 区保持启用");
        assert!(out.contains("--[[@release@"), "release 区被注释化");
        assert!(out.contains("--@end-release@]]"));
        assert!(out.contains("--[[@remove@"));
        assert!(!out.ends_with('\n'), "trimEnd 语义");
    }

    #[test]
    fn release_uncomments_previously_disabled_block() {
        // 已被上一轮注释化的 release 区，在 release 编译时应解注释
        let src = "--[[@release@\nr()\n--@end-release@]]";
        let out = process_code_macros(src, true, false);
        assert!(out.contains("--@release@\nr()\n--@end-release@"));
        assert!(!out.contains("--[[@release@"));
    }

    #[test]
    fn nested_brackets_bump_comment_level() {
        let src = "s = [[str]]\n--@release@\nr()\n--@end-release@";
        let out = process_code_macros(src, false, false);
        assert!(out.contains("--[=[@release@"), "已有 [[ ]] 时用 [=[");
        assert!(out.contains("--@end-release@]=]"));
    }
}
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core macros`
Expected: 编译失败。

- [ ] **Step 3: 实现**

```rust
use crate::luastr::comment_equal;

/// release/classic 标志 → accepts/ignores key 集（顺序与 TS 一致）。
fn macro_keys(release: bool, classic: bool) -> (Vec<&'static str>, Vec<&'static str>) {
    let mut ignores = vec!["remove"];
    let mut accepts = vec![];
    if release {
        ignores.extend(["debug", "non-release"]);
        accepts.extend(["release", "non-debug"]);
    } else {
        ignores.extend(["release", "non-debug"]);
        accepts.extend(["debug", "non-release"]);
    }
    if classic {
        ignores.extend(["reforge", "non-classic"]);
        accepts.extend(["classic", "non-reforge"]);
    } else {
        ignores.extend(["classic", "non-reforge"]);
        accepts.extend(["reforge", "non-classic"]);
    }
    (accepts, ignores)
}

pub fn process_code_macros(code: &str, release: bool, classic: bool) -> String {
    let (accepts, ignores) = macro_keys(release, classic);
    let mut code = code.trim_end().to_string();

    for key in accepts {
        let open = regex::Regex::new(&format!(r"(?m)--\[=*\[@{key}@")).unwrap();
        code = open.replace_all(&code, format!("--@{key}@")).into_owned();
        let close = regex::Regex::new(&format!(r"(?m)--\s*@end-{key}@\]=*\]")).unwrap();
        code = close.replace_all(&code, format!("--@end-{key}@")).into_owned();
    }

    for key in ignores {
        let eq = comment_equal(&code); // 与 TS 一致：每个 key 重新计算
        let open = regex::Regex::new(&format!(r"(?m)--\s*@{key}@")).unwrap();
        code = open.replace_all(&code, format!("--[{eq}[@{key}@")).into_owned();
        let close = regex::Regex::new(&format!(r"(?m)--\s*@end-{key}@\s*$")).unwrap();
        code = close.replace_all(&code, format!("--@end-{key}@]{eq}]")).into_owned();
    }

    code
}
```

注意：TS 的 `RegExp(p, 'mg')` 中 `\s*` 会越行匹配（`\s` 含 `\n`）。Rust `regex` 的 `(?m)` 下 `\s` 同样含换行，行为一致。`@end-key@\s*$` 的 `$` 在两边都是行尾锚——保留 `(?m)`。

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core macros`
Expected: 3 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): comment macro processing (debug/release/classic/reforge)"
```

### Task 8: fsutil.rs（遍历与命名规则）

**Files:**
- Create: `crates/wc3-core/src/fsutil.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod fsutil;`）

TS 对应 `utils/utils.ts`：`getAllFiles`（递归）、`isHiddenFile`（`.` 前缀；`.lua` 且 `@` 前缀）、`isLuaFile`、`posixCase`。排序按 DV5。

- [ ] **Step 1: 写失败测试**

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn hidden_rules() {
        assert!(is_hidden_file(std::path::Path::new("a/.git")));
        assert!(is_hidden_file(std::path::Path::new("a/@gen.lua")));
        assert!(!is_hidden_file(std::path::Path::new("a/@gen.txt")), "@ 前缀仅对 .lua 生效");
        assert!(!is_hidden_file(std::path::Path::new("a/main.lua")));
        assert!(is_lua_file(std::path::Path::new("x/Main.LUA")));
    }

    #[test]
    fn posix_relative() {
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
        let rel: Vec<String> = files.iter().map(|f| posix_relative(&dir, f).unwrap()).collect();
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
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core fsutil`
Expected: 编译失败。

- [ ] **Step 3: 实现**

```rust
use std::path::{Path, PathBuf};

use crate::error::{Error, Result};

pub fn is_lua_file(p: &Path) -> bool {
    p.extension().map(|e| e.eq_ignore_ascii_case("lua")).unwrap_or(false)
}

pub fn is_hidden_file(p: &Path) -> bool {
    let name = p.file_name().and_then(|n| n.to_str()).unwrap_or("");
    name.starts_with('.') || (is_lua_file(p) && name.starts_with('@'))
}

/// TS posixCase(path.relative(root, file))。
pub fn posix_relative(root: &Path, file: &Path) -> Result<String> {
    let rel = file
        .strip_prefix(root)
        .map_err(|_| Error::new("error.io", format!("{} not under {}", file.display(), root.display())))?;
    Ok(rel.components().map(|c| c.as_os_str().to_string_lossy()).collect::<Vec<_>>().join("/"))
}

/// 递归收集 src 下非隐藏 .lua 文件，整体按 posix 相对路径字典序（DV5）。
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

pub fn read_to_string(p: &Path) -> Result<String> {
    std::fs::read_to_string(p).map_err(|e| Error::io(&p.to_path_buf(), e))
}
```

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core fsutil`
Expected: 3 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): source file collection and naming rules"
```

### Task 9: templates.rs（模板渲染）

**Files:**
- Create: `crates/wc3-core/assets/main-debug.lua`、`crates/wc3-core/assets/main-release.lua`、`crates/wc3-core/src/templates.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod templates;`）

TS 模板（`src/templates/{debug,release}/main.lua`）中 `--[[%> ... %]]` 求值块只做一件事：按 classic/reforge 条件输出 `--[==[`/`]==]--` 注释开关。Rust 资产文件 = 原模板逐字复制，但把求值块整行中的块部分替换为标记；`--[[%= code %]]` → `%CODE%`，`package.path` 行 → `%PACKAGE_PATH%`。

**资产制作规则（手工一次性转换，两个文件同规则）：**

以 `src/templates/debug/main.lua` 为底，做如下替换得到 `assets/main-debug.lua`：

| 原文 | 替换为 |
|---|---|
| `'--[[%> print(package.path.join(";")) %]]'`（第 2 行） | `'%PACKAGE_PATH%'` |
| `--[[%>  if (!classic) { print('--[==['); } %]]` | `%NC_OPEN%` |
| `--[[%>  if (!classic) { print(']==]--'); } %]]` | `%NC_CLOSE%` |
| `--[[%>  if (classic) { print('--[==['); } %]]` | `%C_OPEN%` |
| `--[[%>  if (classic) { print(']==]--'); } %]]` | `%C_CLOSE%` |
| `--[[%= code %]]` | `%CODE%` |

`assets/main-release.lua` 同法（release 模板与 debug 模板仅 preloadType/preload 实现不同，原样保留）。注意保留每行的前导缩进与文件原有换行。

- [ ] **Step 1: 写失败测试**

`templates.rs` 尾部：

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn debug_file_entry() {
        assert_eq!(
            render_debug_file("lib/util.lua", "return 1"),
            "P['lib/util.lua'] = [[return 1]]"
        );
        // body 含 ]] 时提升括号层级（层级由 body 经 comment_equal 计算，与 TS genFile 一致）
        assert_eq!(
            render_debug_file("a.lua", "s=']]'"),
            "P['a.lua'] = [=[s=']]']=]"
        );
    }

    #[test]
    fn release_file_entry() {
        assert_eq!(
            render_release_file("main.lua", "return 1"),
            "P['main.lua'] = function(_ENV, ...)\nreturn 1\nend"
        );
    }

    #[test]
    fn main_classic_gating() {
        let classic = render_main(Kind::Debug, "__CODE__", &["./?.lua".into()], true);
        assert!(classic.contains("__CODE__"));
        assert!(classic.contains("package.path = './?.lua'"));
        assert!(!classic.contains('%'), "所有标记都被替换");
        let reforge = render_main(Kind::Debug, "__CODE__", &["./?.lua".into()], false);
        assert!(!reforge.contains('%'));
        // classic 与 reforge 的注释开关互补：classic 注释 origwar3map 块、激活末尾 main()，reforge 相反
        assert_ne!(classic, reforge);
        let count = |s: &str| s.matches("--[==[").count();
        assert_eq!(count(&classic) + count(&reforge), 5, "5 组开关分属两种配置");
    }
}
```

注：开关归属的精确验证由 Task 14/17 完成（classic 不含 origwar3map、reforge 不自调 main 等行为级断言 + 黄金字节对照是最终裁判）。

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core templates`
Expected: 编译失败。

- [ ] **Step 3: 实现**

```rust
const MAIN_DEBUG: &str = include_str!("../assets/main-debug.lua");
const MAIN_RELEASE: &str = include_str!("../assets/main-release.lua");

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Kind {
    Debug,
    Release,
}

/// TS templates/debug/file.lua：P['name'] = [eq[body]eq]
pub fn render_debug_file(name: &str, body: &str) -> String {
    let eq = crate::luastr::comment_equal(body);
    format!("P['{name}'] = [{eq}[{body}]{eq}]")
}

/// TS templates/release/file.lua：P['name'] = function(_ENV, ...) body end
pub fn render_release_file(name: &str, body: &str) -> String {
    format!("P['{name}'] = function(_ENV, ...)\n{body}\nend")
}

/// TS templates/*/main.lua：classic 控制三组注释开关。
pub fn render_main(kind: Kind, code: &str, package_path: &[String], classic: bool) -> String {
    let tpl = match kind {
        Kind::Debug => MAIN_DEBUG,
        Kind::Release => MAIN_RELEASE,
    };
    let (nc_open, nc_close) = if classic { ("", "") } else { ("--[==[", "]==]--") };
    let (c_open, c_close) = if classic { ("--[==[", "]==]--") } else { ("", "") };
    tpl.replace("%PACKAGE_PATH%", &package_path.join(";"))
        .replace("%NC_OPEN%", nc_open)
        .replace("%NC_CLOSE%", nc_close)
        .replace("%C_OPEN%", c_open)
        .replace("%C_CLOSE%", c_close)
        .replace("%CODE%", code)
}
```

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core templates`
Expected: 3 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): debug/release template rendering with classic gating"
```

### Task 10: comptime.rs（compiletime 求值与替换）

**Files:**
- Create: `crates/wc3-core/src/comptime.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod comptime;`）

TS 对应 `checkCompileTime`（compiler.ts:252-269）+ `initLuaEngine`（io.readFile/writeFile 注入）。Rust 策略：full-moon 定位 `compiletime(...)` 调用的字节区间 → 提取实参函数源码 → mlua 执行 `return (<fn>)()` → 多返回值经 `luastr::to_lua` 以 `,` 连接 → **源码区间文本替换**（倒序应用），不重打印 AST（DV2）。嵌套 compiletime 不支持（与 TS 行为一致按错误处理：内层求值时 `compiletime` 未定义会报错）。

- [ ] **Step 1: 写失败测试**

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn substitutes_table_result() {
        let src = "local t = compiletime(function()\n    return { name = 'wc3', count = 3 }\nend)\nreturn t";
        let out = process(src, "main.lua").unwrap();
        assert_eq!(out, "local t = {count=3,name=[[wc3]]}\nreturn t");
    }

    #[test]
    fn substitutes_multiple_returns_and_scalars() {
        let out = process("local a, b = compiletime(function() return 1, 'x' end)", "f.lua").unwrap();
        assert_eq!(out, "local a, b = 1,[[x]]");
        let out = process("local n = compiletime(function() return 40 + 2 end)", "f.lua").unwrap();
        assert_eq!(out, "local n = 42");
    }

    #[test]
    fn empty_return_becomes_empty() {
        // TS：无返回值 → raw='' → 调用处替换为空
        let out = process("compiletime(function() end)\nreturn 1", "f.lua").unwrap();
        assert_eq!(out, "\nreturn 1");
    }

    #[test]
    fn rejects_non_function_argument() {
        let err = process("local x = compiletime(42)", "bad.lua").unwrap_err();
        assert_eq!(err.key, "error.processFilesFailure");
    }

    #[test]
    fn io_api_is_available() {
        let dir = std::env::temp_dir().join(format!("wc3-ct-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let f = dir.join("data.txt");
        std::fs::write(&f, "from-disk").unwrap();
        let src = format!(
            "local s = compiletime(function() return io.readFile([[{}]]) end)",
            f.display().to_string().replace('\\', "/")
        );
        let out = process(&src, "f.lua").unwrap();
        assert_eq!(out, "local s = [[from-disk]]");
        std::fs::remove_dir_all(&dir).unwrap();
    }
}
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core comptime`
Expected: 编译失败。

- [ ] **Step 3: 实现**

```rust
use full_moon::node::Node;
use full_moon::visitors::Visitor;

use crate::error::{Error, Result};
use crate::luastr::to_lua;

struct CallSpan {
    start: usize, // 整个 compiletime(...) 调用的起始字节
    end: usize,   // 结束字节（独占）
}

#[derive(Default)]
struct Finder {
    spans: Vec<CallSpan>,
}

impl Visitor for Finder {
    fn visit_function_call(&mut self, node: &full_moon::ast::FunctionCall) {
        if let full_moon::ast::Prefix::Name(name) = node.prefix() {
            if name.token().to_string() == "compiletime" {
                if let (Some(s), Some(e)) = (node.start_position(), node.end_position()) {
                    self.spans.push(CallSpan { start: s.bytes(), end: e.bytes() });
                }
            }
        }
    }
}

/// 提取 compiletime( ... ) 外层括号内的实参源码。
fn extract_arg(call_src: &str, file: &str) -> Result<&str> {
    let open = call_src.find('(').ok_or_else(|| bad_arg(file))?;
    let close = call_src.rfind(')').ok_or_else(|| bad_arg(file))?;
    let arg = call_src[open + 1..close].trim();
    if !arg.starts_with("function") {
        return Err(bad_arg(file));
    }
    Ok(arg)
}

fn bad_arg(file: &str) -> Error {
    Error::with_args(
        "error.processFilesFailure",
        format!("File: {file}\nError: Incorrect compiletime argument"),
        vec![file.to_string()],
    )
}

fn make_lua() -> Result<mlua::Lua> {
    let lua = mlua::Lua::new();
    let io: mlua::Table = lua.globals().get("io").map_err(lua_err)?;
    io.set(
        "readFile",
        lua.create_function(|_, path: String| {
            std::fs::read_to_string(&path).map_err(|e| mlua::Error::external(format!("{path}: {e}")))
        })
        .map_err(lua_err)?,
    )
    .map_err(lua_err)?;
    io.set(
        "writeFile",
        lua.create_function(|_, (path, content): (String, String)| {
            std::fs::write(&path, content).map_err(|e| mlua::Error::external(format!("{path}: {e}")))
        })
        .map_err(lua_err)?,
    )
    .map_err(lua_err)?;
    Ok(lua)
}

fn lua_err(e: mlua::Error) -> Error {
    Error::new("error.processFilesFailure", e.to_string())
}

/// 对含 compiletime 的源码做求值替换；`file` 仅用于错误信息。
pub fn process(source: &str, file: &str) -> Result<String> {
    let ast = full_moon::parse(source)
        .map_err(|e| Error::new("error.processFilesFailure", format!("File: {file}\nError: {e:?}")))?;
    let mut finder = Finder::default();
    finder.visit_ast(&ast);
    if finder.spans.is_empty() {
        return Ok(source.to_string());
    }
    let lua = make_lua()?;
    let mut out = source.to_string();
    finder.spans.sort_by_key(|s| s.start);
    for span in finder.spans.iter().rev() {
        let call_src = &source[span.start..span.end];
        let arg = extract_arg(call_src, file)?;
        let results: mlua::MultiValue = lua
            .load(&format!("return ({arg})()"))
            .eval()
            .map_err(|e| Error::new("error.processFilesFailure", format!("File: {file}\nError: {e}")))?;
        let literal = results.iter().map(to_lua).collect::<Vec<_>>().join(",");
        out.replace_range(span.start..span.end, &literal);
    }
    Ok(out)
}
```

实现备注：full-moon 1.x 中 `Node::start_position/end_position` 与 `Position::bytes()` 的具体签名以 crate 文档为准；若 `visit_ast` 不存在则用 `finder.visit_ast(&ast)` 对应版本 API（`Visitor::visit_ast` 由 trait 提供）。若 `FunctionCall` 的 end_position 不含尾括号，改用「suffixes 最后一个 token 的 end_position」。本任务测试覆盖了精确字节区间，API 偏差会被测试暴露。

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core comptime`
Expected: 5 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): compiletime evaluation via mlua with span substitution"
```

### Task 11: require_graph.rs（release 依赖解析）

**Files:**
- Create: `crates/wc3-core/src/require_graph.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod require_graph;`）

TS 对应 `ReleaseCompiler.processFiles/getMaybeFiles/resolveFile/isRequireFunction`（release.ts:42-158）。语义：扫描 `require/dofile/loadfile` 的字符串调用（含 `require'x'` 语法糖）；`require` 经 package.path finder 解析（`?` ← 模块名 `.` 分段转 `/`），`dofile/loadfile` 按相对 src 路径；classic 下解析失败静默跳过（jass.* 内置包），reforge 下报 `error.notFound`；按 posix 相对名去重；确定性 DFS（DV4）。本模块只做「扫描 + 解析」，编排在 Task 15。

- [ ] **Step 1: 写失败测试**

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn scans_require_calls_including_sugar() {
        let reqs = scan_requires("require('a.b')\nrequire 'c'\ndofile('d.lua')\nloadfile('e.lua')\nrequire(x)\n");
        assert_eq!(
            reqs,
            vec![
                RequireItem { module: "a.b".into(), is_require: true },
                RequireItem { module: "c".into(), is_require: true },
                RequireItem { module: "d.lua".into(), is_require: false },
                RequireItem { module: "e.lua".into(), is_require: false },
            ],
            "非字符串字面量参数忽略"
        );
    }

    #[test]
    fn resolves_require_via_package_path() {
        let dir = tempdir();
        std::fs::create_dir_all(dir.join("lib")).unwrap();
        std::fs::write(dir.join("lib/util.lua"), "x").unwrap();
        std::fs::create_dir_all(dir.join("mod")).unwrap();
        std::fs::write(dir.join("mod/init.lua"), "x").unwrap();
        let finders = vec!["./?.lua".to_string(), "./?/init.lua".to_string()];

        let p = resolve(&dir, &finders, &RequireItem { module: "lib.util".into(), is_require: true }, false).unwrap();
        assert_eq!(p.unwrap(), dir.join("lib/util.lua"));
        let p = resolve(&dir, &finders, &RequireItem { module: "mod".into(), is_require: true }, false).unwrap();
        assert_eq!(p.unwrap(), dir.join("mod/init.lua"));
        // dofile：直接相对 src
        let p = resolve(&dir, &finders, &RequireItem { module: "lib/util.lua".into(), is_require: false }, false).unwrap();
        assert_eq!(p.unwrap(), dir.join("lib/util.lua"));
        std::fs::remove_dir_all(&dir).unwrap();
    }

    #[test]
    fn missing_module_classic_vs_reforge() {
        let dir = tempdir();
        let finders = vec!["./?.lua".to_string()];
        let item = RequireItem { module: "jass.common".into(), is_require: true };
        assert!(resolve(&dir, &finders, &item, true).unwrap().is_none(), "classic 跳过");
        let err = resolve(&dir, &finders, &item, false).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        std::fs::remove_dir_all(&dir).unwrap();
    }

    fn tempdir() -> std::path::PathBuf {
        let d = std::env::temp_dir().join(format!("wc3-req-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        d
    }
}
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core require_graph`
Expected: 编译失败。

- [ ] **Step 3: 实现**

```rust
use std::path::{Path, PathBuf};

use full_moon::node::Node;
use full_moon::visitors::Visitor;

use crate::error::{Error, Result};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct RequireItem {
    pub module: String,
    pub is_require: bool, // true=require（走 package.path），false=dofile/loadfile（按路径）
}

#[derive(Default)]
struct ReqFinder {
    items: Vec<RequireItem>,
}

impl Visitor for ReqFinder {
    fn visit_function_call(&mut self, node: &full_moon::ast::FunctionCall) {
        let full_moon::ast::Prefix::Name(name) = node.prefix() else { return };
        let fname = name.token().to_string();
        if fname != "require" && fname != "dofile" && fname != "loadfile" {
            return;
        }
        // 第一个 suffix 必须是调用；取唯一字符串字面量实参
        let Some(full_moon::ast::Suffix::Call(call)) = node.suffixes().next() else { return };
        let arg = match call {
            full_moon::ast::Call::AnonymousCall(full_moon::ast::FunctionArgs::Parentheses { arguments, .. }) => {
                if arguments.len() != 1 {
                    return;
                }
                match arguments.iter().next() {
                    Some(full_moon::ast::Expression::String(tok)) => string_literal_value(tok),
                    _ => return,
                }
            }
            full_moon::ast::Call::AnonymousCall(full_moon::ast::FunctionArgs::String(tok)) => {
                string_literal_value(tok)
            }
            _ => return,
        };
        if let Some(module) = arg {
            self.items.push(RequireItem { module, is_require: fname == "require" });
        }
    }
}

fn string_literal_value(tok: &full_moon::tokenizer::TokenReference) -> Option<String> {
    match tok.token().token_type() {
        full_moon::tokenizer::TokenType::StringLiteral { literal, .. } => Some(literal.to_string()),
        _ => None,
    }
}

/// 扫描源码中的 require/dofile/loadfile 字符串调用（出现序）。
pub fn scan_requires(source: &str) -> Vec<RequireItem> {
    match full_moon::parse(source) {
        Ok(ast) => {
            let mut f = ReqFinder::default();
            f.visit_ast(&ast);
            f.items
        }
        Err(_) => vec![],
    }
}

/// TS getMaybeFiles + resolveFile。返回 Ok(None) 表示 classic 下允许的缺失。
pub fn resolve(
    source_dir: &Path,
    finders: &[String],
    item: &RequireItem,
    classic: bool,
) -> Result<Option<PathBuf>> {
    let candidates: Vec<PathBuf> = if item.is_require {
        let name = item
            .module
            .split('.')
            .filter(|w| !w.is_empty())
            .collect::<Vec<_>>()
            .join("/");
        finders.iter().map(|f| source_dir.join(f.replace('?', &name))).collect()
    } else {
        let p = Path::new(&item.module);
        vec![if p.is_absolute() { p.to_path_buf() } else { source_dir.join(p) }]
    };

    for c in candidates {
        if c.exists() {
            return Ok(Some(c));
        }
    }
    if classic {
        return Ok(None); // classic 允许 jass.* 等内置包
    }
    Err(Error::with_args(
        "error.notFound",
        format!("Not found {}", item.module),
        vec![item.module.clone()],
    ))
}
```

实现备注：full-moon 1.x 的 `Expression::String` / `FunctionArgs::String` / `StringLiteral` 变体名随版本可能为 `Expression::Value`+`Value::String`；以编译错误为准调整模式匹配，测试锁定行为。

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core require_graph`
Expected: 3 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): require/dofile/loadfile scanning and resolution"
```

### Task 12: minify.rs（token 级压缩，DV3）

**Files:**
- Create: `crates/wc3-core/src/minify.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod minify;`）

替代 luamin：丢弃注释与多余空白，token 间按需插入单空格（两个相邻 token 若直接拼接会改变词法则插空格），**不重命名**。判定规则：前 token 末字符与后 token 首字符同为「单词字符（字母/数字/_）」时需空格；`-`+`-`（拼成注释）、数字后接 `.`/`..` 等歧义场景统一保守插空格。

- [ ] **Step 1: 写失败测试**

```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn strips_comments_and_whitespace() {
        let out = minify("-- comment\nlocal x = 1  +  2\n--[[ block ]]\nreturn x\n").unwrap();
        assert_eq!(out, "local x=1+2 return x");
    }

    #[test]
    fn preserves_word_boundaries_and_strings() {
        let out = minify("local function f(a, b)\n    return a and b\nend\nreturn f(1, 2), 'a  b'").unwrap();
        assert_eq!(out, "local function f(a,b)return a and b end return f(1,2),'a  b'");
    }

    #[test]
    fn keeps_ambiguous_minus_apart() {
        let out = minify("local a = 1 - -2").unwrap();
        assert_eq!(out, "local a=1- -2");
    }

    #[test]
    fn rejects_invalid_source() {
        assert!(minify("local = =").is_err());
    }
}
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core minify`
Expected: 编译失败。

- [ ] **Step 3: 实现**

```rust
use crate::error::{Error, Result};

fn is_word_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

fn needs_space(prev: &str, next: &str) -> bool {
    let (Some(a), Some(b)) = (prev.chars().last(), next.chars().next()) else { return false };
    if is_word_char(a) && is_word_char(b) {
        return true; // and b / 1 e 等
    }
    if a == '-' && b == '-' {
        return true; // 避免拼成注释
    }
    if a.is_ascii_digit() && b == '.' {
        return true; // 1 .. 2 之类
    }
    if a == '.' && b == '.' {
        return true;
    }
    false
}

/// token 级 minify：丢注释/空白，必要处补单空格。不重命名（DV3）。
pub fn minify(source: &str) -> Result<String> {
    let tokens = full_moon::tokenizer::tokens(source)
        .map_err(|e| Error::new("error.processFilesFailure", format!("minify: {e:?}")))?;
    let mut out = String::with_capacity(source.len() / 2);
    let mut prev: Option<String> = None;
    for tok in &tokens {
        use full_moon::tokenizer::TokenKind;
        match tok.token_kind() {
            TokenKind::Whitespace | TokenKind::SingleLineComment | TokenKind::MultiLineComment | TokenKind::Eof => {
                continue
            }
            _ => {}
        }
        let text = tok.to_string();
        if let Some(p) = &prev {
            if needs_space(p, &text) {
                out.push(' ');
            }
        }
        out.push_str(&text);
        prev = Some(text);
    }
    Ok(out)
}
```

实现备注：`full_moon::tokenizer::tokens()` 若该版本未公开，等价替代为 `full_moon::parse` 后遍历 `ast.tokens()`。注释 TokenKind 名以 crate 为准（可能是 `Shebang`/`SingleLineComment`/`MultiLineComment`）。

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core minify`
Expected: 4 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): token-level lua minifier (no renaming)"
```

### Task 13: jass.rs + mopaq.rs（war3map.j 注入）

**Files:**
- Create: `crates/wc3-core/src/jass.rs`、`crates/wc3-core/src/mopaq.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod jass;` `pub mod mopaq;`）

TS 对应 `injectWar3mapJass`/`extractWar3mapJass`（compiler.ts:95-135）。注入规则（按 `\r\n` 分行，逐行扫描）：进入 `function main takes nothing returns nothing` 后，遇 `call InitGlobals()`（或带双空格变体）→ 该行替换为两行 `    call InitGlobals()` + `    call Cheat("exec-lua:war3map")`，结束；否则遇 `endfunction` → 该行替换为 `    call Cheat("exec-lua:war3map")` + `endfunction`，结束。未找到 main → `error.noMapScriptFileMain`。

- [ ] **Step 1: 写失败测试（jass.rs 尾部）**

```rust
#[cfg(test)]
mod tests {
    use super::*;

    const J: &str = "globals\r\nendglobals\r\n\r\nfunction main takes nothing returns nothing\r\n    call InitGlobals()\r\n    call X()\r\nendfunction\r\n";

    #[test]
    fn injects_after_init_globals() {
        let out = inject_cheat(J).unwrap();
        assert!(out.contains("    call InitGlobals()\r\n    call Cheat(\"exec-lua:war3map\")\r\n    call X()"));
    }

    #[test]
    fn injects_before_endfunction_when_no_init_globals() {
        let j = "function main takes nothing returns nothing\r\n    call X()\r\nendfunction";
        let out = inject_cheat(j).unwrap();
        assert!(out.contains("    call X()\r\n    call Cheat(\"exec-lua:war3map\")\r\nendfunction"));
    }

    #[test]
    fn errors_without_main() {
        let err = inject_cheat("function foo takes nothing returns nothing\r\nendfunction").unwrap_err();
        assert_eq!(err.key, "error.noMapScriptFileMain");
    }

    #[test]
    fn does_not_touch_init_globals_outside_main() {
        let j = "function setup takes nothing returns nothing\r\n    call InitGlobals()\r\nendfunction\r\nfunction main takes nothing returns nothing\r\n    call InitGlobals()\r\nendfunction";
        let out = inject_cheat(j).unwrap();
        let first = out.find("call Cheat").unwrap();
        assert!(first > out.find("function main").unwrap());
    }
}
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core jass`
Expected: 编译失败。

- [ ] **Step 3: 实现**

`jass.rs`：

```rust
use crate::error::{Error, Result};

const CHEAT: &str = "    call Cheat(\"exec-lua:war3map\")";

/// TS injectWar3mapJass 的纯文本部分：CRLF 分行、main 内注入。
pub fn inject_cheat(jass: &str) -> Result<String> {
    let mut lines: Vec<String> = jass.split("\r\n").map(|s| s.to_string()).collect();
    let mut in_main = false;
    let mut done = false;
    let mut i = 0;
    while i < lines.len() {
        let line = lines[i].clone();
        if line.contains("function main takes nothing returns nothing") {
            in_main = true;
        }
        if in_main && (line.contains("call InitGlobals()") || line.contains("call InitGlobals(  )")) {
            lines.splice(i..=i, ["    call InitGlobals()".to_string(), CHEAT.to_string()]);
            done = true;
            break;
        }
        if in_main && line.contains("endfunction") {
            lines.splice(i..=i, [CHEAT.to_string(), "endfunction".to_string()]);
            done = true;
            break;
        }
        i += 1;
    }
    if !in_main || !done {
        return Err(Error::new("error.noMapScriptFileMain", "Not found: main function in War3map.j file"));
    }
    Ok(lines.join("\r\n"))
}
```

注意：TS 原实现的 `index` 变量在 main 函数行之后才匹配时存在「index 未对齐」的潜在 bug（index 不在 main 行重置）——但因 splice 用的是同一个遍历索引，实际行为等价于上述写法；黄金 `debug-classic/war3map.j` 对照兜底。

`mopaq.rs`（阶段 1 仅子进程薄封装，供「mapdir 是 .w3x 文件」时提取 war3map.j/war3map.lua；阶段 2 库化替换）：

```rust
use std::path::Path;

use crate::error::{Error, Result};

/// 调用 MopaqPack-rs.exe extract（TS utils.extractFileFromMap 等价）。
/// `exe` 由 CLI 层传入（--res-dir 解析），返回 false 表示文件不存在于地图。
pub fn extract_file_from_map(exe: &Path, map: &Path, file_in_map: &str, out: &Path) -> Result<bool> {
    if out.exists() {
        std::fs::remove_file(out).map_err(|e| Error::io(&out.to_path_buf(), e))?;
    }
    if let Some(dir) = out.parent() {
        std::fs::create_dir_all(dir).map_err(|e| Error::io(&dir.to_path_buf(), e))?;
    }
    let status = std::process::Command::new(exe)
        .args(["extract", "-o"])
        .arg(out)
        .arg("-m")
        .arg(map)
        .args(["-f", file_in_map])
        .status()
        .map_err(|e| Error::new("error.io", format!("{}: {e}", exe.display())))?;
    let _ = status; // TS 忽略退出码，以输出文件是否存在为准
    Ok(out.exists())
}
```

mopaq.rs 不写单测（依赖外部 exe），由阶段 2 库化时覆盖；`cargo clippy` 通过即可。

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core jass`
Expected: 4 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): war3map.j cheat injection and mopaq subprocess wrapper"
```

### Task 14: compiler.rs — debug 管线编排

**Files:**
- Create: `crates/wc3-core/src/compiler.rs`
- Modify: `crates/wc3-core/src/lib.rs`（加 `pub mod compiler;`）

TS 对应 `DebugCompiler.execute/genFile`（debug.ts）。流程：校验 src 目录 → 收集排序后的源文件 → 逐文件 `macros → (含 compiletime 则求值替换，DV2 不 minify) → render_debug_file` → reforge 追加 origwar3map.lua（mapdir 为目录时取 `<mapdir>/war3map.lua`；为 .w3x 文件时经 mopaq 提取）→ join `'\n'` → `render_main(Debug, ...)` → 写 `.build/war3map.lua` → classic 时 JASS 注入（jassfile 优先，否则 mopaq 提取 `war3map.j`，再退 `scripts\war3map.j`）写 `.build/war3map.j`。

- [ ] **Step 1: 写失败测试**

`compiler.rs` 尾部：

```rust
#[cfg(test)]
mod tests {
    use super::*;
    use crate::config::{BuildContext, BuildOptions, ProjectConfig};

    fn synth_project() -> std::path::PathBuf {
        let d = std::env::temp_dir().join(format!("wc3-dbg-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(d.join("src/lib")).unwrap();
        std::fs::create_dir_all(d.join("map")).unwrap();
        std::fs::write(d.join("warcraft.json"), r#"{ "mapdir": "map", "jassfile": "war3map.j" }"#).unwrap();
        std::fs::write(d.join("src/main.lua"), "--@debug@\nD=1\n--@end-debug@\nreturn require('lib.util')").unwrap();
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
        BuildContext::new(root, cfg, BuildOptions { release, classic, ..Default::default() })
    }

    #[test]
    fn debug_reforge_bundles_sources_and_orig() {
        let root = synth_project();
        compile_debug(&ctx(&root, false, false), None).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['main.lua'] = "));
        assert!(out.contains("P['lib/util.lua'] = "));
        assert!(out.contains("P['origwar3map.lua'] = "));
        assert!(out.contains("--@debug@\nD=1\n--@end-debug@"), "debug 宏启用");
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
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core compiler`
Expected: 编译失败。

- [ ] **Step 3: 实现**

```rust
use std::path::{Path, PathBuf};

use crate::config::BuildContext;
use crate::error::{Error, Result};
use crate::{comptime, fsutil, jass, macros, mopaq, templates};

/// 外部工具定位（CLI 层从 --res-dir 解析传入；None 时依赖 jassfile/目录地图路径）。
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

/// TS DebugCompiler.genFile：宏 → compiletime → 模板单文件项。
/// `lua`：构建级共享 compiletime 引擎（DV6）。
fn gen_debug_file(ctx: &BuildContext, lua: &mlua::Lua, file: &Path, name: &str) -> Result<String> {
    let raw = fsutil::read_to_string(file)?;
    let mut body = macros::process_code_macros(&raw, ctx.opts.release, ctx.opts.classic);
    if body.contains("compiletime") {
        body = comptime::process(lua, &body, name)?;
    }
    Ok(templates::render_debug_file(name, &body))
}

/// TS getOriginMapScript：目录地图直接读，文件地图经 mopaq 提取到 .build。
fn origin_map_script(ctx: &BuildContext, tools: &Tools) -> Result<PathBuf> {
    let map = ctx.map_dir()?;
    if map.is_file() {
        let exe = tools.mopaq_exe.ok_or_else(|| Error::new("error.io", "MopaqPack-rs.exe not configured"))?;
        let out = ctx.build_dir().join("origwar3map.lua.extracted");
        if !mopaq::extract_file_from_map(exe, &map, "war3map.lua", &out)? {
            return Err(Error::new("error.noMapScriptFile", "Not found: war3map.lua file"));
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
        let exe = tools.mopaq_exe.ok_or_else(|| Error::new("error.io", "MopaqPack-rs.exe not configured"))?;
        let map = ctx.map_dir()?;
        if !mopaq::extract_file_from_map(exe, &map, "war3map.j", &out)?
            && !mopaq::extract_file_from_map(exe, &map, "scripts\\war3map.j", &out)?
        {
            return Err(Error::new("error.noMapScriptFile", "Not found: war3map.j file"));
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

    let lua = comptime::make_lua()?; // 构建级共享 compiletime 引擎（DV6）
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
```

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core compiler`
Expected: 3 个测试 PASS。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): debug compile pipeline"
```

### Task 15: compiler.rs — release 管线编排

**Files:**
- Modify: `crates/wc3-core/src/compiler.rs`
- Modify: `crates/wc3-core/Cargo.toml`（已含 indexmap）

TS 对应 `ReleaseCompiler`（release.ts）。差异点：以 `main.lua` + `warcraft.json files[]` 为根做 require 图 DFS（DV4 确定性顺序）；每文件 `宏 → compiletime → minify`；按 posix 名去重；reforge 追加 origwar3map.lua；整体经 `render_main(Release)` 后再整体 minify（confusion=Disable 路径）；confusion 启用时写未压缩产物并调用 wc3-confuse（子进程，Task 18）。

- [ ] **Step 1: 写失败测试（追加到 compiler.rs tests）**

```rust
    #[test]
    fn release_reforge_resolves_require_graph() {
        let root = synth_project();
        compile_release(&ctx(&root, true, false), None, None).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['main.lua']"));
        assert!(out.contains("P['lib/util.lua']"), "require 链被打包");
        assert!(out.contains("P['origwar3map.lua']"));
        assert!(!out.contains("--@debug@"), "整体 minify 后无注释");
        assert!(!out.contains("D=1"), "debug 宏在 release 被注释剔除");
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
        compile_release(&ctx(&root, true, true), None, None).unwrap();
        let out = std::fs::read_to_string(root.join(".build/war3map.lua")).unwrap();
        assert!(out.contains("P['lib/util.lua']"));
        assert!(!out.contains("jass/common"), "classic 内置包跳过");
        std::fs::remove_dir_all(&root).unwrap();
    }

    #[test]
    fn release_reforge_missing_module_errors() {
        let root = synth_project();
        std::fs::write(root.join("src/main.lua"), "require('no.such')").unwrap();
        let err = compile_release(&ctx(&root, true, false), None, None).unwrap_err();
        assert_eq!(err.key, "error.notFound");
        std::fs::remove_dir_all(&root).unwrap();
    }
```

- [ ] **Step 2: 运行确认失败**

Run: `cargo test -p wc3-core compiler::tests::release`
Expected: 编译失败（`compile_release` 未定义）。

- [ ] **Step 3: 实现（追加到 compiler.rs）**

```rust
use indexmap::IndexMap;

use crate::config::Confusion;
use crate::{minify, require_graph};

struct PendingFile {
    item: require_graph::RequireItem,
    /// 覆盖名（origwar3map.lua 用）
    name: Option<String>,
    /// dofile/files 项的绝对路径直传
    abs: Option<PathBuf>,
}

/// TS ReleaseCompiler.processFiles 的确定性 DFS 版（DV4）。`lua`：构建级共享 compiletime 引擎（DV6）。
fn process_release_files(
    ctx: &BuildContext,
    lua: &mlua::Lua,
    src: &Path,
    files: &mut IndexMap<String, String>,
    pending: PendingFile,
) -> Result<()> {
    let resolved: Option<PathBuf> = match &pending.abs {
        Some(p) => Some(p.clone()),
        None => require_graph::resolve(src, &ctx.config.lua_package_path, &pending.item, ctx.opts.classic)?,
    };
    let Some(file) = resolved else { return Ok(()) }; // classic 内置包
    let name = match &pending.name {
        Some(n) => n.clone(),
        None => fsutil::posix_relative(src, &file)?,
    };
    if files.contains_key(&name) {
        return Ok(());
    }
    let raw = fsutil::read_to_string(&file)?;
    let mut body = macros::process_code_macros(&raw, ctx.opts.release, ctx.opts.classic);
    if body.contains("compiletime") {
        body = comptime::process(lua, &body, &name)?;
    }
    let required = require_graph::scan_requires(&body);
    files.insert(name, minify::minify(&body)?);
    for item in required {
        process_release_files(ctx, lua, src, files, PendingFile { item, name: None, abs: None })?;
    }
    Ok(())
}

/// TS ReleaseCompiler.execute。`confuse_exe`：confusion!=Disable 时必需（Task 18）。
pub fn compile_release(ctx: &BuildContext, mopaq_exe: Option<&Path>, confuse_exe: Option<&Path>) -> Result<()> {
    let tools = Tools { mopaq_exe };
    let src = ensure_source_dir(ctx)?;
    std::fs::create_dir_all(ctx.build_dir()).map_err(|e| Error::io(&ctx.build_dir(), e))?;

    let lua = comptime::make_lua()?; // 构建级共享 compiletime 引擎（DV6）
    let mut files: IndexMap<String, String> = IndexMap::new();
    process_release_files(
        ctx,
        &lua,
        &src,
        &mut files,
        PendingFile {
            item: require_graph::RequireItem { module: "main.lua".into(), is_require: false },
            name: None,
            abs: None,
        },
    )?;
    for f in &ctx.config.files {
        process_release_files(
            ctx,
            &lua,
            &src,
            &mut files,
            PendingFile {
                item: require_graph::RequireItem { module: f.clone(), is_require: false },
                name: None,
                abs: None,
            },
        )?;
    }
    if !ctx.opts.classic {
        let script = origin_map_script(ctx, &tools)?;
        process_release_files(
            ctx,
            &lua,
            &src,
            &mut files,
            PendingFile {
                item: require_graph::RequireItem { module: String::new(), is_require: false },
                name: Some("origwar3map.lua".into()),
                abs: Some(script),
            },
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

    if ctx.opts.confusion != Confusion::Disable {
        std::fs::write(&out_path, &out).map_err(|e| Error::io(&out_path, e))?;
        let exe = confuse_exe.ok_or_else(|| Error::new("error.io", "wc3-confuse.exe not configured"))?;
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
            return Err(Error::new("error.processFilesFailure", "lua confusion failed"));
        }
    } else {
        let minified = minify::minify(&out)?;
        std::fs::write(&out_path, minified).map_err(|e| Error::io(&out_path, e))?;
    }

    if ctx.opts.classic {
        write_injected_jass(ctx, &tools)?;
    }
    Ok(())
}
```

- [ ] **Step 4: 运行测试通过**

Run: `cargo test -p wc3-core compiler`
Expected: 6 个测试 PASS（含 Task 14 的 3 个）。

- [ ] **Step 5: Commit**

```bash
git add crates/wc3-core
git commit -m "feat(core): release compile pipeline with require graph"
```

### Task 16: wc3-cli — compile 子命令与 NDJSON 事件

**Files:**
- Modify: `crates/wc3-cli/src/main.rs`

- [ ] **Step 1: 实现 CLI**

```rust
use std::path::PathBuf;
use std::process::ExitCode;

use clap::{Parser, Subcommand, ValueEnum};
use wc3_core::config::{BuildContext, BuildOptions, Confusion, ProjectConfig};

#[derive(Parser)]
#[command(name = "wc3", about = "Warcraft III map toolchain", version)]
struct Cli {
    #[command(subcommand)]
    command: Command,
}

#[derive(Clone, Copy, ValueEnum)]
enum ConfusionArg {
    Disable,
    Minify,
    Weak,
    Medium,
    Strong,
}

impl From<ConfusionArg> for Confusion {
    fn from(v: ConfusionArg) -> Self {
        match v {
            ConfusionArg::Disable => Confusion::Disable,
            ConfusionArg::Minify => Confusion::Minify,
            ConfusionArg::Weak => Confusion::Weak,
            ConfusionArg::Medium => Confusion::Medium,
            ConfusionArg::Strong => Confusion::Strong,
        }
    }
}

#[derive(Subcommand)]
enum Command {
    /// Compile lua sources into .build/war3map.lua
    Compile {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        release: bool,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        #[arg(long, value_enum, default_value = "disable")]
        confusion: ConfusionArg,
        /// Directory containing MopaqPack-rs.exe / wc3-confuse.exe (defaults next to wc3.exe)
        #[arg(long)]
        res_dir: Option<PathBuf>,
    },
}

fn emit(value: serde_json::Value) {
    println!("{value}");
}

fn progress(step: &str, message: &str) {
    emit(serde_json::json!({ "event": "progress", "step": step, "message": message }));
}

fn res_dir_or_exe_dir(res_dir: Option<PathBuf>) -> PathBuf {
    res_dir.unwrap_or_else(|| {
        std::env::current_exe()
            .ok()
            .and_then(|p| p.parent().map(|d| d.to_path_buf()))
            .unwrap_or_else(|| PathBuf::from("."))
    })
}

fn main() -> ExitCode {
    let cli = Cli::parse();
    match cli.command {
        Command::Compile { project, release, classic, map, confusion, res_dir } => {
            let run = || -> wc3_core::error::Result<()> {
                let config = ProjectConfig::load(&project)?;
                let ctx = BuildContext::new(
                    &project,
                    config,
                    BuildOptions { release, classic, map, confusion: confusion.into() },
                );
                let tools = res_dir_or_exe_dir(res_dir);
                let mopaq = tools.join("MopaqPack-rs.exe");
                let mopaq = mopaq.exists().then_some(mopaq);
                let confuse = tools.join("wc3-confuse.exe");
                let confuse = confuse.exists().then_some(confuse);
                progress("compile", "Compiling script");
                if release {
                    wc3_core::compiler::compile_release(&ctx, mopaq.as_deref(), confuse.as_deref())?;
                } else {
                    wc3_core::compiler::compile_debug(&ctx, mopaq.as_deref())?;
                }
                progress("compile", "done");
                Ok(())
            };
            match run() {
                Ok(()) => ExitCode::SUCCESS,
                Err(e) => {
                    emit(serde_json::json!({
                        "event": "error", "key": e.key, "message": e.message, "args": e.args
                    }));
                    ExitCode::FAILURE
                }
            }
        }
    }
}
```

- [ ] **Step 2: 冒烟验证**

Run: `cargo run -p wc3-cli -- compile testdata/fixtures/basic`
Expected: 两行 progress NDJSON，退出码 0，`testdata/fixtures/basic/.build/war3map.lua` 生成。验证后删除 `.build`：`Remove-Item -Recurse -Force testdata/fixtures/basic/.build`。

Run: `cargo run -p wc3-cli -- compile testdata/fixtures/basic -r -c`，同样验证后清理。

- [ ] **Step 3: Commit**

```bash
git add crates/wc3-cli
git commit -m "feat(cli): wc3 compile subcommand with NDJSON events"
```

### Task 17: 四象限黄金对照集成测试

**Files:**
- Create: `crates/wc3-core/tests/golden.rs`

对照规则（spec §5 + DV1-DV5）：
- `basic` 的 **debug-reforge / debug-classic**：与黄金**字节一致**（无 compiletime、无 minify 路径，理论上完全可复现；war3map.j 同样字节比）。
- `basic` 的 release 象限与 `comptime` 全部象限：**语义对照**——黄金与 Rust 产物分别在干净 mlua(5.4) 沙箱执行，比较 `RESULT` 表深度相等。reforge 产物执行后需手动调 `main()`（模板不自调），classic 产物加载即自调。

- [ ] **Step 1: 编写测试**

```rust
use std::path::{Path, PathBuf};

use wc3_core::config::{BuildContext, BuildOptions, ProjectConfig};

fn repo_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../..").canonicalize().unwrap()
}

/// fixture 复制到临时目录构建，避免污染 testdata。
fn build(fixture: &str, release: bool, classic: bool) -> PathBuf {
    let src = repo_root().join("testdata/fixtures").join(fixture);
    let dst = std::env::temp_dir().join(format!("wc3-golden-{fixture}-{release}-{classic}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dst);
    copy_dir(&src, &dst);
    let cfg = ProjectConfig::load(&dst).unwrap();
    let ctx = BuildContext::new(&dst, cfg, BuildOptions { release, classic, ..Default::default() });
    if release {
        wc3_core::compiler::compile_release(&ctx, None, None).unwrap();
    } else {
        wc3_core::compiler::compile_debug(&ctx, None).unwrap();
    }
    dst
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

fn golden(fixture: &str, quad: &str, file: &str) -> String {
    std::fs::read_to_string(repo_root().join("testdata/golden").join(fixture).join(quad).join(file)).unwrap()
}

/// 在干净沙箱执行 war3map.lua，返回 RESULT 的 to_lua 规范化串。
fn exec_result(code: &str, classic: bool) -> String {
    let lua = mlua::Lua::new();
    lua.load(code).exec().unwrap();
    if !classic {
        let main: mlua::Function = lua.globals().get("main").unwrap();
        main.call::<()>(()).unwrap();
    }
    let result: mlua::Value = lua.globals().get("RESULT").unwrap();
    wc3_core::luastr::to_lua(&result)
}

#[test]
fn basic_debug_quadrants_byte_identical() {
    for classic in [false, true] {
        let quad = if classic { "debug-classic" } else { "debug-reforge" };
        let out_dir = build("basic", false, classic);
        let ours = std::fs::read_to_string(out_dir.join(".build/war3map.lua")).unwrap();
        assert_eq!(ours, golden("basic", quad, "war3map.lua"), "{quad} war3map.lua 必须字节一致");
        if classic {
            let j = std::fs::read_to_string(out_dir.join(".build/war3map.j")).unwrap();
            assert_eq!(j, golden("basic", quad, "war3map.j"), "{quad} war3map.j 必须字节一致");
        }
        std::fs::remove_dir_all(&out_dir).unwrap();
    }
}

#[test]
fn semantic_quadrants_match_golden() {
    let cases: &[(&str, bool, bool)] = &[
        ("basic", true, false),
        ("basic", true, true),
        ("comptime", false, false),
        ("comptime", false, true),
        ("comptime", true, false),
        ("comptime", true, true),
    ];
    for (fixture, release, classic) in cases {
        let quad = format!("{}-{}", if *release { "release" } else { "debug" }, if *classic { "classic" } else { "reforge" });
        let out_dir = build(fixture, *release, *classic);
        let ours = std::fs::read_to_string(out_dir.join(".build/war3map.lua")).unwrap();
        let theirs = golden(fixture, &quad, "war3map.lua");
        assert_eq!(
            exec_result(&ours, *classic),
            exec_result(&theirs, *classic),
            "{fixture}/{quad} RESULT 语义必须一致"
        );
        std::fs::remove_dir_all(&out_dir).unwrap();
    }
}
```

- [ ] **Step 2: 运行并校准**

Run: `cargo test -p wc3-core --test golden`

预期需要 1-3 轮校准：字节对照失败时 diff 黄金与产物（`git diff --no-index`），**黄金是裁判**——差异通常出现在模板资产的空白/换行缝（underscore-template-loader 对求值块行的留白处理）。修正 `assets/main-*.lua` 的标记行留白直至 `basic_debug_quadrants_byte_identical` 通过。语义对照失败则回到对应模块修复。

Expected（最终）: 2 个测试 PASS。

- [ ] **Step 3: 全量回归**

Run: `cargo fmt --all -- --check && cargo clippy --workspace --all-targets -- -D warnings && cargo test --workspace`
Expected: 全绿。

- [ ] **Step 4: Commit**

```bash
git add crates/wc3-core
git commit -m "test(core): four-quadrant golden comparison against TS pipeline"
```

### Task 18: wc3-confuse spike（Prometheus on mlua/lua51）

**Files:**
- Create: `crates/wc3-confuse/Cargo.toml`、`crates/wc3-confuse/src/main.rs`
- Modify: `Cargo.toml`（workspace members 加 `crates/wc3-confuse`）

**Spike 性质：本任务结束时给出 go/no-go 结论。** 前置：`node prepare.js` 已下载 Prometheus 源码到 `bin/lua/`（需 GH_ACCESS_TOKEN 或公网直连）。mlua 的 lua51 与 lua54 不能共存于同一进程，故独立二进制（spec §7 风险 3 方案 A）。

- [ ] **Step 1: crate 骨架**

`crates/wc3-confuse/Cargo.toml`：

```toml
[package]
name = "wc3-confuse"
version.workspace = true
edition.workspace = true
license.workspace = true

[[bin]]
name = "wc3-confuse"
path = "src/main.rs"

[dependencies]
# 注意：不能用 workspace 的 mlua（lua54）；本 crate 单独声明 lua51
mlua = { version = "0.10", features = ["lua51", "vendored"] }
clap.workspace = true
```

> workspace 内两个 crate 依赖不同 lua feature 会因 feature 合一冲突 —— mlua 的版本 feature 互斥。若 `cargo build --workspace` 报 feature 冲突，则将 wc3-confuse 从 workspace members 移除、改为独立 crate（保留在 crates/ 目录，单独 `cargo build -p` 路径构建，CI 单列 step）。这是 spike 要验证的第一件事。

- [ ] **Step 2: 实现 Prometheus 运行器**

`crates/wc3-confuse/src/main.rs`（TS Prometheus.compile 等价：cli.lua + `--Lua51 --preset X --out f f`，注入 io patch）：

```rust
use std::path::PathBuf;

use clap::Parser;

#[derive(Parser)]
#[command(name = "wc3-confuse")]
struct Cli {
    /// Prometheus 源码目录（含 cli.lua），默认 exe 旁的 lua/
    #[arg(long)]
    prometheus_dir: Option<PathBuf>,
    #[arg(long)]
    preset: String,
    #[arg(long)]
    out: PathBuf,
    input: PathBuf,
}

fn main() -> std::process::ExitCode {
    let cli = Cli::parse();
    let dir = cli.prometheus_dir.unwrap_or_else(|| {
        std::env::current_exe().unwrap().parent().unwrap().join("lua")
    });
    match run(&dir, &cli.preset, &cli.input, &cli.out) {
        Ok(()) => std::process::ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("confuse failed: {e}");
            std::process::ExitCode::FAILURE
        }
    }
}

fn run(dir: &std::path::Path, preset: &str, input: &std::path::Path, out: &std::path::Path) -> Result<(), Box<dyn std::error::Error>> {
    let lua = unsafe { mlua::Lua::unsafe_new() }; // Prometheus 需要完整 stdlib（含 io/os）
    // arg 表与 TS doString 注入一致
    let args = lua.create_table()?;
    args.set(1, "--Lua51")?;
    args.set(2, "--preset")?;
    args.set(3, preset)?;
    args.set(4, "--out")?;
    args.set(5, out.to_string_lossy().to_string())?;
    args.set(6, input.to_string_lossy().to_string())?;
    lua.globals().set("arg", args)?;
    // package.path 指向 Prometheus 源码目录（原生 io 可直接读盘，无需 wasmoon 的挂载与 io patch）
    lua.load(format!(
        "package.path = [[{0}/?.lua;{0}/?/init.lua;]] .. package.path",
        dir.display().to_string().replace('\\', "/")
    ))
    .exec()?;
    let cli_lua = dir.join("cli.lua");
    let code = std::fs::read_to_string(&cli_lua)?;
    lua.load(&code).set_name("@cli.lua").exec()?;
    Ok(())
}
```

- [ ] **Step 3: spike 验证（人工，go/no-go）**

前置：`node prepare.js`（生成 `bin/lua/`）。

Run: `cargo build -p wc3-confuse`，然后：

```powershell
Copy-Item testdata/golden/basic/release-reforge/war3map.lua $env:TEMP/confuse-in.lua
cargo run -p wc3-confuse -- --prometheus-dir bin/lua --preset Minify --out $env:TEMP/confuse-out.lua $env:TEMP/confuse-in.lua
```

Expected: 退出码 0，`confuse-out.lua` 非空且可被 `lua` 加载（用 Task 17 的 exec_result 思路人工验证 RESULT 一致）。

**Go**：上述通过 → 在 plan 收尾提交中记录结论，wc3-cli 的 confusion 路径即告可用。
**No-go**：Prometheus 依赖 wasmoon 特有行为（如 io patch、路径假设）无法直跑 → 记录失败细节，回退方案：阶段 3 暂保留 TS 混淆路径（仅 confusion!=Disable 时走旧管线），混淆迁移移入阶段 4 重新设计。**No-go 不阻塞阶段 1 验收**（confusion 默认 Disable）。

- [ ] **Step 4: Commit**

```bash
git add Cargo.toml crates/wc3-confuse
git commit -m "feat(confuse): prometheus runner spike on mlua/lua51"
```

### Task 19: 阶段收尾 — 文档与验收

**Files:**
- Modify: `README.md`（追加 crates 构建说明小节）
- Modify: `docs/superpowers/specs/2026-06-12-rust-core-split-design.md`（如 spike 结论影响 §7 风险 3，更新之）

- [ ] **Step 1: README 追加**

在 README 适当位置（开发说明附近）追加：

```markdown
## Rust toolchain (crates/)

The map pipeline is being rewritten in Rust (see docs/superpowers/specs/2026-06-12-rust-core-split-design.md).

- Build: `cargo build --workspace`
- Test: `cargo test --workspace` (golden tests compare against `testdata/golden/`, generated by `scripts/make-golden.ps1`)
- CLI: `cargo run -p wc3-cli -- compile <project> [-r] [-c]`
```

- [ ] **Step 2: 阶段 1 验收清单（全部满足才算完成）**

- `cargo fmt/clippy/test --workspace` 全绿，CI 通过。
- Task 17 黄金对照 2 测试通过（含字节级 debug 象限）。
- 真实工程抽验：任选一个实际地图工程，分别用 `bin/cli.js compile` 与 `wc3 compile` 构建 debug-reforge，diff war3map.lua 为空；在游戏中实跑 Rust 产物一次（spec §5 端到端要求）。
- spike go/no-go 结论已记录。

- [ ] **Step 3: Commit**

```bash
git add README.md docs
git commit -m "docs: rust toolchain build notes and phase 1 acceptance"
```

---

## 后续（不在本计划内）

阶段 2（pack/objediting + MopaqPack-rs 库化）与阶段 3（插件瘦身、NDJSON 桥、VSIX 集成）在阶段 1 验收后另行出计划，复用本计划的 fixtures 与黄金机制。






