# warcraft-vscode

A complete Warcraft III map development toolset for VS Code — Lua script compilation, map packing, object editing, and one-click testing. Supports both Reforged and Classic.

**[中文文档](README.zh-CN.md)**

## Quick Start

1. Install the extension, then run `Warcraft: Create Project` from the command palette
2. Write Lua scripts in the `src/` directory
3. `Ctrl+Shift+P` → `Warcraft: Run Map` to compile, pack, and launch

Project structure:

```
my-map/
├── warcraft.json          # Project manifest
├── src/
│   ├── main.lua           # Entry point
│   └── lib/               # Third-party libraries (git submodules)
├── imports/               # Map resources (textures, models — packed into .w3x)
├── objediting/            # Object editing scripts (optional)
│   └── main.lua
└── map/                   # Map folder or .w3x file
    └── war3map.lua        # Original map script (Reforged)
```

## Features

### Compile Script

Merges all Lua sources under `src/` into a single `war3map.lua` injected into the map at runtime.

**Debug mode:**
- Bundles every `.lua` file in `src/` (excluding `.`/`@`-prefixed hidden files)
- Each file registered as a string in a preload table
- Built-in `require` loads modules on demand at runtime
- Source formatting preserved for easier debugging

**Release mode:**
- Static dependency analysis starting from `main.lua` (`require`/`dofile`/`loadfile`)
- Only referenced files are bundled
- Each file wrapped as a function, executed on demand
- Automatic minification (whitespace/comment stripping, no variable renaming)
- Optional Lua obfuscation

**Compile-time evaluation:**

```lua
local config = compiletime(function()
    return { version = "1.0", buildDate = os.date() }
end)
```

Functions inside `compiletime()` execute during compilation. Return values are serialized as Lua literals and substituted directly into the source. `io.readFile`/`io.writeFile` are available for build-time file I/O.

### Build Macros (Conditional Compilation)

Comment-based markers for conditional code blocks — the compiler enables or comments out sections based on the active configuration:

```lua
--@debug@
print("Debug HP = " .. unit.hp)
--@end-debug@

--@release@
-- Release-only code
--@end-release@

--@classic@
-- Classic edition only
--@end-classic@

--@reforge@
-- Reforged edition only
--@end-reforge@

--@remove@
-- Always stripped (scratch notes)
--@end-remove@
```

Full macro list: `debug`/`non-debug`, `release`/`non-release`, `classic`/`non-classic`, `reforge`/`non-reforge`, `remove`.

### Pack Map

Combines compiled scripts, map data, and import directories into the final `.w3x` archive.

**Import directories:**

| Directory | When packed |
|---|---|
| `imports/` | Always |
| `imports.debug/` | Debug builds only |
| `imports.release/` | Release builds only |
| `imports.reforge/` | Reforged target only |
| `imports.classic/` | Classic target only |
| `src/lib/<name>/imports*/` | Library imports, same rules as above |

Same-name override priority: `imports/` overrides `map/`; project root overrides library directories.

**Packing strategy:**
- Reforged + directory map: creates a new MPQ archive (Debug includes listfile, Release does not)
- Classic + .w3x file: copies the original map, then appends/overwrites files

### Object Editing

Define custom units, abilities, items, etc. via Lua scripts — replacing manual World Editor work:

```lua
-- objediting/main.lua
local hero = UnitObjEditing:new('H000', 'Hpal') -- Based on Paladin
hero:setName('Custom Hero')
hero:setHP(1000)
hero:setAttack1Dmg(50)
```

How it works:
- Extracts existing `war3map.w3u` (and 6 other object types) from the map
- Executes user Lua scripts to modify/add definitions
- Writes back the modified binary object files
- Packed into the final map archive

Version-specific scripts: `objediting.reforge/main.lua` or `objediting.classic/main.lua` take priority over the generic `objediting/main.lua`.

### Lua Obfuscation

Optional code protection for Release builds, powered by [Prometheus](https://github.com/prometheus-lua/Prometheus):

| Level | Techniques | Perf Impact | Size |
|---|---|---|---|
| Disable | None | None | 1x |
| Minify | Variable renaming only | Negligible | ~0.8x |
| Weak | VM + constant array + function wrapping | Low | ~3.6x |
| Medium | String encryption + anti-tamper + VM + constant array + number expressions | Moderate | ~11x |
| Strong | Double VM + all protections | High | ~45x |

Configure via `warcraft.luaConfusion` setting. Only applies to Release builds.

### Run Map

One-click compile + pack + launch Warcraft III:

- Auto-detects game installation (prompts on first use)
- Reforged: copies map to `Documents/Warcraft III/Maps/Test/`, launches with `-loadfile`
- Classic: launches via KKWE
- `autoCloseClient`: automatically kills the previous game instance before launching
- Custom launch arguments supported (`warcraft.gameArgs`)

### Open World Editor

Quickly opens World Editor with the current map loaded:
- Reforged: `World Editor.exe -loadfile <map>`
- Classic: launches via KKWE

### Library Management

Browse and add Lua libraries from GitHub:

1. Queries configured GitHub organizations/users for repos prefixed `lib-`
2. Presents a selection list (marks deprecated repos)
3. Adds the chosen library as a Git submodule at `src/lib/<name>`

Default organization `warcraft-iii` provides:
- [lib-stdlib](https://github.com/warcraft-iii/lib-stdlib) — Standard library extensions
- [lib-console](https://github.com/warcraft-iii/lib-console) — Debug console

Add custom sources via `warcraft.libraryOrganizations`.

## warcraft.json

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

| Field | Description |
|---|---|
| `mapdir` | Path to map folder or `.w3x`/`.w3m` file (required) |
| `files` | Extra files to always bundle in Release (for dynamic requires) |
| `jassfile` | Classic: path to `war3map.j` (injects Lua execution trigger) |
| `lua.package.path` | Require search patterns (`?` replaced with module name) |

## Extension Settings

All under the `warcraft.*` namespace in VS Code Settings:

| Setting | Description |
|---|---|
| `gamePath` / `gamePathClassic` | Game executable path |
| `wePath` / `wePathClassic` | World Editor path |
| `gameArgs` / `gameArgsClassic` | Extra game launch arguments |
| `weArgs` / `weArgsClassic` | Extra editor launch arguments |
| `kkwePath` | KKWE path (Classic object editing and launching) |
| `autoCloseClient` | Kill running game before launching |
| `configuration` | Build config: Debug or Release |
| `warcraftVersion` | Target: Reforge or Classic |
| `luaConfusion` | Obfuscation level (Disable/Minify/Weak/Medium/Strong) |
| `libraryOrganizations` | GitHub sources for library browsing |

## Command Line Interface

### wc3 (Rust CLI, bundled with the extension)

```bash
# Full build: objediting + compile + pack
wc3 build <project> [-r] [-c] [-o output.w3x] [--confusion weak]

# Compile only
wc3 compile <project> [-r] [-c]

# Pack only (requires prior compile)
wc3 pack <project> [-r] [-c] [-o output.w3x]

# Object editing only
wc3 objediting <project> [-c]
```

| Flag | Description |
|---|---|
| `-r, --release` | Release mode |
| `-c, --classic` | Classic edition |
| `-m, --map <path>` | Override mapdir |
| `-o, --output <path>` | Copy output to path |
| `--confusion <level>` | Obfuscation level |
| `--res-dir <path>` | Resource directory (def.zip, defaults next to wc3.exe) |

### vscwarcraft (Node CLI, backward-compatible)

```bash
npx vscwarcraft pack <project> [-r] [-c] [-t map] [-o output.w3x]
npx vscwarcraft compile <project> [-r] [-c] [-t map]
```

## Build Error Diagnostics

When compilation fails, the extension:
1. Places a red squiggly on the offending line in the source file
2. Opens and scrolls to the error location
3. Shows a toast notification with the error summary

Supported error types: compiletime runtime errors, Lua syntax errors, missing require modules, object editing script errors.

## Architecture

```
VS Code Extension (TypeScript, ~2000 lines)
  ├── Command registration / status bar / settings / progress display
  ├── bridge.ts — spawns wc3.exe, streams NDJSON events
  └── diagnostics.ts — maps build errors to VS Code squigglies

wc3.exe (Rust, ~5000 lines)
  ├── compiler — macros / compiletime / require graph / minify / JASS injection
  ├── packer — packlist generation / MPQ archiving (stormlib, statically linked)
  ├── objediting — def management / Lua VM for object scripts (mlua embedded)
  └── confuse — Prometheus obfuscator (mlua/Lua5.1, separate binary)
```

Build artifacts go to `.build/` — contains `war3map.lua` (compiled script) and the final map archive.

## Development

```bash
# Rust toolchain
cargo build --workspace                    # Build wc3-core + wc3-cli
cargo test --workspace                     # All tests (including golden comparisons)
cargo build -p wc3-cli --release           # Production build
cp target/release/wc3.exe bin/

# TypeScript extension
npm install && npm run compile             # Build the extension
node bin/cli.js build testdata/fixtures/basic  # Smoke test

# Obfuscator (separate Lua 5.1 environment)
cargo build --manifest-path crates/wc3-confuse/Cargo.toml --release

# Regenerate golden baselines (requires npm run compile first)
pwsh scripts/make-golden.ps1
```

Building wc3.exe requires cmake + MSVC (for the StormLib C library static compilation).

## Known Issues

See the [issue tracker](https://github.com/warcraft-iii/warcraft-vscode/issues).

## License

See [LICENSE.md](LICENSE.md).
