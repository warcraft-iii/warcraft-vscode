/**
 * @File   : config.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 12:57:32 PM
 */
import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs-extra';
import * as globals from '../globals';
import { Errors } from '../error';

interface WarcraftJson {
    mapdir?: string;
}

export class Config {
    private projectConfig: WarcraftJson = {};

    async init() {
        if (vscode.workspace.workspaceFolders) {
            this.reload();
        }
    }

    reload() {
        this.projectConfig = {};

        if (!vscode.workspace.workspaceFolders) {
            return;
        }

        const file = path.join(vscode.workspace.workspaceFolders[0].uri.fsPath, globals.PROJECT_FILE);

        if (!fs.pathExistsSync(file)) {
            return;
        }

        if (!fs.statSync(file).isFile()) {
            return;
        }

        const content = fs.readJsonSync(file);
        if (!content || typeof content !== 'object') {
            return;
        }

        this.projectConfig = content as WarcraftJson;
    }

    private get config() {
        return vscode.workspace.getConfiguration('warcraft');
    }

    get gamePath() {
        const value = this.config.get<string>('gamePath');
        if (!value) {
            throw Error(Errors.NotFoundGame);
        }
        return value;
    }

    set gamePath(value: string) {
        this.config.update('gamePath', value, vscode.ConfigurationTarget.Global);
    }

    get wePath() {
        const value = this.config.get<string>('wePath');
        if (!value) {
            throw Error(Errors.NotFoundEditor);
        }
        return value;
    }

    set wePath(value: string) {
        this.config.update('wePath', value, vscode.ConfigurationTarget.Global);
    }

    get gameArgs() {
        return this.config.get<string[]>('gameArgs') || [];
    }

    get weArgs() {
        return this.config.get<string[]>('weArgs') || [];
    }

    get autoCloseClient() {
        return this.config.get<boolean>('autoCloseClient') || false;
    }

    set autoCloseClient(value: boolean) {
        this.config.update('autoCloseClient', value, vscode.ConfigurationTarget.Global);
    }

    get mapDir() {
        if (!this.projectConfig.mapdir) {
            throw Error(Errors.NotFoundMap);
        }
        return this.projectConfig.mapdir;
    }

    set mapDir(value: string) {
        if (!vscode.workspace.workspaceFolders) {
            return;
        }

        const rootPath = vscode.workspace.workspaceFolders[0].uri.fsPath;

        fs.writeJSON(path.join(rootPath, globals.PROJECT_FILE), this.projectConfig);

        this.projectConfig.mapdir = value;
    }
}
