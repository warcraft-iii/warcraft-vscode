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
        const localVersion = this.readLocalVersion();
        const exeVersion = this.readExeVersion();
    }

    async execute() {
        await this.download();
    }

    readExeVersion() {
        return utils.execFile(env.asExetensionPath('bin/ObjEditing.exe'), ['-d']);
    }

    async readLocalVersion() {
        const versionFile = env.asRootPath('.def/.version');
        if (!(await fs.pathExists(versionFile))) {
            return;
        }
        return utils.readFile(versionFile);
    }

    async readRemoteVersions() {
        const tags = (await this.github.repos.listReleases({
            owner: 'warcraft-iii',
            repo: 'ObjEditingDefine'
        })).data;

        if (tags.length === 0) {
            return;
        }

        const tag = tags[0];
        return tag.zipball_url;
    }

    async pack() {
        await utils.execFile(env.asExetensionPath('bin/ObjEditing.exe'), [
            '-m',
            env.mapFolder,
            '-o',
            env.buildFolder,
            env.asRootPath('objediting/main.lua')
        ]);
    }

    async download() {
        const url = await this.readRemoteVersions();
        if (!url) {
            return;
        }

        await utils.downloadZip(url, entry => env.asRootPath('.def', entry.fileName.replace(/^[^/]+\//g, '')));
    }
}

export const objediting = new ObjEditing();
