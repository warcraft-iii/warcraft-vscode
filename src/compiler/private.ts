/**
 * @File   : private.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:04:39 AM
 */

import * as fs from 'fs-extra';

import template from 'lodash-es/template';
import templateSettings from 'lodash-es/templateSettings';

import { env } from '../env';
import { CompilerType } from './compiler';

templateSettings.interpolate = /\-\-\[\[%\=([\s\S]+?)%\]\]/g;
templateSettings.evaluate = /\-\-\[\[%\>([\s\S]+?)%\]\]/g;

export function readCompilerTemplate(compilerType: CompilerType, file: string) {
    return template(
        fs.readFileSync(env.asExetensionPath('templates', CompilerType[compilerType].toLowerCase(), file), {
            encoding: 'utf-8'
        })
    );
}
