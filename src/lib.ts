/**
 * @File   : lib.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/24/2019, 11:20:43 AM
 */

import * as vscode from 'vscode';
import * as path from 'path';
import * as fs from 'fs-extra';
import * as cp from 'child_process';

import * as Octokit from '@octokit/rest';

import { env } from './environment';
import { promisify } from 'util';

export interface ClassicLibrary extends vscode.QuickPickItem {
    clone_url: string;
    ssh_url: string;
}

export async function getClassicLibraries(): Promise<ClassicLibrary[]> {
    const octokit = new Octokit();

    const repos = await octokit.repos.listForOrg({
        org: 'warcraft-iii',
        type: 'public'
    });

    return repos.data
        .filter(item => item.name.startsWith('lib-'))
        .map(item => ({
            label: item.name.replace(/^lib-/i, ''),
            clone_url: item.clone_url,
            ssh_url: item.ssh_url,
            description: item.clone_url
        }));
}

const execFile = promisify(cp.execFile);

export async function addLibrary(library: ClassicLibrary, ssh: boolean): Promise<void> {
    const target = path.posix.join('src/lib', library.label);

    if (await fs.pathExists(path.join(env.rootPath, target))) {
        throw new Error(`${target} already exists`);
    }

    try {
        const { stdout, stderr } = await execFile(
            'git',
            ['submodule', 'add', ssh ? library.ssh_url : library.clone_url, target],
            {
                cwd: env.rootPath
            }
        );

        console.log(stdout, stderr);
    } catch (e) {
        throw e;
    }
}
