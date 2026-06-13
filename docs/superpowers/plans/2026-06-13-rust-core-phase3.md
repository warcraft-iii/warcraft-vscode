# Plan: Phase 3 — Plugin thinning (TS → spawn wc3.exe)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 VS Code 插件从「in-process 执行编译/打包/物编」转为「spawn wc3.exe 子进程 + NDJSON 桥接」，删除 TS 侧 compiler/packer/objediting 实现与对应依赖（wasmoon/luaparse/luamin），准备 VSIX 发布形态。

**Architecture:** 新建 `src/app/bridge.ts`：封装 spawn wc3.exe、逐行解析 stdout NDJSON、分发 progress/error 事件给 vscode.window.withProgress。App 中 compile/pack/objediting/run 命令改为调用 bridge。旧 compiler/packer/objediting 目录整体删除。`src/cli.ts` 简化为直接 spawn wc3.exe（或标记弃用）。

**Tech Stack:** child_process spawn（TS）、wc3.exe（Rust, 已构建）、webpack（保留但移除 underscore-template-loader 和 wasmoon external）

**Spec:** `docs/superpowers/specs/2026-06-12-rust-core-split-design.md` §6 阶段 3

---

## 文件结构变更

```
src/
  app/
    bridge.ts           [新增] spawn wc3.exe 封装 + NDJSON→withProgress
    app.ts              [修改] compile/pack 命令改走 bridge
    compiler/           [删除] 整个目录
    packer/             [删除] 整个目录
    objediting/         [删除] 整个目录
  templates/            [删除] 整个目录（lua 模板已在 Rust assets 内）
  utils/
    prometheus.ts       [删除]
    confuser.ts         [删除]
    utils.ts            [修改] 移除 yauzl/extractFile 导出（仅 project.ts 内联）
  cli.ts                [修改] 简化为 spawn wc3.exe wrapper 或标记弃用
  env/
    config.ts           [修改] 移除 luaEngine 相关代码（如有）
bin/
  wc3.exe              [新增 到 .gitignore; 由 prepare.js 构建放置]
webpack.config.js       [修改] 移除 underscore-template-loader、wasmoon external
package.json            [修改] 移除 wasmoon/luaparse/luamin 依赖; 移除相关 @types
prepare.js              [修改] 加 cargo build wc3-cli 步骤; 移除 MopaqPack-rs 下载
.vscodeignore           [修改] 确保 bin/wc3.exe 不被排除
```

## 约定

- 先切分支：`git checkout -b rust-core-phase3`。
- 提交信息用 conventional commits，每条以 `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>` 结尾。
- yauzl 保留（project.ts 的模板下载解压仍需要）。
- `src/utils/utils.ts` 中 `extractFile` / `downloadZip` 保留给 project.ts 用；`extractFileFromMap` 删除（仅 compiler/objediting 调用,均将被删）。
- bin/wc3.exe 不入库(git-ignored)；开发时由 prepare.js 的 `cargo build -p wc3-cli --release` 步骤产出并复制到 bin/。

---

### Task 1: bridge.ts — spawn wc3.exe 封装 + NDJSON 桥接

**Files:**
- Create: `src/app/bridge.ts`

bridge.ts 是阶段 3 的核心新增件——封装子进程通信协议:

- [ ] **Step 1: 实现 bridge.ts**

```typescript
import * as path from 'path';
import * as cp from 'child_process';
import { env } from '../env';
import { runtime } from '../env/runtime';

export interface BuildOptions {
    release?: boolean;
    classic?: boolean;
    map?: string;
    confusion?: string;
    output?: string;
}

interface NdjsonProgress { event: 'progress'; step: string; message: string; }
interface NdjsonError { event: 'error'; key: string; message: string; args: string[]; }
type NdjsonEvent = NdjsonProgress | NdjsonError;

function wc3ExePath(): string {
    return env.asExetensionPath('bin/wc3.exe');
}

function resDir(): string {
    return env.asExetensionPath('bin');
}

/**
 * spawn wc3.exe 子命令，逐行解析 NDJSON stdout，驱动 vscode.window.withProgress。
 * 失败时 throw Error（message = NDJSON error.message 或 stderr）。
 */
export async function runWc3(
    subcommand: 'compile' | 'pack' | 'objediting' | 'build',
    opts: BuildOptions = {}
): Promise<void> {
    const exe = wc3ExePath();
    const args: string[] = [subcommand, env.rootPath!];
    if (opts.release) args.push('-r');
    if (opts.classic) args.push('-c');
    if (opts.map) args.push('-m', opts.map);
    if (opts.confusion && opts.confusion !== 'Disable') {
        args.push('--confusion', opts.confusion.toLowerCase());
    }
    if (opts.output) args.push('-o', opts.output);
    if (subcommand === 'compile' || subcommand === 'build' || subcommand === 'objediting') {
        args.push('--res-dir', resDir());
    }

    return new Promise<void>((resolve, reject) => {
        const child = cp.spawn(exe, args, { stdio: ['ignore', 'pipe', 'pipe'] });
        let stderrBuf = '';
        let lastError: NdjsonError | undefined;

        const reporter = runtime.createProgressReporter();

        child.stdout!.setEncoding('utf-8');
        let lineBuf = '';
        child.stdout!.on('data', (chunk: string) => {
            lineBuf += chunk;
            const lines = lineBuf.split('\n');
            lineBuf = lines.pop()!;
            for (const line of lines) {
                if (!line.trim()) continue;
                try {
                    const ev: NdjsonEvent = JSON.parse(line);
                    if (ev.event === 'progress') {
                        reporter.report(ev.message);
                    } else if (ev.event === 'error') {
                        lastError = ev;
                    }
                } catch { /* ignore non-json lines */ }
            }
        });
        child.stderr!.setEncoding('utf-8');
        child.stderr!.on('data', (chunk: string) => { stderrBuf += chunk; });
        child.on('close', (code) => {
            reporter.done();
            if (code === 0) {
                resolve();
            } else {
                const msg = lastError
                    ? lastError.message
                    : (stderrBuf.trim() || `wc3 ${subcommand} failed (exit ${code})`);
                reject(new Error(msg));
            }
        });
        child.on('error', (err) => {
            reporter.done();
            reject(new Error(`Failed to start wc3.exe: ${err.message}`));
        });
    });
}
```

- [ ] **Step 2: Commit**

```bash
git add src/app/bridge.ts
git commit -m "feat(ext): NDJSON bridge for spawning wc3.exe subprocess"
```

### Task 2: runtime.ts — progress reporter 抽象

**Files:**
- Modify: `src/env/runtime.ts`

- [ ] **Step 1: 追加 createProgressReporter 方法**

在 `Runtime` 类末尾追加（vscode 不可用时返回 no-op）:

```typescript
    createProgressReporter(): { report(message: string): void; done(): void } {
        if (!this.vscode) {
            return { report() {}, done() {} };
        }
        let resolver: (() => void) | undefined;
        let currentReporter: { report(value: { message?: string }): void } | undefined;
        this.vscode.window.withProgress(
            { location: this.vscode.ProgressLocation.Notification },
            (progress) => new Promise<void>((resolve) => {
                currentReporter = progress;
                resolver = resolve;
            })
        );
        return {
            report(message: string) { currentReporter?.report({ message }); },
            done() { resolver?.(); }
        };
    }
```

- [ ] **Step 2: 构建验证**

Run: `npm run compile`
Expected: 成功。

- [ ] **Step 3: Commit**

```bash
git add src/env/runtime.ts
git commit -m "feat(ext): progress reporter abstraction in runtime layer"
```

### Task 3: app.ts — 命令改走 bridge

**Files:**
- Modify: `src/app/app.ts`

- [ ] **Step 1: 重写命令注册**

移除 compiler/packer/objediting 的 import（`debugCompiler`, `releaseCompiler`, `debugPacker`, `releasePacker`, `objediting`）。替换为 bridge 调用。保留 project/library/runner imports。

- [ ] **Step 2: 构建验证**

Run: `npm run compile`
Expected: 成功。

- [ ] **Step 3: Commit**

```bash
git add src/app/app.ts
git commit -m "refactor(ext): commands delegate to wc3.exe via bridge"
```

### Task 4: 删除旧 TS 实现

**Files:**
- Delete: `src/app/compiler/`, `src/app/packer/`, `src/app/objediting/`, `src/templates/`
- Delete: `src/utils/prometheus.ts`, `src/utils/confuser.ts`
- Modify: `src/utils/utils.ts` — 移除 `extractFileFromMap`

- [ ] **Step 1: 删除文件与目录**

```bash
rm -rf src/app/compiler src/app/packer src/app/objediting src/templates
rm -f src/utils/prometheus.ts src/utils/confuser.ts
```

- [ ] **Step 2: 清理 utils.ts**

移除 `extractFileFromMap` 函数及相关 `MopaqPack-rs.exe` 引用。保留 `extractFile`(yauzl) + `downloadZip`。

- [ ] **Step 3: 构建验证**

Run: `npm run compile`
Expected: webpack 成功。

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "refactor(ext): remove in-process compiler/packer/objediting (replaced by wc3.exe)"
```

### Task 5: cli.ts — 简化为 wc3.exe shim

**Files:**
- Modify: `src/cli.ts`

- [ ] **Step 1: 重写为 spawn wrapper**

移除 env/config/compiler/packer/objediting imports，替换为 child_process spawn wc3.exe，维持 `vscwarcraft pack/compile` CLI 向后兼容。

- [ ] **Step 2: 构建 + 冒烟**

```bash
npm run compile
node bin/cli.js compile testdata/fixtures/basic
```
Expected: NDJSON 输出、退出 0。

- [ ] **Step 3: Commit**

```bash
git add src/cli.ts
git commit -m "refactor(cli): vscwarcraft delegates to wc3.exe (backward compat shim)"
```

### Task 6: 依赖清理 + webpack 简化

**Files:**
- Modify: `package.json`, `webpack.config.js`

- [ ] **Step 1: 移除依赖**

package.json dependencies: 删 `wasmoon`, `luaparse`, `luamin`。
devDependencies: 删 `@types/luaparse`, `underscore-template-loader`。

- [ ] **Step 2: webpack 简化**

移除 `.lua` 文件 loader rule；移除 wasmoon externals。

- [ ] **Step 3: npm install + 构建**

```bash
npm install && npm run compile
```

- [ ] **Step 4: Commit**

```bash
git add package.json package-lock.json webpack.config.js
git commit -m "chore(ext): remove wasmoon/luaparse/luamin deps and lua template loader"
```

### Task 7: prepare.js + .gitignore

**Files:**
- Modify: `prepare.js`, `.gitignore`

- [ ] **Step 1: prepare.js — 加 cargo build 步骤、移除 MopaqPack-rs 下载**

- [ ] **Step 2: .gitignore — 追加 `bin/wc3.exe`**

- [ ] **Step 3: Commit**

```bash
git add prepare.js .gitignore
git commit -m "chore: prepare.js builds wc3.exe, removes MopaqPack-rs download"
```

### Task 8: 端到端验证 + 收尾文档

- [ ] **Step 1: 全链路构建验证**

```bash
cargo build -p wc3-cli --release && cp target/release/wc3.exe bin/
npm run compile
cargo test --workspace
node bin/cli.js pack testdata/fixtures/basic -t map
```

- [ ] **Step 2: 验收清单**

- npm run compile 成功。
- node bin/cli.js pack/compile 正常。
- cargo test --workspace 全绿。
- `npm ls wasmoon luaparse luamin 2>&1` 确认未安装。
- 人工: VSCode F5 运行、Pack Map 命令正常（待用户验收）。

- [ ] **Step 3: Commit**

```bash
git add README.md docs
git commit -m "docs: phase 3 plugin thinning complete"
```

---

## 后续（不在本计划内）

- `vscwarcraft` npm bin 标记 deprecated。
- CI 改用 `wc3 build` 替代 `vscwarcraft pack`。
- runner 迁移（阶段 4，可选）。
- ObjEditing.exe 库化吸收（远期）。
