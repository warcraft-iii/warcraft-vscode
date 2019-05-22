/**
 * @File   : runner.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 10:44:57 AM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as cp from 'child_process';
import * as utils from './utils';

import { env } from './environment';
import { DEBUG_MAP_FILE } from './globals';

export enum ProcessType {
    Game,
    Editor
}

export class Runner {
    private processes = new Map<ProcessType, cp.ChildProcess>();

    constructor() {}

    hasProcess(type: ProcessType) {
        return this.processes.has(type);
    }

    async runGame() {
        const mapPath = env.asBuildPath(DEBUG_MAP_FILE);
        const isPtr = await fs.pathExists(
            path.join(path.dirname(env.gamePath), '../Warcraft III Public Test Launcher.exe')
        );
        const docMapFolder = env.asDocumentPath(isPtr ? 'Warcraft III Public Test' : 'Warcraft III', 'Maps');
        const targetPath = path.join(docMapFolder, 'Test', path.basename(mapPath));
        await fs.copy(mapPath, targetPath);

        const process = cp.spawn(env.gamePath, [...env.gameArgs, '-loadfile', path.relative(docMapFolder, targetPath)]);

        this.saveProcess(process, ProcessType.Game);
    }

    async runEditor() {
        const process = cp.spawn(env.wePath, [...env.weArgs, '-loadfile', env.mapFolder]);
        this.saveProcess(process, ProcessType.Editor);
    }

    async kill(type: ProcessType) {
        const p = this.processes.get(type);
        if (!p) {
            return;
        }

        p.kill();

        while (this.processes.has(type)) {
            await utils.sleep(100);
        }
    }

    private saveProcess(process: cp.ChildProcess, type: ProcessType) {
        process.on('close', () => this.removeProcess(process, type));
        process.on('exit', () => this.removeProcess(process, type));
        this.processes.set(type, process);
    }

    private removeProcess(process: cp.ChildProcess, type: ProcessType) {
        process.removeAllListeners();
        this.processes.delete(type);
    }
}
