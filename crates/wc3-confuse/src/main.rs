use std::path::{Path, PathBuf};
use std::process::ExitCode;

use clap::Parser;

#[derive(Parser)]
#[command(
    name = "wc3-confuse",
    about = "Prometheus lua obfuscator runner",
    version
)]
struct Cli {
    /// Prometheus 源码目录（含 cli.lua），默认 exe 旁的 lua/
    #[arg(long)]
    prometheus_dir: Option<PathBuf>,
    /// 混淆 preset（Minify/Weak/Medium/Strong）
    #[arg(long)]
    preset: String,
    /// 输出文件
    #[arg(long)]
    out: PathBuf,
    /// 输入文件
    input: PathBuf,
}

fn main() -> ExitCode {
    let cli = Cli::parse();
    let dir = cli.prometheus_dir.unwrap_or_else(|| {
        std::env::current_exe()
            .ok()
            .and_then(|p| p.parent().map(|d| d.join("lua")))
            .unwrap_or_else(|| PathBuf::from("lua"))
    });
    match run(&dir, &cli.preset, &cli.input, &cli.out) {
        Ok(()) => ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("confuse failed: {e}");
            ExitCode::FAILURE
        }
    }
}

fn run(
    dir: &Path,
    preset: &str,
    input: &Path,
    out: &Path,
) -> Result<(), Box<dyn std::error::Error>> {
    // Prometheus 需要完整 stdlib（io/os/debug）
    let lua = unsafe { mlua::Lua::unsafe_new() };

    // arg 表与 TS Prometheus.compile 注入一致：--Lua51 --preset X --out f f
    let args = lua.create_table()?;
    args.set(1, "--Lua51")?;
    args.set(2, "--preset")?;
    args.set(3, preset)?;
    args.set(4, "--out")?;
    args.set(5, out.to_string_lossy().replace('\\', "/"))?;
    args.set(6, input.to_string_lossy().replace('\\', "/"))?;
    lua.globals().set("arg", args)?;

    let dir_fwd = dir.to_string_lossy().replace('\\', "/");
    // package.path 指向 Prometheus 源码目录（原生 io 直接读盘，无需 wasmoon 的挂载与 io patch）
    lua.load(format!(
        "package.path = [[{dir_fwd}/?.lua;{dir_fwd}/?/init.lua;]] .. package.path"
    ))
    .exec()?;

    let cli_lua = dir.join("cli.lua");
    let code =
        std::fs::read_to_string(&cli_lua).map_err(|e| format!("{}: {e}", cli_lua.display()))?;
    // cli.lua 用 debug.getinfo(...).source 推导自身目录配置 package.path，
    // chunk 名必须是含目录分隔符的真实路径（裸 "@cli.lua" 会使 script_path() 返回 nil）
    lua.load(&code)
        .set_name(format!("@{dir_fwd}/cli.lua"))
        .exec()?;
    Ok(())
}
