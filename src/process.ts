/**
 * @File   : process.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/9/2019, 6:27:50 PM
 */

import * as cp from "child_process";

import { sleep } from "./util";
export class Process {
    private process: cp.ChildProcess | undefined;

    constructor(command: string, args?: string[]) {
        this.process = cp.spawn(command, args, {
            detached: true
        });
        this.process.on("exit", () => {
            this.process = undefined;
        });
        this.process.on("close", () => {
            this.process = undefined;
        });
    }

    async kill(): Promise<void> {
        if (this.process) {
            this.process.kill();
            while (this.process) {
                await sleep(100);
            }
        }
    }

    isAlive() {
        return !!this.process;
    }
}
