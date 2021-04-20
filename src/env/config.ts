/**
 * @File   : config.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 12:57:32 PM
 */
import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs-extra';
import * as utils from '../utils';

import isArray from 'lodash-es/isArray';
import isString from 'lodash-es/isString';
import isBoolean from 'lodash-es/isBoolean';
import isUndefined from 'lodash-es/isUndefined';
import isPlainObject from 'lodash-es/isPlainObject';

import { globals, localize, ConfigurationType, GithubOrgOrUserInfo, WarcraftVersionType } from '../globals';

interface WarcraftJson {
    mapdir?: string;
    files?: string[];
    'lua.package.path'?: string[];
}

interface LuaPackage {
    path: string[];
}

interface LuaConfig {
    package: LuaPackage;
}

interface WarcraftConfig {
    mapdir?: string;
    files: string[];
    lua: LuaConfig;
}

function isStringArray(val: any) {
    return isArray(val) && val.every(isString);
}

export class Config {
    private defaultConfig: WarcraftConfig = {
        files: [],
        lua: {
            package: {
                path: ['./?.lua', './?/init.lua'],
            },
        },
    };
    private projectConfig = this.defaultConfig;
    private waiter?: Promise<void>;

    constructor() {
        this.reload();
    }

    reload() {
        return (this.waiter =
            this.waiter ||
            new Promise<void>((resolve) => {
                this.readProjectConfig()
                    .then((cfg) => {
                        this.projectConfig = cfg || this.defaultConfig;
                        resolve();
                    })
                    .finally(() => {
                        this.waiter = undefined;
                    });
            }));
    }

    async waitLoaded() {
        if (this.waiter) {
            await this.waiter;
        }
    }

    private get config() {
        return vscode.workspace.getConfiguration('warcraft');
    }

    private async readProjectConfig(): Promise<WarcraftConfig | undefined> {
        if (!vscode.workspace.workspaceFolders) {
            return;
        }

        const file = path.resolve(vscode.workspace.workspaceFolders[0].uri.fsPath, globals.FILE_PROJECT);
        if (!(await fs.pathExists(file))) {
            return;
        }
        if (!(await fs.stat(file)).isFile()) {
            return;
        }

        const content = await fs.readJson(file);
        if (!isPlainObject(content)) {
            return;
        }

        const json = utils.pick<WarcraftJson>(content, {
            mapdir: isString,
            files: isStringArray,
            'lua.package.path': isStringArray,
        });

        return {
            mapdir: json.mapdir,
            files: json.files || [],
            lua: {
                package: {
                    path: ['./?.lua', './?/init.lua', ...(json['lua.package.path'] || [])],
                },
            },
        };
    }

    get gamePath() {
        const value = this.config.get<string>('gamePath');
        if (!value) {
            throw Error(localize('error.noGamePath', 'Not found: Warcraft III.exe'));
        }
        return value;
    }

    set gamePath(value: string) {
        this.config.update('gamePath', value, vscode.ConfigurationTarget.Global);
    }

    get wePath() {
        const value = this.config.get<string>('wePath');
        if (!value) {
            throw Error(localize('error.noEditorPath', 'Not found: World Editor.exe'));
        }
        return value;
    }

    set wePath(value: string) {
        this.config.update('wePath', value, vscode.ConfigurationTarget.Global);
    }

    private parseArguments(args: string[]) {
        const result = [];
        for (const argument of args) {
            let arg = argument;
            while (arg.length > 0) {
                const hasQoutes = arg.startsWith('"');
                const pos = arg.indexOf(hasQoutes ? '"' : ' ', hasQoutes ? 1 : 0);

                if (pos < 0) {
                    if (hasQoutes) {
                        throw Error(localize('error.invalidGameArgs', `Invalid argument with qoutes ${argument}`));
                    }
                    result.push(arg);
                    break;
                } else {
                    result.push(arg.substr(0, hasQoutes ? pos + 1 : pos));
                    arg = arg.substr(pos + 1);
                }
            }
        }

        return result;
    }

    get gameArgs() {
        const gameArgs = this.config.get<string[]>('gameArgs') || [];
        return this.parseArguments(gameArgs);
    }

    get weArgs() {
        const weArgs = this.config.get<string[]>('weArgs') || [];
        return this.parseArguments(weArgs);
    }

    get autoCloseClient() {
        return this.config.get<boolean>('autoCloseClient') || false;
    }

    set autoCloseClient(value: boolean) {
        this.config.update('autoCloseClient', value, vscode.ConfigurationTarget.Global);
    }

    get configuration() {
        return ConfigurationType[this.config.get<string>('configuration') || ''] || ConfigurationType.Debug;
    }

    set configuration(value: ConfigurationType) {
        this.config.update('configuration', ConfigurationType[value], vscode.ConfigurationTarget.Workspace);
    }

    get warcraftVersion() {
        return WarcraftVersionType[this.config.get<string>('warcraftVersion') || ''] || WarcraftVersionType.Reforge;
    }

    set warcraftVersion(value: WarcraftVersionType) {
        this.config.update('warcraftVersion', WarcraftVersionType[value], vscode.ConfigurationTarget.Workspace);
    }

    get classic() {
        return this.warcraftVersion === WarcraftVersionType.Classic;
    }

    get codeConfusion() {
        return this.config.get<boolean>('codeConfusion') || false;
    }

    set codeConfusion(value: boolean) {
        this.config.update('codeConfusion', value, vscode.ConfigurationTarget.Global);
    }

    get mapDir() {
        if (!this.projectConfig.mapdir) {
            throw Error(localize('error.noMapFolder', 'Not found: map folder'));
        }
        return this.projectConfig.mapdir;
    }

    set mapDir(value: string) {
        if (!vscode.workspace.workspaceFolders) {
            return;
        }

        const rootPath = vscode.workspace.workspaceFolders[0].uri.fsPath;

        fs.writeJSON(path.resolve(rootPath, globals.FILE_PROJECT), this.projectConfig);

        this.projectConfig.mapdir = value;
    }

    get files() {
        return this.projectConfig.files;
    }

    get lua() {
        return this.projectConfig.lua;
    }

    get libraryOrganizations() {
        const setting = this.config.get<GithubOrgOrUserInfo[]>('libraryOrganizations');
        if (!setting || !isArray(setting)) {
            return;
        }

        const orgs = setting
            .map((item) =>
                utils.pick<GithubOrgOrUserInfo>(item, {
                    name: isString,
                    type: (x) => isUndefined(x) || (isString(x) && (x === 'user' || x === 'organization')),
                    ssh: (x) => isUndefined(x) || isBoolean(x),
                })
            )
            .filter((item) => item.name);

        return orgs.length > 0 ? orgs : undefined;
    }
}
