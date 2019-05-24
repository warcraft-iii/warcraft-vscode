/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:19 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as utils from '../utils';
import * as globals from '../globals';

import { env } from '../env';

import { report } from '../report';

import { Compiler, CompilerType } from './compiler';
import { readCompilerTemplate } from './private';
import { Errors } from '../errors';

export class DebugCompiler implements Compiler {
    private main: any;
    private file: any;

    constructor() {
        this.main = readCompilerTemplate(CompilerType.Debug, 'main.lua');
        this.file = readCompilerTemplate(CompilerType.Debug, 'file.lua');
    }

    type() {
        return CompilerType.Debug;
    }

    @report('Compiling Scripts ...')
    async execute() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw Error(Errors.NotFoundSource);
        }

        const outputPath = env.asBuildPath(globals.ENTRY_FILE);
        await fs.mkdirp(path.dirname(outputPath));

        const war3map = await utils.readFile(env.asMapPath(globals.ENTRY_FILE));
        const code = (await Promise.all(
            (await utils.getAllFiles(env.sourceFolder))
                .filter(file => !utils.isHiddenFile(file) && utils.isLuaFile(file))
                .map(async file => {
                    const body = await utils.readFile(file);
                    const comment = this.getCommentExpr(body);
                    const name = this.getRequireName(file);
                    return this.file({ name, comment, body });
                })
        )).join('\n\n');

        const out = this.main({ war3map, code });
        await fs.writeFile(outputPath, out);
    }

    getCommentExpr(code: string) {
        const m = code.match(/\[(=*)\[|\](=*)\]/g);
        const exists = new Set(m ? m.map(x => x.length - 2) : []);

        let length = 0;
        while (exists.has(length)) {
            length++;
        }
        return '='.repeat(length);
    }

    getRequireName(file: string) {
        return path
            .relative(env.sourceFolder, file)
            .replace(globals.LUA_REG, '')
            .replace(/[\\\/]+/g, '.');
    }
}

export const debugCompiler = new DebugCompiler();
