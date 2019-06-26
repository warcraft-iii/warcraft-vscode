/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:19 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as utils from '../../utils';
import * as templates from '../../templates';

import { env } from '../../env';
import { globals, localize, ConfigurationType } from '../../globals';

import { BaseCompiler } from './compiler';

class DebugCompiler extends BaseCompiler {
    constructor() {
        super();
    }

    type() {
        return ConfigurationType.Debug;
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
                    const body = this.processCodeMacros(await utils.readFile(file));
                    const comment = this.getCommentEqual(body);
                    const name = utils.posixCase(path.relative(env.sourceFolder, file));

                    return templates.debug.file({ name, comment, body });
                })
        )).join('\n\n');

        const out = templates.debug.main({ war3map, code, package: env.config.lua.package });
        const outputPath = env.asBuildPath(globals.FILE_ENTRY);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);
    }
}

export const debugCompiler = new DebugCompiler();
