const Octokit = require('@octokit/rest');
const got = require('got');
const fs = require('fs-extra');
const path = require('path');
const yauzl = require('yauzl-promise');
const { pipeline } = require('stream/promises');

async function downloadAsserts(owner, repo, out) {
    const versions = {};
    const github = new Octokit.Octokit({ auth: process.env['GH_ACCESS_TOKEN'] });

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

async function downloadRepo(owner, repo, out) {
    const github = new Octokit.Octokit({ auth: process.env['GH_ACCESS_TOKEN'] });
    const resp = await github.repos.downloadZipballArchive({ owner: owner, repo: repo });
    if (resp.status !== 200) {
        throw Error('download repo failed');
    }
    await fs.writeFile(out, Buffer.from(resp.data));
    console.log(`Download repo ${repo} out: ${out} success`);
}

async function extractFile(zipFile, out, prefix) {
    const zip = await yauzl.open(zipFile);
    try {
        await zip.walkEntries(async (entry) => {
            if (entry.fileName.indexOf(prefix) < 0) return;
            const newPath = entry.fileName.substring(entry.fileName.indexOf(prefix) + prefix.length);
            if (entry.fileName.endsWith('/')) {
                await fs.mkdirp(path.join(out, newPath));
            } else {
                const readStream = await entry.openReadStream();
                const writeStream = fs.createWriteStream(path.join(out, newPath));
                await pipeline(readStream, writeStream);
            }
        })
    } finally {
        await zip.close();
    }
}
async function main() {
    const files = [
        {
            owner: 'warcraft-iii',
            repo: 'ObjEditingDefine',
            out: path.join('./res', 'def.zip'),
            json: path.join('./res', '.version.json'),
        },
        {
            owner: 'prometheus-lua',
            repo: 'Prometheus',
            out: path.join('./bin', 'prometheus.zip'),
            clone: true,
            unzip: './bin/lua',
            prefix: '/src/',
        },
    ];

    for (const f of files) {
        if (f.clone) {
            await fs.emptyDir(f.unzip);
            await downloadRepo(f.owner, f.repo, f.out);
            await extractFile(f.out, f.unzip, f.prefix);
            await fs.remove(f.out);
        } else {
            const versions = await downloadAsserts(f.owner, f.repo, f.out);
            if (f.json) {
                await fs.writeJson(f.json, versions);
            }
        }
    }

    await fs.mkdirp('out');

    // Build wc3.exe from crates/ (stormlib statically linked, no MopaqPack-rs.exe needed)
    const { execSync } = require('child_process');
    console.log('Building wc3.exe...');
    execSync('cargo build -p wc3-cli --release', { stdio: 'inherit', cwd: __dirname });
    const wc3Src = path.join(__dirname, 'target/release/wc3.exe');
    const wc3Dst = path.join(__dirname, 'bin/wc3.exe');
    await fs.copyFile(wc3Src, wc3Dst);
    console.log('wc3.exe built and copied to bin/');
}

main();
