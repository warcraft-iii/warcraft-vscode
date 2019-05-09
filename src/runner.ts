/**
 * @File   : runner.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 10:44:57 AM
 */

import * as path from "path";
import * as fs from "fs-extra";

import { Process } from "./process";

import env from "./environment";

export async function runGame(map: string) {
    if (!env.documentFolder) {
        throw new Error("Not found documents folder");
    }

    const isPtr = await fs.pathExists(
        path.join(path.dirname(env.gamePath), "../Warcraft III Public Test Launcher.exe")
    );
    const mapFolder = path.join(env.documentFolder, isPtr ? "Warcraft III Public Test" : "Warcraft III", "Maps");
    const target = path.join(mapFolder, "Test", path.basename(map));

    await fs.copy(map, target);

    return new Process(env.gamePath, [...env.gameArgs, "-loadfile", path.relative(mapFolder, target)]);
}

export async function runWorldEditor() {
    return new Process(env.wePath, [...env.weArgs, "-loadfile", env.mapFolder]);
}
