/**
 * @File   : utils.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 6:05:31 PM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as vscode from 'vscode';

async function _getAllFiles(root: string, r: string[], isDir: boolean, recursive: boolean) {
    const files = (await fs.readdir(root)).map(file => path.join(root, file));

    for (const file of files) {
        const stat = await fs.stat(file);

        if (stat.isDirectory()) {
            if (recursive) {
                await _getAllFiles(file, r, isDir, recursive);
            }
            if (isDir) {
                r.push(file);
            }
        } else if (!isDir) {
            r.push(file);
        }
    }

    return r;
}

export enum ConfirmResult {
    Cancel,
    Ok,
    Alt
}

export function getAllFiles(root: string, isDir: boolean = false, recursive: boolean = true) {
    return _getAllFiles(root, [], isDir, recursive);
}

export function sleep(n: number) {
    return new Promise<void>(resolve => setTimeout(() => resolve(), n));
}

export function isLuaFile(file: string) {
    return path.extname(file).toLowerCase() === '.lua';
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
