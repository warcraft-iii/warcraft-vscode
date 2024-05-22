/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:19 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as luaparse from 'luaparse';
import * as luamin from 'luamin';

import { env } from '../../env';
import { ConfigurationType, globals, localize } from '../../globals';
import * as templates from '../../templates';
import * as utils from '../../utils';

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

        const files = [
            ...(await Promise.all(
                (await utils.getAllFiles(env.sourceFolder))
                    .filter((file) => !utils.isHiddenFile(file) && utils.isLuaFile(file))
                    .map((file) => this.genFile(file))
            )),
        ];

        if (!env.config.classic) {
            const scriptFile = await this.getOriginMapScript();
            files.push(await this.genFile(scriptFile, 'orig' + globals.FILE_ENTRY));
        }

        const code = files.join('\n');

        const out = templates.debug.main({
            code,
            package: env.config.lua.package,
            classic: env.config.classic,
        });
        const outputPath = env.asBuildPath(globals.FILE_ENTRY);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);

        if (env.config.classic) {
            await this.injectWar3mapJass();
        }
    }

    async genFile(file: string, name?: string) {
        let body = this.processCodeMacros(await utils.readFile(file));
        if (body.indexOf('compiletime') > 0) {
            await this.initLuaEngine();
            const ast = luaparse.parse(body, {
                locations: true,
                ranges: true,
                scope: true,
                onCreateNode: (node) => {
                    this.checkCompileTime(file, node);
                }
            });
            body = luamin.minify(ast);
        }
        const comment = this.getCommentEqual(body);
        if (!name) {
            name = utils.posixCase(path.relative(env.sourceFolder, file));
        }
        return templates.debug.file({ name, comment, body });
    }
}

export const debugCompiler = new DebugCompiler();
