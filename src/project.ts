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

    private gameProcess: Process | undefined;
    private weProcess: Process | undefined;
    private progress: vscode.Progress<string> | undefined;

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
                return value.apply(this, args);
            };
        }
    }

    static progress(message: string) {
        return function(target: any, key: string, descriptor: any) {
            if (descriptor.value) {
                const value = descriptor.value;
                descriptor.value = function(...args: any[]) {
                    if (this.process) {
                        this.process.report({ message });
                        return value.apply(this, args);
                    } else {
                        return vscode.window.withProgress(
                            {
                                cancellable: false,
                                location: vscode.ProgressLocation.Notification,
                                title: "Warcraft: "
                            },
                            async process => {
                                process.report({ message });
                                this.process = process;

                                await value.apply(this, args);
                                this.process = undefined;
                            }
                        );
                    }
                };
            }
        };
    }

    @Project.catch
    @Project.validate
    compileDebug() {
        return this._compileDebug();
    }

    @Project.catch
    @Project.validate
    packMap() {
        return this._packMap();
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
        this.gameProcess = await this._runGame();
    }

    @Project.catch
    @Project.validate
    async runWorldEditor() {
        if (this.weProcess && this.weProcess.isAlive()) {
            throw new Error("WorldEditor running...");
        }
        this.weProcess = await this._runWorldEditor();
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
    private async _compileDebug() {
        return await code.compileDebug(env.sourceFolder, env.tempScriptPath);
    }

    @Project.progress("Packing map ...")
    private async _packMap() {
        await fs.emptyDir(env.buildMapFolder);
        await fs.copy(env.tempScriptPath, env.outScriptPath);
        await fs.copy(env.mapFolder, env.buildMapFolder);
        await pack.pack(env.buildMapFolder, env.outMapPath);
    }

    @Project.progress("Starting game ...")
    private async _runGame() {
        await this._compileDebug();
        await this._packMap();
        return await runner.runGame(env.outMapPath);
    }

    @Project.progress("Starting world editor ...")
    private async _runWorldEditor() {
        return await runner.runWorldEditor();
    }
}
