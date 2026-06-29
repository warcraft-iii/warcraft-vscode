// npm 的 `prepare` 生命周期钩子不仅会在本地 `npm install`（开发初始化，期望运行）
// 时触发，也会在 `npm publish` / `npm pack` 时触发。CI 的 publish 任务没有
// node_modules，也没有 Rust 工具链，下面的 require 会因找不到 '@octokit/rest'
// 而抛错并中断发布。发布的 npm 包只是 CLI 垫片 (bin/cli.js)；res/、bin/lua/
// 与 bin/wc3.exe 均被 .gitignore/.npmignore 排除，本就不会从此处打包。因此
// 在 publish/pack 上下文中直接跳过。
if (process.env.npm_command === 'publish' || process.env.npm_command === 'pack') {
    console.log(`prepare: skipping (npm ${process.env.npm_command})`);
    process.exit(0);
}

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

// 把 `math.log10(EXPR)` 还原为 `math.log(EXPR) / math.log(10)`，
// 其中 EXPR 可含嵌套括号。幂等：对已经是 math.log 形式的内容不改动。
function rewriteLog10(content) {
    const needle = 'math.log10(';
    let out = '';
    let i = 0;
    while (true) {
        const idx = content.indexOf(needle, i);
        if (idx < 0) {
            out += content.slice(i);
            break;
        }
        out += content.slice(i, idx);
        // 从 needle 之后的 '(' 开始做括号配平
        let depth = 1;
        let j = idx + needle.length;
        while (j < content.length && depth > 0) {
            const ch = content[j];
            if (ch === '(') depth++;
            else if (ch === ')') depth--;
            if (depth === 0) break;
            j++;
        }
        if (depth !== 0) {
            // 括号不配平，原样保留以免破坏文件
            out += content.slice(idx);
            break;
        }
        const inner = content.slice(idx + needle.length, j);
        out += `math.log(${inner}) / math.log(10)`;
        i = j + 1;
    }
    return out;
}

// 对解压后的文件应用本地补丁。
async function applyPatches(unzip, patches) {
    for (const patch of patches) {
        const file = path.join(unzip, patch.file);
        let content = await fs.readFile(file, 'utf8');
        const before = content;
        content = patch.rewrite(content);
        if (content !== before) {
            await fs.writeFile(file, content);
            console.log(`patched ${patch.file}`);
        }
    }
}

async function extractFile(zipFile, out, prefix) {
    const zip = await yauzl.open(zipFile);
    try {
        await zip.walkEntries(async (entry) => {
            const idx = entry.fileName.indexOf(prefix);
            if (idx < 0) return;
            // 仅匹配顶层 <root>/src/，跳过嵌套的 <root>/web/src/ 等，避免误抓
            // 仓库里的 web/playground 资源污染 bin/lua。
            if (entry.fileName.slice(0, idx).includes('/')) return;
            const newPath = entry.fileName.substring(idx + prefix.length);
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
    // 可选目标过滤：`node prepare.js lua` 只拉取 Prometheus lua 资源 (bin/lua)，
    // 供 CI 填充 npm/VSIX 载荷；跳过 ObjEditing 下载与 wc3.exe 构建（CI 单独构建）。
    // 无参数 = 完整运行（本地 npm install 初始化）。
    const target = process.argv[2];
    const files = [
        {
            id: 'objediting',
            owner: 'warcraft-iii',
            repo: 'ObjEditingDefine',
            out: path.join('./res', 'def.zip'),
            json: path.join('./res', '.version.json'),
        },
        {
            id: 'lua',
            owner: 'prometheus-lua',
            repo: 'Prometheus',
            out: path.join('./bin', 'prometheus.zip'),
            clone: true,
            unzip: './bin/lua',
            prefix: '/src/',
            // math.log10 在我们的 Lua 运行时不存在，还原为 math.log(x)/math.log(10)
            patches: [
                {
                    file: 'prometheus/steps/NumbersToExpressions.lua',
                    rewrite: rewriteLog10,
                },
            ],
        },
    ].filter((f) => !target || f.id === target);

    for (const f of files) {
        if (f.clone) {
            await fs.emptyDir(f.unzip);
            await downloadRepo(f.owner, f.repo, f.out);
            await extractFile(f.out, f.unzip, f.prefix);
            if (f.patches) {
                await applyPatches(f.unzip, f.patches);
            }
            await fs.remove(f.out);
        } else {
            const versions = await downloadAsserts(f.owner, f.repo, f.out);
            if (f.json) {
                await fs.writeJson(f.json, versions);
            }
        }
    }

    if (target) {
        console.log(`prepare: targeted run (${target}), skipping wc3.exe build`);
        return;
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
