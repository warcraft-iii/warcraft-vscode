# Rust 核心拆分阶段 2 — pack / objediting / build 设计

- 日期：2026-06-12
- 状态：已确认（待实施）
- 父文档：`2026-06-12-rust-core-split-design.md`（§6 阶段 2）
- 范围：`wc3 pack`、`wc3 objediting`、`wc3 build` 三个子命令；MopaqPack-rs 库化集成（stormlib crate）；compile 管线的地图提取改库调用

## 1. 决策记录

| # | 决策 | 选择 | 理由 |
|---|---|---|---|
| P1 | stormlib 集成方式 | cargo git 依赖 `warcraft-iii/MopaqPack-rs`，rev 锁定 | MopaqPack-rs 内部已是 lib（crates/stormlib）+ bin（222 行）结构，无需仓库改造即可按 package 名引用；cargo 自动拉取含 StormLib 子模块（.gitmodules 为 https）；CI 可复现 |
| P2 | 库化落地范围 | 一步到位：新建 mpq.rs，compile 管线的地图提取一并改走库，删除 mopaq.rs 子进程封装 | 彻底移除 MopaqPack-rs.exe 运行时依赖；阶段 1 黄金测试兜底提取语义不变；避免两套 MPQ 机制并存 |
| P3 | 跨仓库修改权限 | 如 MopaqPack-rs 需修复（构建兼容/API 缺口），直接提交并推送 master，随后锁定新 rev | 用户为该仓库作者，已授权 |
| P4 | 测试口径 | 单测 + TS 对照归档（归档内容级比较：文件名集合 + 逐文件字节） | .w3x 非字节可复现格式；「产物可互换」验收的最近似自动化 |

## 2. CLI 接口

```
wc3 objediting <project> [--classic] [--map <p>] [--res-dir <d>]
wc3 pack       <project> [--release] [--classic] [--map <p>] [--output <p>]
wc3 build      <project> [--release] [--classic] [--map <p>] [--output <p>]
               [--confusion <level>] [--res-dir <d>]
```

- `objediting` 无 `--release`：TS 物编只区分 reforge/classic（imports 矩阵中的 debug/release 仅作用于 pack）。
- `pack` 是纯打包步：要求 `.build/war3map.lua` 已存在（缺失显式报 `error.notFound`，message 指明先运行 compile），不隐式编译。classic 下同样要求 `.build/war3map.j`。
- `build` = objediting → compile → pack 串联，等价 TS `vscwarcraft pack` 全流程。
- `--output`：打包完成后把产物复制到指定路径（自动创建父目录），等价 TS cli 的 `-o`。
- 产物路径：`.build/{_warcraft_vscode_test|release}<mapdir 扩展名>`（debug|release 对应；扩展名取 mapdir 路径的 extname，目录地图名不带扩展名时为空）。
- `--res-dir` 沿用阶段 1 约定（默认 wc3.exe 所在目录），在其下查找 `ObjEditing.exe`、`def.zip`、`.version.json`、`wc3-confuse.exe`。VSIX 内布局调整（现状 def.zip 在 res/、exe 在 bin/）属阶段 3。
- NDJSON 事件沿用阶段 1 格式：`progress` 带 step（objediting/compile/pack），`error` 带 nls key + 英文 fallback message。

## 3. wc3-core 模块划分

| 模块 | 职责 |
|---|---|
| `mpq.rs`（新） | stormlib 封装：`extract_file(map, name) -> Result<Option<Vec<u8>>>`（不存在返回 None）、`create_archive(out, files, with_filelist)`（全新归档，容量 = 文件数）、`add_files(map, files)`（打开现有归档、扩容 max_files、逐个 add_file、compact）。**替代并删除 `mopaq.rs`** |
| `packer.rs`（新） | `generate_packlist(ctx) -> Vec<(String, PathBuf)>`（内存传递，不落盘 json）+ `pack(ctx)`（分支见 §4） |
| `objediting.rs`（新） | def 版本检查与解压（`zip` crate）、7 类物编源文件准备、ObjEditing.exe 子进程编排 |
| `compiler.rs`（改） | `Tools{mopaq_exe}` 与相关参数移除；`origin_map_script`/`write_injected_jass` 的地图提取改走 mpq.rs |

新依赖（workspace）：`stormlib = { git = "https://github.com/warcraft-iii/MopaqPack-rs", rev = "<实施时锁定 master HEAD，当前 06ceb1d>" }`、`zip`。

## 4. 行为复刻要点（TS 为裁判）

### 4.1 packlist 生成（TS Packer.generatePackList）

按 TS push 顺序收集 `(归档内相对名, 源绝对路径)`：

1. map 目录文件（仅当地图是目录）：递归、非隐藏、**非 .lua**。
2. imports 矩阵：对 3 个 imports 名 `imports`、`imports.{debug|release}`、`imports.{reforge|classic}`（外层循环），每个名先遍历全部 `src/lib/<lib>/<imp>`（`<lib>` 为 src/lib 下一级条目，按文件名字典序，对齐 DV5 的 NTFS readdir 序），再加根 `<imp>`；目录不存在则跳过；条目过滤隐藏文件。
3. `.build/objediting` 全部文件。
4. `war3map.lua` ← `.build/war3map.lua`；classic 再加 `war3map.j` ← `.build/war3map.j`。

去重与顺序 = TS `reduceRight`：同名条目**后写入者优先**，最终列表为**反序**。归档内相对名用 `path.relative` 原生分隔符（Windows 为 `\`，MPQ 内名即如此）。

### 4.2 打包分支（TS Packer.packByPackList）

- `!classic && 地图是目录` → `create_archive`（debug 配置加 filelist，对应 TS `-f`）。
- 否则 → 复制地图文件到产物路径，再 `add_files` 追加 packlist。
- classic + 地图是目录 → 显式报 `error.invalidMapFile`（DV10）。

### 4.3 objediting（TS ObjEditing）

- **def 检查**（每次执行先做，DV9）：读 `<res-dir>/.version.json` 的 `def` 字段与 `<root>/.def/.version` 内容（trim）比较，不一致（或 .version 不存在）则解压 `<res-dir>/def.zip` 到 `<root>/.def`。res 资源缺失时跳过检查（容错，不阻塞物编）。
- **脚本发现**：`<root>/objediting.{reforge|classic}/main.lua` → `<root>/objediting/main.lua` → 都不存在则整步**静默跳过（成功）**。
- **classic 地图校验**：classic 且地图非文件 → `error.invalidMapFile`（TS checkMapFolder）。
- **源文件准备**：清空重建 `.build/objediting.source`；7 类 `war3map.{w3u,w3t,w3b,w3h,w3d,w3a,w3q}`：classic 从地图文件经 mpq.rs 提取（不存在则跳过），reforge 从地图目录复制（存在才复制）。
- **执行**：清空重建 `.build/objediting`；`ObjEditing.exe -m <source> -o <out> <lua>`；**非零退出或 stderr 非空均为失败**（TS execFile 语义）。exe 缺失报 `error.notFound`。

## 5. 与 TS 的允许偏差（延续阶段 1 DV 编号）

| # | 偏差 | 理由 |
|---|---|---|
| DV8 | packlist 不再写 `.build/packlist.json`（内存直传 stormlib） | json 仅是 TS↔exe 的 IPC 中转；D3 目标就是消除它 |
| DV9 | def 检查从「插件会话启动时（构造函数）」移到「`wc3 objediting` 执行时」，且无论有无物编脚本都先检查 | CLI 无会话概念；保证「构建过的工程 .def 必新」不变。TS 的多 workspaceFolder 跳过逻辑留在 TS 侧 |
| DV10 | classic + 目录地图显式报 `error.invalidMapFile`；TS 同场景行为未定义（fs.copy 目录后 MopaqPack pack 必失败） | 把隐性崩溃变成既有错误语义 |
| DV11 | `src/lib` 不存在时按空库列表处理；TS 对其无保护 `fs.readdir` 直接 ENOENT 崩溃 | 无库工程是合法形态；TS 行为是隐性缺陷 |

## 6. 测试策略

- **单测**（无外部依赖，CI 可跑）：
  - packlist：顺序、reduceRight 去重反序、imports 矩阵展开、隐藏文件/非 lua 过滤、classic 加 war3map.j。
  - objediting：def 版本比较与解压、源文件准备（reforge 复制路径）、脚本发现优先级、无脚本跳过。
  - mpq.rs：create → extract round-trip、add_files 追加与覆盖（stormlib 静态链接，CI 真跑——库化的直接红利）。
- **TS 对照归档**：`make-golden.ps1` 增加 pack 步——basic fixture 补 `src/lib/<lib>/imports*/`、根 `imports*/` 样例文件（覆盖矩阵与同名覆盖优先级）；TS 管线（`bin/cli.js pack`）产出 `.w3x` 入库 `testdata/golden/<fixture>/<quad>-pack/`；Rust 测试双侧用 stormlib 解包，比较文件名集合 + 逐文件字节。覆盖 reforge × {debug,release}。fixture 不放 objediting 脚本（该步双侧均跳过，ObjEditing.exe 不进 CI）。
- **classic copy+pack 路径**：测试内用 stormlib 自造最小基底 .w3x（临时文件），跑 Rust pack 后解包自洽验证（TS 侧该路径需真实地图，不进 golden）。
- **ObjEditing.exe 编排**：不做自动化集成测试（需有效 .def 与物编脚本，外部依赖过深）；编排逻辑（脚本发现、源准备、失败语义）单测覆盖，真实 exe 由阶段验收的真实工程人工抽验覆盖。
- **人工验收**（阶段验收）：真实工程 `wc3 build` 与 TS 管线产物互换、游戏加载各一次。

## 7. 风险与对策

1. **cmake 4.x 兼容**：本机 cmake 4.2.3 对 `cmake_minimum_required < 3.5` 的工程硬报错，StormLib 子模块（v9.20+）是否触雷需验证 → 实施首个任务即 git 依赖 spike（加依赖 → 构建 → round-trip 冒烟）；若需修，在 MopaqPack-rs 的 stormlib-sys build.rs 加 `CMAKE_POLICY_VERSION_MINIMUM` define 或 bump 子模块，直推 master（P3）后锁新 rev。
2. **stormlib API 缺口**：已对照 lib.rs——create/open/write_file/add_file/remove_file/compact/has_file/read_all 齐备，预计零改动；万一有缺口按 P3 处理。
3. **CI 构建时长**：静态链 StormLib（cmake + MSVC）增加首次构建时间，Swatinem/rust-cache 缓存兜底。
4. **MPQ 内路径分隔符**：TS `path.relative` 在 Windows 产生 `\` 分隔名，MPQ 约定亦为 `\`；Rust 侧归档内名需统一用 `\`（与 fsutil 的 posix 名区分），TS 对照归档测试兜底。
