/**
 * @File   : runner.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 10:44:57 AM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as proc from './proc';

import { env } from './environment';
import { DEBUG_MAP_FILE } from './globals';
import { Report } from './report';

export enum ProcessType {
    Game,
    Editor
}

export class Runner {
    private processes = new Map<ProcessType, proc.Process>();

    constructor() {}

    hasProcess(type: ProcessType) {
        const process = this.processes.get(type);
        return process && process.isAlive();
    }

    @Report('Starting Game ...')
    async runGame() {
        const mapPath = env.asBuildPath(DEBUG_MAP_FILE);
        const isPtr = await fs.pathExists(
            path.join(path.dirname(env.gamePath), '../Warcraft III Public Test Launcher.exe')
        );
        const docMapFolder = env.asDocumentPath(isPtr ? 'Warcraft III Public Test' : 'Warcraft III', 'Maps');
        const targetPath = path.join(docMapFolder, 'Test', path.basename(mapPath));
        await fs.copy(mapPath, targetPath);

        const process = proc.spawn(env.gamePath, [
            ...env.gameArgs,
            '-loadfile',
            path.relative(docMapFolder, targetPath)
        ]);

        this.processes.set(ProcessType.Game, process);
    }

    @Report('Starting World Editor ...')
    async runEditor() {
        const process = proc.spawn(env.wePath, [...env.weArgs, '-loadfile', env.mapFolder]);
        this.processes.set(ProcessType.Editor, process);
    }

    async kill(type: ProcessType) {
        const p = this.processes.get(type);
        if (!p) {
            return;
        }

        await p.kill();
    }
}
