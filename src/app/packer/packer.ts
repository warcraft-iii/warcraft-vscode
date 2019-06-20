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

type PackItem = [string, string];

class Packer {
    private _type: ConfigurationType;

    constructor(type: ConfigurationType) {
        this._type = type;
    }

    type() {
        return this._type;
    }

    async generatePackList() {
        const packList: PackItem[] = [];
        const libs = await fs.readdir(env.asSourcePath(globals.FOLDER_LIBRARIES));

        packList.push([globals.FILE_ENTRY, env.asBuildPath(globals.FILE_ENTRY)]);
        packList.push(...(await this.generatePackItems(env.mapFolder, file => !utils.isLuaFile(file))));
        packList.push(...(await this.generatePackItems(env.asRootPath(globals.FOLDER_IMPORTS))));

        for (const lib of libs) {
            packList.push(
                ...(await this.generatePackItems(
                    env.asSourcePath(globals.FOLDER_LIBRARIES, lib, globals.FOLDER_IMPORTS)
                )),
                ...(await this.generatePackItems(
                    env.asSourcePath(
                        globals.FOLDER_LIBRARIES,
                        lib,
                        `${globals.FOLDER_IMPORTS}.${ConfigurationType[this.type()].toLowerCase()}`
                    )
                ))
            );
        }
        await fs.writeFile(env.asBuildPath(globals.FILE_PACKLIST), JSON.stringify(packList));
    }

    async packByPackList() {
        const args: string[] = [];

        if (this.type() === ConfigurationType.Debug) {
            args.push('-f', '1');
        }

        args.push('-o', env.outFilePath, env.asBuildPath(globals.FILE_PACKLIST));

        await utils.execFile(env.asExetensionPath('bin/MopaqPack.exe'), args);
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

export const debugPacker = new Packer(ConfigurationType.Debug);
export const releasePacker = new Packer(ConfigurationType.Release);
