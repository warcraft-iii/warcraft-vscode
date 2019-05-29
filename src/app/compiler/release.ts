/**
 * @File   : release.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/28/2019, 10:32:12 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as luaparse from 'luaparse';
import * as luamin from 'luamin';
import * as utils from '../../utils';

import { env } from '../../env';
import { globals, localize } from '../../globals';

import { Compiler, CompilerType } from './compiler';
import { readCompilerTemplate } from './private';

export class ReleaseCompiler implements Compiler {
    private file: any;
    private main: any;
    private touched = new Map<string, string>();

    constructor() {
        this.file = readCompilerTemplate(CompilerType.Release, 'file.lua');
        this.main = readCompilerTemplate(CompilerType.Release, 'main.lua');
    }

    type() {
        return CompilerType.Release;
    }

    async resolveFile(name: string) {
        const base = name.replace(/\./g, '/');

        const files = [env.asSourceFolder(base + globals.LUA), env.asSourceFolder(base + '/init' + globals.LUA)];

        for (const file of files) {
            if (await fs.pathExists(file)) {
                return file;
            }
        }

        throw new Error('not found');
    }

    async processFiles(files: string[]) {
        for (const file of files) {
            await this.processFile(file);
        }
    }

    async processFile(file: string) {
        file = path.resolve(file);

        if (this.touched.has(file)) {
            return;
        }

        const required: string[] = [];
        const code = (await utils.readFile(file))
            .replace(/--@debug@/g, '--[===[@debug')
            .replace(/--@end-debug/g, '--@end-debug]===]');

        this.touched.set(file, code);

        luaparse.parse(code, {
            locations: true,
            ranges: true,
            scope: true,
            onCreateNode: node => {
                if (node.type === 'CallExpression' && node.base.type === 'Identifier' && node.base.name === 'require') {
                    if (node.arguments.length !== 1) {
                        throw new Error('error');
                    }

                    const arg = node.arguments[0];
                    if (arg.type !== 'StringLiteral') {
                        console.error(node);
                        throw new Error(arg.type);
                    }

                    required.push(arg.value);
                }
            }
        });

        await this.processFiles(await Promise.all(required.map(item => this.resolveFile(item))));
    }

    async execute() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw Error(localize('error.noSrcFolder', 'Not found: source folder'));
        }

        this.touched.clear();

        await this.processFiles([env.asSourceFolder('main.lua'), env.asSourceFolder('lib/init.lua')]);

        const war3map = await utils.readFile(env.asMapPath(globals.ENTRY_FILE));
        const code = [...this.touched.entries()]
            .map(([file, body]) => this.file({ name: this.getRequireName(file), body }))
            .join('\n');

        const out = luamin.minify(this.main({ war3map, code }));
        const outputPath = env.asBuildPath(globals.ENTRY_FILE);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);
    }

    getRequireName(file: string) {
        return path
            .relative(env.sourceFolder, file)
            .replace(globals.LUA_REG, '')
            .replace(/[\\\/]+/g, '.');
    }
}

export const releaseCompiler = new ReleaseCompiler();
