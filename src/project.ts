/**
 * @File   : workspace.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 5:43:52 PM
 */

import * as vscode from "vscode";
import * as code from "./code";
import * as pack from "./pack";
import * as runner from "./runner";
import * as lib from "./lib";
import * as util from "./util";
import env from "./environment";

export class Project {
    private static _instance = new Project();

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
                    vscode.window.showErrorMessage(error.message);
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
                    return vscode.window.withProgress(
                        {
                            cancellable: false,
                            location: vscode.ProgressLocation.Notification,
                            title: "Warcraft: " + message
                        },
                        () => value.apply(this, args)
                    );
                };
            }
        };
    }

    @Project.catch
    @Project.validate
    @Project.progress("compiling scripts ...")
    compileDebug() {
        return this._compileDebug();
    }

    @Project.catch
    @Project.validate
    @Project.progress("packing map ...")
    packMap() {
        return this._packMap();
    }

    @Project.catch
    @Project.validate
    @Project.progress("starting game ...")
    runGame() {
        return this._runGame();
    }

    @Project.catch
    @Project.validate
    @Project.progress("starting world editor ...")
    runWorldEditor() {
        return runner.runWorldEditor();
    }

    @Project.catch
    @Project.validate
    async addLibrary() {
        const library = await vscode.window.showQuickPick(lib.getClassicLibraries(), {
            placeHolder: "Select library to add ..."
        });

        if (!library) {
            return;
        }

        const isSsh = env.allowSshLibrary && (await this._askSsh());
        await this._addLibrary(library, isSsh);
    }

    private async _askSsh() {
        const result = await vscode.window.showQuickPick([
            { label: "SSH", value: true },
            { label: "HTTPS", value: false }
        ]);
        return result ? result.value : false;
    }

    @Project.progress("checkouting submodule ...")
    private _addLibrary(library: lib.ClassicLibrary, isSsh: boolean) {
        return lib.addLibrary(library, isSsh);
    }

    private _compileDebug() {
        return code.compileDebug(env.sourceFolder, env.outScriptPath);
    }

    private async _packMap() {
        await util.copyFolder(env.mapFolder, env.buildMapFolder);
        await pack.pack(env.buildMapFolder, env.outMapPath);
    }

    private async _runGame() {
        await this._compileDebug();
        await this._packMap();
        await runner.runGame(env.outMapPath);
    }
}
