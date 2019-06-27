/**
 * @File   : compiler.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:09 AM
 */

import { ConfigurationType } from '../../globals';

export interface Compiler {
    execute(): Promise<void>;
    type(): ConfigurationType;
}

export abstract class BaseCompiler implements Compiler {
    abstract execute(): Promise<void>;
    abstract type(): ConfigurationType;

    protected processCodeMacros(code: string) {
        const comment = this.getCommentEqual(code);
        code = code
            .trimRight()
            .replace(/--\s*@remove@/g, `--[${comment}[@remove@`)
            .replace(/--\s*@end-remove@/g, `--@end-remove@]${comment}]`);

        if (this.type() === ConfigurationType.Release) {
            code = code
                .replace(/--\s*@debug@/g, `--[${comment}[@debug@`)
                .replace(/--\s*@end-debug@/g, `--@end-debug@]${comment}]`)
                .replace(/--\s*\[=*\[@non-debug@/g, '--@non-debug@')
                .replace(/--\s*@end-non-debug@\]=*\]/g, '--@end-non-debug@');
        }
        return code;
    }

    protected getCommentEqual(code: string) {
        const m = code.match(/\[(=*)\[|\](=*)\]/g);
        const exists = new Set(m ? m.map(x => x.length - 2) : []);

        let length = 0;
        while (exists.has(length)) {
            length++;
        }
        return '='.repeat(length);
    }
}
