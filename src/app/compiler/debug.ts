/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:19 AM
 */

import * as fs from 'fs-extra';
import * as path from 'path';

import { env } from '../../env';
import { SubModulesConfig } from '../../env/config';
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

    async writeFiles(filePaths: [string, boolean][], cfg: SubModulesConfig) {
        const outputPath = cfg.out || '';
        const files = await Promise.all(
            filePaths.map((file) => this.genFile(file[0], file[1] ? env.sourceFolder : cfg.relativePath || ''))
        );

        // if (!env.config.classic) {
        //     files.push(
        //         await this.genFile(
        //             env.asMapPath(globals.FILE_ENTRY),
        //             cfg.relativePath || '',
        //             'orig' + globals.FILE_ENTRY
        //         )
        //     );
        // }
        const code = files.join('\n');
        const out = templates.debug.main({
            code,
            package: env.config.lua.package,
            classic: env.config.classic,
            version: env.version,
            id: cfg.id,
        });
        await fs.mkdirp(path.dirname(outputPath));
        await fs.writeFile(outputPath, out);

        if (env.config.classic) {
            await this.injectWar3mapJass(cfg.path, cfg.mapdir);
        }
    }

    @utils.report(localize('report.compile', 'Compiling script'))
    async execute() {
        if (!(await fs.stat(env.sourceFolder)).isDirectory()) {
            throw Error(localize('error.noSrcFolder', 'Not found: source folder'));
        }
        const allFiles: [string, boolean][] = (await utils.getAllFiles(env.sourceFolder))
            .filter((file) => !utils.isHiddenFile(file) && utils.isLuaFile(file))
            .map((file) => [file, true]);

        await this.writeFiles(allFiles, {
            path: '',
            out: env.asBuildPath(globals.FILE_ENTRY),
            mapdir: path.resolve(env.rootPath || '', env.mapDir),
            relativePath: env.sourceFolder,
            id: 0,
        });

        await this.packSubMoudles();
    }

    async getAllLuaFiles(path: string, isSource: boolean = false): Promise<[string, boolean][]> {
        return (await utils.getAllFiles(path))
            .filter((file) => !utils.isHiddenFile(file) && utils.isLuaFile(file))
            .map((file) => [file, isSource]);
    }

    @utils.report(localize('report.compile', 'Compiling submodules script'))
    async packSubMoudles() {
        const rootPath = path.resolve(env.rootPath || '', globals.FOLADER_MODULES);
        const modules: SubModulesConfig[] = env.submodules || [];
        for (let module of modules) {
            const mpath = path.resolve(rootPath, module.path);
            const allFiles = await this.getAllLuaFiles(mpath);
            const fileSet = new Set<string>();
            allFiles.forEach((file) => fileSet.add(path.relative(mpath, file[0])));
            for (const file of module.files || []) {
                const filepath = path.resolve(env.rootPath || '', file);
                    if ((await fs.stat(filepath)).isDirectory()) {
                        const af = await this.getAllLuaFiles(filepath, true);
                        af.filter(file=>!fileSet.has(path.relative(env.sourceFolder, file[0])))
                        allFiles.push(...af);
                    } else if(!fileSet.has(path.relative(env.sourceFolder, filepath)))  {
                        allFiles.push([filepath, true]);
                    }
            }

            await this.writeFiles(allFiles, {
                path: module.path + '/' + module.id,
                out: env.asBuildPath(module.path, module.id.toString(), globals.FILE_ENTRY),
                mapdir: path.resolve(mpath, module.mapdir),
                relativePath: mpath,
                id: module.id,
            });
        }
    }

    async genFile(file: string, relativePath: string, name?: string) {
        const body = this.processCodeMacros(await utils.readFile(file));
        const comment = this.getCommentEqual(body);
        if (!name) {
            name = utils.posixCase(path.relative(relativePath, file));
        }
        return templates.debug.file({ name, comment, body });
    }
}

export const debugCompiler = new DebugCompiler();
