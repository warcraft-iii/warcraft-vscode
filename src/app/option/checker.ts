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
    title: string;
    name: string;
    key: string;
    selectFile: boolean;
}

const EXECUTION_FILES: ExecutionItem[] = [
    {
        title: 'Warcraft III',
        name: 'Warcraft III.exe',
        key: 'gamePath',
        selectFile: false,
    },
    {
        title: 'Warcraft III Editor',
        name: 'World Editor.exe',
        key: 'wePath',
        selectFile: false,
    },
];

const EXECUTION_FILES_YDWE: ExecutionItem[] = [
    {
        title: 'YDWE',
        name: 'bin/YDWEConfig.exe',
        key: 'ydwePath',
        selectFile: true,
    },
];

class Checker {
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
                localize('confirm.setGamePath', notFounds[0].title + ' is not set or incorrect, to set?')
            ))
        ) {
            return;
        }

        const result = await vscode.window.showOpenDialog({
            canSelectFolders: !notFounds[0].selectFile,
            canSelectFiles: notFounds[0].selectFile,
            canSelectMany: false,
        });

        if (!result) {
            return;
        }

        const folder = result[0].fsPath;
        const names: string[] = [];

        for (const item of notFounds) {
            let file: string;
            if (item.selectFile) {
                file = path.resolve(path.dirname(folder), item.name);
            } else {
                file = path.resolve(folder, item.name);
            }
            if ((await fs.pathExists(file)) && (await fs.stat(file)).isFile()) {
                if (item.selectFile) {
                    env.config[item.key] = folder;
                } else {
                    env.config[item.key] = file;
                }
            } else {
                names.push(item.name);
            }
        }

        if (names.length > 0) {
            vscode.window.showWarningMessage(localize('error.notFound', 'Not found {0}', names.join(' ')));
        }
    }

    async check() {
        if (!env.rootPath) {
            throw Error(localize('error.notProject', 'Not Warcraft III project'));
        }

        if (!env.mapFolder) {
            throw Error(localize('error.notProject', 'Not Warcraft III project'));
        }

        const notFounds: ExecutionItem[] = [];

        const checkItems = EXECUTION_FILES;
        if (env.config.classic) {
            checkItems.push(...EXECUTION_FILES_YDWE);
        }

        for (const item of checkItems) {
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
