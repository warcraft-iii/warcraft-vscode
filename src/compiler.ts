/**
 * @File   : compiler.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/21/2019, 9:34:28 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';

import { template, templateSettings, TemplateExecutor } from 'lodash';
import { env } from './environment';
import { getAllFiles } from './util';
import { LUA, LUA_REG } from './globals';

export enum CompileType {
    Debug,
    Release
}

export class Compiler {
    private executors = new Map<CompileType, TemplateExecutor>();

    constructor() {
        templateSettings.interpolate = /\-\-\[\[%\=([\s\S]+?)%\]\]/g;
    }

    async init() {
        this.executors.set(
            CompileType.Debug,
            template(await fs.readFile(env.asExetensionPath('templates/debug.lua'), { encoding: 'utf-8' }))
        );
    }

    async debug() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw new Error('Not found source folder');
        }

        await fs.mkdirp(path.dirname(env.tempScriptPath));

        const executor = this.executors.get(CompileType.Debug);
        if (!executor) {
            throw new Error('template not exists');
        }

        const war3map = await fs.readFile(env.asMapPath('war3map.lua'), { encoding: 'utf-8' });
        const code = (await Promise.all(
            (await getAllFiles(env.sourceFolder))
                .filter(file => !path.basename(file).startsWith('.') && !path.basename(file).startsWith('@'))
                .filter(file => path.extname(file).toLowerCase() === LUA)
                .map(async file => {
                    const body = await fs.readFile(file, { encoding: 'utf-8' });
                    const comment = this.getCommentExpr(body);
                    const name = this.getRequireName(file);
                    return `_PRELOADED['${name}'] = [${comment}[${body}]${comment}]`;
                })
        )).join('\n\n');

        const out = executor({ war3map, code });
        await fs.writeFile(env.asBuildPath('war3map.lua'), out);
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
            .replace(LUA_REG, '')
            .replace(/[\\\/]+/g, '.');
    }
}
