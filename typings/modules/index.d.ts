declare module '*.lua' {
    declare function template(data: any): string;
    declare namespace template {}

    export = template;
}
