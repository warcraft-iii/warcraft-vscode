/**
 * @File   : workspace.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 5:43:52 PM
 */

import * as vscode from "vscode";
import * as fs from "fs-extra";
import env from "./environment";

import * as code from "./code";
import * as pack from "./pack";
import * as runner from "./runner";
import * as lib from "./lib";
import { Process } from "./process";
import { sleep } from "./util";

export class Project {
    private static _instance = new Project();

    private gameProcess?: Process;
    private weProcess?: Process;
    private progress?: vscode.Progress<{ message?: string; increment?: number }>;

    private constructor() {}

    static get() {
        return Project._instance;
    }

    static catch(target: any, key: string, descriptor: any) {
        if (descriptor.value) {
            const value = descriptor.value;
            descriptor.value = async function(...args: any[]) {
                try {
                    await value.apply(this, args);
                } catch (error) {
                    if (typeof error === "string") {
                        vscode.window.showErrorMessage(error);
                    } else if (typeof error === "object") {
                        vscode.window.showErrorMessage(error.message);
                    } else {
                        vscode.window.showErrorMessage("Unknown error");
                    }
                }
            };
            descriptor.value.raw = value;
        }
    }

    static validate(target: any, key: string, descriptor: any) {
        if (descriptor.value) {
            const value = descriptor.value;
            descriptor.value = async function(...args: any[]) {
                await env.load();
                return await value.apply(this, args);
            };
        }
    }

    static progress(message: string) {
        return function(target: any, key: string, descriptor: any) {
            if (descriptor.value) {
                const orig = descriptor.value;

                descriptor.value = async function(...args: any[]) {
                    if (this.progress) {
                        this.progress.report({ message });
                        await sleep(100);
                    }
                    return await orig.apply(this, args);
                };
            }
        };
    }

    private withProgress(...tasks: (() => void)[]) {
        return vscode.window.withProgress(
            {
                cancellable: false,
                location: vscode.ProgressLocation.Notification,
                title: "Warcraft: "
            },
            async progress => {
                this.progress = progress;

                for (const task of tasks) {
                    await task();
                }

                this.progress = undefined;
            }
        );
    }

    @Project.catch
    @Project.validate
    compileDebug() {
        return this.withProgress(() => this._compileDebug());
    }

    @Project.catch
    @Project.validate
    packMap() {
        return this.withProgress(() => this._packMap());
    }

    @Project.catch
    @Project.validate
    async runGame() {
        if (this.gameProcess && this.gameProcess.isAlive()) {
            if (await this.confirm("Warcraft III running, to terminal?")) {
                await this.gameProcess.kill();
            } else {
                return;
            }
        }

        return this.withProgress(
            () => this._compileDebug(),
            () => this._packMap(),
            async () => (this.gameProcess = await this._runGame())
        );
    }

    @Project.catch
    @Project.validate
    runWorldEditor() {
        if (this.weProcess && this.weProcess.isAlive()) {
            throw new Error("WorldEditor running...");
        }

        return this.withProgress(async () => (this.weProcess = await this._runWorldEditor()));
    }

    @Project.catch
    @Project.validate
    async addLibrary() {
        const library = await vscode.window.showQuickPick(lib.getClassicLibraries(), {
            placeHolder: "Select library to add ...",
            ignoreFocusOut: true
        });

        if (!library) {
            return;
        }

        const isSsh = env.allowSshLibrary && (await this.askGit());
        await this._addLibrary(library, isSsh);
    }

    private async confirm(info: string) {
        return (
            (await vscode.window.showInformationMessage(
                info,
                {
                    modal: true
                },
                "Ok"
            )) === "Ok"
        );
    }

    private async askGit() {
        const result = await vscode.window.showQuickPick(
            [{ label: "SSH", value: true }, { label: "HTTPS", value: false }],
            {
                ignoreFocusOut: true
            }
        );
        return result ? result.value : false;
    }

    @Project.progress("Checkouting submodule ...")
    private _addLibrary(library: lib.ClassicLibrary, isSsh: boolean) {
        return lib.addLibrary(library, isSsh);
    }

    @Project.progress("Compiling scripts ...")
    private _compileDebug() {
        return code.compileDebug(env.sourceFolder, env.tempScriptPath);
    }

    @Project.progress("Packing map ...")
    private async _packMap() {
        await fs.emptyDir(env.buildMapFolder);
        await fs.copy(env.tempScriptPath, env.outScriptPath);
        await fs.copy(env.mapFolder, env.buildMapFolder);
        await pack.pack(env.buildMapFolder, env.outMapPath);
    }

    @Project.progress("Starting game ...")
    private _runGame() {
        return runner.runGame(env.outMapPath);
    }

    @Project.progress("Starting world editor ...")
    private _runWorldEditor() {
        return runner.runWorldEditor();
    }
}
