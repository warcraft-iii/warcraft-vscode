/**
 * @File   : workspace.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 5:43:52 PM
 */

import * as vscode from 'vscode';
import * as fs from 'fs-extra';
import * as utils from './utils';

import * as runner from './runner';
import * as lib from './lib';

import { Process } from './process';

import { env } from './environment';
import { Compiler } from './compiler';
import { Packer } from './packer';
import { App } from './app';

export class Project {
    private gameProcess?: Process;
    private weProcess?: Process;
    private progress?: vscode.Progress<{ message?: string; increment?: number }>;

    private compiler = new Compiler();
    private packer = new Packer();
    private app = new App();

    constructor() {}

    async init(context: vscode.ExtensionContext) {
        await env.init(context);
        await this.app.init();
        await this.compiler.init();
    }

    static catch(_target: any, _key: any, descriptor: any) {
        if (!descriptor.value) {
            return;
        }
        const orig = descriptor.value;
        descriptor.value = async function(...args: any[]) {
            try {
                return await orig.apply(this, args);
            } catch (error) {
                let message;
                if (typeof error === 'string') {
                    message = error;
                } else if (typeof error === 'object') {
                    message = error.message;
                } else {
                    message = 'Unknown error';
                }
                vscode.window.showErrorMessage('Warcraft: ' + message);
            }
        };
    }

    static validate(_target: any, _key: any, descriptor: any) {
        if (!descriptor.value) {
            return;
        }
        const orig = descriptor.value;
        descriptor.value = async function(...args: any[]) {
            await env.verifyProjectConfig();
            return await orig.apply(this, args);
        };
    }

    static progress(_target: any, _key: any, descriptor: any) {
        if (!descriptor.value) {
            return;
        }
        const orig = descriptor.value;
        descriptor.value = function(...args: any[]) {
            return this.withProgress(() => orig.apply(this, args));
        };
    }

    static report(message: string) {
        return (_target: any, key: string, descriptor: any) => {
            if (!descriptor.value) {
                return;
            }
            const orig = descriptor.value;
            descriptor.value = async function(...args: any[]) {
                if (this.progress) {
                    this.progress.report({ message });
                    await utils.sleep(100);
                } else {
                    console.warn(`it's outside withProgress (${key})`);
                }
                return await orig.apply(this, args);
            };
        };
    }

    private withProgress(task: () => Promise<void>) {
        return vscode.window.withProgress(
            {
                cancellable: false,
                location: vscode.ProgressLocation.Notification,
                title: 'Warcraft: '
            },
            async progress => {
                this.progress = progress;
                this.progress.report({ message: 'haha' });
                await task();
                this.progress = undefined;
            }
        );
    }

    @Project.catch
    @Project.validate
    @Project.progress
    commandCompileDebug() {
        return this.compileDebug();
    }

    @Project.catch
    @Project.validate
    @Project.progress
    async commandPackMap() {
        await this.compileDebug();
        await this.packMap();
    }

    @Project.catch
    @Project.validate
    async commandRunGame() {
        if (this.gameProcess && this.gameProcess.isAlive()) {
            if (env.autoCloseClient) {
                await this.gameProcess.kill();
            } else {
                const confirm = await this.confirmKillWar3('Warcraft III running, to terminal?');
                if (confirm) {
                    if (confirm === 'Auto Close') {
                        env.autoCloseClient = true;
                    }
                    await this.gameProcess.kill();
                }
            }
        }

        return this.withProgress(async () => {
            await this.compileDebug();
            await this.packMap();
            await this.runGame();
        });
    }

    @Project.catch
    @Project.validate
    commandRunWorldEditor() {
        if (this.weProcess && this.weProcess.isAlive()) {
            throw new Error('World Editor is running.');
        }

        return this.withProgress(() => this.runWorldEditor());
    }

    @Project.catch
    @Project.validate
    @Project.progress
    @Project.report('Cleaning project ...')
    commandClean() {
        return fs.remove(env.buildFolder);
    }

    @Project.catch
    @Project.validate
    async commandAddLibrary() {
        const library = await vscode.window.showQuickPick(lib.getClassicLibraries(), {
            placeHolder: 'Select library to add ...',
            ignoreFocusOut: true
        });

        if (!library) {
            return;
        }

        const isSsh = env.allowSshLibrary && (await this.askGit());
        await this.withProgress(() => this.addLibrary(library, isSsh));
    }

    @Project.report('Checkouting Submodule ...')
    private addLibrary(library: lib.ClassicLibrary, isSsh: boolean) {
        return lib.addLibrary(library, isSsh);
    }

    @Project.report('Compiling Scripts ...')
    private compileDebug() {
        return this.compiler.debug();
    }

    @Project.report('Packing Map ...')
    private async packMap() {
        await this.packer.pack();
    }

    @Project.report('Starting Game ...')
    private async runGame() {
        this.gameProcess = await runner.runGame(env.outMapPath);
    }

    @Project.report('Starting World Editor ...')
    private async runWorldEditor() {
        this.weProcess = await runner.runWorldEditor();
    }

    private async confirmKillWar3(info: string) {
        return await vscode.window.showInformationMessage(
            info,
            {
                modal: true
            },
            'Ok',
            'Auto Close'
        );
    }

    private async askGit() {
        const result = await vscode.window.showQuickPick(
            [{ label: 'SSH', value: true }, { label: 'HTTPS', value: false }],
            {
                ignoreFocusOut: true
            }
        );
        return result ? result.value : false;
    }
}
