/**
 * @File   : app.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 10:48:53 AM
 */

import * as vscode from 'vscode';
import debounce from 'lodash-es/debounce';

import { env } from '../env';
import { globals, ConfigurationType } from '../globals';

export class App implements vscode.Disposable {
    private subscriptions: vscode.Disposable[] = [];
    private reloader = debounce(() => env.config.reload(), 100);
    private configurationButton = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left, 1);
    private anonymousCommandIndex = 0;

    dispose() {
        this.configurationButton.dispose();
        this.subscriptions.forEach(sub => sub.dispose());
    }

    constructor() {
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

        vscode.workspace.onDidChangeConfiguration(e => {
            if (e.affectsConfiguration('warcraft')) {
                this.reload();
            }
        });

        this.configurationButton.command = this.createAnonymousCommand(async () => {
            const result = await vscode.window.showQuickPick([
                {
                    label: 'Debug',
                    value: ConfigurationType.Debug
                },
                {
                    label: 'Release',
                    value: ConfigurationType.Release
                }
            ]);

            if (!result) {
                return;
            }

            env.config.configuration = result.value;
        });
        this.configurationButton.show();
        this.updateConfigurationButton();
    }

    private reload() {
        this.reloader();
        this.updateConfigurationButton();
    }

    private updateConfigurationButton() {
        this.configurationButton.text = '$(gear) ' + ConfigurationType[env.config.configuration];
    }

    private createAnonymousCommand(callback: (...args: any[]) => any) {
        const command = 'extension.warcraft.anonymous.' + this.anonymousCommandIndex++;
        this.subscriptions.push(vscode.commands.registerCommand(command, callback));
        return command;
    }
}

export const app = new App();
