/**
 * @File   : app.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 10:48:53 AM
 */

import * as vscode from 'vscode';

import { env } from '../env';

export class App implements vscode.Disposable {
    private subscriptions: vscode.Disposable[] = [];

    dispose() {
        this.subscriptions.forEach(sub => sub.dispose());
    }

    constructor() {
        if (env.rootPath) {
            const watcher = vscode.workspace.createFileSystemWatcher(
                new vscode.RelativePattern(env.rootPath, 'warcraft.json')
            );

            this.subscriptions.push(
                watcher.onDidChange(() => env.config.reload()),
                watcher.onDidCreate(() => env.config.reload()),
                watcher.onDidDelete(() => env.config.reload())
            );
        }

        vscode.workspace.onDidChangeConfiguration(e => {
            if (e.affectsConfiguration('warcraft')) {
                env.config.reload();
            }
        });
    }
}

export const app = new App();
