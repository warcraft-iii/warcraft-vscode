/**
 * @File   : runner.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 10:44:57 AM
 */

import * as path from "path";
import * as cp from "mz/child_process";
import * as util from "./util";
import mkdirp from "mkdirp-promise";
import config from "./config";

export async function runGame() {
    const docFolder = await util.getDocumentFolder();
    if (!docFolder) {
        throw new Error("Not found documents folder");
    }

    const mapFolder = path.join(docFolder, "Warcraft III/Maps");
    const target = path.join(mapFolder, "Test", path.basename(config.mapPath));

    await mkdirp(path.dirname(target));
    await util.copyFile(config.mapPath, target);

    cp.spawn(config.gamePath, [...config.gameArgs, "-loadfile", path.relative(mapFolder, target)], {
        detached: true
    });
}

export function runWorldEditor() {
    cp.spawn(config.wePath, [...config.weArgs, "-loadfile", config.mapFolder], {
        detached: true
    });
}
