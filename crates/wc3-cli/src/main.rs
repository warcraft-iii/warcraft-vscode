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
    /// Run object editing (skips when no objediting script)
    Objediting {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        /// Directory containing def.zip / .version.json (defaults next to wc3.exe)
        #[arg(long)]
        res_dir: Option<PathBuf>,
    },
    /// Pack .build outputs and imports into a map archive (requires prior compile)
    Pack {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        release: bool,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        /// Copy resulting archive to this path
        #[arg(short, long)]
        output: Option<PathBuf>,
    },
    /// objediting + compile + pack in one go
    Build {
        /// Project root (contains warcraft.json)
        project: PathBuf,
        #[arg(short, long)]
        release: bool,
        #[arg(short, long)]
        classic: bool,
        /// Override mapdir (file or folder)
        #[arg(short, long)]
        map: Option<PathBuf>,
        /// Copy resulting archive to this path
        #[arg(short, long)]
        output: Option<PathBuf>,
        #[arg(long, value_enum, default_value = "disable")]
        confusion: ConfusionArg,
        /// Directory containing def.zip / wc3-confuse.exe (defaults next to wc3.exe)
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

fn make_ctx(
    project: &std::path::Path,
    release: bool,
    classic: bool,
    map: Option<PathBuf>,
    confusion: Confusion,
) -> wc3_core::error::Result<BuildContext> {
    let config = ProjectConfig::load(project)?;
    Ok(BuildContext::new(
        project,
        config,
        BuildOptions {
            release,
            classic,
            map,
            confusion,
        },
    ))
}

fn copy_output(from: &std::path::Path, to: &std::path::Path) -> wc3_core::error::Result<()> {
    if let Some(dir) = to.parent() {
        std::fs::create_dir_all(dir).map_err(|e| wc3_core::error::Error::io(dir, e))?;
    }
    std::fs::copy(from, to).map_err(|e| wc3_core::error::Error::io(to, e))?;
    Ok(())
}

fn finish(result: wc3_core::error::Result<()>) -> ExitCode {
    match result {
        Ok(()) => ExitCode::SUCCESS,
        Err(e) => {
            let mut json = serde_json::json!({
                "event": "error", "key": e.key, "message": e.message, "args": e.args
            });
            if let Some(file) = &e.file {
                json["file"] = serde_json::Value::String(file.clone());
            }
            if let Some(line) = e.line {
                json["line"] = serde_json::Value::Number(line.into());
            }
            println!("{json}");
            ExitCode::FAILURE
        }
    }
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
        } => finish((|| {
            let ctx = make_ctx(&project, release, classic, map, confusion.into())?;
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
        })()),
        Command::Objediting {
            project,
            classic,
            map,
            res_dir,
        } => finish((|| {
            let ctx = make_ctx(&project, false, classic, map, Confusion::Disable)?;
            let dir = res_dir_or_exe_dir(res_dir);
            progress("objediting", "Object editing");
            wc3_core::objediting::execute(&ctx, &dir)?;
            progress("objediting", "done");
            Ok(())
        })()),
        Command::Pack {
            project,
            release,
            classic,
            map,
            output,
        } => finish((|| {
            let ctx = make_ctx(&project, release, classic, map, Confusion::Disable)?;
            progress("pack", "Packing map");
            let out = wc3_core::packer::pack(&ctx)?;
            if let Some(o) = &output {
                copy_output(&out, o)?;
            }
            progress("pack", "done");
            Ok(())
        })()),
        Command::Build {
            project,
            release,
            classic,
            map,
            output,
            confusion,
            res_dir,
        } => finish((|| {
            let ctx = make_ctx(&project, release, classic, map, confusion.into())?;
            let dir = res_dir_or_exe_dir(res_dir);
            progress("objediting", "Object editing");
            wc3_core::objediting::execute(&ctx, &dir)?;
            progress("objediting", "done");
            progress("compile", "Compiling script");
            let confuse = dir.join("wc3-confuse.exe");
            let tools = Tools {
                confuse_exe: confuse.exists().then_some(confuse.as_path()),
            };
            if release {
                compile_release(&ctx, &tools)?;
            } else {
                compile_debug(&ctx)?;
            }
            progress("compile", "done");
            progress("pack", "Packing map");
            let out = wc3_core::packer::pack(&ctx)?;
            if let Some(o) = &output {
                copy_output(&out, o)?;
            }
            progress("pack", "done");
            progress("build", "done");
            Ok(())
        })()),
    }
}
