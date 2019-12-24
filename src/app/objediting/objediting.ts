/**
 * @File   : objediting.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 7/16/2019, 2:42:02 PM
 */

import * as vscode from 'vscode';
import * as fs from 'fs-extra';
import * as yauzl from 'yauzl-promise';

import * as utils from '../../utils';

import { env } from '../../env';

export class ObjEditing {
    constructor() {
        this.checkDefine();
    }

    async checkDefine() {
        if (!vscode.workspace.workspaceFolders || vscode.workspace.workspaceFolders.length > 1) {
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

    async execute() {
        const outDir = env.asBuildPath('objediting');
        await fs.emptyDir(outDir);
        await utils.execFile(env.asExetensionPath('bin/ObjEditing.exe'), [
            '-m',
            env.mapFolder,
            '-o',
            outDir,
            env.asRootPath('objediting/main.lua')
        ]);
    }
}

export const objediting = new ObjEditing();
