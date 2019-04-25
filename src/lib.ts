/**
 * @File   : lib.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 4/24/2019, 11:20:43 AM
 */

import Octokit from "@octokit/rest";
import * as vscode from "vscode";
import * as path from "path";
import * as fs from "mz/fs";
import * as cp from "mz/child_process";
import env from "./environment";

const octokit = new Octokit();

export interface ClassicLibrary extends vscode.QuickPickItem {
    clone_url: string;
    ssh_url: string;
}

export async function getClassicLibraries(): Promise<ClassicLibrary[]> {
    const repos = await octokit.repos.listForOrg({
        org: "warcraft-iii",
        type: "public"
    });

    return repos.data
        .filter(item => item.name.startsWith("lib-"))
        .map(item => ({
            label: item.name.replace(/^lib-/i, ""),
            clone_url: item.clone_url,
            ssh_url: item.ssh_url,
            description: item.clone_url
        }));
}

export async function addLibrary(library: ClassicLibrary, ssh: boolean) {
    const target = path.posix.join("src/lib", library.label);

    if (await fs.exists(path.join(env.rootPath, target))) {
        throw new Error(`${target} already exists`);
    }

    const [err, output] = await cp.execFile(
        "git",
        ["submodule", "add", ssh ? library.ssh_url : library.clone_url, target],
        {
            cwd: env.rootPath
        }
    );

    if (err) {
        throw new Error(output);
    }
}
