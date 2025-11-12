/**
 * @File   : config.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 12:57:32 PM
 */

import * as path from 'path';
import * as fs from 'fs-extra';
import * as utils from '../utils';
import { runtime, ConfigurationTarget } from './runtime';

import isArray from 'lodash-es/isArray';
import isString from 'lodash-es/isString';
import isBoolean from 'lodash-es/isBoolean';
import isUndefined from 'lodash-es/isUndefined';
import isPlainObject from 'lodash-es/isPlainObject';

import { globals, localize, ConfigurationType, GithubOrgOrUserInfo, WarcraftVersionType, LuaConfusionType } from '../globals';

interface LuaPackage {
    path: string[];
}

interface LuaConfig {
    package: LuaPackage;
}

interface WarcraftConfig {
    mapdir?: string;
    files: string[];
    jassfile?: string;
    lua: LuaConfig;
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
    public projectConfig = this.defaultConfig;
    private waiter?: Promise<void>;
    public isClassic: boolean;
    public isRelease: boolean
    public luaConfusionType: LuaConfusionType

    constructor() {
        if (runtime.inVscode) {
            this.reload();
        }
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
        return runtime.getConfiguration('warcraft');
    }

    private async readProjectConfig(): Promise<WarcraftConfig | undefined> {
        if (!runtime.workspaceFolder) {
            return;
        }

        const file = path.resolve(runtime.workspaceFolder, globals.FILE_PROJECT);
        if (!(await fs.pathExists(file))) {
            return;
        }
        if (!(await fs.stat(file)).isFile()) {
            return;
        }

        const json: WarcraftConfig = await fs.readJson(file);
        if (!isPlainObject(json)) {
            return;
        }

        return {
            mapdir: json.mapdir,
            files: json.files || [],
            jassfile: json.jassfile,
            lua: {
                package: {
                    path: [...(json.lua?.package?.path || ['./?.lua', './?/init.lua'])],
                },
            },
        };
    }

    get gamePath() {
        const value = this.config?.get<string>(this.classic ? 'gamePathClassic' : 'gamePath');
        if (!value) {
            throw Error(localize('error.noGamePath', 'Not found: Warcraft III.exe'));
        }
        return value;
    }

    set gamePath(value: string) {
        this.config?.update(this.classic ? 'gamePathClassic' : 'gamePath', value, ConfigurationTarget.Global);
    }

    get wePath() {
        const value = this.config?.get<string>(this.classic ? 'wePathClassic' : 'wePath');
        if (!value) {
            throw Error(localize('error.noEditorPath', 'Not found: World Editor.exe'));
        }
        return value;
    }

    set wePath(value: string) {
        this.config?.update(this.classic ? 'wePathClassic' : 'wePath', value, ConfigurationTarget.Global);
    }

    get kkwePath() {
        const value = this.config?.get<string>('kkwePath');
        if (!value) {
            throw Error(localize('error.noKKWEPath', 'Not found: YDWEConfig.exe'));
        }
        return value;
    }

    set kkwePath(value: string) {
        this.config?.update('kkwePath', value, ConfigurationTarget.Global);
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
        const gameArgs = this.config?.get<string[]>(this.classic ? 'gameArgsClassic' : 'gameArgs') || [];
        return this.parseArguments(gameArgs);
    }

    get weArgs() {
        const weArgs = this.config?.get<string[]>(this.classic ? 'weArgsClassic' : 'weArgs') || [];
        return this.parseArguments(weArgs);
    }

    get autoCloseClient() {
        return this.config?.get<boolean>('autoCloseClient') || false;
    }

    set autoCloseClient(value: boolean) {
        this.config?.update('autoCloseClient', value, ConfigurationTarget.Global);
    }

    get configuration() {
        if (this.config)
            return ConfigurationType[this.config?.get<string>('configuration') as keyof typeof ConfigurationType || ''] || ConfigurationType.Debug;
        return this.isRelease ? ConfigurationType.Release : ConfigurationType.Debug;
    }

    set configuration(value: ConfigurationType) {
        this.config?.update('configuration', ConfigurationType[value], ConfigurationTarget.Workspace);
    }

    get warcraftVersion() {
        if (this.config)
            return WarcraftVersionType[this.config?.get<string>('warcraftVersion') as keyof typeof WarcraftVersionType || ''] || WarcraftVersionType.Reforge;
        return this.isClassic ? WarcraftVersionType.Classic : WarcraftVersionType.Reforge;
    }

    set warcraftVersion(value: WarcraftVersionType) {
        this.config?.update('warcraftVersion', WarcraftVersionType[value], ConfigurationTarget.Workspace);
    }

    get classic() {
        if (this.config)
            return this.warcraftVersion === WarcraftVersionType.Classic;
        return this.isClassic == true;
    }

    get luaConfusion() {
        if (this.config)
            return LuaConfusionType[this.config.get<string>('luaConfusion') as keyof typeof LuaConfusionType || ''] || LuaConfusionType.Disable
        return this.luaConfusionType;
    }

    set luaConfusion(value: LuaConfusionType) {
        this.config?.update('luaConfusion', value, ConfigurationTarget.Global);
    }

    get mapDir() {
        if (!this.projectConfig.mapdir) {
            throw Error(localize('error.noMapFolder', 'Not found: map folder'));
        }
        return this.projectConfig.mapdir;
    }

    set mapDir(value: string) {
        if (!runtime.workspaceFolder) {
            return;
        }

        this.projectConfig.mapdir = value;
        const rootPath = runtime.workspaceFolder;
        fs.writeFile(path.resolve(rootPath, globals.FILE_PROJECT), JSON.stringify(this.projectConfig, undefined, 2));
    }

    get files() {
        return this.projectConfig.files;
    }

    get jassfile() {
        if (runtime.workspaceFolder && this.projectConfig.jassfile) {
            return path.resolve(runtime.workspaceFolder, this.projectConfig.jassfile);
        }
        return null;
    }

    get lua() {
        return this.projectConfig.lua;
    }

    get libraryOrganizations() {
        const setting = this.config?.get<GithubOrgOrUserInfo[]>('libraryOrganizations');
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
