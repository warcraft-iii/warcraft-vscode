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
import * as luaparse from 'luaparse';
import * as luamin from 'luamin';
import { LuaFactory, LuaEngine } from 'wasmoon';

export interface Compiler {
    execute(): Promise<void>;
    type(): ConfigurationType;
}

export abstract class BaseCompiler implements Compiler {
    private luaEngine: LuaEngine;

    abstract execute(): Promise<void>;
    abstract type(): ConfigurationType;

    protected processCodeMacros(code: string) {

        const ignores: string[] = [];
        const accepts: string[] = [];

        ignores.push('remove');

        if (this.type() === ConfigurationType.Release) {
            ignores.push('debug');
            ignores.push('non-release');
            accepts.push('release');
            accepts.push('non-debug');
        } else {
            ignores.push('release');
            ignores.push('non-debug');
            accepts.push('debug');
            accepts.push('non-release');
        }

        if (env.config.warcraftVersion === WarcraftVersionType.Classic) {
            ignores.push('reforge');
            ignores.push('non-classic');
            accepts.push('classic');
            accepts.push('non-reforge');
        } else {
            ignores.push('classic');
            ignores.push('non-reforge');
            accepts.push('reforge');
            accepts.push('non-classic');
        }

        code = code.trimRight();

        for (const key of accepts) {
            code = code
                .replace(RegExp(`--\\[=*\\[@${key}@`, 'mg'), `--@${key}@`)
                .replace(RegExp(`--\\s*@end-${key}@\\]=*\\]`, 'mg'), `--@end-${key}@`);
        }

        for (const key of ignores) {
            const comment = BaseCompiler.getCommentEqual(code);
            code = code
                .replace(RegExp(`--\\s*@${key}@`, 'mg'), `--[${comment}[@${key}@`)
                .replace(RegExp(`--\\s*@end-${key}@\\s*$`, 'mg'), `--@end-${key}@]${comment}]`);
        }

        return code;
    }

    static getCommentEqual(code: string) {
        const m = code.match(/\[(=*)\[|\](=*)\]/g);
        const exists = new Set(m ? m.map((x) => x.length - 2) : []);

        let length = 0;
        while (exists.has(length)) {
            length++;
        }
        return '='.repeat(length);
    }

    static toLuaString(str: string) {
        const comment = BaseCompiler.getCommentEqual(str);
        if (comment.length > 0) {
            return `[${comment}[${str}]${comment}]`
        }
        return `[[${str}]]`
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
            if (mainFunc && (line.includes('call InitGlobals()') || line.includes('call InitGlobals(  )'))) {
                jass.splice(index, 1, '    call InitGlobals()', '    call Cheat("exec-lua:war3map")');
                break;
            }
            if (mainFunc && line.includes('endfunction')) {
                jass.splice(index, 1, '    call Cheat("exec-lua:war3map")', 'endfunction');
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

    protected async initLuaEngine() {
        if (this.luaEngine) {
            return;
        }
        const factory = new LuaFactory(
            (() => {
                const p = env.asExetensionPath('out/glue.wasm');
                return fs.existsSync(p) ? p : undefined;
            })()
        );
        this.luaEngine = await factory.createEngine();

        const apis = {
            io: {
                readFile: (fileName: string) => fs.readFileSync(fileName, { encoding: 'utf-8' }),
                writeFile: (fileName: string, content: string) => fs.writeFileSync(fileName, content, { encoding: 'utf-8' }),
            }
        };

        for (const [t, v] of Object.entries(apis)) {
            this.luaEngine.global.getTable(t, (idx) => {
                for (const [n, f] of Object.entries(v)) {
                    this.luaEngine.global.setField(idx, n, f);
                }
            });
        }
    }

    /**
     * Digital character set
     */
    static NumberCharSet = new Set<string>(['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']);

    /**
     * The first valid character set for a word
     */
    static WordFirstValidCharSet = new Set<string>(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '_']);

    /**
     *
     * @description Check 's' is a vaild word
     * @param s input string
     * @returns true if 's' is a Valid word
     */
    static isValidWord(s: string): boolean {
        for (let i = 0; i < s.length; ++i) {
            const c = s[i];
            if (i == 0) {
                if (!BaseCompiler.WordFirstValidCharSet.has(c))
                    return false;
            } else {
                if (!BaseCompiler.WordFirstValidCharSet.has(c) && !BaseCompiler.NumberCharSet.has(c))
                    return false;
            }
        }
        return true;
    }

    static makeLuaKey(s: string): string {
        if (parseInt(s).toString() == s) {
            return `[${s}]`;
        } else if (BaseCompiler.isValidWord(s)) {
            return s;
        }
        return `['${s.replace(`'`, `\\'`)}']`;
    }

    static toLua(obj: any, currDepth: number = 0, CurrEntry?: string, pretty: boolean = false): string {
        const NextDepth = currDepth + 1;
        CurrEntry = (CurrEntry != undefined && pretty) ? CurrEntry + '\t' : '';
        const ObjectEntry = (CurrEntry != undefined && pretty) ? CurrEntry + '\t' : '';
        const EndLine = pretty ? '\n' : '';
        const WriteSpace = pretty ? ' ' : '';
        if (obj === null || obj === undefined) {
            return 'nil';
        }
        if (typeof obj !== 'object') {
            if (typeof obj === 'string') {
                return BaseCompiler.toLuaString(obj);
            }
            return obj.toString();
        }
        let result = `{` + EndLine,
            isArray = obj instanceof Array,
            len = Object.entries(obj).length,
            i = 0;

        for (const [k, v] of Object.entries(obj)) {
            let objStr = '';
            if (isArray) {
                objStr = BaseCompiler.toLua(v, NextDepth, CurrEntry, pretty);
            } else {
                objStr = `${BaseCompiler.makeLuaKey(k)}${WriteSpace}=${WriteSpace}${BaseCompiler.toLua(v, NextDepth, CurrEntry, pretty)}`;
            }
            if (i < len - 1) {
                objStr += ',';
            }
            i += 1;
            result += ObjectEntry + objStr + EndLine;
        };
        result += CurrEntry + '}';
        return result;
    }

    protected checkCompileTime(fileName: string | undefined, node: luaparse.Node) {
        if (node.type === 'CallExpression' &&
            node.base.type === 'Identifier' && node.base.name == 'compiletime') {
            if (node.arguments.length != 1 || node.arguments[0].type != 'FunctionDeclaration') {
                throw Error(localize('error.processFilesFailure', ['File: ' + fileName, 'Line: ' + node.loc?.start.line, 'Error: Incorrect compiletime argument'].join('\n')));
            }

            const script = luamin.stringify(node.arguments[0]);
            this.luaEngine.global.loadString(script);
            const result = this.luaEngine.global.runSync();

            var newNode = node as any;
            newNode.type = 'StringLiteral';
            newNode.raw = result.map((v) => BaseCompiler.toLua(v)).join(',');
            return true;
        }
        return false;
    }
}
