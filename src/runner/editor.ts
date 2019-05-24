/**
 * @File   : editor.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:14:03 AM
 */

import * as proc from './proc';
import { env } from '../env';
import { RunnerType } from './runner';
import { BaseRunner } from './private';
import { report } from '../report';
import { Errors } from '../errors';

class EditorRunner extends BaseRunner {
    type() {
        return RunnerType.Editor;
    }

    @report('Starting World Editor: ')
    async execute() {
        if (this.isAlive()) {
            throw Error(Errors.EditorIsRunning);
        }
        this.process = proc.spawn(env.config.wePath, [...env.config.weArgs, '-loadfile', env.mapFolder]);
    }
}

export const editorRunner = new EditorRunner();
