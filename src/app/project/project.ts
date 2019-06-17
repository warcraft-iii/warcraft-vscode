/**
 * @File   : project.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:06:58 PM
 */

import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs-extra';
import * as got from 'got';
import * as yauzl from 'yauzl-promise';
import * as utils from '../../utils';

import { env } from '../../env';
import { globals, localize } from '../../globals';

export class Project {
    constructor() {}

    @utils.report(localize('report.clean', 'Cleaning project'))
    clean() {
        return fs.remove(env.buildFolder);
    }

    @utils.report(localize('report.create', 'Creating project'))
    async create() {
        const result = await vscode.window.showOpenDialog({
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

        await this.download(output);

        if (await utils.confirm(localize('confirm.openProject', 'Create project success, to open?'))) {
            vscode.commands.executeCommand('vscode.openFolder', vscode.Uri.file(output), true);
        }
    }

    async download(output: string) {
        const resp = await got(globals.TEMPLATE_URL, { encoding: null });
        const zipFile = await yauzl.fromBuffer(resp.body);

        await zipFile.walkEntries(entry => {
            if (entry.fileName.endsWith('/')) {
                return;
            }
            return new Promise((resolve, reject) => {
                const outputPath = path.join(output, path.relative('warcraft-template-master', entry.fileName));

                fs.mkdirp(path.dirname(outputPath))
                    .then(() => entry.openReadStream())
                    .then(stream =>
                        stream
                            .pipe(fs.createWriteStream(outputPath))
                            .on('close', () => resolve())
                            .on('error', err => reject(err))
                    );
            });
        });
    }
}

export const project = new Project();
