/**
 * @File   : environment.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/22/2019, 11:18:19 AM
 */

import * as path from 'path';
import * as vscode from 'vscode';
import * as fs from 'fs-extra';
import * as cp from 'child_process';

import { PROJECT_FILE } from './globals';
import { promisify } from 'util';

const execFile = promisify(cp.execFile);

const FILE_MAP = '_warcraft_vscode_test.w3x';
const FOLDER_BUILD = '.build';
const FOLDER_IMPORTS = 'imports';
const REQUIRED_CONFIG_KEYS = ['sourcedir', 'mapdir'];
const REQUIRED_SETTING_KEYS = ['gamePath', 'wePath'];

interface WarcraftJson {
    mapdir?: string;
    sourcedir?: string;
}

class Environment {
    private data: WarcraftJson;
    private context?: vscode.ExtensionContext;
    private documentFolder?: string;

    private get config() {
        return vscode.workspace.getConfiguration('warcraft');
    }

    asExetensionPath(...args: string[]) {
        return path.join(this.extensionFolder, ...args);
    }

    asMapPath(...args: string[]) {
        return path.join(this.mapFolder, ...args);
    }

    asBuildPath(...args: string[]) {
        return path.join(this.buildFolder, ...args);
    }

    asGamePath(...args: string[]) {
        return path.join(path.dirname(this.gamePath), ...args);
    }

    asDocumentPath(...args: string[]) {
        if (!this.documentFolder) {
            throw new Error('Not found documents folder');
        }
        return path.join(this.documentFolder, ...args);
    }

    get extensionFolder() {
        return this.context ? this.context.extensionPath : '';
    }

    get rootPath() {
        if (!vscode.workspace.workspaceFolders) {
            throw Error('Not warcraft III map project');
        }
        return vscode.workspace.workspaceFolders[0].uri.fsPath;
    }

    get gamePath(): string {
        return this.config.get('gamePath') || '';
    }

    get wePath(): string {
        return this.config.get('wePath') || '';
    }

    get allowSshLibrary(): boolean {
        return this.config.get<boolean>('allowAddSshLibrary') || false;
    }

    get gameArgs(): string[] {
        return this.config.get('gameArgs') || [];
    }

    get weArgs(): string[] {
        return this.config.get('weArgs') || [];
    }

    get autoCloseClient(): boolean {
        return this.config.get<boolean>('autoCloseClient') || false;
    }

    set autoCloseClient(flag: boolean) {
        this.config.update('autoCloseClient', flag, vscode.ConfigurationTarget.Global);
    }

    get sourceFolder(): string {
        if (!this.data.sourcedir) {
            throw new Error('sourcedir not set in warcraft.json');
        }
        return path.join(this.rootPath, this.data.sourcedir);
    }

    get mapFolder(): string {
        if (!this.data.mapdir) {
            throw new Error('mapdir not set in warcraft.json');
        }
        return path.join(this.rootPath, this.data.mapdir);
    }

    get buildFolder(): string {
        return path.join(this.rootPath, FOLDER_BUILD);
    }

    get importsFolder(): string {
        return path.join(this.rootPath, FOLDER_IMPORTS);
    }

    get outMapPath(): string {
        return path.join(this.buildFolder, FILE_MAP);
    }

    private async loadProjectConfig() {
        const configFile = path.join(this.rootPath, PROJECT_FILE);
        if (!(await fs.pathExists(configFile))) {
            throw new Error(`Not found ${PROJECT_FILE}`);
        }
        const stat = await fs.stat(configFile);
        if (!stat.isFile()) {
            throw new Error(`Not found ${PROJECT_FILE}`);
        }

        const config = await fs.readJson(configFile, { encoding: 'utf-8' });
        if (!config) {
            throw new Error(`Parse ${PROJECT_FILE} failed`);
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
        type Env = Map<string, string>;
        const sys: Env = new Map(Object.keys(process.env).map(key => [key.toLowerCase(), process.env[key]])) as Env;

        let stdout: string;
        try {
            const result = await execFile('reg', [
                'query',
                'HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders',
                '/v',
                'Personal'
            ]);
            stdout = result.stdout;
        } catch (error) {
            throw new Error('Not found documents folder');
        }

        const m = stdout.match(/Personal\s+REG_EXPAND_SZ\s+([^\r\n]+)/);
        if (!m) {
            throw new Error('Not found documents folder');
        } else {
            this.documentFolder = m[1].replace(/%([^%]+)%/g, (_, x) => {
                x = x.toLowerCase();
                return sys.has(x) ? sys.get(x) : x;
            });
        }
    }

    async init(context: vscode.ExtensionContext) {
        this.context = context;
        await this.initDocumentFolder();
    }

    async verifyProjectConfig() {
        await this.loadProjectConfig();
        await this.checkProjectConfig();
    }
}

export const env = new Environment();
