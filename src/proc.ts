/**
 * @File   : proc.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/9/2019, 6:27:50 PM
 */

import * as cp from 'child_process';
import * as utils from './utils';

import { promisify } from 'util';

const execFilePromise = promisify(cp.execFile);

export class Process {
    private process: cp.ChildProcess | undefined;

    constructor(command: string, args?: string[]) {
        this.process = cp.spawn(command, args, {
            detached: true
        });

        const onExit = () => (this.process = undefined);

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
    }

    isAlive() {
        return !!this.process;
    }
}

export function spawn(command: string, args?: string[]) {
    return new Process(command, args);
}

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
        throw new Error(output);
    }
    return output;
}
