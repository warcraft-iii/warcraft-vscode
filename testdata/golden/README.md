# Golden baseline

由 `scripts/make-golden.ps1` 基于 TS 管线（out/cli.js compile）生成，是 Rust 重写的对照锚点。
**禁止手改。** 仅当 TS 管线行为被有意修订时重新生成并在 PR 中说明差异。
对照规则见 docs/superpowers/specs/2026-06-12-rust-core-split-design.md §5。
