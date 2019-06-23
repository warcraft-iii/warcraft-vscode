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
import * as templates from '../../templates';

import isString from 'lodash-es/isString';
import memoize from 'lodash-es/memoize';

import { env } from '../../env';
import { globals, localize, ConfigurationType } from '../../globals';

import { BaseCompiler } from './compiler';

interface RequireItem {
    name: string;
    isRequire?: boolean;
}

type FileItem = RequireItem | string;

class ReleaseCompiler extends BaseCompiler {
    private files = new Map<string, string>();

    constructor() {
        super();

        this.resolveFile = memoize(this.resolveFile.bind(this));
    }

    type() {
        return ConfigurationType.Release;
    }

    private async resolveFile(item: FileItem) {
        let files: string[];

        if (isString(item)) {
            files = [env.asSourcePath(item)];
        } else if (!item.isRequire) {
            files = [env.asBuildPath(item.name)];
        } else {
            const base = item.name.replace(/\./g, '/');
            files = [env.asSourcePath(base + globals.LUA), env.asSourcePath(base, 'init' + globals.LUA)];
        }

        for (const file of files) {
            if (await fs.pathExists(file)) {
                return file;
            }
        }

        throw Error('not found');
    }

    private async processFiles(items: FileItem[]) {
        const files = (await Promise.all(items.map(item => this.resolveFile(item)))).filter(
            file => !this.files.has(file)
        );

        for (const file of files) {
            const body = this.processCodeMacros(await utils.readFile(file));
            const required: { name: string; isRequire: boolean }[] = [];

            const ast = luaparse.parse(body, {
                locations: true,
                ranges: true,
                scope: true,
                onCreateNode: node => {
                    if (node.type === 'CallExpression' && node.base.type === 'Identifier') {
                        if (this.isRequireFunction(node.base.name)) {
                            if (node.arguments.length !== 1) {
                                return;
                            }
                            const arg = node.arguments[0];
                            if (arg.type !== 'StringLiteral') {
                                return;
                            }
                            required.push({
                                name: arg.value,
                                isRequire: node.base.name === 'require'
                            });
                        }
                    }
                }
            });

            this.files.set(file, luamin.minify(ast));

            await this.processFiles(required);
        }
    }

    private isRequireFunction(name: string) {
        switch (name) {
            case 'require':
            case 'dofile':
            case 'loadfile':
                return true;
            default:
                return false;
        }
    }

    @utils.report(localize('report.compile', 'Compiling script'))
    async execute() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw Error(localize('error.noSrcFolder', 'Not found: source folder'));
        }

        this.files.clear();

        await this.processFiles(['main.lua', ...env.config.files]);

        const war3map = await utils.readFile(env.asMapPath(globals.FILE_ENTRY));
        const code = [...this.files.entries()]
            .map(([file, body]) =>
                templates.release.file({ name: utils.posixCase(path.relative(env.sourceFolder, file)), body })
            )
            .join('\n');

        const out = luamin.minify(templates.release.main({ war3map, code }));
        const outputPath = env.asBuildPath(globals.FILE_ENTRY);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);
    }
}

export const releaseCompiler = new ReleaseCompiler();
