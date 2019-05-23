/**
 * @File   : utils.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 6:05:31 PM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as vscode from 'vscode';

import { LUA } from './globals';

async function _getAllFiles(root: string, r: string[]) {
    const files = (await fs.readdir(root)).map(file => path.join(root, file));

    for (const file of files) {
        const stat = await fs.stat(file);

        if (stat.isFile()) {
            r.push(file);
        } else if (stat.isDirectory()) {
            await _getAllFiles(file, r);
        }
    }
    return r;
}

export function getAllFiles(root: string) {
    return _getAllFiles(root, []);
}

export function sleep(n: number): Promise<void> {
    return new Promise(resolve => setTimeout(() => resolve(), n));
}

export function isLuaFile(file: string) {
    return path.extname(file).toLowerCase() === LUA;
}

export function isHiddenFile(file: string) {
    const name = path.basename(file);
    if (name.startsWith('.')) {
        return true;
    }

    if (isLuaFile(file) && name.startsWith('@')) {
        return true;
    }
    return false;
}

export function readFile(file: string) {
    return fs.readFile(file, { encoding: 'utf-8' });
}

export enum ConfirmResult {
    Cancel,
    Ok,
    Alt
}

export async function confirm(title: string, ok: string = 'Ok', alt?: string) {
    const items = [
        {
            title: ok,
            value: ConfirmResult.Ok
        }
    ];

    if (alt) {
        items.push({
            title: alt,
            value: ConfirmResult.Alt
        });
    }

    const result = await vscode.window.showInformationMessage(
        title,
        {
            modal: true
        },
        ...items
    );

    if (!result) {
        return;
    }
    return result.value;
}
