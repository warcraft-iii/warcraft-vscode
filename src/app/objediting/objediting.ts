/**
 * @File   : objediting.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 7/16/2019, 2:42:02 PM
 */

import * as fs from 'fs-extra';
import * as Octokit from '@octokit/rest';

import * as utils from '../../utils';

import { env } from '../../env';
// import { globals } from '../../globals';

export class ObjEditing {
    private github = new Octokit();

    constructor() {
        this.checkDefine();
    }

    async checkDefine() {
        const localVersion = await this.readLocalVersion();
        const exeVersion = await this.readExeVersion();

        if (localVersion !== exeVersion) {
            this.updateDefine(exeVersion);
        }
    }

    async updateDefine(version: string) {
        const url = await this.getRemoteUrl(version);
        if (!url) {
            return;
        }
        await utils.downloadZip(url, entry => env.asRootPath('.def', entry.fileName.replace(/^[^/]+\//g, '')));
    }

    readExeVersion() {
        return utils.execFile(env.asExetensionPath('bin/ObjEditing.exe'), ['-d']);
    }

    async readLocalVersion() {
        const versionFile = env.asRootPath('.def/.version');
        if (!(await fs.pathExists(versionFile))) {
            return;
        }
        return await utils.readFile(versionFile);
    }

    async getRemoteUrl(version: string) {
        const tags = (await this.github.repos.listTags({
            owner: 'warcraft-iii',
            repo: 'ObjEditingDefine'
        })).data;

        for (const tag of tags) {
            if (tag.name === version) {
                return tag.zipball_url;
            }
        }
        return undefined;
    }

    async execute() {}

    async pack() {
        await utils.execFile(env.asExetensionPath('bin/ObjEditing.exe'), [
            '-m',
            env.mapFolder,
            '-o',
            env.buildFolder,
            env.asRootPath('objediting/main.lua')
        ]);
    }
}

export const objediting = new ObjEditing();
