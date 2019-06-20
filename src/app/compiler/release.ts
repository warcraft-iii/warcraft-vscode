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

import template from 'lodash-es/template';

import { env } from '../../env';
import { globals, localize, ConfigurationType } from '../../globals';

import { BaseCompiler } from './compiler';
import { templates } from '../../templates';

class ReleaseCompiler extends BaseCompiler {
    private main = template(templates.release.main);
    private file = template(templates.release.file);

    private touched = new Map<string, string>();

    constructor() {
        super();
    }

    type() {
        return ConfigurationType.Release;
    }

    private async resolveFile(item: { name: string; isRequire: boolean }) {
        let files: string[];

        if (item.isRequire) {
            const base = item.name.replace(/\./g, '/');
            files = [env.asSourcePath(base + globals.LUA), env.asSourcePath(base, 'init' + globals.LUA)];
        } else {
            files = [env.asSourcePath(item.name)];
        }

        for (const file of files) {
            if (await fs.pathExists(file)) {
                return file;
            }
        }

        throw Error('not found');
    }

    private async processFiles(files: string[]) {
        for (const file of files) {
            await this.processFile(file);
        }
    }

    private async processFile(file: string) {
        file = path.resolve(file);

        if (this.touched.has(file)) {
            return;
        }

        const body = this.processCodeMacros(await utils.readFile(file));
        const required: { name: string; isRequire: boolean }[] = [];

        this.touched.set(file, body);

        luaparse.parse(body, {
            locations: true,
            ranges: true,
            scope: true,
            onCreateNode: node => {
                if (node.type === 'CallExpression' && node.base.type === 'Identifier') {
                    if (node.base.name === 'require' || node.base.name === 'dofile' || node.base.name === 'loadfile') {
                        if (node.arguments.length !== 1) {
                            throw Error('error');
                        }

                        const arg = node.arguments[0];
                        if (arg.type !== 'StringLiteral') {
                            console.error(node);
                            throw Error(arg.type);
                        }

                        required.push({
                            name: arg.value,
                            isRequire: node.base.name === 'require'
                        });
                    }
                }
            }
        });

        await this.processFiles(await Promise.all(required.map(item => this.resolveFile(item))));
    }

    @utils.report(localize('report.compile', 'Compiling script'))
    async execute() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw Error(localize('error.noSrcFolder', 'Not found: source folder'));
        }

        this.touched.clear();

        await this.processFiles([env.asSourcePath('main.lua')]);

        const war3map = await utils.readFile(env.asMapPath(globals.FILE_ENTRY));
        const code = [...this.touched.entries()]
            .map(([file, body]) => this.file({ name: utils.posixCase(path.relative(env.sourceFolder, file)), body }))
            .join('\n');

        const out = luamin.minify(this.main({ war3map, code }));
        const outputPath = env.asBuildPath(globals.FILE_ENTRY);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);
    }
}

export const releaseCompiler = new ReleaseCompiler();
