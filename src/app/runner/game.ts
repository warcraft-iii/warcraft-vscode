/**
 * @File   : game.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:13:56 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as utils from '../../utils';

import { env } from '../../env';
import { localize } from '../../globals';

import { RunnerType } from './runner';
import { BaseRunner } from './private';

class GameRunner extends BaseRunner {
    type() {
        return RunnerType.Game;
    }

    @utils.report(localize('report.openGame', 'Starting game'))
    async execute() {
        const mapPath = env.outFilePath;
        const isPtr = await fs.pathExists(env.asGamePath('../Warcraft III Public Test Launcher.exe'));
        const docMapFolder = env.asDocumentPath(isPtr ? 'Warcraft III Public Test' : 'Warcraft III', 'Maps');
        const targetPath = path.resolve(docMapFolder, 'Test', path.basename(mapPath));
        await fs.copy(mapPath, targetPath);

        this.process = utils.spawn(env.config.gamePath, [
            ...env.config.gameArgs,
            '-loadfile',
            path.relative(docMapFolder, targetPath)
        ]);
    }

    async check() {
        if (!this.isAlive()) {
            return true;
        }

        if (!env.config.autoCloseClient) {
            const result = await utils.confirm(
                localize('confirm.closeGame', 'Warcraft III running, to terminate?'),
                localize('confirm.accept', 'Accept'),
                localize('confirm.autoCloseGame', 'Auto close')
            );
            if (!result) {
                return false;
            }
            if (result === utils.ConfirmResult.Alt) {
                env.config.autoCloseClient = true;
            }
        }
        await this.kill();
        return true;
    }
}

export const gameRunner = new GameRunner();
