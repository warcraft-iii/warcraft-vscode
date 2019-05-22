/**
 * @File   : process.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/9/2019, 6:27:50 PM
 */

import * as cp from 'child_process';
import * as utils from './utils';

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
