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
import { SubModulesConfig } from '../../env/config';

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

    private getMaybeFiles(item: RequireItem, relativePath: string) {
        if (item.isRequire) {
            const name = item.file
                .split('.')
                .filter((word) => word !== '')
                .join('/');
            return env.config.lua.package.path.map((finder) => path.resolve(relativePath, finder.replace('?', name)));
        } else {
            return [path.isAbsolute(item.file) ? item.file : path.resolve(relativePath, item.file)];
        }
    }

    private async resolveFile(item: RequireItem, relativePath: string): Promise<[string, boolean]> {
        let files = this.getMaybeFiles(item, relativePath);
        for (const file of files) {
            if (await fs.pathExists(file)) {
                return [file, false];
            }
        }
        files = this.getMaybeFiles(item, env.sourceFolder);
        for (const file of files) {
            if (await fs.pathExists(file)) {
                return [file, true];
            }
        }

        if (!env.config.classic) {
            throw Error(localize('error.notFound', 'Not found {0}', item.file));
        }

        // classic allow use inner package, likes jass.xxxx
        return ['', false];
    }

    private async processFiles(relativePath: string, ...items: FileItem[]) {
        const itemsList = items.map((item) => this.convert(item));

        for (const item of itemsList) {
            try {
                const [file, isSource] = await this.resolveFile(item, relativePath);
                if (file.length === 0) {
                    continue;
                }
                const name =
                    item.name || utils.posixCase(path.relative(isSource ? env.sourceFolder : relativePath, file));
                if (this.files.has(name)) {
                    continue;
                }
                const body = this.processCodeMacros(await utils.readFile(file)); //lua comment
                if (this.files.has(name)) {
                    continue;
                }
                const required: RequireItem[] = [];

                const ast = luaparse.parse(body, {
                    locations: true,
                    ranges: true,
                    scope: true,
                    onCreateNode: (node) => {
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
                            isRequire: node.base.name === 'require',
                        });
                    },
                });

                this.files.set(name, luamin.minify(ast));

                await this.processFiles(relativePath, ...required);
            } catch (error) {
                throw Error(
                    localize(
                        'error.processFilesFailure',
                        ['Item: ' + item.file, 'Error: ' + error.message, 'Stack: ' + error.stack].join('\n')
                    )
                );
            }
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

        await this.processFiles(env.sourceFolder, 'main.lua', ...env.config.files);

        if (!env.config.classic) {
            await this.processFiles(env.sourceFolder, {
                name: 'origwar3map.lua',
                file: env.asMapPath(globals.FILE_ENTRY),
            });
        }

        const code = [...this.files.entries()].map(([name, body]) => templates.release.file({ body, name })).join('\n');

        let out = templates.release.main({
            code,
            package: env.config.lua.package,
            classic: env.config.classic,
            version: env.version,
            id: 0,
        });

        if (env.config.codeConfusion) {
            out = luamin.minify(SimpleConfuser.parse(out));
        } else {
            out = luamin.minify(out);
        }

        const outputPath = env.asBuildPath(globals.FILE_ENTRY);
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);

        if (env.config.classic) {
            await this.injectWar3mapJass('', path.resolve(env.rootPath || '', env.mapDir));
        }

        await this.packSubMoudles();
    }

    async packSubMoudles() {
        const rootPath = path.resolve(env.rootPath || '', globals.FOLADER_MODULES);
        const modules: SubModulesConfig[] = env.submodules || [];
        for (let module of modules) {
            const mpath = path.resolve(rootPath, module.path);
            if (!module.luacopy) {
                this.files.clear();
                await this.processFiles(mpath, 'main.lua');
                // if (!env.config.classic) {
                //     await this.processFiles(mpath, { name: 'origwar3map.lua', file: env.asMapPath(globals.FILE_ENTRY) });
                // }

                const code = [...this.files.entries()]
                    .map(([name, body]) => templates.release.file({ body, name }))
                    .join('\n');

                let out = templates.release.main({
                    code,
                    package: env.config.lua.package,
                    classic: env.config.classic,
                    version: env.version,
                    id: module.id,
                });

                if (env.config.codeConfusion) {
                    out = luamin.minify(SimpleConfuser.parse(out));
                } else {
                    out = luamin.minify(out);
                }

                const outputPath = env.asBuildPath(module.path, module.id.toString(), globals.FILE_ENTRY);
                await fs.mkdirp(path.dirname(outputPath));
                await fs.writeFile(outputPath, out);
                if (env.config.classic) {
                    await this.injectWar3mapJass(module.path + '/' + module.id, path.resolve(mpath, module.mapdir));
                }
            } else {
                let outputPath = env.asBuildPath(module.path, module.id.toString(), globals.FILE_ENTRY);
                let inputPath = env.asBuildPath(module.path, module.luacopy.toString(), globals.FILE_ENTRY);
                let file = await utils.readFile(inputPath);
                await fs.mkdirp(path.dirname(outputPath));
                await fs.writeFile(outputPath, file.replace(/MAP_ID *= *\d*/m, `MAP_ID = ${module.id}`));
                if (env.config.classic) {
                    await this.injectWar3mapJass(module.path + '/' + module.id, path.resolve(mpath, module.mapdir));
                }
            }
        }
    }
}

export const releaseCompiler = new ReleaseCompiler();
