/**
 * @File   : app.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 10:48:53 AM
 */

import * as vscode from 'vscode';
import debounce from 'lodash-es/debounce';

import { env } from '../env';
import { globals } from '../globals';

export class App implements vscode.Disposable {
    private subscriptions: vscode.Disposable[] = [];
    private reload = debounce(() => env.config.reload(), 100);

    dispose() {
        this.subscriptions.forEach(sub => sub.dispose());
    }

    constructor() {
        if (env.rootPath) {
            const watcher = vscode.workspace.createFileSystemWatcher(
                new vscode.RelativePattern(env.rootPath, globals.FILE_PROJECT)
            );

            this.subscriptions.push(
                watcher.onDidChange(() => this.reload()),
                watcher.onDidCreate(() => this.reload()),
                watcher.onDidDelete(() => this.reload())
            );
        }

        vscode.workspace.onDidChangeConfiguration(e => {
            if (e.affectsConfiguration('warcraft')) {
                this.reload();
            }
        });
    }
}

export const app = new App();
