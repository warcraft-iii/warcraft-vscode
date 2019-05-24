/**
 * @File   : private.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:26:03 AM
 */

import * as utils from '../../utils';

import { Runner, RunnerType } from './runner';

export abstract class BaseRunner implements Runner {
    protected process?: utils.Process;

    abstract execute(): Promise<void>;
    abstract type(): RunnerType;

    isAlive() {
        return this.process ? this.process.isAlive() : false;
    }

    async kill() {
        if (this.process) {
            await this.process.kill();
        }
    }
}
