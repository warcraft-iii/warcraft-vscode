/**
 * @File   : code.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 9:18:39 PM
 */

import * as path from "path";
import * as fs from "fs-extra";

import env from "./environment";

import { getAllFiles } from "./util";

const LUA = ".lua";
const LUA_REG = new RegExp(LUA + "$");

export async function compileDebug(from: string, to: string) {
    if (!(await fs.stat(from)).isDirectory()) {
        throw new Error("Not found source folder");
    }

    await fs.mkdirp(path.dirname(to));

    const output = fs.createWriteStream(to, { encoding: "utf-8" });
    const files = (await getAllFiles(from))
        .filter(file => !path.basename(file).startsWith(".") && !path.basename(file).startsWith("@"))
        .filter(file => path.extname(file).toLowerCase() === LUA);

    const pipe = (file: string) => {
        return new Promise((resolve, reject) => {
            fs.createReadStream(file, {
                encoding: "utf-8"
            })
                .on("close", (err: any) => (err ? reject(err) : resolve()))
                .pipe(
                    output,
                    { end: false }
                );
        });
    };
    const write = (chunk: string) => {
        return new Promise((resolve, reject) => {
            output.write(chunk, (err: any) => (err ? reject(err) : resolve()));
        });
    };

    await pipe(path.join(env.extensionFolder, "resources/debug.lua"));

    for (const file of files) {
        const name = path
            .relative(from, file)
            .replace(LUA_REG, "")
            .replace(/[\\\/]+/g, ".");

        await write(`_PRELOADED['${name}']=[==========[`);
        await pipe(file);
        await write("]==========]");
        await write("\n");
    }

    await write("require('war3map')");

    output.close();
}
