/**
 * @File   : workspace.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 5:43:52 PM
 */

import * as vscode from "vscode";
import * as fs from "fs-extra";

import * as code from "./code";
import * as pack from "./pack";
import * as runner from "./runner";
import * as lib from "./lib";

import { sleep } from "./util";
import { Process } from "./process";

import env from "./environment";

export class Project {
    private static _instance = new Project();

    private gameProcess?: Process;
    private weProcess?: Process;
    private progress?: vscode.Progress<{ message?: string; increment?: number }>;

    static catch(target: any, key: any, descriptor: any) {
        if (!descriptor.value) {
            return;
        }
        const orig = descriptor.value;
        descriptor.value = async function(...args: any[]) {
            try {
                return await orig.apply(this, args);
            } catch (error) {
                let message;
                if (typeof error === "string") {
                    message = error;
                } else if (typeof error === "object") {
                    message = error.message;
                } else {
                    message = "Unknown error";
                }
                vscode.window.showErrorMessage("Warcraft: " + message);
            }
        };
    }

    static validate(target: any, key: any, descriptor: any) {
        if (!descriptor.value) {
            return;
        }
        const orig = descriptor.value;
        descriptor.value = async function(...args: any[]) {
            await env.verifyProjectConfig();
            return await orig.apply(this, args);
        };
    }

    static progress(target: any, key: any, descriptor: any) {
        if (!descriptor.value) {
            return;
        }
        const orig = descriptor.value;
        descriptor.value = function(...args: any[]) {
            return this.withProgress(() => orig.apply(this, args));
        };
    }

    static report(message: string) {
        return function(target: any, key: string, descriptor: any) {
            if (!descriptor.value) {
                return;
            }
            const orig = descriptor.value;
            descriptor.value = async function(...args: any[]) {
                if (this.progress) {
                    this.progress.report({ message });
                    await sleep(100);
                } else {
                    console.warn(`it's outside withProgress (${key})`);
                }
                return await orig.apply(this, args);
            };
        };
    }

    private constructor() {}

    static get() {
        return Project._instance;
    }

    private withProgress(task: () => Promise<void>) {
        return vscode.window.withProgress(
            {
                cancellable: false,
                location: vscode.ProgressLocation.Notification,
                title: "Warcraft: "
            },
            async progress => {
                this.progress = progress;
                await task();
                this.progress = undefined;
            }
        );
    }

    async init(context: vscode.ExtensionContext) {
        await env.init(context);
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
            if (await this.confirm("Warcraft III running, to terminal?")) {
                await this.gameProcess.kill();
            } else {
                return;
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
            throw new Error("World Editor is running.");
        }

        return this.withProgress(() => this.runWorldEditor());
    }

    @Project.catch
    @Project.validate
    @Project.progress
    @Project.report("Cleaning project ...")
    commandClean() {
        return fs.remove(env.buildFolder);
    }

    @Project.catch
    @Project.validate
    async commandAddLibrary() {
        const library = await vscode.window.showQuickPick(lib.getClassicLibraries(), {
            placeHolder: "Select library to add ...",
            ignoreFocusOut: true
        });

        if (!library) {
            return;
        }

        const isSsh = env.allowSshLibrary && (await this.askGit());
        await this.withProgress(() => this.addLibrary(library, isSsh));
    }

    @Project.report("Checkouting Submodule ...")
    private addLibrary(library: lib.ClassicLibrary, isSsh: boolean) {
        return lib.addLibrary(library, isSsh);
    }

    @Project.report("Compiling Scripts ...")
    private compileDebug() {
        return code.compileDebug(env.sourceFolder, env.tempScriptPath);
    }

    @Project.report("Packing Map ...")
    private async packMap() {
        await fs.emptyDir(env.buildMapFolder);
        await fs.copy(env.mapFolder, env.buildMapFolder);
        await fs.copy(env.tempScriptPath, env.outScriptPath);
        await pack.pack(env.buildMapFolder, env.outMapPath);
    }

    @Project.report("Starting Game ...")
    private async runGame() {
        this.gameProcess = await runner.runGame(env.outMapPath);
    }

    @Project.report("Starting World Editor ...")
    private async runWorldEditor() {
        this.weProcess = await runner.runWorldEditor();
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
}
