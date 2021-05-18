/**
 * @File   : objediting.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 7/16/2019, 2:42:02 PM
 */

import * as vscode from 'vscode';
import * as fs from 'fs-extra';
import * as yauzl from 'yauzl-promise';
import * as path from 'path';

import * as utils from '../../utils';

import { env } from '../../env';
import { globals } from '../../globals';

export class ObjEditing {
    constructor() {
        this.checkDefine();
    }

    async checkDefine() {
        if (!vscode.workspace.workspaceFolders || vscode.workspace.workspaceFolders.length > 1) {
            return;
        }

        const file = path.resolve(vscode.workspace.workspaceFolders[0].uri.fsPath, globals.FILE_PROJECT);
        if (!(await fs.pathExists(file))) {
            return;
        }

        const localVersion = await this.readProjectVersion();
        const projectVersion = await this.readCurrentVersion();

        if (localVersion !== projectVersion) {
            this.updateDefine();
        }
    }

    async updateDefine() {
        await utils.extractFile(
            await yauzl.fromBuffer(await fs.readFile(env.asExetensionPath('res/def.zip'))),
            env.asRootPath('.def')
        );
    }

    async readCurrentVersion() {
        const data = await fs.readJson(env.asExetensionPath('res/.version.json'));
        return (data && (data.def as string)) || '';
    }

    async readProjectVersion() {
        const versionFile = env.asRootPath('.def/.version');
        if (!(await fs.pathExists(versionFile))) {
            return;
        }
        return (await utils.readFile(versionFile)).trim();
    }

    async prepareObjectFiles() {
        const outDir = env.asBuildPath('objediting.source');
        await fs.emptyDir(outDir);
        const extensions = ['w3u', 'w3t', 'w3b', 'w3h', 'w3d', 'w3a', 'w3q'];

        for (const ext of extensions) {
            const file = 'war3map.' + ext;
            if (env.config.classic) {
                await utils.extractFileFromMap(path.join(outDir, file), file);
            } else {
                const p = path.join(env.mapFolder, file);
                if (await fs.pathExists(p)) {
                    await fs.copy(p, path.join(outDir, file));
                }
            }
        }

        return outDir;
    }

    async execute() {
        const lua = env.asRootPath('objediting/main.lua');
        if (!(await fs.pathExists(lua))) {
            return;
        }
        await env.checkMapFolder();
        const outDir = env.asBuildPath('objediting');
        await fs.emptyDir(outDir);
        const sourceDir = await this.prepareObjectFiles();
        await utils.execFile(env.asExetensionPath('bin/ObjEditing.exe'), ['-m', sourceDir, '-o', outDir, lua]);
    }
}

export const objediting = new ObjEditing();
