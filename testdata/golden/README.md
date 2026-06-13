# Golden baseline

由 `scripts/make-golden.ps1` 基于 TS 管线（node bin/cli.js compile，加载 out/cli.js）生成，是 Rust 重写的对照锚点。
**禁止手改。** 仅当 TS 管线行为被有意修订时重新生成并在 PR 中说明差异。
对照规则见 docs/superpowers/specs/2026-06-12-rust-core-split-design.md §5。

## 再生成须知

- 仅在 Windows/NTFS 上再生成（debug 文件序来自 fs.readdir；其他文件系统会乱序）。
- 先 `npm run compile`（bin/lua 的 29 个既有 TS 错误可忽略，确认 out/cli.js 已更新）。
- **只有 basic 的 debug 象限字节稳定**；comptime/release 象限因 wasmoon 表迭代序与 Promise.all 完成序，重生成出现字节 diff 属预期，以语义对照为准。
- luamin/wasmoon 是 GitHub 分支引用依赖（package.json），且 package-lock.json 未入库——再生成前用 `npm ls luamin wasmoon` 核对版本漂移。
- fixture 文件命名约束：小写 ASCII（中文目录除外，刻意覆盖），避免大小写或前缀冲突（NTFS 大小写不敏感排序 vs Rust 字节排序）。

`<quad>-pack/` 为 TS 管线（node bin/cli.js pack）产出的 .w3x 归档（需 bin/MopaqPack-rs.exe，本地构建见 plan 阶段 2 Task 8）；对照为内容级（文件名集合 + 逐文件字节），见 specs/2026-06-12-rust-core-phase2-pack-objediting-design.md §6。
