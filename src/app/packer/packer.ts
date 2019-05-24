/**
 * @File   : packer.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 12:27:25 PM
 */

export enum PackerType {
    Debug,
    Release
}

export interface Packer {
    execute(): Promise<void>;
    type(): PackerType;
}
