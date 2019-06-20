/**
 * @File   : compiler.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:09 AM
 */

import * as fs from 'fs-extra';

import template from 'lodash-es/template';
import templateSettings from 'lodash-es/templateSettings';

import { env } from '../../env';
import { ConfigurationType } from '../../globals';

templateSettings.interpolate = /\-\-\[\[%\=([\s\S]+?)%\]\]/g;
templateSettings.evaluate = /\-\-\[\[%\>([\s\S]+?)%\]\]/g;

export interface Compiler {
    execute(): Promise<void>;
    type(): ConfigurationType;
}

export abstract class BaseCompiler implements Compiler {
    abstract execute(): Promise<void>;
    abstract type(): ConfigurationType;

    processCodeMacros(code: string) {
        const comment = this.getCommentEqual(code);
        code = code
            .trimRight()
            .replace(/--@remove@/g, `--[${comment}[@remove@`)
            .replace(/--@end-remove@/g, `--@end-remove@]${comment}]`);

        if (this.type() === ConfigurationType.Release) {
            code = code
                .replace(/--@debug@/g, `--[${comment}[@debug@`)
                .replace(/--@end-debug@/g, `--@end-debug@]${comment}]`);
        }

        if (this.type() === ConfigurationType.Debug) {
            code = code
                .replace(/--@release@/g, `--[${comment}[@release@`)
                .replace(/--@end-release@/g, `--@end-release@]${comment}]`);
        }
        return code;
    }

    getCommentEqual(code: string) {
        const m = code.match(/\[(=*)\[|\](=*)\]/g);
        const exists = new Set(m ? m.map(x => x.length - 2) : []);

        let length = 0;
        while (exists.has(length)) {
            length++;
        }
        return '='.repeat(length);
    }

    readCompilerTemplate(file: string) {
        return template(
            fs.readFileSync(env.asExetensionPath('templates', ConfigurationType[this.type()].toLowerCase(), file), {
                encoding: 'utf-8'
            })
        );
    }
}
