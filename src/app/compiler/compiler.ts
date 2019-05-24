/**
 * @File   : compiler.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 10:45:09 AM
 */

export enum CompilerType {
    Debug,
    Release
}

export interface Compiler {
    execute(): Promise<void>;
    type(): CompilerType;
}
