# warcraft-vscode

Warcraft III 地图开发工具集，以 VS Code 插件形式提供完整的 Lua 脚本编译、地图打包、物编管理和一键测试工作流。支持 Reforged 和 Classic 两个版本。

## 快速开始

1. 安装插件后，命令面板运行 `Warcraft: Create Project`（或 `Create Classic Project`）
2. 在生成的工程中编写 Lua 脚本（`src/` 目录）
3. `Ctrl+Shift+P` → `Warcraft: Run Map` 即可编译打包并启动游戏测试

工程结构：

```
my-map/
├── warcraft.json          # 工程配置
├── src/
│   ├── main.lua           # 入口文件
│   └── lib/               # 第三方库（git submodule）
├── imports/               # 地图资源（贴图、模型等，打包进 .w3x）
├── objediting/            # 物编脚本（可选）
│   └── main.lua
└── map/                   # 地图目录或 .w3x 文件
    └── war3map.lua        # 原始地图脚本（Reforged 用）
```

## 核心功能

### 编译（Compile Script）

将 `src/` 下所有 Lua 源文件合并为一个 `war3map.lua`，注入到地图中运行。

**Debug 模式：**
- 收集 `src/` 下全部 `.lua` 文件（排除 `.` 和 `@` 前缀的隐藏文件）
- 每个文件以字符串形式注册到 preload 表
- 运行时通过内置 `require` 按需加载
- 保留源码格式，方便调试

**Release 模式：**
- 从 `main.lua` 开始静态分析 `require`/`dofile`/`loadfile` 依赖链
- 仅打包实际被引用的文件
- 每个文件包裹为函数，按需执行
- 自动 minify（变量不重命名，仅去空白注释）
- 可选 Lua 混淆保护

**编译时求值（compiletime）：**

```lua
local config = compiletime(function()
    return { version = "1.0", buildDate = os.date() }
end)
```

`compiletime(fn)` 中的函数在编译期执行，返回值被序列化为 Lua 字面量直接替换到源码中。支持 `io.readFile`/`io.writeFile` 在编译期读写文件。

### 条件编译（Build Macros）

用注释标记条件代码块，编译器根据配置自动启用/注释化：

```lua
--@debug@
print("调试信息：当前 HP = " .. unit.hp)
--@end-debug@

--@release@
-- 仅 release 构建包含的代码
--@end-release@

--@classic@
-- 仅 Classic 版本包含
--@end-classic@

--@reforge@
-- 仅 Reforged 版本包含
--@end-reforge@

--@remove@
-- 永远被移除的代码（临时注释用）
--@end-remove@
```

完整宏列表：`debug`/`non-debug`、`release`/`non-release`、`classic`/`non-classic`、`reforge`/`non-reforge`、`remove`。

### 打包（Pack Map）

将编译产物、地图资源、imports 目录合并为最终的 `.w3x` 地图文件。

**资源目录（imports）：**

| 目录 | 打包时机 |
|---|---|
| `imports/` | 始终打包 |
| `imports.debug/` | 仅 Debug 构建 |
| `imports.release/` | 仅 Release 构建 |
| `imports.reforge/` | 仅 Reforged 目标 |
| `imports.classic/` | 仅 Classic 目标 |
| `src/lib/<name>/imports*/` | 库自带资源，规则同上 |

同名文件的覆盖优先级：imports/ 覆盖 map/ 中的同名文件；根目录覆盖库目录。

**打包策略：**
- Reforged + 目录地图：创建全新 MPQ 归档（Debug 含 listfile，Release 不含）
- Classic + .w3x 文件：复制原始地图后追加/覆盖文件

### 物编（Object Editing）

通过 Lua 脚本定义自定义单位、技能、物品等，替代 World Editor 的物体编辑器手动操作。

```lua
-- objediting/main.lua
local hero = UnitObjEditing:new('H000', 'Hpal') -- 基于圣骑士创建
hero:setName('自定义英雄')
hero:setHP(1000)
hero:setAttack1Dmg(50)
```

原理：
- 从地图中提取现有 `war3map.w3u` 等 7 类物编文件
- 执行用户 Lua 脚本修改/添加定义
- 写回修改后的二进制物编文件
- 打包时并入地图

物编脚本可按版本分目录：`objediting.reforge/main.lua` 或 `objediting.classic/main.lua` 优先于通用 `objediting/main.lua`。

### Lua 混淆（Confusion）

Release 构建可选的代码保护，基于 [Prometheus](https://github.com/prometheus-lua/Prometheus) 混淆器：

| 级别 | 效果 | 性能影响 | 体积 |
|---|---|---|---|
| Disable | 不混淆 | 无 | 1x |
| Minify | 仅重命名变量 | 极低 | ~0.8x |
| Weak | 虚拟机化 + 常量数组 + 函数包裹 | 低 | ~3.6x |
| Medium | 字符串加密 + 防篡改 + 虚拟机化 + 常量数组 + 数字表达式化 | 中 | ~11x |
| Strong | 双重虚拟机化 + 全部保护 | 高 | ~45x |

在设置中配置 `warcraft.luaConfusion`，仅 Release 构建生效。

### 游戏启动（Run Map）

一键编译打包后启动 Warcraft III 加载地图：

- 自动检测游戏安装路径（首次使用会提示选择）
- Reforged：将地图复制到 `文档/Warcraft III/Maps/Test/`，通过 `-loadfile` 启动
- Classic：通过 KKWE 启动器加载
- 支持 `autoCloseClient`：自动关闭上一个游戏实例再启动新的
- 自定义启动参数（`warcraft.gameArgs`）

### 世界编辑器（Open World Editor）

快速打开 World Editor 并加载当前地图目录：
- Reforged：`World Editor.exe -loadfile <map>`
- Classic：通过 KKWE 打开

### 库管理（Add Library）

从 GitHub 浏览并添加 Lua 库到工程：

1. 查询配置的 GitHub 组织/用户下 `lib-` 前缀的仓库
2. 显示列表供选择（标记已废弃的仓库）
3. 作为 Git submodule 添加到 `src/lib/<name>`

默认组织 `warcraft-iii`，提供：
- [lib-stdlib](https://github.com/warcraft-iii/lib-stdlib) — 标准库扩展
- [lib-console](https://github.com/warcraft-iii/lib-console) — 调试控制台

通过 `warcraft.libraryOrganizations` 可添加自定义来源。

## warcraft.json 配置

```json
{
  "mapdir": "map",
  "files": ["extra.lua"],
  "jassfile": "war3map.j",
  "lua": {
    "package": {
      "path": ["./?.lua", "./?/init.lua"]
    }
  }
}
```

| 字段 | 说明 |
|---|---|
| `mapdir` | 地图目录路径或 `.w3x`/`.w3m` 文件路径（必填） |
| `files` | Release 模式额外打包的文件列表（静态分析无法覆盖动态 require 时使用） |
| `jassfile` | Classic 模式的 JASS 脚本路径（注入 `call Cheat("exec-lua:war3map")` 触发 Lua 执行） |
| `lua.package.path` | require 搜索路径模板（`?` 替换为模块名，默认 `["./?.lua", "./?/init.lua"]`） |

## 插件设置

通过 VS Code Settings 配置（`warcraft.*` 命名空间）：

| 设置 | 说明 |
|---|---|
| `gamePath` / `gamePathClassic` | 游戏可执行文件路径 |
| `wePath` / `wePathClassic` | 世界编辑器路径 |
| `gameArgs` / `gameArgsClassic` | 游戏启动附加参数 |
| `weArgs` / `weArgsClassic` | 编辑器启动附加参数 |
| `kkwePath` | KKWE 路径（Classic 物编和启动用） |
| `autoCloseClient` | 启动前自动关闭已运行的游戏 |
| `configuration` | 当前构建配置（Debug/Release） |
| `warcraftVersion` | 目标版本（Reforge/Classic） |
| `luaConfusion` | 混淆级别（Disable/Minify/Weak/Medium/Strong） |
| `libraryOrganizations` | GitHub 库源配置 |

## 命令行工具

### wc3（Rust CLI，内置于插件）

```bash
# 完整构建：物编 + 编译 + 打包
wc3 build <project> [-r] [-c] [-o output.w3x] [--confusion weak]

# 仅编译脚本
wc3 compile <project> [-r] [-c]

# 仅打包（需先编译）
wc3 pack <project> [-r] [-c] [-o output.w3x]

# 仅物编
wc3 objediting <project> [-c]
```

| 参数 | 说明 |
|---|---|
| `-r, --release` | Release 模式 |
| `-c, --classic` | Classic 版本 |
| `-m, --map <path>` | 覆盖 warcraft.json 的 mapdir |
| `-o, --output <path>` | 复制产物到指定路径 |
| `--confusion <level>` | 混淆级别 |
| `--res-dir <path>` | 资源目录（def.zip 等，默认 wc3.exe 同级） |

### vscwarcraft（Node CLI，向后兼容）

```bash
npx vscwarcraft pack <project> [-r] [-c] [-t map] [-o output.w3x]
npx vscwarcraft compile <project> [-r] [-c] [-t map]
```

## 构建错误定位

编译失败时，插件会：
1. 在出错的源文件对应行显示红色波浪线（VS Code Diagnostics）
2. 自动打开并跳转到出错位置
3. 弹出 toast 通知显示错误摘要

支持的错误类型：compiletime 运行时错误、Lua 语法错误、require 模块未找到、物编脚本错误。

## 技术架构

```
VS Code Extension (TypeScript, ~2000 行)
  ├── 命令注册 / 状态栏 / 设置读取 / 进度展示
  ├── bridge.ts — spawn wc3.exe + NDJSON 事件流桥接
  └── diagnostics.ts — 构建错误 → VS Code 红线

wc3.exe (Rust, ~5000 行)
  ├── compiler — 宏处理 / compiletime / require 图 / minify / JASS 注入
  ├── packer — packlist 生成 / MPQ 归档 (stormlib 静态链接)
  ├── objediting — def 管理 / 物编 Lua VM (mlua 嵌入)
  └── confuse — Prometheus 混淆器 (mlua/Lua5.1, 独立二进制)
```

构建产物位于 `.build/` 目录，包含 `war3map.lua`（编译脚本）和最终地图归档。

## 开发

```bash
# Rust 工具链
cargo build --workspace                    # 构建 wc3-core + wc3-cli
cargo test --workspace                     # 运行全部测试（含黄金基准对照）
cargo build -p wc3-cli --release           # 生产构建
cp target/release/wc3.exe bin/

# TypeScript 插件
npm install && npm run compile             # 构建插件
node bin/cli.js build testdata/fixtures/basic  # 冒烟测试

# 混淆器（独立 Lua 5.1 环境）
cargo build --manifest-path crates/wc3-confuse/Cargo.toml --release

# 黄金基准再生成（需 npm run compile 先行）
pwsh scripts/make-golden.ps1
```

构建 wc3.exe 需要 cmake + MSVC（stormlib 的 StormLib C 库静态编译）。

## License

See [LICENSE.md](LICENSE.md).
