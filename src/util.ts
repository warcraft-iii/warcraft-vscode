/**
 * @File   : util.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 6:05:31 PM
 */

import * as fs from "mz/fs";
import * as cp from "mz/child_process";
import * as path from "path";
import mkdirp from "mkdirp-promise";

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

type Env = Map<string, string>;

const env: Env = new Map(Object.keys(process.env).map(key => [key.toLowerCase(), process.env[key]])) as Env;

export async function getDocumentFolder() {
    let result = (await cp.exec(
        `reg query "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders" /v Personal`
    )).toString();

    let m = result.match(/Personal\s+REG_EXPAND_SZ\s+([^\r\n]+)/);
    if (!m) {
        return;
    }
    return m[1].replace(/%([^%]+)%/g, (_, x) => {
        x = x.toLowerCase();
        return env.has(x) ? env.get(x) : x;
    });
}

export function copyFile(from: string, to: string) {
    return new Promise((resolve, reject) => {
        fs.createReadStream(from)
            .pipe(fs.createWriteStream(to))
            .on("close", (err: any) => {
                if (err) {
                    reject(err);
                } else {
                    resolve();
                }
            });
    });
}

export async function copyFolder(from: string, to: string) {
    const stat = await fs.stat(to);
    if (stat && !stat.isDirectory()) {
        throw Error("target not a folder");
    }

    await mkdirp(to);
    await Promise.all(
        (await fs.readdir(from)).map(async file => {
            const source = path.join(from, file);
            const target = path.join(to, file);
            const stat = await fs.stat(source);

            if (stat.isDirectory()) {
                await copyFolder(source, target);
            } else {
                await copyFile(source, target);
            }
        })
    );
}
