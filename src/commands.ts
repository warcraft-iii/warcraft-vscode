/**
 * @File   : command.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 6:03:28 PM
 */

import * as vscode from 'vscode';
import * as utils from './utils';

import { debugCompiler } from './compiler';
import { debugPacker } from './packer';
import { gameRunner, editorRunner } from './runner';

import { withReport } from './report';
import { env } from './environment';

function registerCommand(name: string, task: () => Promise<void>) {
    return vscode.commands.registerCommand('extension.warcraft.' + name, async () => withReport(task));
}

export function registerCommands() {
    return vscode.Disposable.from(
        registerCommand('compile.debug', () => debugCompiler.execute()),
        registerCommand('pack.debug', async () => {
            await debugCompiler.execute();
            await debugPacker.execute();
        }),
        registerCommand('run.game', async () => {
            const canTerminateGame = async () => {
                if (env.config.autoCloseClient) {
                    return true;
                }

                const result = await utils.confirm('Warcraft III running, to terminate?', 'Ok', 'Auto close');
                if (!result) {
                    return false;
                }

                if (result === utils.ConfirmResult.Alt) {
                    env.config.autoCloseClient = true;
                }
                return true;
            };

            if (gameRunner.isAlive()) {
                if (!(await canTerminateGame())) {
                    return;
                }
                await gameRunner.kill();
            }

            await debugCompiler.execute();
            await debugPacker.execute();
            await gameRunner.execute();
        }),
        registerCommand('run.editor', () => editorRunner.execute())
    );
}
