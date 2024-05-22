const Octokit = require('@octokit/rest');
const got = require('got');
const fs = require('fs-extra');
const path = require('path');

async function downloadAsserts(owner, repo, out) {
    const versions = {};
    const github = new Octokit.Octokit({auth: process.env['GH_ACCESS_TOKEN']});

    const releaseResp = await github.repos.getLatestRelease({
        owner,
        repo
    });

    if (releaseResp.status !== 200) {
        throw Error('not found latest release');
    }

    if (releaseResp.data.assets.length < 1) {
        throw Error('not found release assets');
    }

    const release = releaseResp.data;
    const asset = release.assets[0];
    const assetResp = await got(asset.browser_download_url, { encoding: null });

    if (assetResp.statusCode !== 200) {
        throw Error('download asset failed');
    }

    const version = release.tag_name;
    const outpath = typeof out === 'function' ? out(asset) : out;
    await fs.mkdirp(path.dirname(outpath));
    await fs.writeFile(outpath, assetResp.body);

    versions.def = version;

    console.log(`Download file ${outpath} version: ${version} success`);
    return versions;
}

async function main() {
    const files = [
        {
            owner: 'warcraft-iii',
            repo: 'ObjEditing',
            out: asset => path.join('./bin', asset.name),
        },
        {
            owner: 'warcraft-iii',
            repo: 'MopaqPack-rs',
            out: asset => path.join('./bin', asset.name),
        },
        {
            owner: 'warcraft-iii',
            repo: 'ObjEditingDefine',
            out: path.join('./res', 'def.zip'),
            json: path.join('./res', '.version.json'),
        }
    ];

    for (const f of files) {
        const versions = await downloadAsserts(f.owner, f.repo, f.out);
        if (f.json) {
            await fs.writeJson(f.json, versions);
        }
    }

    await fs.copyFile("node_modules/wasmoon/dist/glue.wasm", path.join('out', "glue.wasm"));
    await fs.copyFile("node_modules/wasmoon/dist/index.js", path.join('out', "wasmoon.js"));
}

main();
