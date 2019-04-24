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
import config from "./config";

export class Project {
    private static _instance = new Project();

    private constructor() {}

    static get() {
        return Project._instance;
    }

    static catch(target: any, key: string, descriptor: any) {
        if (descriptor.value) {
            const value = descriptor.value;
            descriptor.value = async function() {
                try {
                    await value.apply(this, arguments);
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
            descriptor.value = async function() {
                await this.check();
                return value.apply(this, arguments);
            };
        }
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
    runGame() {
        return this._runGame();
    }

    @Project.catch
    @Project.validate
    runWorldEditor() {
        return runner.runWorldEditor();
    }

    private _compileDebug() {
        return code.compileDebug(config.sourceFolder, config.scriptPath);
    }

    private _packMap() {
        return pack.pack(config.mapFolder, config.mapPath);
    }

    private async _runGame() {
        await this._compileDebug();
        await this._packMap();
        await runner.runGame();
    }

    async check() {
        config.load();
    }
}
