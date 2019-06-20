/**
 * @File   : library.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/26/2019, 12:39:42 AM
 */

import * as vscode from 'vscode';
import * as fs from 'fs-extra';
import * as path from 'path';
import * as git from 'simple-git/promise';
import * as Octokit from '@octokit/rest';
import * as utils from '../../utils';

import { env } from '../../env';
import { localize, globals } from '../../globals';

export interface GithubOrgInfo {
    name: string;
    type?: 'org';
    ssh?: boolean;
}

export interface GithubUserInfo {
    name: string;
    type: 'user';
    ssh?: boolean;
}

export type GithubOrgOrUserInfo = GithubOrgInfo | GithubUserInfo;

interface RepoInfo {
    name: string;
    url: string;
}

const ORGS: GithubOrgOrUserInfo[] = [
    {
        name: 'warcraft-iii'
    }
];

type ReposResponse = Octokit.Response<Octokit.ReposListForOrgResponseItem[]>;

class Library {
    private repo = git(env.rootPath);
    private github = new Octokit();

    private async askOrg() {
        if (ORGS.length === 1) {
            return ORGS[0];
        }

        const result = await vscode.window.showQuickPick(
            ORGS.map(item => ({
                label: item.name,
                description:
                    item.type === 'user' ? localize('quick.Org', 'Organization') : localize('quick.User', 'User'),
                value: item
            })),
            { ignoreFocusOut: true }
        );

        return result ? result.value : undefined;
    }

    private async getOrgRepos(org: GithubOrgOrUserInfo): Promise<RepoInfo[]> {
        const resp =
            org.type === 'user'
                ? ((await this.github.repos.listForUser({ username: org.name })) as ReposResponse)
                : await this.github.repos.listForOrg({ org: org.name, type: 'public' });

        const regex = /^lib[-._]/;

        return resp.data
            .filter(item => regex.test(item.name))
            .map(item => ({
                name: item.name.replace(regex, ''),
                url: org.ssh ? item.ssh_url : item.clone_url
            }));
    }

    private async askRepo(org: GithubOrgOrUserInfo) {
        const asyncRepos = async () => {
            const exists = new Set(await fs.readdir(env.asSourcePath(globals.FOLDER_LIBRARIES)));
            const repos = (await this.getOrgRepos(org)).filter(item => !exists.has(item.name));

            if (repos.length === 0) {
                throw Error(localize('error.noMoreLibrary', 'No more libraries in {0}', org.name));
            }

            return repos.map(item => ({
                label: item.name,
                description: item.url,
                value: item
            }));
        };

        const result = await vscode.window.showQuickPick(asyncRepos(), { ignoreFocusOut: true });
        if (!result) {
            return;
        }
        return result.value;
    }

    private async askGit() {
        const result = await utils.confirm(
            localize('confirm.gitAddLibrary', 'Project is not initialized with Git, init it?'),
            localize('confirm.accept', 'Accept')
        );

        if (result) {
            await this.repo.init();
        }
        return !!result;
    }

    private async isGit() {
        try {
            await this.repo.status();
            return true;
        } catch (error) {}
        return false;
    }

    @utils.report(localize('report.addSubmodule', 'Adding submodule'))
    async addLibrary(repo: RepoInfo) {
        if (!env.rootPath) {
            return;
        }
        return await this.repo.submoduleAdd(
            repo.url,
            utils.posixCase(path.relative(env.rootPath, env.asSourcePath(globals.FOLDER_LIBRARIES, repo.name)))
        );
    }

    async add() {
        if (!(await this.isGit())) {
            if (!(await this.askGit())) {
                return;
            }
        }

        const org = await this.askOrg();
        if (!org) {
            return;
        }

        const repo = await this.askRepo(org);
        if (!repo) {
            return;
        }

        await this.addLibrary(repo);
    }
}

export const library = new Library();
