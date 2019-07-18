/**
 * @File   : utils.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/18/2019, 6:05:31 PM
 */

import * as fs from 'fs-extra';
import * as path from 'path';
import * as vscode from 'vscode';
import * as got from 'got';
import * as yauzl from 'yauzl-promise';
import pickBy from 'lodash-es/pickBy';

async function _getAllFiles(root: string, r: string[], isDir: boolean, recursive: boolean) {
    const files = (await fs.readdir(root)).map(file => path.resolve(root, file));

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

export function posixCase(p: string) {
    return p.split(path.normalize(path.sep)).join(path.posix.sep);
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
        return ConfirmResult.Cancel;
    }
    return result.value;
}

export interface PickPredicate {
    [key: string]: (value: any) => boolean;
}

export function pick<T>(object: any, predicate: PickPredicate) {
    return pickBy(object, (value: any, key: string) => (predicate[key] ? predicate[key](value) : false)) as T;
}

type ResolvePath = (entry: yauzl.Entry) => string;

export async function extractFile(zipFile: yauzl.ZipFile, output: string | ResolvePath, relative?: string) {
    let resolvePath: ResolvePath;

    if (typeof output === 'string') {
        const outputDir = output;
        resolvePath = (entry: yauzl.Entry) =>
            path.resolve(outputDir, relative ? path.relative(relative, entry.fileName) : entry.fileName);
    } else {
        resolvePath = output;
    }

    await zipFile.walkEntries(entry => {
        if (entry.fileName.endsWith('/')) {
            return;
        }
        return new Promise((resolve, reject) => {
            const outputPath = resolvePath(entry);
            fs.mkdirp(path.dirname(outputPath))
                .then(() => entry.openReadStream())
                .then(stream =>
                    stream
                        .pipe(fs.createWriteStream(outputPath))
                        .on('close', () => resolve())
                        .on('error', err => reject(err))
                );
        });
    });
}

export async function downloadZip(url: string) {
    return await yauzl.fromBuffer((await got(url, { encoding: null })).body);
}
