/**
 * @File   : app.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 10:48:53 AM
 */

import * as vscode from 'vscode';
import * as utils from '../utils';

import { env } from '../env';
import { globals, ConfigurationType, WarcraftVersionType } from '../globals';
import { registerCommand, registerCheckedCommand } from './command';
import { debugCompiler, releaseCompiler } from './compiler';
import { debugPacker, releasePacker } from './packer';
import { gameRunner, editorRunner } from './runner';
import { project, library } from './project';
import { objediting } from './objediting';

class App implements vscode.Disposable {
    private subscriptions: vscode.Disposable[] = [];
    private configurationButton = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left, 1);
    private warcraftVersionButton = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left, 1);

    dispose() {
        this.configurationButton.dispose();
        this.warcraftVersionButton.dispose();
        this.subscriptions.forEach((sub) => sub.dispose());
    }

    constructor() {
        this.initListeners();
        this.initCommands();
        this.initStatusBar();
    }

    private get compiler() {
        return env.config.configuration === ConfigurationType.Release ? releaseCompiler : debugCompiler;
    }

    private get packer() {
        return env.config.configuration === ConfigurationType.Release ? releasePacker : debugPacker;
    }

    private initListeners() {
        if (env.rootPath) {
            const watcher = vscode.workspace.createFileSystemWatcher(
                new vscode.RelativePattern(env.rootPath, globals.FILE_PROJECT)
            );

            this.subscriptions.push(
                watcher.onDidChange(() => this.reload()),
                watcher.onDidCreate(() => this.reload()),
                watcher.onDidDelete(() => this.reload())
            );
        }

        vscode.workspace.onDidChangeConfiguration((e) => {
            if (e.affectsConfiguration('warcraft')) {
                this.reload();
            }
        });
    }

    private initStatusBar() {
        this.configurationButton.command = 'extension.warcraft.project.toggleConfiguration';
        this.configurationButton.show();
        this.warcraftVersionButton.command = 'extension.warcraft.project.toggleWarcraftVersion';
        this.warcraftVersionButton.show();
        this.updateConfigurationButton();
        this.updateWarcraftVersionButton();
    }

    private initCommands() {
        this.subscriptions.push(
            registerCommand('compile.debug', () => this.compiler.execute()),
            registerCommand('pack.debug', async () => {
                await objediting.execute();
                await this.compiler.execute();
                await this.packer.execute();
            }),
            registerCommand('pack.object', () => objediting.execute()),
            registerCheckedCommand('run.debug', async () => {
                if (!(await gameRunner.check())) {
                    return;
                }
                await objediting.execute();
                await this.compiler.execute();
                await this.packer.execute();
                await gameRunner.execute();
            }),
            registerCheckedCommand('run.editor', async () => {
                if (!(await editorRunner.check())) {
                    return;
                }
                await editorRunner.execute();
            }),
            registerCommand('project.create', () => project.create()),
            registerCommand('project.clean', () => project.clean()),
            registerCommand('project.addlibrary', () => library.add()),
            registerCommand('project.toggleConfiguration', () => project.toggleConfiguration()),
            registerCommand('project.toggleWarcraftVersion', () => project.toggleWarcraftVersion()),
            registerCommand('project.choseMapFile', () => project.choseMapFile()),
            registerCommand('export.data', async () => {
                await utils.spawn(env.compilerPath + "/make.bat")
            })
        );
    }

    @utils.debounce(100)
    private async reload() {
        await env.config.reload();
        await this.updateConfigurationButton();
        await this.updateWarcraftVersionButton();
    }

    private async updateConfigurationButton() {
        await env.config.waitLoaded();
        try {
            if (env.config.mapDir) {
                const text = ConfigurationType[env.config.configuration];
                this.configurationButton.text = '$(gear) ' + text;
                this.configurationButton.tooltip = 'Warcraft Configuration: ' + text;
                this.configurationButton.show();
            }
        } catch (error) {
            this.configurationButton.hide();
        }
    }

    private async updateWarcraftVersionButton() {
        await env.config.waitLoaded();
        try {
            if (env.config.mapDir) {
                const text = WarcraftVersionType[env.config.warcraftVersion];
                this.warcraftVersionButton.text = '$(gear) ' + text;
                this.warcraftVersionButton.tooltip = 'Warcraft Version: ' + text;
                this.warcraftVersionButton.show();
            }
        } catch (error) {
            this.warcraftVersionButton.hide();
        }
    }
}

export const app = new App();
