/**
 * @File   : app.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/22/2019, 1:40:29 PM
 */

import { workspace } from 'vscode';

export class App {
    constructor() {
        workspace.onDidChangeConfiguration(e => {
            console.log(e.affectsConfiguration);
        });
    }

    async init() {}
}
