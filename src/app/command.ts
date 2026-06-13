/**
 * @File   : command.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 6:03:28 PM
 */

import * as vscode from 'vscode';
import * as utils from '../utils';

import { checker } from './option';
import { env } from '../env';
import { WarcraftBuildError } from './bridge';
import { clearDiagnostics, reportBuildError } from './diagnostics';

export function registerCommand(name: string, task: () => Promise<void>) {
    return vscode.commands.registerCommand('extension.warcraft.' + name, async () => {
        try {
            await env.config.waitLoaded();
            clearDiagnostics();
            await utils.withReport(task);
        } catch (error) {
            if (error instanceof WarcraftBuildError) {
                await reportBuildError(error);
                vscode.window.showWarningMessage(`[Warcraft vscode] ${error.message}`);
            } else {
                vscode.window.showWarningMessage(`[Warcraft vscode] ${error.message}`);
            }
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
