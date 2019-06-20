/**
 * @File   : environment.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 11:18:19 AM
 */

import * as path from 'path';
import * as vscode from 'vscode';

import { Config } from './config';
import { globals, localize, ConfigurationType } from '../globals';

class Environment {
    private extensionFolder?: string;
    readonly config = new Config();

    constructor() {
        const extension = vscode.extensions.getExtension(globals.EXTENSION_ID);
        if (extension) {
            this.extensionFolder = extension.extensionPath;
        }
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
            return;
        }
        return vscode.workspace.workspaceFolders[0].uri.fsPath;
    }

    get sourceFolder() {
        return this.asRootPath(globals.FOLDER_SOURCE);
    }

    get mapFolder() {
        return this.asRootPath(this.config.mapDir);
    }

    get buildFolder() {
        return this.asRootPath(globals.FOLDER_BUILD);
    }

    get outFilePath() {
        const fileName =
            (this.config.configuration === ConfigurationType.Release
                ? globals.FILE_RELEASE_MAP
                : globals.FILE_DEBUG_MAP) + this.mapExtName;
        return this.asBuildPath(fileName);
    }

    get mapExtName() {
        return path.extname(this.config.mapDir);
    }
}

export const env = new Environment();
