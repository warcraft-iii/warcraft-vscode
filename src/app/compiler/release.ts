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

import { env } from '../../env';
import { globals, localize, ConfigurationType } from '../../globals';

import { BaseCompiler } from './compiler';
import { SimpleConfuser } from '../../utils/confuser';

interface RequireItem {
    file: string;
    name?: string;
    isRequire?: boolean;
}

type FileItem = RequireItem | string;

class ReleaseCompiler extends BaseCompiler {
    private files = new Map<string, string>();

    constructor() {
        super();
    }

    type() {
        return ConfigurationType.Release;
    }

    private convert(item: FileItem): RequireItem {
        return isString(item) ? { file: item } : item;
    }

    private getMaybeFiles(item: RequireItem) {
        if (item.isRequire) {
            const name = item.file
                .split('.')
                .filter(word => word !== '')
                .join('/');
            return env.config.lua.package.path.map(finder => env.asSourcePath(finder.replace('?', name)));
        } else {
            return [path.isAbsolute(item.file) ? item.file : env.asSourcePath(item.file)];
        }
    }

    private async resolveFile(item: RequireItem) {
        const files = this.getMaybeFiles(item);
        for (const file of files) {
            if (await fs.pathExists(file)) {
                return file;
            }
        }

        throw Error(localize('error.notFound', 'Not found {0}', item.file));
    }

    private async processFiles(...items: FileItem[]) {
        await Promise.all(
            items
                .map(item => this.convert(item))
                .map(async item => {
                    const file = await this.resolveFile(item);
                    const name = item.name || utils.posixCase(path.relative(env.sourceFolder, file));
                    if (this.files.has(name)) {
                        return;
                    }
                    const body = this.processCodeMacros(await utils.readFile(file));
                    if (this.files.has(name)) {
                        return;
                    }
                    const required: RequireItem[] = [];

                    const ast = luaparse.parse(body, {
                        locations: true,
                        ranges: true,
                        scope: true,
                        onCreateNode: node => {
                            let arg: luaparse.Expression;

                            if (
                                node.type === 'CallExpression' &&
                                node.base.type === 'Identifier' &&
                                this.isRequireFunction(node.base.name)
                            ) {
                                if (node.arguments.length !== 1) {
                                    return;
                                }
                                arg = node.arguments[0];
                            } else if (
                                node.type === 'StringCallExpression' &&
                                node.base.type === 'Identifier' &&
                                this.isRequireFunction(node.base.name)
                            ) {
                                arg = node.argument;
                            } else {
                                return;
                            }

                            if (arg.type !== 'StringLiteral') {
                                return;
                            }

                            required.push({
                                file: arg.value,
                                isRequire: node.base.name === 'require'
                            });
                        }
                    });

                    this.files.set(name, luamin.minify(ast));

                    await this.processFiles(...required);
                })
        );
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

        await this.processFiles(
            'main.lua',
            { name: 'origwar3map.lua', file: env.asMapPath(globals.FILE_ENTRY) },
            ...env.config.files
        );

        const code = [...this.files.entries()].map(([name, body]) => templates.release.file({ body, name })).join('\n');

        let out = templates.release.main({ code, package: env.config.lua.package });

        if (env.config.codeConfusion) {
            out = SimpleConfuser.parse(out);
        }

        out = luamin.minify(out);

        const outputPath = env.asBuildPath(globals.FILE_ENTRY);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);
    }
}

export const releaseCompiler = new ReleaseCompiler();
