/**
 * @File   : compiler.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/21/2019, 9:34:28 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as utils from './utils';

import { template, templateSettings, TemplateExecutor } from 'lodash';

import { env } from './environment';
import { LUA_REG, ENTRY_FILE } from './globals';

interface CompilerTemplate {
    main: TemplateExecutor;
    file: TemplateExecutor;
}

export enum CompileType {
    Debug,
    Release
}

export class Compiler {
    private executors = new Map<CompileType, CompilerTemplate>();

    constructor() {
        templateSettings.interpolate = /\-\-\[\[%\=([\s\S]+?)%\]\]/g;
        templateSettings.evaluate = /\-\-\[\[%\>([\s\S]+?)%\]\]/g;
    }

    async init() {
        await this.loadTemplate(CompileType.Debug);
    }

    async debug() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw new Error('Not found source folder');
        }

        const outputPath = env.asBuildPath(ENTRY_FILE);
        await fs.mkdirp(path.dirname(outputPath));

        const executor = this.executors.get(CompileType.Debug);
        if (!executor) {
            throw new Error('template not exists');
        }

        const war3map = await fs.readFile(env.asMapPath(ENTRY_FILE), { encoding: 'utf-8' });
        const code = (await Promise.all(
            (await utils.getAllFiles(env.sourceFolder))
                .filter(file => !utils.isHiddenFile(file) && utils.isLuaFile(file))
                .map(async file => {
                    const body = await fs.readFile(file, { encoding: 'utf-8' });
                    const comment = this.getCommentExpr(body);
                    const name = this.getRequireName(file);
                    return executor.file({ name, comment, body });
                })
        )).join('\n\n');

        const out = executor.main({ war3map, code });
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
            .replace(LUA_REG, '')
            .replace(/[\\\/]+/g, '.');
    }

    private async loadTemplate(compileType: CompileType) {
        this.executors.set(compileType, {
            main: await this.readTemplate(compileType, 'main.lua'),
            file: await this.readTemplate(compileType, 'file.lua')
        });
    }

    private async readTemplate(compileType: CompileType, file: string) {
        return template(
            (await utils.readFile(
                env.asExetensionPath('templates', CompileType[compileType].toLowerCase(), file)
            )).trim()
        );
    }
}
