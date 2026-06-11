# warcraft-vscode 拆分与 Rust 重构设计

- 日期：2026-06-12
- 状态：已确认（待实施）
- 范围：将 VSCode 插件脚手架与功能主体拆分，功能主体以 Rust 重写为独立 CLI

## 1. 背景与目标

warcraft-vscode 是 Warcraft III 地图开发工具集，当前以 TypeScript 单体实现：VSCode UI、Lua 编译管线、打包编排、物编编排、游戏启动混在同一代码库与运行时中。

目标：

1. 功能主体（编译/打包/物编管线）用 Rust 重写为独立 CLI（`wc3.exe`），插件以子进程方式调用。
2. VSCode 插件退化为薄壳：命令注册、状态栏、设置读取、UI 对话框、进度展示。
3. CLI 可脱离 VSCode 独立用于 CI，最终取代现有 Node CLI（`vscwarcraft`）。

非目标（本期不做）：

- runner（游戏/编辑器启动）迁移——首期留在 TS（见决策 D4）。
- ObjEditing.exe 的库化吸收——仍以外部 exe 编排。
- 跨平台支持——工具链 Windows-only（reg 查询、.exe 工具、游戏本体），暂不扩展。

## 2. 现状分析

### 2.1 已有的拆分基础

- 打包已由外部 Rust 程序 `bin/MopaqPack-rs.exe` 完成，物编由 `bin/ObjEditing.exe` 完成，均由 `prepare.js` 从 GitHub Release 下载——「边车」模式已是既成事实。
- `src/env/runtime.ts` 对 vscode API 做懒加载抽象，`src/cli.ts` 已能脱离 VSCode 复用同一管线（`bin.vscwarcraft`）。
- 真正留在 TS 进程内的核心功能是 Lua 编译管线。

### 2.2 模块归类

| 类别 | 模块 | 内容 |
|---|---|---|
| 功能主体（迁 Rust） | `src/app/compiler/` | 注释宏处理（`--@debug@`/`--@release@`/`--@classic@`/`--@reforge@` 及 non-* 变体）、`compiletime()` 求值（wasmoon Lua VM）、release 模式 require 依赖图解析、luamin 压缩、Prometheus 混淆、Classic 版 war3map.j 主函数注入 |
| 功能主体（迁 Rust） | `src/app/packer/` | packlist 生成（map 目录 + libraries imports + objediting 产物 + war3map.lua 去重合并）+ 调用 MopaqPack-rs.exe |
| 功能主体（迁 Rust） | `src/app/objediting/` | 物编源文件准备（从地图提取/复制 w3u 等 7 类）、.def 定义版本管理（res/def.zip 解压）、调用 ObjEditing.exe |
| 脚手架（留 TS） | `src/extension.ts`、`src/app/app.ts`、`src/app/command.ts` | 激活、命令注册、状态栏按钮、warcraft.json 文件监听 |
| 脚手架（留 TS） | `src/app/project/project.ts`、`library.ts` | 创建工程对话框（模板 zip 下载解压）、GitHub 库 QuickPick、git submodule 管理 |
| 暂留 TS | `src/app/runner/` | 启动游戏/编辑器、注册表查询文档目录、product.db protobuf 解析、进程管理（kill/sudo）、关闭确认对话框 |
| 两侧分割 | `src/env/config.ts` | vscode settings（gamePath、configuration、luaConfusion 等）读取留 TS 并转为 CLI 参数；`warcraft.json`（mapdir/files/jassfile/lua.package.path）由 Rust 直接读取 |

### 2.3 关键耦合点

1. **Lua 模板经 webpack `underscore-template-loader` 编译进 bundle**（`src/templates/`，自定义定界符 `--[[%= %]]` / `--[[%> %]]`）。Rust 侧需 `include_str!` 内嵌并重写渲染逻辑。
2. **wasmoon（WASM Lua VM）承担两件事**：`compiletime()` 求值（`BaseCompiler.checkCompileTime`：把 `compiletime(function() ... end)` 的返回值经 `toLua` 序列化回填为 StringLiteral 节点）；运行 Prometheus 混淆器（`utils/prometheus.ts`：挂载 bin/lua 目录、注入 `io.readFile/writeFile`、patch `io.open` 写模式）。
3. **进度上报装饰器 `@utils.report` 直通 vscode 通知**（`utils/report.ts`）——需改为 CLI 输出 NDJSON 事件、TS 桥接到 `withProgress`。

## 3. 决策记录

| # | 决策 | 选择 | 理由 |
|---|---|---|---|
| D1 | Rust 与插件集成方式 | 独立 CLI 边车进程 | 与现有 MopaqPack-rs.exe/ObjEditing.exe 模式一致；CLI 直接用于 CI；不受 Electron ABI 约束。否决 napi-rs（打包复杂、无法独立使用）与 WASM（无法 spawn 进程、收益为零） |
| D2 | 仓库布局 | 本仓库 monorepo（`crates/` Cargo workspace） | 迁移期 TS/Rust 原子提交，黄金对照测试方便 |
| D3 | MopaqPack-rs 整合 | 吸收为 crate 依赖 | 同属 warcraft-iii 组织；消除 packlist.json 临时文件 + 子进程中转 |
| D4 | runner 归属 | 首期留 TS | UI 强耦合（确认对话框、autoCloseClient 设置写回），逻辑量小，作为阶段 4 可选项 |

## 4. 目标架构

```
warcraft-vscode (monorepo)
├── crates/
│   ├── wc3-core/        # 库：编译管线、packlist 生成、objediting 编排
│   └── wc3-cli/         # 二进制 wc3.exe：clap 子命令 + NDJSON 事件输出
│       依赖 MopaqPack-rs（crate 形式，需将其改造为 lib+bin 双形态）
├── src/                 # TS 插件：仅 UI/命令/设置，spawn wc3.exe
├── docs/
└── package.json
```

### 4.1 CLI 接口（进程边界即 API）

```
wc3 compile    --project <dir> [--release] [--classic] [--map <path>]
               [--confusion disable|minify|weak|medium|strong] [--jassfile <p>]
wc3 pack       --project <dir> [--release] [--classic] [--map <path>] [--output <p>]
wc3 objediting --project <dir> [--classic] [--map <path>]
wc3 build      --project <dir> [...]   # objediting + compile + pack 一条龙
```

- 所有 vscode settings 派生的状态经 CLI 参数显式传入；`warcraft.json` 由 Rust 直接读取解析。
- 外部工具路径（ObjEditing.exe、res/def.zip 等资源）经 `--res-dir` 或环境变量传入，默认相对 exe 自身定位。

### 4.2 进程间协议

- stdout 每行一个 JSON 事件（NDJSON）：
  - `{"event":"progress","step":"compile","message":"Compiling script"}`
  - `{"event":"error","key":"error.noSrcFolder","args":[]}`
- 错误携带本地化 key（沿用现有 `package.nls.json` 键名空间），TS 侧用 vscode-nls 渲染，Rust 不做 i18n；同时附带英文 fallback message 供纯 CLI 使用。
- 退出码非 0 = 失败。
- TS 侧 `utils/report.ts` 改造为事件流消费者，驱动 `withProgress`。

### 4.3 技术选型映射

| 现 JS 依赖 | Rust 替代 | 备注 |
|---|---|---|
| luaparse + luamin | `full-moon`（解析/AST 访问）+ `darklua` 或自研 minify | 输出不要求字节级一致，要求语义一致（见 §5 测试策略） |
| wasmoon | `mlua` | compiletime 对齐 wasmoon 的 Lua 5.4；Prometheus 需 Lua 5.1（版本冲突处理见 §7 风险 3）；注入相同的 `io.readFile/writeFile` API |
| underscore 模板 | `include_str!` + 代码内渲染 | debug/release 两套 main/file 模板逐行移植 |
| yauzl-promise（def.zip） | `zip` crate | 随 objediting 迁移 |
| MopaqPack-rs.exe 子进程 | crate 依赖直调 | packlist 在内存传递 |
| fs-extra / 递归遍历 | `std::fs` + `walkdir` | 隐藏文件规则（`.` 前缀、`@` 前缀 lua）保留 |

### 4.4 留在 TS 的部分（瘦身后）

extension.ts / app.ts / command.ts（命令、状态栏、watcher）、project.ts（创建工程、toggle、choseMapFile）、library.ts（GitHub 库）、runner/、config.ts（settings → CLI 参数映射）、report.ts（NDJSON → withProgress 桥）。

移除依赖：wasmoon、luaparse、luamin、yauzl-promise，webpack 的 lua loader；pbjs-loader/protobuf 随 runner 保留。

## 5. 测试策略

- **黄金基准四象限**：用现有 TS 管线对样例工程产出 {debug, release} × {classic, reforge} 的完整中间产物并按字节存档（minify/混淆前的拼装产物、packlist、JASS 注入结果）。
- **对照层级**：
  1. minify 前中间产物：字节级一致（强约束）。
  2. minify/混淆后产物：语义级一致——用 Lua VM 加载快照对比，不要求字节一致。
  3. 纯函数单测：`toLua`/`makeLuaKey`/`getCommentEqual`/`toLuaString`/宏替换，逐函数移植并固定历史行为（含 JS `Object.entries` 遍历序等怪癖）。
- **端到端**：样例地图经 `wc3 build` 产出 .w3x，游戏实际加载验证（每阶段验收各一次）。
- 黄金样例必须覆盖：中文路径、Classic 地图文件（.w3x 单文件）、Reforge 地图目录、含 `compiletime` 的源文件、含 require 链的 release 工程。

## 6. 分阶段实施计划

### 阶段 0 — 基线与脚手架（小）

- 建 `crates/` Cargo workspace（wc3-core、wc3-cli 空壳）。
- CI 增加 Rust 构建/clippy/test job。
- 制作黄金基准四象限存档与样例工程。
- 验收：CI 绿；基准产物入库（或入 LFS/制品库）。

### 阶段 1 — 编译器核心（最大）

`wc3 compile` 与 TS 完全等价：宏处理 → compiletime 求值（mlua）→ debug 拼装 / release require 图解析 → 模板渲染 → minify → 混淆（mlua 跑 Prometheus）→ Classic JASS 注入。

- 验收：四象限黄金对照通过；纯函数单测全绿；样例地图游戏实跑一次。

### 阶段 2 — 打包与物编（中）

- `wc3 pack`：packlist 生成逻辑移植 + MopaqPack-rs 库化集成（先在 MopaqPack-rs 仓库做 lib+bin 改造）。
- `wc3 objediting`：物编源准备、def 版本检查与解压、ObjEditing.exe 编排。
- `wc3 build` 串联三步。
- 验收：产物 .w3x 与 TS 管线可互换，游戏可加载。

### 阶段 3 — 插件瘦身（中）

- TS 删除 compiler/packer/objediting 实现，改为 spawn `wc3.exe` + NDJSON 桥接。
- settings → CLI 参数映射层；`report.ts` 改造。
- VSIX 内置 `wc3.exe`（win32-x64）；prepare.js 移除 MopaqPack-rs 下载项（改为本仓库构建产物）。
- 移除 wasmoon/luaparse/luamin/yauzl 依赖与 webpack lua loader。
- `vscwarcraft` 标记弃用，文档与 CI 指向 `wc3`。
- 验收：插件全部命令行为不变；VSIX 体积下降；CI 改用 `wc3 build`。

### 阶段 4 — 可选后续（不在本期承诺内）

runner 迁 Rust（winreg + prost + 进程管理，TS 只留确认 UI）；ObjEditing 库化；移除 Node CLI。

## 7. 风险与对策

1. **minify/混淆输出不可字节级复现** → 测试分层（§5）：字节对照只施加于 minify 前产物，之后转语义对照。
2. **compiletime 语义偏差**（`toLua` 序列化的 key 顺序、字符串 `[[ ]]`/`[=[ ]=]` 包裹选择、数字 key 规则）→ 纯函数级单测先行，固定历史行为后再接管线。
3. **Lua 版本冲突**：Prometheus 要求 Lua 5.1，compiletime 对齐 wasmoon（5.4）；mlua 同一进程不能同时 vendored 两个版本 → 方案 A：混淆拆为独立辅助二进制（wc3-confuse.exe，lua51）；方案 B：feature 拆分两个 crate 静态链接不同符号前缀。阶段 1 早期 spike 验证后定夺。
4. **Windows 路径/编码**（GBK 路径、JASS 注入按 `\r\n` 行处理）→ 黄金样例强制覆盖中文路径与 Classic 用例；Rust 侧统一 `PathBuf`，输出时显式 `\r\n`。
5. **MopaqPack-rs 库化改造**属于跨仓库前置依赖 → 阶段 2 开始前先行；若受阻，pack 临时保留 exe 子进程调用（packlist 仍走 JSON 文件），不阻塞阶段 3。
