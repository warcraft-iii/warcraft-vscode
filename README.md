# warcraft-vscode

A Visual Studio Code extension that provides a complete Warcraft III map development toolset based on Lua. It supports both **Warcraft III: Reforged** and **Warcraft III: Classic**, and streamlines the day‑to‑day loop of writing script, packing the map, and launching the game or the World Editor.

[![Node.js](https://github.com/warcraft-iii/warcraft-vscode/actions/workflows/node.js.yml/badge.svg)](https://github.com/warcraft-iii/warcraft-vscode/actions/workflows/node.js.yml)
[![Discord](https://discordapp.com/api/guilds/594229838869692466/embed.png?style=shield)](https://discord.gg/26N8ycP)

## Features

- Create Reforged or Classic map projects from a template
- Compile all Lua sources into a single `war3map.lua`
- Pack the map directory into a `.w3x` archive
- Launch the map in Warcraft III or open it in the World Editor
- Toggle between **Debug** / **Release** configurations and between **Reforged** / **Classic** versions
- Add third‑party Git libraries to a project with one command
- Pack Object Editor data (via KKWE integration)
- Optional Lua code minification / obfuscation for Release builds
- Command line interface (`vscwarcraft`) for CI / headless builds

## Quick Start

1. Press `F1` (or `Ctrl+Shift+P`) in VS Code.
2. Run **Warcraft: Create Project** (Reforged) or **Warcraft: Create Classic Project**.
3. Open the generated folder — the extension activates automatically when a `warcraft.json` is present.
4. Use the **Warcraft: …** commands to compile, pack, and run your map.

## Commands

| Command | Description |
| --- | --- |
| `Warcraft: Create Project` | Create a new map project for Warcraft III: Reforged |
| `Warcraft: Create Classic Project` | Create a new map project for Warcraft III: Classic |
| `Warcraft: Clean Project` | Remove the `.build` folder |
| `Warcraft: Add Library` | Add a Git library to the current project |
| `Warcraft: Compile Script` | Compile all Lua sources into a single script |
| `Warcraft: Pack Map` | Compile the script and pack the map into a `.w3x` |
| `Warcraft: Run Map` | Compile, pack and launch the map in Warcraft III |
| `Warcraft: Open World Editor` | Open the map folder in the World Editor |
| `Warcraft: Pack Objects` | Pack Object Editor data through KKWE |
| `Warcraft: Chose a Map File` | Pick the map file used by the project |
| `Warcraft: Toggle Configuration` | Switch between Debug and Release |
| `Warcraft: Toggle Warcraft Version` | Switch between Reforged and Classic |

## Extension Settings

These settings are available under `warcraft.*`:

| Setting | Description |
| --- | --- |
| `warcraft.gamePath` | Path to the Warcraft III (Reforged) executable |
| `warcraft.wePath` | Path to the World Editor (Reforged) executable |
| `warcraft.gameArgs` | Extra arguments used when launching the game |
| `warcraft.weArgs` | Extra arguments used when launching the World Editor |
| `warcraft.gamePathClassic` | Path to the Warcraft III Classic executable |
| `warcraft.wePathClassic` | Path to the World Editor Classic executable |
| `warcraft.gameArgsClassic` | Extra arguments for the Classic game |
| `warcraft.weArgsClassic` | Extra arguments for the Classic World Editor |
| `warcraft.kkwePath` | Path to the KKWE executable (used by `Pack Objects`) |
| `warcraft.autoCloseClient` | Automatically close a running client before launching |
| `warcraft.configuration` | Active configuration: `Debug` or `Release` |
| `warcraft.warcraftVersion` | Target Warcraft version: `Reforge` or `Classic` |
| `warcraft.luaConfusion` | Release‑only Lua transform: `Minify`, `Weak`, `Medium`, `Strong` (experimental) |
| `warcraft.libraryOrganizations` | GitHub users / organizations searched by `Add Library` |

## Project Layout

A typical project looks like:

```
my-map/
├── warcraft.json          # project manifest
├── map.w3x/               # map folder opened by the World Editor
├── src/                   # Lua sources
│   ├── main.lua
│   └── lib/               # third-party libraries added via "Add Library"
├── imports/               # files always packed into the map
├── imports.debug/         # files packed only in Debug builds
└── imports.release/       # files packed only in Release builds
```

### warcraft.json

```json
{
    "mapdir": "map.w3x",
    "files": ["main.lua"],
    "jassfile": "",
    "lua.package.path": ["./lib/?.lua", "./lib/?/init.lua"]
}
```

| Field | Description |
| --- | --- |
| `mapdir` | The map folder (relative to the project root) |
| `files` | Extra entry Lua files that must always be included in Release builds |
| `jassfile` | *Classic only* — path to `war3map.j`, or a path inside the map folder |
| `lua.package.path` | Search patterns used when resolving `require` |

> **Debug** packs every Lua file under `src/`. **Release** performs static dependency analysis based on `require` / `dofile` / `loadfile`. If you pass non‑string‑literal arguments to those functions you must list the affected files in `warcraft.json` explicitly.

## Lua API

The extension re‑implements a few Lua functions that Blizzard removed from the in‑game runtime. They behave as in standard Lua:

- [`require`](https://www.lua.org/manual/5.3/manual.html#pdf-require)
- [`dofile`](https://www.lua.org/manual/5.3/manual.html#pdf-dofile)
- [`loadfile`](https://www.lua.org/manual/5.3/manual.html#pdf-loadfile)

Plus a small debug facility:

- `seterrorhandler(func)`
- `geterrorhandler()`

## Build‑Time Macros

Sections wrapped in the macros below are conditionally included or stripped when the script is compiled.

```lua
--@debug@
onlyInDebug()
--@end-debug@

--@non-debug@
onlyInRelease()
--@end-non-debug@

--@remove@
strippedFromEveryBuild()
--@end-remove@

--@classic@
onlyInClassic()
--@end-classic@

--@non-reforge@
onlyInClassic()
--@end-non-reforge@

--@reforge@
onlyInReforged()
--@end-reforge@

--@non-classic@
onlyInReforged()
--@end-non-classic@
```

## Packing

Files under `imports/` and `src/lib/*/imports/` are always packed into the map. `imports.debug/` is packed in Debug builds, `imports.release/` in Release builds.

## Command Line Interface

The project is also published as an npm package — [warcraft-vscode](https://www.npmjs.com/package/warcraft-vscode) — that exposes a `vscwarcraft` binary. It runs the exact same compile + pack pipeline as the VS Code commands, without needing VS Code to be open. This is useful for CI pipelines, automated release builds, or scripting the packer from other tools.

### Installation

```bash
# Global install
npm install -g warcraft-vscode

# Or as a dev dependency of your map project
npm install --save-dev warcraft-vscode
# then call via npx
npx vscwarcraft --help
```

### Usage

```
vscwarcraft pack [project path] [options]
```

| Option | Description | Default |
| --- | --- | --- |
| `-o, --output <output>` | Copy the packed map to this path after building | *(none — build only)* |
| `-t, --target <map>` | Override the map file / folder path (absolute, or relative to the project) | value of `mapdir` in `warcraft.json` |
| `-c, --classic` | Build for Warcraft III: Classic instead of Reforged | `false` |
| `-r, --release` | Build in Release mode (dependency analysis + macro stripping) | `false` (Debug) |
| `-l, --luaconfusion <level>` | Release‑only Lua transform: `Disable`, `Minify`, `Weak`, `Medium`, `Strong` | `Disable` |

`[project path]` defaults to the current working directory when omitted, and must contain a valid `warcraft.json`.

### Examples

```bash
# Debug build in-place (equivalent to the "Pack Map" command)
vscwarcraft pack .

# Release build for Reforged, copy the result out for publishing
vscwarcraft pack ./my-map -r -o ./dist/my-map.w3x

# Release build for Classic with minified Lua
vscwarcraft pack ./my-map -c -r -l Minify -o ./dist/my-map.w3x

# Override which map folder is packed
vscwarcraft pack ./my-map -t ./map.w3x -r -o ./dist/my-map.w3x
```

### CI Notes

- The CLI reads the same `warcraft.json` and `imports*/` folders as the extension.
- `Pack Objects` (KKWE) is **not** executed by the CLI; pre‑generate those artifacts in the map folder before invoking `vscwarcraft pack`.
- Exit code is non‑zero when compilation or packing fails, so it can be used directly in CI gates.

## Libraries

- [stdlib](https://github.com/warcraft-iii/lib-stdlib)
- [console](https://github.com/warcraft-iii/lib-console)

Additional GitHub users or organizations can be registered in `warcraft.libraryOrganizations` to appear in the **Add Library** picker.

## Known Issues

See the [issue tracker](https://github.com/warcraft-iii/warcraft-vscode/issues).

## Roadmap

- Support per‑user library sources from arbitrary GitHub accounts
- Report compile time
- macOS support

## License

See [LICENSE.md](LICENSE.md).

**Enjoy!**
