/**
 * @File   : index.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 6/20/2019, 3:21:02 PM
 */

import template from 'lodash-es/template';

import DEBUG_MAIN from './debug/main.lua';
import DEBUG_FILE from './debug/file.lua';
import RELEASE_MAIN from './release/main.lua';
import RELEASE_FILE from './release/file.lua';

function luaTemplate(code: string) {
    return template(code, {
        interpolate: /\-\-\[\[%\=([\s\S]+?)%\]\]/g,
        evaluate: /\-\-\[\[%\>([\s\S]+?)%\]\]/g
    });
}

export namespace debug {
    export const main = luaTemplate(DEBUG_MAIN);
    export const file = luaTemplate(DEBUG_FILE);
}

export namespace release {
    export const main = luaTemplate(RELEASE_MAIN);
    export const file = luaTemplate(RELEASE_FILE);
}
