/**
 * @File   : environment.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 11:18:19 AM
 */

import * as path from "path";
import * as vscode from "vscode";
import * as fs from "fs-extra";
import * as cp from "child_process";

import { promisify } from "util";

const FILE_WARCRAFT = "warcraft.json";
const FILE_SCRIPT = "war3map.lua";
const FILE_MAP = "_warcraft_vscode_test.w3x";
const FOLDER_BUILD = ".build";
const REQUIRED_CONFIG_KEYS = ["sourcedir", "mapdir"];
const REQUIRED_SETTING_KEYS = ["gamePath", "wePath"];

class Environment {
    private data: any;
    private _documentFolder?: string;

    private get config() {
        return vscode.workspace.getConfiguration("warcraft");
    }

    get documentFolder() {
        return this._documentFolder;
    }

    get rootPath() {
        return vscode.workspace.workspaceFolders ? vscode.workspace.workspaceFolders[0].uri.fsPath : "";
    }

    get gamePath(): string {
        return this.config.get("gamePath") || "";
    }

    get wePath(): string {
        return this.config.get("wePath") || "";
    }

    get allowSshLibrary(): boolean {
        return this.config.get<boolean>("allowAddSshLibrary") || false;
    }

    get gameArgs(): string[] {
        return this.config.get("gameArgs") || [];
    }

    get weArgs(): string[] {
        return this.config.get("weArgs") || [];
    }

    get sourceFolder(): string {
        return path.join(this.rootPath, this.data.sourcedir);
    }

    get mapFolder(): string {
        return path.join(this.rootPath, this.data.mapdir);
    }

    get buildFolder(): string {
        return path.join(this.rootPath, FOLDER_BUILD);
    }

    get buildMapFolder(): string {
        return path.join(this.buildFolder, this.data.mapdir);
    }

    get outMapPath(): string {
        return path.join(this.buildFolder, FILE_MAP);
    }

    get outScriptPath(): string {
        return path.join(this.buildMapFolder, FILE_SCRIPT);
    }

    get tempScriptPath(): string {
        return path.join(this.buildFolder, FILE_SCRIPT);
    }

    private async loadProjectConfig() {
        const configFile = path.join(this.rootPath, FILE_WARCRAFT);
        if (!(await fs.pathExists(configFile))) {
            throw new Error(`Not found ${FILE_WARCRAFT}`);
        }
        const stat = await fs.stat(configFile);
        if (!stat.isFile()) {
            throw new Error(`Not found ${FILE_WARCRAFT}`);
        }

        const config = await fs.readJson(configFile, { encoding: "utf-8" });
        if (!config) {
            throw new Error(`Parse ${FILE_WARCRAFT} failed`);
        }

        this.data = config;
    }

    private async checkProjectConfig() {
        for (const key of REQUIRED_CONFIG_KEYS) {
            if (!this.data[key]) {
                throw new Error(`Lost config ${key}`);
            }
        }

        for (const key of REQUIRED_SETTING_KEYS) {
            if (!this.config.get(key)) {
                throw new Error(`${key} not set`);
            }
        }

        const folders = [this.sourceFolder, this.mapFolder, this.gamePath, this.wePath];
        for (const folder of folders) {
            if (!(await fs.pathExists(folder))) {
                throw new Error(`Not found dir: ${folder}`);
            }
        }
    }

    private async initDocumentFolder() {
        const exec = promisify(cp.exec);

        type Env = Map<string, string>;
        const env: Env = new Map(Object.keys(process.env).map(key => [key.toLowerCase(), process.env[key]])) as Env;

        try {
            const { stdout } = await exec(
                `reg query "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders" /v Personal`
            );

            const m = stdout.match(/Personal\s+REG_EXPAND_SZ\s+([^\r\n]+)/);
            if (!m) {
                return;
            } else {
                this._documentFolder = m[1].replace(/%([^%]+)%/g, (_, x) => {
                    x = x.toLowerCase();
                    return env.has(x) ? env.get(x) : x;
                });
            }
        } catch (error) {}
    }

    async init() {
        await this.initDocumentFolder();
    }

    async verifyProjectConfig() {
        await this.loadProjectConfig();
        await this.checkProjectConfig();
    }
}

export default new Environment();
