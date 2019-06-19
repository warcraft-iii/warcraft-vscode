/**
 * @File   : command.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 6:03:28 PM
 */

import * as vscode from 'vscode';
import * as utils from '../utils';

import { debugCompiler } from './compiler';
import { debugPacker } from './packer';
import { gameRunner, editorRunner } from './runner';

import { project, library } from './project';
import { checker } from './option';

function registerCommand(name: string, task: () => Promise<void>) {
    return vscode.commands.registerCommand('extension.warcraft.' + name, async () => {
        try {
            await utils.withReport(task);
        } catch (error) {
            vscode.window.showWarningMessage(`[Warcraft vscode] ${error.message}`);
        }
    });
}

function registerCheckedCommand(name: string, task: () => Promise<void>) {
    return registerCommand(name, async () => {
        if (!(await checker.check())) {
            return;
        }
        return await task();
    });
}

export const commands = [
    registerCommand('compile.debug', () => debugCompiler.execute()),
    registerCommand('pack.debug', async () => {
        await debugCompiler.execute();
        await debugPacker.execute();
    }),
    registerCheckedCommand('run.debug', async () => {
        if (!(await gameRunner.check())) {
            return;
        }
        await debugCompiler.execute();
        await debugPacker.execute();
        await gameRunner.execute();
    }),
    registerCheckedCommand('run.editor', async () => {
        if (!(await editorRunner.check())) {
            return;
        }
        await editorRunner.execute();
    }),
    registerCommand('project.create', () => project.create()),
    registerCommand('project.clean', () => project.clean()),
    registerCommand('project.addlibrary', () => library.add())
];
