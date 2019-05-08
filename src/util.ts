/**
 * @File   : util.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 6:05:31 PM
 */

import * as fs from "fs-extra";
import * as cp from "child_process";
import * as path from "path";

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

export function getDocumentFolder(): Promise<string | undefined> {
    return new Promise((resolve, reject) => {
        cp.exec(
            `reg query "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders" /v Personal`,
            (err, out) => {
                if (err) {
                    reject(err);
                } else {
                    let m = out.match(/Personal\s+REG_EXPAND_SZ\s+([^\r\n]+)/);
                    if (!m) {
                        resolve();
                    } else {
                        resolve(
                            m[1].replace(/%([^%]+)%/g, (_, x) => {
                                x = x.toLowerCase();
                                return env.has(x) ? env.get(x) : x;
                            })
                        );
                    }
                }
            }
        );
    });
}
