/**
 * @File   : app.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 10:48:53 AM
 */

import * as vscode from 'vscode';
import * as utils from '../utils';

import { env } from '../env';
import { globals, ConfigurationType, WarcraftVersionType, LuaConfusionType } from '../globals';
import { registerCommand, registerCheckedCommand } from './command';
import { runWc3, BuildOptions } from './bridge';
import { gameRunner, editorRunner } from './runner';
import { project, library } from './project';

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

    private buildOpts(): BuildOptions {
        return {
            release: env.config.configuration === ConfigurationType.Release,
            classic: env.config.classic,
            confusion: LuaConfusionType[env.config.luaConfusion],
        };
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
            registerCommand('compile.debug', () => runWc3('compile', this.buildOpts())),
            registerCommand('pack.debug', () => runWc3('build', this.buildOpts())),
            registerCommand('pack.object', () => runWc3('objediting', this.buildOpts())),
            registerCheckedCommand('run.debug', async () => {
                if (!(await gameRunner.check())) {
                    return;
                }
                await runWc3('build', this.buildOpts());
                await gameRunner.execute();
            }),
            registerCheckedCommand('run.editor', async () => {
                if (!(await editorRunner.check())) {
                    return;
                }
                await editorRunner.execute();
            }),
            registerCommand('project.create', () => project.create(true)),
            registerCommand('project.createClassic', () => project.create(false)),
            registerCommand('project.clean', () => project.clean()),
            registerCommand('project.addlibrary', () => library.add()),
            registerCommand('project.toggleConfiguration', () => project.toggleConfiguration()),
            registerCommand('project.toggleWarcraftVersion', () => project.toggleWarcraftVersion()),
            registerCommand('project.choseMapFile', () => project.choseMapFile())
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
