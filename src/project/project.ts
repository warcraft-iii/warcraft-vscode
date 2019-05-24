/**
 * @File   : project.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:06:58 PM
 */

import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs-extra';
import * as unzipper from 'unzipper';
import * as request from 'request';
import * as utils from '../utils';
import * as globals from '../globals';

import { env } from '../env';
import { report } from '../report';
import { Errors } from '../error';

export class Project {
    constructor() {}

    @report('Cleaning Project ...')
    clean() {
        return fs.remove(env.buildFolder);
    }

    @report('Creating Project ...')
    async create() {
        const result = await vscode.window.showOpenDialog({
            canSelectFiles: false,
            canSelectFolders: true
        });

        if (!result) {
            return;
        }

        const output = result[0].fsPath;

        if (await fs.pathExists(output)) {
            if (!(await fs.stat(output)).isDirectory()) {
                throw Error(Errors.TargetNotFolder);
            }
            if ((await fs.readdir(output)).length > 0) {
                throw Error(Errors.TargetMustEmpty);
            }
        }

        await this.download(output);

        if (await utils.confirm('Create project success, to open project?')) {
            vscode.commands.executeCommand('vscode.openFolder', vscode.Uri.file(output), true);
        }
    }

    download(output: string) {
        return new Promise<void>((resolve, reject) => {
            request
                .get(globals.TEMPLATE_URL)
                .pipe(unzipper.Parse())
                .on('entry', (entry: unzipper.Entry) => {
                    if (entry.type === 'Directory') {
                        entry.autodrain().promise();
                    } else {
                        const outputPath = path.join(output, path.relative('warcraft-template-master', entry.path));

                        fs.mkdirp(path.dirname(outputPath)).then(() => {
                            entry.pipe(fs.createWriteStream(outputPath));
                        });
                    }
                })
                .on('close', () => resolve())
                .on('error', err => reject(err));
        });
    }
}

export const project = new Project();
