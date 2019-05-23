/**
 * @File   : environment.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 11:18:19 AM
 */

import * as path from 'path';
import * as vscode from 'vscode';
import * as proc from './proc';

import { Config } from './config';

const FOLDER_BUILD = '.build';
const FOLDER_IMPORTS = 'imports';

class Environment {
    private context?: vscode.ExtensionContext;
    private documentFolder?: string;

    readonly config = new Config();

    async init(context: vscode.ExtensionContext) {
        this.context = context;
        await this.initDocumentFolder();
        await this.config.init();
    }

    asExetensionPath(...args: string[]) {
        return path.join(this.extensionFolder, ...args);
    }

    asMapPath(...args: string[]) {
        return path.join(this.mapFolder, ...args);
    }

    asBuildPath(...args: string[]) {
        return path.join(this.buildFolder, ...args);
    }

    asGamePath(...args: string[]) {
        return path.join(path.dirname(this.config.gamePath), ...args);
    }

    asDocumentPath(...args: string[]) {
        if (!this.documentFolder) {
            throw new Error('Not found documents folder');
        }
        return path.join(this.documentFolder, ...args);
    }

    get extensionFolder() {
        return this.context ? this.context.extensionPath : '';
    }

    get rootPath() {
        if (!vscode.workspace.workspaceFolders) {
            throw Error('Not warcraft III map project');
        }
        return vscode.workspace.workspaceFolders[0].uri.fsPath;
    }

    get sourceFolder(): string {
        return path.join(this.rootPath, this.config.sourceDir);
    }

    get mapFolder(): string {
        return path.join(this.rootPath, this.config.mapDir);
    }

    get buildFolder(): string {
        return path.join(this.rootPath, FOLDER_BUILD);
    }

    get importsFolder(): string {
        return path.join(this.rootPath, FOLDER_IMPORTS);
    }

    private async initDocumentFolder() {
        const output = await proc.execFile('reg', [
            'query',
            'HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders',
            '/v',
            'Personal'
        ]);

        const m = output.match(/Personal\s+REG_EXPAND_SZ\s+([^\r\n]+)/);
        if (!m) {
            throw new Error('Not found documents folder');
        } else {
            type SysEnv = Map<string, string>;
            const sys = new Map(Object.keys(process.env).map(key => [key.toLowerCase(), process.env[key]])) as SysEnv;

            this.documentFolder = m[1].replace(/%([^%]+)%/g, (_, x) => {
                x = x.toLowerCase();
                return sys.has(x) ? sys.get(x) : x;
            });
        }
    }
}

export const env = new Environment();
