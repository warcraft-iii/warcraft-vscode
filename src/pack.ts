/**
 * @File   : pack.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/19/2019, 1:22:22 AM
 */

import * as path from "path";
import * as cp from "child_process";

export function pack(from: string, to: string): Promise<void> {
    return new Promise((resolve, reject) => {
        const exec = path.join(__dirname, "../bin/MopaqPack.exe");

        const p = cp.spawn(exec, ["-o", to, from]);
        const chunks: any[] = [];
        p.stdout.on("data", chunk => {
            chunks.push(chunk.toString());
        });
        p.on("close", code => {
            if (code !== 0) {
                reject(new Error(chunks.join()));
            } else {
                resolve();
            }
        });
    });
}
