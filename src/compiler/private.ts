/**
 * @File   : private.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:04:39 AM
 */

import * as utils from '../utils';

import { templateSettings, template } from 'lodash';
import { env } from '../environment';
import { CompilerType } from './compiler';

export { TemplateExecutor } from 'lodash';

templateSettings.interpolate = /\-\-\[\[%\=([\s\S]+?)%\]\]/g;
templateSettings.evaluate = /\-\-\[\[%\>([\s\S]+?)%\]\]/g;

export async function readCompilerTemplate(compilerType: CompilerType, file: string) {
    return template(
        (await utils.readFile(env.asExetensionPath('templates', CompilerType[compilerType].toLowerCase(), file))).trim()
    );
}
