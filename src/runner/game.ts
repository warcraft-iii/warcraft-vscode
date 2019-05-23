/**
 * @File   : game.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:13:56 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as proc from '../proc';
import * as globals from '../globals';

import { env } from '../environment';
import { RunnerType } from './runner';
import { BaseRunner } from './private';
import { Report } from '../report';

class GameRunner extends BaseRunner {
    type() {
        return RunnerType.Game;
    }

    @Report('Starting Game ...')
    async execute() {
        const mapPath = env.asBuildPath(globals.DEBUG_MAP_FILE);
        const isPtr = await fs.pathExists(
            path.join(path.dirname(env.config.gamePath), '../Warcraft III Public Test Launcher.exe')
        );
        const docMapFolder = env.asDocumentPath(isPtr ? 'Warcraft III Public Test' : 'Warcraft III', 'Maps');
        const targetPath = path.join(docMapFolder, 'Test', path.basename(mapPath));
        await fs.copy(mapPath, targetPath);

        this.process = proc.spawn(env.config.gamePath, [
            ...env.config.gameArgs,
            '-loadfile',
            path.relative(docMapFolder, targetPath)
        ]);
    }
}

export const gameRunner = new GameRunner();
