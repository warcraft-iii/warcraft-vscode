/**
 * @File   : checker.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 3:47:31 PM
 */

import * as vscode from 'vscode';
import * as fs from 'fs-extra';
import * as path from 'path';
import * as utils from '../../utils';

import { env } from '../../env';
import { localize } from '../../globals';

interface ExecutionItem {
    name: string;
    key: string;
}

const EXECUTION_FILES: ExecutionItem[] = [
    {
        name: 'Warcraft III.exe',
        key: 'gamePath'
    },
    {
        name: 'World Editor.exe',
        key: 'wePath'
    }
];

export class Checker {
    private async checkFile(file: string) {
        if (!(await fs.pathExists(file))) {
            return false;
        }
        const stat = await fs.stat(file);
        if (!stat.isFile()) {
            return false;
        }
        return true;
    }

    private async checkPath(key: string) {
        try {
            if (await this.checkFile(env.config[key])) {
                return true;
            }
        } catch (error) {}

        return false;
    }

    private async notify(notFounds: ExecutionItem[]) {
        if (
            !(await utils.confirm(
                localize('confirm.setGamePath', 'Warcraft III path is not set or incorrect, to set?')
            ))
        ) {
            return;
        }

        const result = await vscode.window.showOpenDialog({
            canSelectFolders: true,
            canSelectFiles: false,
            canSelectMany: false
        });

        if (!result) {
            return;
        }

        const folder = result[0].fsPath;
        const names: string[] = [];

        for (const item of notFounds) {
            const file = path.join(folder, item.name);
            if ((await fs.pathExists(file)) && (await fs.stat(file)).isFile()) {
                env.config[item.key] = file;
            } else {
                names.push(item.name);
            }
        }

        if (names.length > 0) {
            vscode.window.showWarningMessage(localize('error.notFound', 'Not found {0}', names.join(' ')));
        }
    }

    async check() {
        const notFounds: ExecutionItem[] = [];

        for (const item of EXECUTION_FILES) {
            if (!(await this.checkPath(item.key))) {
                notFounds.push(item);
            }
        }

        if (notFounds.length > 0) {
            this.notify(notFounds);
            return false;
        }

        return true;
    }
}

export const checker = new Checker();
