$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
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
        New-Item -ItemType Directory -Force $dst | Out-Null
        Copy-Item "$proj/.build/war3map.lua" $dst -Force
        if (Test-Path "$proj/.build/war3map.j") { Copy-Item "$proj/.build/war3map.j" $dst -Force }
    }
    Remove-Item -Recurse -Force "$proj/.build"
}
Write-Host 'golden baseline updated.'
