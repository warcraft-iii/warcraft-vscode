/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 12:27:34 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as utils from '../utils';
import * as proc from '../proc';
import * as globals from '../globals';

import { env } from '../environment';
import { Report } from '../report';
import { Packer } from '../packer';

import { PackerType } from './packer';

type PackItem = [string, string];

export class DebugPacker implements Packer {
    type() {
        return PackerType.Debug;
    }

    async generatePackList() {
        const packList = [
            ...(await this.generatePackItems(env.mapFolder, file => !utils.isLuaFile(file))),
            ...(await this.generatePackItems(env.importsFolder)),
            [globals.ENTRY_FILE, env.asBuildPath(globals.ENTRY_FILE)]
        ];
        await fs.writeFile(env.asBuildPath(globals.PACKLIST_FILE), JSON.stringify(packList));
    }

    async packByPackList() {
        await proc.execFile(env.asExetensionPath('bin/MopaqPack.exe'), [
            '-o',
            env.asBuildPath(globals.DEBUG_MAP_FILE),
            env.asBuildPath(globals.PACKLIST_FILE)
        ]);
    }

    @Report('Packing Map ...')
    async execute() {
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

export const debugPacker = new DebugPacker();
