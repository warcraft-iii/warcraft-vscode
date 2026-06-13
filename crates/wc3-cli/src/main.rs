use std::path::PathBuf;
use std::process::ExitCode;

use clap::{Parser, Subcommand, ValueEnum};
use wc3_core::compiler::{compile_debug, compile_release, Tools};
use wc3_core::config::{BuildContext, BuildOptions, Confusion, ProjectConfig};

#[derive(Parser)]
#[command(name = "wc3", about = "Warcraft III map toolchain", version)]
struct Cli {
    #[command(subcommand)]
    command: Command,
}

#[derive(Clone, Copy, ValueEnum)]
enum ConfusionArg {
    Disable,
    Minify,
    Weak,
    Medium,
    Strong,
}

impl From<ConfusionArg> for Confusion {
    fn from(v: ConfusionArg) -> Self {
        match v {
            ConfusionArg::Disable => Confusion::Disable,
            ConfusionArg::Minify => Confusion::Minify,
            ConfusionArg::Weak => Confusion::Weak,
            ConfusionArg::Medium => Confusion::Medium,
            ConfusionArg::Strong => Confusion::Strong,
        }
    }
}

#[derive(Subcommand)]
enum Command {
    /// Compile lua sources into .build/war3map.lua
    Compile {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        release: bool,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        #[arg(long, value_enum, default_value = "disable")]
        confusion: ConfusionArg,
        /// Directory containing wc3-confuse.exe (defaults next to wc3.exe)
        #[arg(long)]
        res_dir: Option<PathBuf>,
    },
}

fn progress(step: &str, message: &str) {
    println!(
        "{}",
        serde_json::json!({ "event": "progress", "step": step, "message": message })
    );
}

fn res_dir_or_exe_dir(res_dir: Option<PathBuf>) -> PathBuf {
    res_dir.unwrap_or_else(|| {
        std::env::current_exe()
            .ok()
            .and_then(|p| p.parent().map(|d| d.to_path_buf()))
            .unwrap_or_else(|| PathBuf::from("."))
    })
}

fn main() -> ExitCode {
    let cli = Cli::parse();
    match cli.command {
        Command::Compile {
            project,
            release,
            classic,
            map,
            confusion,
            res_dir,
        } => {
            let run = || -> wc3_core::error::Result<()> {
                let config = ProjectConfig::load(&project)?;
                let ctx = BuildContext::new(
                    &project,
                    config,
                    BuildOptions {
                        release,
                        classic,
                        map,
                        confusion: confusion.into(),
                    },
                );
                let dir = res_dir_or_exe_dir(res_dir);
                let confuse = dir.join("wc3-confuse.exe");
                let tools = Tools {
                    confuse_exe: confuse.exists().then_some(confuse.as_path()),
                };
                progress("compile", "Compiling script");
                if release {
                    compile_release(&ctx, &tools)?;
                } else {
                    compile_debug(&ctx)?;
                }
                progress("compile", "done");
                Ok(())
            };
            match run() {
                Ok(()) => ExitCode::SUCCESS,
                Err(e) => {
                    println!(
                        "{}",
                        serde_json::json!({
                            "event": "error", "key": e.key, "message": e.message, "args": e.args
                        })
                    );
                    ExitCode::FAILURE
                }
            }
        }
    }
}
