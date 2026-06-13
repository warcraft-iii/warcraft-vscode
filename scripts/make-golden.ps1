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
# pack 黄金：仅 basic × reforge 两象限（classic 需真实 .w3x 基底，由 Rust 侧 packer 单测自洽覆盖）。
# TS cli 的 pack 子命令对空 -t 会把 mapdir 重置为工程根（无 guard），必须显式传 -t map。
if (-not (Test-Path (Join-Path $root 'bin/MopaqPack-rs.exe'))) {
    throw 'bin/MopaqPack-rs.exe missing - build: cargo build --release --manifest-path ../MopaqPack-rs/Cargo.toml; cp to bin/'
}
$packQuads = @(
    @{ name = 'debug-reforge';   args = @();     out = '_warcraft_vscode_test' },
    @{ name = 'release-reforge'; args = @('-r'); out = 'release' }
)
$proj = Join-Path $root 'testdata/fixtures/basic'
foreach ($q in $packQuads) {
    if (Test-Path "$proj/.build") { Remove-Item -Recurse -Force "$proj/.build" }
    node (Join-Path $root 'bin/cli.js') pack $proj -t map @($q.args)
    if ($LASTEXITCODE -ne 0) { throw "pack failed: $($q.name)" }
    $src = "$proj/.build/$($q.out)"
    if (-not (Test-Path $src)) { throw "missing archive: $($q.name)" }
    $dst = Join-Path $root "testdata/golden/basic/$($q.name)-pack"
    if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
    New-Item -ItemType Directory -Force $dst | Out-Null
    Copy-Item $src $dst -Force
    Remove-Item -Recurse -Force "$proj/.build"
}
Write-Host 'golden baseline updated.'
