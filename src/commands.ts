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
import { env } from './env';
import { project, checker } from './project';

function registerCommand(name: string, task: () => Promise<void>) {
    return vscode.commands.registerCommand('extension.warcraft.' + name, () => withReport(task));
}

function registerCheckedCommand(name: string, task: () => Promise<void>) {
    return registerCommand(name, async () => {
        if (!checker.check()) {
            return;
        }
        return await task();
    });
}

export const commands = [
    registerCheckedCommand('compile.debug', () => debugCompiler.execute()),
    registerCheckedCommand('pack.debug', async () => {
        await debugCompiler.execute();
        await debugPacker.execute();
    }),
    registerCheckedCommand('run.game', async () => {
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
    registerCheckedCommand('run.editor', () => editorRunner.execute()),
    registerCommand('project.create', () => project.create()),
    registerCheckedCommand('project.clean', () => project.clean())
    // registerCommand('project.addlibrary', async () => {})
];
