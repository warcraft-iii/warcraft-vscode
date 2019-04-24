/**
 * @File   : config.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 11:18:19 AM
 */

import * as path from "path";
import * as vscode from "vscode";
import * as fs from "mz/fs";

const FOLDER_SOURCE = "src";
const FOLDER_MAP = "map.w3x";

const FILE_WARCRAFT = "warcraft.json";
const FILE_SCRIPT = "war3map.lua";
const FILE_MAP = "_" + FOLDER_MAP;

class Config {
    private _data: any;
    private _prop: any = {};

    static once(target: any, propertyKey: string, descriptor: any) {
        const getter = descriptor.get;
        const key = Symbol();
        descriptor.get = function() {
            return (this._prop[key] = this._prop[key] || getter.call(this));
        };
    }

    @Config.once
    get rootPath() {
        return vscode.workspace.workspaceFolders ? vscode.workspace.workspaceFolders[0].uri.fsPath : "";
    }

    get gamePath(): string {
        return this._data.GAME_PATH;
    }

    get wePath(): string {
        return this._data.WE_PATH;
    }

    get allowSshLibrary(): boolean {
        return !!this._data.ALLOW_SSH_LIBRARY;
    }

    @Config.once
    get gameArgs(): string[] {
        return this._data.GAME_ARGS ? this._data.GAME_ARGS : [];
    }

    @Config.once
    get weArgs(): string[] {
        return this._data.WE_ARGS ? this._data.WE_ARGS : [];
    }

    @Config.once
    get sourceFolder(): string {
        return path.join(this.rootPath, FOLDER_SOURCE);
    }

    @Config.once
    get mapFolder(): string {
        return path.join(this.rootPath, FOLDER_MAP);
    }

    @Config.once
    get mapPath(): string {
        return path.join(this.rootPath, FILE_MAP);
    }

    @Config.once
    get scriptPath(): string {
        return path.join(this.mapFolder, FILE_SCRIPT);
    }

    async load() {
        this._prop = {};

        const configFile = path.join(this.rootPath, FILE_WARCRAFT);
        const stat = await fs.stat(configFile);
        if (!stat.isFile()) {
            throw new Error(`Not found ${FILE_WARCRAFT}`);
        }

        const body = await fs.readFile(configFile, { encoding: "utf-8" });
        if (!body) {
            throw new Error("Read ${FILE_WARCRAFT} failed");
        }

        const config = JSON.parse(body);
        if (!config) {
            throw new Error(`Parse ${FILE_WARCRAFT} failed`);
        }

        const keys = ["GAME_PATH", "WE_PATH"];
        for (const key of keys) {
            if (!config[key]) {
                throw new Error(`Lost config ${key}`);
            }
        }

        this._data = config;
    }
}

export default new Config();
