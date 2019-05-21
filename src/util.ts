/**
 * @File   : util.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 6:05:31 PM
 */

import * as fs from 'fs-extra';
import * as path from 'path';

async function _getAllFiles(root: string, r: string[]) {
    const files = (await fs.readdir(root)).map(file => path.join(root, file));

    for (const file of files) {
        const stat = await fs.stat(file);

        if (stat.isFile()) {
            r.push(file);
        } else if (stat.isDirectory()) {
            await _getAllFiles(file, r);
        }
    }
    return r;
}

export function getAllFiles(root: string) {
    return _getAllFiles(root, []);
}

export function sleep(n: number): Promise<void> {
    return new Promise(resolve => setTimeout(() => resolve(), n));
}
