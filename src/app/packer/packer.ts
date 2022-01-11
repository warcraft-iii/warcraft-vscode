/**
 * @File   : debug.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 12:27:34 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as utils from '../../utils';

import { env } from '../../env';
import { globals, localize, ConfigurationType } from '../../globals';
import { SubModulesConfig } from '../../env/config';

type PackItem = [string, string];

class Packer {
    private _type: ConfigurationType;

    constructor(type: ConfigurationType) {
        this._type = type;
    }

    type() {
        return this._type;
    }

    async generatePackList() {
        const packList: PackItem[] = [];
        const libs = await fs.readdir(env.asSourcePath(globals.FOLDER_LIBRARIES));
        const imports = [
            globals.FOLDER_IMPORTS,
            `${globals.FOLDER_IMPORTS}.${ConfigurationType[this.type()].toLowerCase()}`,
        ];

        // map.w3x
        packList.push(...(await this.generatePackItems(env.mapFolder, (file) => !utils.isLuaFile(file))));

        // imports
        for (const imp of imports) {
            for (const lib of libs) {
                packList.push(...(await this.generatePackItems(env.asSourcePath(globals.FOLDER_LIBRARIES, lib, imp))));
            }

            packList.push(...(await this.generatePackItems(env.asRootPath(imp))));
        }

        // objediting
        packList.push(...(await this.generatePackItems(env.asBuildPath('objediting'))));

        // war3map.lua
        packList.push([globals.FILE_ENTRY, env.asBuildPath(globals.FILE_ENTRY)]);

        if (env.config.classic) {
            packList.push([globals.FILE_ENTRY_JASS, env.asBuildPath(globals.FILE_ENTRY_JASS)]);
        }

        const exists = new Set<string>();

        await fs.writeFile(
            env.asBuildPath(globals.FILE_PACKLIST),
            JSON.stringify(
                packList.reduceRight((r, item) => {
                    if (!exists.has(item[0])) {
                        exists.add(item[0]);
                        r.push(item);
                    } else {
                        console.log(item[0], item[1]);
                    }
                    return r;
                }, [] as PackItem[])
            )
        );
    }
    async generateSubPackList() {
        const rootPath = path.resolve(env.rootPath || '', globals.FOLADER_MODULES);
        const modules: SubModulesConfig[] = env.submodules || [];
        const imports = [
            globals.FOLDER_IMPORTS,
            `${globals.FOLDER_IMPORTS}.${ConfigurationType[this.type()].toLowerCase()}`,
        ];

        const libs = await fs.readdir(env.asSourcePath(globals.FOLDER_LIBRARIES));
        for (let module of modules) {
            const packList: PackItem[] = [];

            const mpath = path.resolve(rootPath, module.path);

            // imports
            for (const imp of imports) {
                for (const lib of libs) {
                    packList.push(
                        ...(await this.generatePackItems(env.asSourcePath(globals.FOLDER_LIBRARIES, lib, imp)))
                    );
                }
                packList.push(...(await this.generatePackItems(path.resolve(mpath, imp))));
            }

            // objediting
            packList.push(...(await this.generatePackItems(env.asBuildPath(module.path, module.id.toString(), 'objediting'))));

            // war3map.lua
            packList.push([globals.FILE_ENTRY, env.asBuildPath(module.path, module.id.toString(), globals.FILE_ENTRY)]);

            // war3map.j
            if (env.config.classic) {
                packList.push([globals.FILE_ENTRY_JASS, env.asBuildPath(module.path, module.id.toString(), globals.FILE_ENTRY_JASS)]);
            }

            for (const file of module.res || []) {
                // imports
                const filePath = path.resolve(env.rootPath || '', file);
                if ((await fs.stat(filePath)).isDirectory()) {
                    packList.push(
                        ...(await this.generatePackItems(
                            path.resolve(filePath),
                            undefined,
                            path.resolve(env.rootPath || '', 'imports')
                        ))
                    );
                } else {
                    packList.push([path.relative(path.resolve(env.rootPath || '', 'imports'), filePath), filePath]);
                }
            }

            const exists = new Set<string>();

            await fs.writeFile(
                env.asBuildPath(module.path, module.id.toString(), globals.FILE_PACKLIST),
                JSON.stringify(
                    packList.reduceRight((r, item) => {
                        if (!exists.has(item[0])) {
                            exists.add(item[0]);
                            r.push(item);
                        } else {
                            console.log(item[0], item[1]);
                        }
                        return r;
                    }, [] as PackItem[])
                )
            );
        }
    }

    async packByPackList() {
        const args: string[] = [];

        if (!env.config.classic) {
            args.push('generate');
            if (this.type() === ConfigurationType.Debug) {
                args.push('-f');
            }
            args.push('-o', env.outFilePath);
            args.push('-i', env.asBuildPath(globals.FILE_PACKLIST));
        } else {
            await fs.copy(env.mapFolder, env.outFilePath);
            args.push('pack');
            args.push('-m', env.outFilePath);
            args.push('-i', env.asBuildPath(globals.FILE_PACKLIST));
        }

        await utils.execFile(env.asExetensionPath('bin/MopaqPack-rs.exe'), args);
    }

    async packSubByPackList() {
        const rootPath = path.resolve(env.rootPath || '', globals.FOLADER_MODULES);
        const modules: SubModulesConfig[] = env.submodules || [];
        for (let module of modules) {
            const args: string[] = [];

            const outPath = env.asBuildPath(module.out || path.resolve(module.path, globals.FILE_RELEASE_MAP));
            if (!env.config.classic) {
                args.push('generate');
                if (this.type() === ConfigurationType.Debug) {
                    args.push('-f');
                }
                args.push('-o', outPath);
                args.push('-i', env.asBuildPath(globals.FILE_PACKLIST));
            } else {
                await fs.copy(path.resolve(rootPath, module.path, module.mapdir), outPath);
                args.push('pack');
                args.push('-m', outPath);
                args.push('-i', env.asBuildPath(module.path, module.id.toString(), globals.FILE_PACKLIST));
            }

            await utils.execFile(env.asExetensionPath('bin/MopaqPack-rs.exe'), args);
        }
    }

    @utils.report(localize('report.pack', 'Packing map'))
    async execute() {
        await this.generatePackList();
        await this.generateSubPackList();
        await this.packByPackList();
        await this.packSubByPackList();
    }

    private async generatePackItems(root: string, filter?: (file: string) => boolean, relativePath?: string) {
        if (!(await fs.pathExists(root)) || !(await fs.stat(root)).isDirectory()) {
            return [];
        }
        let files = (await utils.getAllFiles(root)).filter((file) => !utils.isHiddenFile(file));
        if (filter) {
            files = files.filter(filter);
        }
        return files.map((file) => this.generatePackItem(file, relativePath || root));
    }

    private generatePackItem(file: string, root: string): PackItem {
        return [path.relative(root, file), file];
    }
}

export const debugPacker = new Packer(ConfigurationType.Debug);
export const releasePacker = new Packer(ConfigurationType.Release);
