/**
 * @File   : bridge.ts
 * @Date   : 6/13/2026
 *
 * spawn wc3.exe 子进程封装 + NDJSON stdout→vscode.window.withProgress 桥接。
 * 阶段 3：TS 插件不再 in-process 执行编译/打包/物编，改为委托 Rust CLI。
 */

import * as cp from 'child_process';
import { env } from '../env';
import { runtime, ProgressLocation } from '../env/runtime';

export interface BuildOptions {
    release?: boolean;
    classic?: boolean;
    map?: string;
    confusion?: string;
    output?: string;
}

interface NdjsonProgress { event: 'progress'; step: string; message: string; }
interface NdjsonError { event: 'error'; key: string; message: string; args: string[]; file?: string; line?: number; }
type NdjsonEvent = NdjsonProgress | NdjsonError;

/**
 * 结构化构建错误——携带源文件定位信息，供 VS Code Diagnostics 使用。
 */
export class WarcraftBuildError extends Error {
    readonly key: string;
    readonly args: string[];
    readonly file?: string;     // 相对于工程根的源文件路径
    readonly line?: number;     // 1-based 行号

    constructor(ev: NdjsonError) {
        super(ev.message);
        this.name = 'WarcraftBuildError';
        this.key = ev.key;
        this.args = ev.args;
        this.file = ev.file;
        this.line = ev.line;
    }
}

function wc3ExePath(): string {
    return env.asExetensionPath('bin/wc3.exe');
}

function resDir(): string {
    return env.asExetensionPath('bin');
}

/**
 * spawn wc3.exe 子命令，逐行解析 NDJSON stdout，驱动 withProgress 通知。
 * 失败时 throw WarcraftBuildError（携带 key/args/file/line）或普通 Error。
 */
export async function runWc3(
    subcommand: 'compile' | 'pack' | 'objediting' | 'build',
    opts: BuildOptions = {}
): Promise<void> {
    const exe = wc3ExePath();
    const args: string[] = [subcommand, env.rootPath!];
    if (opts.release) args.push('-r');
    if (opts.classic) args.push('-c');
    if (opts.map) args.push('-m', opts.map);
    if (opts.confusion && opts.confusion !== 'Disable') {
        args.push('--confusion', opts.confusion.toLowerCase());
    }
    if (opts.output) args.push('-o', opts.output);
    if (subcommand === 'compile' || subcommand === 'build' || subcommand === 'objediting') {
        args.push('--res-dir', resDir());
    }

    return runtime.withProgress(
        { location: ProgressLocation.Notification },
        (progress: any) => new Promise<void>((resolve, reject) => {
            const child = cp.spawn(exe, args, { stdio: ['ignore', 'pipe', 'pipe'] });
            let stderrBuf = '';
            let lastError: NdjsonError | undefined;

            child.stdout!.setEncoding('utf-8');
            let lineBuf = '';
            child.stdout!.on('data', (chunk: string) => {
                lineBuf += chunk;
                const lines = lineBuf.split('\n');
                lineBuf = lines.pop()!;
                for (const line of lines) {
                    if (!line.trim()) continue;
                    try {
                        const ev: NdjsonEvent = JSON.parse(line);
                        if (ev.event === 'progress') {
                            progress.report({ message: ev.message });
                        } else if (ev.event === 'error') {
                            lastError = ev;
                        }
                    } catch { /* ignore non-json lines */ }
                }
            });
            child.stderr!.setEncoding('utf-8');
            child.stderr!.on('data', (chunk: string) => { stderrBuf += chunk; });
            child.on('close', (code) => {
                if (code === 0) {
                    resolve();
                } else if (lastError) {
                    reject(new WarcraftBuildError(lastError));
                } else {
                    reject(new Error(stderrBuf.trim() || `wc3 ${subcommand} failed (exit ${code})`));
                }
            });
            child.on('error', (err) => {
                reject(new Error(`Failed to start wc3.exe: ${err.message}`));
            });
        })
    );
}
