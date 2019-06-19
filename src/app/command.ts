/**
 * @File   : command.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 6:03:28 PM
 */

import * as vscode from 'vscode';
import * as utils from '../utils';

import { checker } from './option';

export function registerCommand(name: string, task: () => Promise<void>) {
    return vscode.commands.registerCommand('extension.warcraft.' + name, async () => {
        try {
            await utils.withReport(task);
        } catch (error) {
            vscode.window.showWarningMessage(`[Warcraft vscode] ${error.message}`);
        }
    });
}

export function registerCheckedCommand(name: string, task: () => Promise<void>) {
    return registerCommand(name, async () => {
        if (!(await checker.check())) {
            return;
        }
        return await task();
    });
}
