/**
 * @File   : proc.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/9/2019, 6:27:50 PM
 */

import * as cp from 'child_process';
import * as utils from './utils';

import { promisify } from 'util';
import * as ps from 'ps-node';
import * as sodu from 'sudo-prompt';

import isRunning = require('is-running');

export class Process {
    private process: cp.ChildProcess | undefined;
    private childprocess: ps.Program | undefined;

    checkChildProcess() {
        if (this.process) {
            ps.lookup({ ppid: this.process.pid }, (err, list) => {
                if (!err && list.length === 1) {
                    this.childprocess = list[0];
                }
            });
        }
    }

    constructor(command: string, args?: string[], childproc?: boolean) {
        this.childprocess = undefined;
        this.process = cp.spawn(command, args, {
            detached: true,
        });

        const onExit = () => {
            if (!!childproc) {
                this.checkChildProcess();
            }
            this.process = undefined;
        };

        this.process.on('exit', onExit);
        this.process.on('close', onExit);
    }

    async kill(): Promise<void> {
        if (this.process) {
            this.process.kill();

            while (this.process) {
                await utils.sleep(100);
            }
        }
        if (!!this.childprocess) {
            let command;
            if (process.platform === 'win32') {
                command = 'taskkill /f /pid ';
            } else {
                command = 'kill -9 ';
            }
            sodu.exec(command + this.childprocess.pid, {
                name: 'Warcraft VSCode',
            });
            this.childprocess = undefined;
        }
    }

    isAlive() {
        return !!this.process || (!!this.childprocess && isRunning(this.childprocess.pid));
    }
}

export function spawn(command: string, args?: string[], childproc?: boolean) {
    return new Process(command, args, childproc);
}

const execFilePromise = promisify(cp.execFile);

export async function execFile(command: string, args?: string[]) {
    let ok: boolean;
    let output: string;

    try {
        let { stdout, stderr } = await execFilePromise(command, args);

        stdout = stdout.trim();
        stderr = stderr.trim();

        if (stderr) {
            ok = false;
            output = stderr;
        } else {
            ok = true;
            output = stdout;
        }
    } catch (error) {
        ok = false;
        output = error.message;
    }

    if (!ok) {
        throw Error(output);
    }
    return output;
}
