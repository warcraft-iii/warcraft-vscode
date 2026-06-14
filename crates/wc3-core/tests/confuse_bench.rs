//! Lua 混淆(Prometheus)正确率与性能自测。
//! 对 basic fixture 的 release 产物跑 Minify/Weak/Medium preset,验证 RESULT 语义不变。
//! 运行: cargo test -p wc3-core --test confuse_bench -- --nocapture

use std::path::PathBuf;
use std::time::Instant;

use wc3_core::compiler::{compile_release, Tools};
use wc3_core::config::{BuildContext, BuildOptions, ProjectConfig};

fn repo_root() -> PathBuf {
    // 不用 canonicalize() — 避免 Windows \\?\ extended-path prefix 干扰 Lua require
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("../..")
        .components()
        .collect()
}

fn copy_dir(src: &std::path::Path, dst: &std::path::Path) {
    std::fs::create_dir_all(dst).unwrap();
    for e in std::fs::read_dir(src).unwrap() {
        let e = e.unwrap();
        let to = dst.join(e.file_name());
        if e.file_type().unwrap().is_dir() {
            copy_dir(&e.path(), &to);
        } else {
            std::fs::copy(e.path(), &to).unwrap();
        }
    }
}

/// 在 Lua 5.4 沙箱中执行 war3map.lua,调用 main(),返回 RESULT 的规范化字符串
fn exec_result(code: &str) -> String {
    let lua = mlua::Lua::new();
    if let Err(e) = lua.load(code).exec() {
        return format!("EXEC_ERROR: {e}");
    }
    if let Ok(f) = lua.globals().get::<mlua::Function>("main") {
        if let Err(e) = f.call::<()>(()) {
            return format!("MAIN_ERROR: {e}");
        }
    }
    match lua.globals().get::<mlua::Value>("RESULT") {
        Ok(v) => wc3_core::luastr::to_lua(&v).unwrap_or_else(|e| format!("ERR:{e}")),
        Err(_) => "nil".into(),
    }
}

/// 构建 basic fixture → release war3map.lua
fn build_release_input() -> (PathBuf, String) {
    let src = repo_root().join("testdata/fixtures/basic");
    let dst = std::env::temp_dir().join(format!("wc3-confbench-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dst);
    copy_dir(&src, &dst);
    let cfg = ProjectConfig::load(&dst).unwrap();
    let ctx = BuildContext::new(
        &dst,
        cfg,
        BuildOptions {
            release: true,
            ..Default::default()
        },
    );
    compile_release(&ctx, &Tools { confuse_exe: None }).unwrap();
    let code = std::fs::read_to_string(dst.join(".build/war3map.lua")).unwrap();
    (dst, code)
}

/// 跑混淆并验证
fn run_preset(
    input_path: &std::path::Path,
    original_result: &str,
    preset: &str,
    iterations: usize,
) {
    let confuse_exe = repo_root().join("crates/wc3-confuse/target/release/wc3-confuse.exe");
    if !confuse_exe.is_file() {
        println!("  [SKIP] wc3-confuse.exe not built (run: cargo build --manifest-path crates/wc3-confuse/Cargo.toml --release)");
        return;
    }
    let prometheus_dir = repo_root().join("bin/lua");
    if !prometheus_dir.join("cli.lua").is_file() {
        println!("  [SKIP] bin/lua/cli.lua not found (run: node prepare.js)");
        return;
    }

    let input_size = std::fs::metadata(input_path).unwrap().len();
    let mut pass = 0;
    let mut fail = 0;
    let mut total_ms = 0u128;

    for i in 1..=iterations {
        let output = input_path.with_extension(format!("confused.{i}.lua"));

        let start = Instant::now();
        let output_cmd = std::process::Command::new(&confuse_exe)
            .arg("--prometheus-dir")
            .arg(&prometheus_dir)
            .arg("--preset")
            .arg(preset)
            .arg("--out")
            .arg(&output)
            .arg(input_path)
            .output();
        let elapsed = start.elapsed().as_millis();
        total_ms += elapsed;

        match output_cmd {
            Ok(o) if o.status.success() => {
                let confused_code = std::fs::read_to_string(&output).unwrap();
                let out_size = confused_code.len();
                let confused_result = exec_result(&confused_code);
                let ratio = out_size as f64 / input_size as f64 * 100.0;
                if confused_result == original_result {
                    println!("    [{i}/{iterations}] PASS  {elapsed}ms  {out_size}B ({ratio:.0}%)");
                    pass += 1;
                } else {
                    println!("    [{i}/{iterations}] FAIL  {elapsed}ms  {out_size}B ({ratio:.0}%)");
                    eprintln!("      expected: {original_result}");
                    eprintln!("      got:      {confused_result}");
                    fail += 1;
                }
                let _ = std::fs::remove_file(&output);
            }
            Ok(o) => {
                let stderr = String::from_utf8_lossy(&o.stderr);
                let stdout = String::from_utf8_lossy(&o.stdout);
                println!(
                    "    [{i}/{iterations}] CONFUSE_FAILED (exit {})  {elapsed}ms",
                    o.status
                );
                if !stderr.is_empty() {
                    println!("      stderr: {}", stderr.lines().next().unwrap_or(""));
                }
                if !stdout.is_empty() {
                    println!("      stdout: {}", stdout.lines().last().unwrap_or(""));
                }
                fail += 1;
            }
            Err(e) => {
                println!("    [{i}/{iterations}] SPAWN_ERROR: {e}");
                fail += 1;
            }
        }
    }

    let avg = total_ms / iterations as u128;
    println!(
        "  {preset}: {pass}/{} passed, avg {avg}ms/iter",
        pass + fail
    );
    assert_eq!(fail, 0, "{preset} had {fail} failures");
}

#[test]
fn confuse_bench_all_presets() {
    let (root, code) = build_release_input();
    let input_path = root.join(".build/war3map.lua");
    let original_result = exec_result(&code);
    let input_size = code.len();

    println!("\n{}", "=".repeat(64));
    println!(" Lua Confusion Benchmark");
    println!(" Input: release war3map.lua ({input_size} bytes)");
    println!(" RESULT: {original_result}");
    println!("{}\n", "=".repeat(64));

    let presets = ["Minify", "Weak", "Medium"];
    let iterations = 3;

    for preset in presets {
        println!("  --- {preset} ---");
        run_preset(&input_path, &original_result, preset, iterations);
    }

    // Strong: Vmify 产出面向 Lua 5.1 的 VM 代码，无法在 Lua 5.4 验证器中执行。
    // 仅验证混淆过程成功完成(产物需在 Warcraft III 的 Lua 5.1 中运行,
    // 完整语义验证见 crates/wc3-confuse/tests/spike_tmp.rs)。
    println!("  --- Strong (obfuscation-only, runtime requires Lua 5.1) ---");
    let confuse_exe = repo_root().join("crates/wc3-confuse/target/release/wc3-confuse.exe");
    if confuse_exe.is_file() {
        let prometheus_dir = repo_root().join("bin/lua");
        let output = root.join(".build/strong_out.lua");
        let start = Instant::now();
        let status = std::process::Command::new(&confuse_exe)
            .args(["--prometheus-dir"])
            .arg(&prometheus_dir)
            .args(["--preset", "Strong", "--out"])
            .arg(&output)
            .arg(&input_path)
            .stdout(std::process::Stdio::null())
            .stderr(std::process::Stdio::null())
            .status()
            .unwrap();
        let elapsed = start.elapsed().as_millis();
        let out_size = std::fs::metadata(&output).map(|m| m.len()).unwrap_or(0);
        let ratio = out_size as f64 / input_size as f64 * 100.0;
        println!(
            "    obfuscation {}: {elapsed}ms, {out_size}B ({ratio:.0}%)",
            if status.success() { "OK" } else { "FAILED" }
        );
        assert!(
            status.success(),
            "Strong obfuscation should complete successfully"
        );
    }

    std::fs::remove_dir_all(&root).unwrap();
}
