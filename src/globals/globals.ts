/**
 * @File   : globals.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/22/2019, 12:15:11 AM
 */

export namespace globals {
    export const LUA = '.lua';

    export const TEMPLATE_URL = 'https://github.com/warcraft-iii/warcraft-template/archive/master.zip';

    export const EXTENSION_ID = 'Dencer.warcraft-vscode';

    export const FILE_DEBUG_MAP = '_warcraft_vscode_test';
    export const FILE_RELEASE_MAP = 'release';
    export const FILE_ENTRY = 'war3map.lua';
    export const FILE_ENTRY_JASS = 'war3map.j';
    export const FILE_PACKLIST = 'packlist.json';
    export const FILE_PROJECT = 'warcraft.json';

    export const FOLDER_BUILD = '.build';
    export const FOLDER_IMPORTS = 'imports';
    export const FOLDER_LIBRARIES = 'lib';
    export const FOLDER_SOURCE = 'src';
}

export enum ConfigurationType {
    Debug,
    Release
}

export enum WarcraftVersionType {
    Reforge,
    Classic
}

export interface GithubOrgInfo {
    name: string;
    type?: 'organization';
    ssh?: boolean;
}

export interface GithubUserInfo {
    name: string;
    type: 'user';
    ssh?: boolean;
}

export type GithubOrgOrUserInfo = GithubOrgInfo | GithubUserInfo;
