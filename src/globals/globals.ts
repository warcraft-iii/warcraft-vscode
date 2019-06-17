/**
 * @File   : globals.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/22/2019, 12:15:11 AM
 */

export namespace globals {
    export const LUA = '.lua';
    export const LUA_REG = new RegExp(LUA + '$');

    export const TEMPLATE_URL = 'https://github.com/warcraft-iii/warcraft-template/archive/master.zip';

    export const EXTENSION_ID = 'Dencer.warcraft-vscode';

    export const FILE_DEBUG_MAP = '_warcraft_vscode_test.w3x';
    export const FILE_ENTRY = 'war3map.lua';
    export const FILE_PACKLIST = 'packlist.json';
    export const FILE_PROJECT = 'warcraft.json';

    export const FOLDER_BUILD = '.build';
    export const FOLDER_IMPORTS = 'imports';
    export const FOLDER_LIBRARIES = 'lib';
    export const FOLDER_SOURCE = 'src';
}
