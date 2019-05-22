/**
 * @File   : workspace.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 5:43:52 PM
 */

import * as vscode from 'vscode';
import * as fs from 'fs-extra';

import * as lib from './lib';

import { env } from './environment';
import { Compiler } from './compiler';
import { Packer } from './packer';
import { Runner, ProcessType } from './runner';
import { App } from './app';
import { Report, Progress } from './report';

export class Project {
    private compiler = new Compiler();
    private packer = new Packer();
    private runner = new Runner();
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
                console.error(error);
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

    @Project.catch
    @Project.validate
    @Progress
    commandCompileDebug() {
        return this.compiler.debug();
    }

    @Project.catch
    @Project.validate
    @Progress
    async commandPackMap() {
        await this.compiler.debug();
        await this.packer.pack();
    }

    @Project.catch
    @Project.validate
    @Progress
    async commandRunGame() {
        if (this.runner.hasProcess(ProcessType.Game)) {
            if (env.autoCloseClient) {
                await this.runner.kill(ProcessType.Game);
            } else {
                const confirm = await this.confirmKillWar3('Warcraft III running, to terminal?');
                if (confirm) {
                    if (confirm === 'Auto Close') {
                        env.autoCloseClient = true;
                    }
                    await this.runner.kill(ProcessType.Game);
                }
            }
        }

        await this.compiler.debug();
        await this.packer.pack();
        await this.runner.runGame();
    }

    @Project.catch
    @Project.validate
    @Progress
    commandRunWorldEditor() {
        if (this.runner.hasProcess(ProcessType.Editor)) {
            throw new Error('World Editor is running.');
        }
        return this.runner.runEditor();
    }

    @Project.catch
    @Project.validate
    @Progress
    @Report('Cleaning project ...')
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
        await this.addLibrary(library, isSsh);
    }

    @Report('Checkouting Submodule ...')
    private addLibrary(library: lib.ClassicLibrary, isSsh: boolean) {
        return lib.addLibrary(library, isSsh);
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
