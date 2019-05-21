/**
 * @File   : packer.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/21/2019, 10:33:43 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';

import { getAllFiles, exec } from './util';
import { env } from './environment';
import { LUA, ENTRY_FILE, PACKLIST_FILE, DEBUG_MAP_FILE } from './globals';

export class Packer {
    async generateFileList() {
        const maps = (await getAllFiles(env.mapFolder))
            .filter(file => path.extname(file).toLowerCase() !== LUA)
            .map(file => [path.relative(env.mapFolder, file), file]);

        const imports = (await fs.pathExists(env.importsFolder))
            ? (await getAllFiles(env.importsFolder)).map(file => [path.relative(env.mapFolder, file), file])
            : [];

        const files = [...maps, ...imports, [ENTRY_FILE, env.asBuildPath(ENTRY_FILE)]];
        await fs.writeFile(env.asBuildPath(PACKLIST_FILE), JSON.stringify(files));
    }

    packByFileList() {
        return exec(env.asExetensionPath('bin/MopaqPack.exe'), [
            '-o',
            env.asBuildPath(DEBUG_MAP_FILE),
            env.asBuildPath(PACKLIST_FILE)
        ]);
    }

    async pack() {
        await this.generateFileList();
        await this.packByFileList();
    }
}
