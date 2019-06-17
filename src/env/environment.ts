/**
 * @File   : environment.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 11:18:19 AM
 */

import * as path from 'path';
import * as vscode from 'vscode';
import * as cp from 'child_process';

import { Config } from './config';
import { globals, localize } from '../globals';

class Environment {
    private extensionFolder?: string;
    private documentFolder?: string;

    readonly config = new Config();

    constructor() {
        this.initExtensionFolder();
        this.initDocumentFolder();
    }

    asExetensionPath(...args: string[]) {
        if (!this.extensionFolder) {
            throw Error(localize('error.noExtFolder', 'Not found: Extension Folder'));
        }
        return path.resolve(this.extensionFolder, ...args);
    }

    asMapPath(...args: string[]) {
        return path.resolve(this.mapFolder, ...args);
    }

    asBuildPath(...args: string[]) {
        return path.resolve(this.buildFolder, ...args);
    }

    asGamePath(...args: string[]) {
        return path.resolve(path.dirname(this.config.gamePath), ...args);
    }

    asDocumentPath(...args: string[]) {
        if (!this.documentFolder) {
            throw Error(localize('error.noDocFolder', 'Not found: My Documents'));
        }
        return path.resolve(this.documentFolder, ...args);
    }

    asRootPath(...args: string[]) {
        if (!this.rootPath) {
            throw Error(localize('error.notProject', 'Not Warcraft III project'));
        }
        return path.resolve(this.rootPath, ...args);
    }

    asSourcePath(...args: string[]) {
        return this.asRootPath(globals.FOLDER_SOURCE, ...args);
    }

    get rootPath() {
        if (!vscode.workspace.workspaceFolders) {
            return undefined;
        }
        return vscode.workspace.workspaceFolders[0].uri.fsPath;
    }

    get sourceFolder(): string {
        return this.asRootPath(globals.FOLDER_SOURCE);
    }

    get mapFolder(): string {
        return this.asRootPath(this.config.mapDir);
    }

    get buildFolder(): string {
        return this.asRootPath(globals.FOLDER_BUILD);
    }

    private initDocumentFolder() {
        const output = cp
            .execFileSync('reg', [
                'query',
                'HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders',
                '/v',
                'Personal'
            ])
            .toString();

        const m = output.match(/Personal\s+REG_EXPAND_SZ\s+([^\r\n]+)/);
        if (!m) {
            return;
        } else {
            type SysEnv = Map<string, string>;
            const sys = new Map(Object.keys(process.env).map(key => [key.toLowerCase(), process.env[key]])) as SysEnv;

            this.documentFolder = m[1].replace(/%([^%]+)%/g, (_, x) => {
                x = x.toLowerCase();
                return sys.has(x) ? sys.get(x) : x;
            });
        }
    }

    private initExtensionFolder() {
        const extension = vscode.extensions.getExtension(globals.EXTENSION_ID);
        if (extension) {
            this.extensionFolder = extension.extensionPath;
        }
    }
}

export const env = new Environment();
