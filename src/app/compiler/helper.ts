/**
 * @File   : private.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:04:39 AM
 */

import * as fs from 'fs-extra';

import template from 'lodash-es/template';
import templateSettings from 'lodash-es/templateSettings';

import { env } from '../../env';
import { ConfigurationType } from '../../globals';

templateSettings.interpolate = /\-\-\[\[%\=([\s\S]+?)%\]\]/g;
templateSettings.evaluate = /\-\-\[\[%\>([\s\S]+?)%\]\]/g;

export function readCompilerTemplate(configurationType: ConfigurationType, file: string) {
    return template(
        fs.readFileSync(env.asExetensionPath('templates', ConfigurationType[configurationType].toLowerCase(), file), {
            encoding: 'utf-8'
        })
    );
}

export function getCommentEqual(code: string) {
    const m = code.match(/\[(=*)\[|\](=*)\]/g);
    const exists = new Set(m ? m.map(x => x.length - 2) : []);

    let length = 0;
    while (exists.has(length)) {
        length++;
    }
    return '='.repeat(length);
}
