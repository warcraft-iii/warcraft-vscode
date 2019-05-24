/**
 * @File   : checker.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 3:47:31 PM
 */

import * as vscode from 'vscode';
import * as fs from 'fs-extra';

import { env } from '../env';

export class Checker {
    private async selectPath(title: string, filter: string) {
        if (!(await vscode.window.showInformationMessage(title, 'Set'))) {
            return;
        }

        const result = await vscode.window.showOpenDialog({
            filters: { [filter]: ['exe'] }
        });
        if (!result) {
            return;
        }
        return result[0].fsPath;
    }

    checkFile(file: string) {
        if (!fs.pathExistsSync(file)) {
            return false;
        }
        const stat = fs.statSync(file);
        if (!stat.isFile()) {
            return false;
        }
        return true;
    }

    checkGamePath() {
        try {
            if (this.checkFile(env.config.gamePath)) {
                return true;
            }
        } catch (error) {}

        (async () => {
            const file = await this.selectPath('Warcraft : Warcraft III.exe is not set, to set?', 'Warcraft III.exe');
            if (file) {
                env.config.gamePath = file;
            }
        })();

        return false;
    }

    checkEditorPath() {
        try {
            if (this.checkFile(env.config.wePath)) {
                return true;
            }
        } catch (error) {}

        (async () => {
            const file = await this.selectPath('Warcraft : WorldEditor.exe is not set, to set?', 'WorldEditor.exe');
            if (file) {
                env.config.wePath = file;
            }
        })();

        return false;
    }

    check() {
        let ok = true;
        ok = this.checkGamePath() && ok;
        ok = this.checkEditorPath() && ok;
        return ok;
    }
}

export const checker = new Checker();
