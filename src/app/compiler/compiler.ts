/**
 * @File   : compiler.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:09 AM
 */

import { globals, ConfigurationType, WarcraftVersionType, localize } from '../../globals';
import { env } from '../../env';
import * as utils from '../../utils';
import * as fs from 'fs-extra';

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

        code = code.trimRight();

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

    protected async extractWar3mapJass(outPath: string, fileName: string) {
        if (!(await utils.extractFileFromMap(outPath, fileName))) {
            if (await utils.extractFileFromMap(outPath, 'scripts\\' + fileName)) {
                return true;
            } else {
                throw Error(localize('error.noMapScriptFile', `Not found: ${fileName} file`));
            }
        }
        return false;
    }

    protected async injectWar3mapJass() {
        const outPath = env.asBuildPath(globals.FILE_ENTRY_JASS);
        if (env.config.jassfile && (await fs.pathExists(env.config.jassfile))) {
            await fs.copyFile(env.config.jassfile, outPath);
        } else {
            await this.extractWar3mapJass(outPath, globals.FILE_ENTRY_JASS);
        }
        const jass = (await fs.readFile(outPath)).toString().split('\r\n');

        let mainFunc = false;
        let index = 0;
        for (const line of jass) {
            if (line.includes('function main takes nothing returns nothing')) {
                mainFunc = true;
            }
            if (mainFunc && line.includes('endfunction')) {
                jass.splice(index, 1, 'call Cheat("exec-lua:war3map")', 'endfunction');
                break;
            }
            index++;
        }
        if (!mainFunc) {
            throw Error(localize('error.noMapScriptFileMain', 'Not found: main function in War3map.j file'));
        }
        await fs.writeFile(outPath, jass.join('\r\n'));
    }

    protected async getOriginMapScript() {
        let scriptFile;
        if (((await fs.stat(env.mapFolder)).isFile())) {
            scriptFile = env.asBuildPath('orig' + globals.FILE_ENTRY);
            await this.extractWar3mapJass(scriptFile, globals.FILE_ENTRY);
        } else {
            scriptFile = env.asMapPath(globals.FILE_ENTRY);
        }
        return scriptFile;
    }
}
