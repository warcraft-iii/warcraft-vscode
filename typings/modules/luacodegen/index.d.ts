declare module 'luacodegen' {
    export function gen(ast: Chunk | string): string;
    export = gen;
}
