/**
 * @File   : private.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:04:39 AM
 */

import * as utils from '../utils';

import template from 'lodash-es/template';
import templateSettings from 'lodash-es/templateSettings';

import { env } from '../environment';
import { CompilerType } from './compiler';

templateSettings.interpolate = /\-\-\[\[%\=([\s\S]+?)%\]\]/g;
templateSettings.evaluate = /\-\-\[\[%\>([\s\S]+?)%\]\]/g;

export async function readCompilerTemplate(compilerType: CompilerType, file: string) {
    return template(
        (await utils.readFile(env.asExetensionPath('templates', CompilerType[compilerType].toLowerCase(), file))).trim()
    );
}
