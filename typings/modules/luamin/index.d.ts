/**
 * @File   : index.d.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/28/2019, 9:30:22 AM
 */

declare module 'luamin' {
    import { Chunk, Statement } from 'luaparse';

    export function minify(code: string | Chunk): string;
    export function stringify(body: Statement): string;
}
