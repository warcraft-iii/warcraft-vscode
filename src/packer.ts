/**
 * @File   : packer.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/21/2019, 10:33:43 PM
 */

// import * as cp from 'child_process';
import * as path from 'path';
import * as fs from 'fs-extra';

import { getAllFiles } from './util';
import { env } from './environment';
import { LUA } from './globals';

export class Packer {
    async pack() {
        const files = (await getAllFiles(env.mapFolder))
            .filter(file => path.extname(file).toLowerCase() !== LUA)
            .map(file => {
                const rel = path.relative(env.mapFolder, file).replace(/[\\\/]/g, '/');

                return [rel, file];
            });

        await fs.writeFile(env.asBuildPath('packlist.json'), JSON.stringify(files));
    }
}
