/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:19 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as utils from '../../utils';
import * as helper from './helper';

import { env } from '../../env';
import { globals, localize } from '../../globals';

import { Compiler, CompilerType } from './compiler';

export class DebugCompiler implements Compiler {
    private main: any;
    private file: any;

    constructor() {
        this.main = helper.readCompilerTemplate(CompilerType.Debug, 'main.lua');
        this.file = helper.readCompilerTemplate(CompilerType.Debug, 'file.lua');
    }

    type() {
        return CompilerType.Debug;
    }

    @utils.report(localize('report.compile', 'Compiling script'))
    async execute() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw Error(localize('error.noSrcFolder', 'Not found: source folder'));
        }

        const war3map = await utils.readFile(env.asMapPath(globals.FILE_ENTRY));
        const code = (await Promise.all(
            (await utils.getAllFiles(env.sourceFolder))
                .filter(file => !utils.isHiddenFile(file) && utils.isLuaFile(file))
                .map(async file => {
                    let body = await utils.readFile(file);
                    const comment = helper.getCommentEqual(body);
                    const name = utils.posixCase(path.relative(env.sourceFolder, file));

                    body = body
                        .trim()
                        .replace(/--@remove@/g, `--[${comment}[@remove@`)
                        .replace(/--@end-remove@/g, `--@end-remove@]${comment}]`);

                    return this.file({ name, comment, body });
                })
        )).join('\n\n');

        const out = this.main({ war3map, code });
        const outputPath = env.asBuildPath(globals.FILE_ENTRY);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);
    }
}

export const debugCompiler = new DebugCompiler();
