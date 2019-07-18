/**
 * @File   : prepublish.js
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 7/19/2019, 12:31:34 AM
 */

const Octokit = require('@octokit/rest');
const got = require('got');
const fs = require('fs-extra');

async function main() {
    const github = new Octokit();

    const releaseResp = await github.repos.getLatestRelease({
        owner: 'warcraft-iii',
        repo: 'ObjEditingDefine'
    });

    if (releaseResp.status !== 200) {
        throw Error('not found latest release');
    }

    if (releaseResp.data.assets.length < 1) {
        throw Error('not found release assets');
    }

    const asset = releaseResp.data.assets[0];
    const assetResp = await got(asset.browser_download_url, { encoding: null });

    if (assetResp.statusCode !== 200) {
        throw Error('download asset failed');
    }

    await fs.writeFile(`res/${asset.name}`, assetResp.body);

    console.log(`download res/${asset.name} success`);
}

main();
