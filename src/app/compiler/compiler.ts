/**
 * @File   : compiler.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:09 AM
 */

import { ConfigurationType, WarcraftVersionType } from '../../globals';
import { env } from '../../env';

export interface Compiler {
    execute(): Promise<void>;
    type(): ConfigurationType;
}

export abstract class BaseCompiler implements Compiler {
    abstract execute(): Promise<void>;
    abstract type(): ConfigurationType;

    protected processCodeMacros(code: string) {
        const comment = this.getCommentEqual(code);

        const ignores: string[] = [];
        const accepts: string[] = [];

        ignores.push('remove');

        if (this.type() === ConfigurationType.Release) {
            ignores.push('debug');
            accepts.push('non-debug');
        }

        if (env.config.warcraftVersion === WarcraftVersionType.Classic) {
            ignores.push('reforge');
            accepts.push('non-reforge');
        } else {
            ignores.push('classic');
            accepts.push('non-classic');
        }

        for (const key of ignores) {
            code = code
                .replace(RegExp(`--\\s*@${key}@`, 'g'), `--[${comment}[@${key}@`)
                .replace(RegExp(`--\\s*@end-${key}@`, 'g'), `--@end-${key}@]${comment}]`);
        }
        for (const key of accepts) {
            code = code
                .replace(RegExp(`--\\s*\\[=*\\[@${key}@`, 'g'), `--@${key}@`)
                .replace(RegExp(`--\\s*@end-${key}@\\]=*\\]`, 'g'), `--@end-${key}@`);
        }

        return code;
    }

    protected getCommentEqual(code: string) {
        const m = code.match(/\[(=*)\[|\](=*)\]/g);
        const exists = new Set(m ? m.map((x) => x.length - 2) : []);

        let length = 0;
        while (exists.has(length)) {
            length++;
        }
        return '='.repeat(length);
    }
}
