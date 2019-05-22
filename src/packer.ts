/**
 * @File   : packer.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/21/2019, 10:33:43 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as utils from './utils';
import * as proc from './proc';

import { env } from './environment';
import { Report } from './report';
import { ENTRY_FILE, PACKLIST_FILE, DEBUG_MAP_FILE } from './globals';

type PackItem = [string, string];

export class Packer {
    async generatePackList() {
        const packList = [
            ...(await this.generatePackItems(env.mapFolder, file => !utils.isLuaFile(file))),
            ...(await this.generatePackItems(env.importsFolder)),
            [ENTRY_FILE, env.asBuildPath(ENTRY_FILE)]
        ];
        await fs.writeFile(env.asBuildPath(PACKLIST_FILE), JSON.stringify(packList));
    }

    async packByPackList() {
        await proc.execFile(env.asExetensionPath('bin/MopaqPack.exe'), [
            '-o',
            env.asBuildPath(DEBUG_MAP_FILE),
            env.asBuildPath(PACKLIST_FILE)
        ]);
    }

    @Report('Packing Map ...')
    async pack() {
        await this.generatePackList();
        await this.packByPackList();
    }

    private async generatePackItems(root: string, filter?: (file: string) => boolean) {
        if (!(await fs.pathExists(root)) || !(await fs.stat(root)).isDirectory()) {
            return [];
        }
        let files = await utils.getAllFiles(root);
        if (filter) {
            files = files.filter(filter);
        }
        return files.map(file => this.generatePackItem(file, root));
    }

    private generatePackItem(file: string, root: string): PackItem {
        return [path.relative(root, file), file];
    }
}
