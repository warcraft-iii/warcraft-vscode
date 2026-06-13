# Plan: Dead Code Cleanup + Structured Error Reporting

## Part A: Dead Code Cleanup (src/utils/utils.ts)

Remove unused functions from `src/utils/utils.ts`:
- `_getAllFiles` (private helper)
- `getAllFiles` (was used by compiler/packer, now deleted)
- `isHiddenFile` (same)
- `isLuaFile` (same)
- `readFile` (no callers)

Keep: `extractFile`, `downloadZip`, `posixCase` (if still used), `pickBy`-related, `confirm`.

## Part B: Structured Error Reporting

### Current flow (loses structure):
```
Rust Error{key, message, args}
  → NDJSON: {"event":"error","key","message","args"}
  → bridge.ts: reject(new Error(message))  ← all structure lost here
  → command.ts: showWarningMessage(error.message) ← flat string toast
```

### Target flow (preserves structure, enables diagnostics):
```
Rust Error{key, message, args, file?, line?}
  → NDJSON: {"event":"error","key","message","args","file?","line?"}
  → bridge.ts: reject(WarcraftError{key, message, args, file?, line?})
  → command.ts: if file → diagnostics (red underline in editor) + output channel
                 else → showWarningMessage
```

### Changes:

1. **crates/wc3-core/src/error.rs** — add optional `file` and `line`:
```rust
pub struct Error {
    pub key: &'static str,
    pub message: String,
    pub args: Vec<String>,
    pub file: Option<String>,  // source file path (relative to project root)
    pub line: Option<u32>,     // 1-based line number
}
```

2. **All error construction sites** — add `.file()` / `.at(file, line)` builder methods. Key sites to enrich:
   - `comptime.rs`: Lua runtime errors include file + line from the Lua traceback
   - `compiler.rs:process_file`: parse errors → file + line 
   - `minify.rs`: parse errors → file + line
   - `require_graph.rs`: missing module → which file referenced it
   - `objediting.rs`: Lua VM errors → file + line from traceback

3. **crates/wc3-cli/src/main.rs** — NDJSON output adds `file`/`line` when present:
```json
{"event":"error","key":"error.processFilesFailure","message":"...","args":[...],"file":"src/main.lua","line":5}
```

4. **src/app/bridge.ts** — parse structured error, create custom error class:
```typescript
export class WarcraftError extends Error {
    key: string;
    args: string[];
    file?: string;
    line?: number;
}
```

5. **src/app/command.ts** — enhanced error display:
   - If `error.file` exists: push diagnostic to a `DiagnosticCollection`, open the file, show Output Channel with full message
   - Otherwise: `showWarningMessage` as before

6. **New: src/app/diagnostics.ts** — manages a `vscode.DiagnosticCollection` for build errors, clears on next successful build.
