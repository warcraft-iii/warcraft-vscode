/**
 * @File   : runner.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 10:44:57 AM
 */

import * as path from "path";
import * as fs from "fs-extra";
import * as cp from "child_process";
import * as util from "./util";
import env from "./environment";

export async function runGame(map: string) {
    const docFolder = await util.getDocumentFolder();
    if (!docFolder) {
        throw new Error("Not found documents folder");
    }

    const isPtr = await fs.pathExists(
        path.join(path.dirname(env.gamePath), "../Warcraft III Public Test Launcher.exe")
    );
    const mapFolder = path.join(docFolder, isPtr ? "Warcraft III Public Test" : "Warcraft III", "Maps");
    const target = path.join(mapFolder, "Test", path.basename(map));

    await fs.copy(map, target);

    cp.spawn(env.gamePath, [...env.gameArgs, "-loadfile", path.relative(mapFolder, target)], {
        detached: true
    });
}

export async function runWorldEditor() {
    cp.spawn(env.wePath, [...env.weArgs, "-loadfile", env.mapFolder], {
        detached: true
    });
}
