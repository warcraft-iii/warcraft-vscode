/**
 * @File   : workspace.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 5:43:52 PM
 */

import * as vscode from "vscode";
import * as fs from "mz/fs";
import * as path from "path";
import * as code from "./code";
import * as pack from "./pack";
import { isString } from "util";

interface WarcraftConfig {
    GAME_PATH?: string;
    GAME_BUILD?: string;
    GAME_EXE?: string;
    GAME_CMDLINE?: string;
    WE_EXE?: string;
    WE_CMDLINE?: string;
    MAP_PKG_PATH?: string;
}

export class Project {
    private static _instance = new Project();

    private _config: WarcraftConfig = {};
    private _rootPath: string = "";
    private _pkgPath: string = "";

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
        return code.compileDebug(
            path.join(this._rootPath, "src"),
            path.join(this._rootPath, this._pkgPath, "war3map.lua")
        );
    }

    @Project.catch
    @Project.validate
    packMap() {
        return pack.pack(path.join(this._rootPath, this._pkgPath), path.join(this._rootPath, `_${this._pkgPath}`));
    }

    async check() {
        if (!vscode.workspace.rootPath) {
            throw new Error("Can not use in workspace");
        }

        const configFile = path.join(vscode.workspace.rootPath, "warcraft.json");
        const stat = await fs.stat(configFile);
        if (!stat.isFile()) {
            throw new Error("Can not use in workspace");
        }

        const body = await fs.readFile(configFile, { encoding: "utf-8" });
        if (!body) {
            throw "ErrorCode.NotWarcraftProject";
        }

        const config = JSON.parse(body) as WarcraftConfig;
        if (!config) {
            throw "ErrorCode.NotWarcraftProject";
        }

        this._rootPath = vscode.workspace.workspaceFolders ? vscode.workspace.workspaceFolders[0].uri.fsPath : "";
        this._pkgPath = config.MAP_PKG_PATH ? config.MAP_PKG_PATH : "";
    }
}
