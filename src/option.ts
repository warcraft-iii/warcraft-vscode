/**
 * @File   : option.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/9/2019, 11:19:44 PM
 */

import * as vscode from 'vscode';

export class Option {
    private static instance = new Option();

    static get() {
        return this.instance;
    }

    private constructor() {}

    async setPath(key: string) {
        vscode.workspace.getConfiguration('warcraft').update(key, await this.askPath(), true);
    }

    async askPath() {
        const value = await vscode.window.showOpenDialog({
            openLabel: 'Select Warcraft III execution',
            filters: { 'Warcraft III.exe': ['exe'] }
        });

        if (!value || value.length < 1) {
            return;
        }

        return value[0].fsPath;
    }

    async open() {
        const choice = await vscode.window.showQuickPick([
            {
                label: 'Set Warcraft III execution path',
                func: async () => this.setPath('gamePath')
            },
            {
                label: 'Set World Editor execution path',
                func: async () => this.setPath('wePath')
            }
        ]);

        if (!choice) {
            return;
        }

        return choice.func();
    }
}
