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
import { localize, globals, GithubOrgOrUserInfo } from '../../globals';

interface RepoInfo {
    name: string;
    url: string;
}

type ReposResponse = Octokit.Response<Octokit.ReposListForOrgResponseItem[]>;

class Library {
    private repo = git(env.rootPath);
    private github = new Octokit();
    private defaultOrgs: GithubOrgOrUserInfo[] = [
        {
            name: 'warcraft-iii'
        }
    ];

    private async getOrgRepos(org: GithubOrgOrUserInfo): Promise<RepoInfo[]> {
        const resp =
            org.type === 'user'
                ? ((await this.github.repos.listForUser({ username: org.name })) as ReposResponse)
                : await this.github.repos.listForOrg({ org: org.name, type: 'public' });

        const regex = /^lib[-._]/;

        return resp.data
            .filter(item => !item.archived && regex.test(item.name))
            .map(item => ({
                name: item.name.replace(regex, ''),
                url: org.ssh ? item.ssh_url : item.clone_url
            }));
    }

    private async getRemoteRepos() {
        const exists = new Set(await fs.readdir(env.asSourcePath(globals.FOLDER_LIBRARIES)));

        return ([] as RepoInfo[])
            .concat(
                ...(await Promise.all(
                    (env.config.libraryOrganizations || this.defaultOrgs).map(async org =>
                        (await this.getOrgRepos(org)).filter(repo => !exists.has(repo.name))
                    )
                ))
            )
            .map(repo => ({
                label: repo.name,
                description: repo.url,
                value: repo
            }));
    }

    private async askRepo() {
        const result = await vscode.window.showQuickPick(this.getRemoteRepos(), {
            ignoreFocusOut: true,
            placeHolder: localize('quick.loadingRepos', 'Loading Repos')
        });
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

        const repo = await this.askRepo();
        if (!repo) {
            return;
        }

        await this.addLibrary(repo);
    }
}

export const library = new Library();
