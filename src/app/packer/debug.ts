/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 12:27:34 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as utils from '../../utils';

import { env } from '../../env';
import { globals, localize, ConfigurationType } from '../../globals';

import { Packer } from './packer';

type PackItem = [string, string];

export class DebugPacker implements Packer {
    type() {
        return ConfigurationType.Debug;
    }

    async generatePackList() {
        const packList: PackItem[] = [];
        const imports = (await fs.readdir(env.asSourcePath(globals.FOLDER_LIBRARIES))).map(f =>
            env.asSourcePath(globals.FOLDER_LIBRARIES, f, globals.FOLDER_IMPORTS)
        );

        packList.push([globals.FILE_ENTRY, env.asBuildPath(globals.FILE_ENTRY)]);
        packList.push(...(await this.generatePackItems(env.mapFolder, file => !utils.isLuaFile(file))));
        packList.push(...(await this.generatePackItems(env.asRootPath(globals.FOLDER_IMPORTS))));

        for (const folder of imports) {
            packList.push(...(await this.generatePackItems(folder)));
        }
        await fs.writeFile(env.asBuildPath(globals.FILE_PACKLIST), JSON.stringify(packList));
    }

    async packByPackList() {
        await utils.execFile(env.asExetensionPath('bin/MopaqPack.exe'), [
            '-o',
            env.asBuildPath(globals.FILE_DEBUG_MAP),
            env.asBuildPath(globals.FILE_PACKLIST)
        ]);
    }

    @utils.report(localize('report.pack', 'Packing map'))
    async execute() {
        await this.generatePackList();
        await this.packByPackList();
    }

    private async generatePackItems(root: string, filter?: (file: string) => boolean) {
        if (!(await fs.pathExists(root)) || !(await fs.stat(root)).isDirectory()) {
            return [];
        }
        let files = (await utils.getAllFiles(root)).filter(file => !utils.isHiddenFile(file));
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
