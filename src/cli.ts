/**
 * @File   : cli.ts
 * @Date   : 6/13/2026
 *
 * vscwarcraft CLI — 向后兼容 shim，委托 wc3.exe 执行。
 * 本文件是 bin/cli.js 的 webpack 入口（out/cli.js），保持 npm bin 'vscwarcraft' 可用。
 */

import * as path from 'path';
import * as cp from 'child_process';
import { program } from 'commander';

function wc3Exe(): string {
    return path.resolve(__dirname, '../bin/wc3.exe');
}

function spawn(args: string[]): Promise<void> {
    return new Promise((resolve, reject) => {
        const child = cp.spawn(wc3Exe(), args, { stdio: 'inherit' });
        child.on('close', (code) => (code === 0 ? resolve() : process.exit(code || 1)));
        child.on('error', (err) => {
            console.error(`Failed to start wc3.exe: ${err.message}`);
            process.exit(1);
        });
    });
}

program
    .command('pack')
    .argument('[project path]')
    .description('Build map (objediting + compile + pack)')
    .option('-o --output <output>', 'Copy resulting archive to this path', '')
    .option('-t --target <map>', 'Map file/folder path', '')
    .option('-c --classic', 'Classic Edition', false)
    .option('-r --release', 'Release mode', false)
    .option('-l --luaconfusion <level>', 'Lua confusion level (Disable|Minify|Weak|Medium|Strong)', '')
    .action(async (projectPath: string, opts: { output: string; target: string; classic: boolean; release: boolean; luaconfusion: string }) => {
        const args = ['build', projectPath || '.'];
        if (opts.classic) args.push('-c');
        if (opts.release) args.push('-r');
        if (opts.target) args.push('-m', path.isAbsolute(opts.target) ? opts.target : path.resolve(projectPath || '.', opts.target));
        if (opts.luaconfusion) args.push('--confusion', opts.luaconfusion.toLowerCase());
        if (opts.output) args.push('-o', opts.output);
        args.push('--res-dir', path.resolve(__dirname, '../bin'));
        await spawn(args);
    });

program
    .command('compile')
    .argument('[project path]')
    .description('Compile script only (no objediting/pack)')
    .option('-t --target <map>', 'Map file/folder path', '')
    .option('-c --classic', 'Classic Edition', false)
    .option('-r --release', 'Release mode', false)
    .action(async (projectPath: string, opts: { target: string; classic: boolean; release: boolean }) => {
        const args = ['compile', projectPath || '.'];
        if (opts.classic) args.push('-c');
        if (opts.release) args.push('-r');
        if (opts.target) args.push('-m', path.isAbsolute(opts.target) ? opts.target : path.resolve(projectPath || '.', opts.target));
        args.push('--res-dir', path.resolve(__dirname, '../bin'));
        await spawn(args);
    });

program.parse(process.argv);
