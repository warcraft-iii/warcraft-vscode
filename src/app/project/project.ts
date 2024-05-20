/**
 * @File   : project.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:06:58 PM
 */

import * as fs from 'fs-extra';
import * as utils from '../../utils';

import { env } from '../../env';
import { globals, localize, ConfigurationType, WarcraftVersionType } from '../../globals';
import { runtime } from '../../env/runtime';

class Project {
    constructor() { }

    @utils.report(localize('report.clean', 'Cleaning project'))
    clean() {
        return fs.remove(env.buildFolder);
    }

    @utils.report(localize('report.create', 'Creating project'))
    async create(reforge = true) {
        const result = await runtime.showOpenDialog({
            canSelectFiles: false,
            canSelectFolders: true,
            openLabel: localize('confirm.createProject', 'Use this folder to create project')
        });

        if (!result) {
            return;
        }

        const output = result[0].fsPath;

        if (await fs.pathExists(output)) {
            if (!(await fs.stat(output)).isDirectory()) {
                throw Error(localize('error.targetNotFolder', 'Target not a folder'));
            }
            if ((await fs.readdir(output)).length > 0) {
                throw Error(localize('error.folderNotEmpty', 'Folder must be empty'));
            }
        }

        await this.download(output, reforge);

        if (await utils.confirm(localize('confirm.openProject', 'Create project success, to open?'))) {
            runtime.executeCommand('vscode.openFolder', output, true);
        }
    }

    async download(output: string, reforge: boolean) {
        await utils.extractFile(await utils.downloadZip(reforge ? globals.TEMPLATE_URL : globals.TEMPLATE_CLASSIC_URL), output, reforge ? 'warcraft-template-master' : 'warcraft-template-classic-main');
    }

    async toggleConfiguration() {
        const result = await runtime.showQuickPick(
            [
                {
                    label: 'Debug',
                    value: ConfigurationType.Debug
                },
                {
                    label: 'Release',
                    value: ConfigurationType.Release
                }
            ],
            { placeHolder: localize('quick.toggleConfiguration', 'Toggle Configuration') }
        );

        if (!result) {
            return;
        }

        env.config.configuration = result.value;
    }

    async toggleWarcraftVersion() {
        const result = await runtime.showQuickPick(
            [
                {
                    label: 'Reforge',
                    value: WarcraftVersionType.Reforge
                },
                {
                    label: 'Classic',
                    value: WarcraftVersionType.Classic
                }
            ],
            { placeHolder: localize('quick.toggleWarcraftVersion', 'Togggle Warcraft Version') }
        );

        if (!result) {
            return;
        }

        env.config.warcraftVersion = result.value;
    }

    async choseMapFile() {
        const maps = await fs.readdir(env.asRootPath());

        const menus = [];
        for (const m of maps) {
            if (m.endsWith('.w3x') || m.endsWith('.w3m')) {
                menus.push({
                    label: m,
                    value: m
                });
            }
        }

        const result = await runtime.showQuickPick(
            menus,
            { placeHolder: localize('quick.choseMapFile', 'Chose a Map File') }
        );

        if (!result) {
            return;
        }

        env.config.mapDir = result.value;
    }
}

export const project = new Project();
