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
import * as helper from './helper';

import { env } from '../../env';
import { globals, localize, ConfigurationType } from '../../globals';

import { Compiler } from './compiler';

export class ReleaseCompiler implements Compiler {
    private file: any;
    private main: any;
    private touched = new Map<string, string>();

    constructor() {
        this.file = helper.readCompilerTemplate(ConfigurationType.Release, 'file.lua');
        this.main = helper.readCompilerTemplate(ConfigurationType.Release, 'main.lua');
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

        let body = await utils.readFile(file);
        const comment = helper.getCommentEqual(body);
        const required: { name: string; isRequire: boolean }[] = [];

        body = body
            .replace(/--@debug@/g, `--[${comment}[@debug@`)
            .replace(/--@end-debug@/g, `--@end-debug@]${comment}]`)
            .replace(/--@remove@/g, `--[${comment}[@remove@`)
            .replace(/--@end-remove@/g, `--@end-remove@]${comment}]`)
            .replace(/--\[=*\[@non-debug@/g, '--@non-debug')
            .replace(/--@end-debug\]=*\]/g, '--@end-debug');

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

        await this.processFiles([env.asSourcePath('main.lua'), env.asSourcePath('lib/init.lua')]);

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
