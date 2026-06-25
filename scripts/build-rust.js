#!/usr/bin/env node
// 构建 Rust 可执行文件并拷贝到 bin/。
//
// wc3-confuse 因 mlua lua51/lua54 feature 互斥而独立于 workspace 之外
// （见根 Cargo.toml 的 exclude 注释），需用 --manifest-path 单独构建。
//
// 用法：
//   node scripts/build-rust.js              # 构建全部（wc3 + wc3-confuse）
//   node scripts/build-rust.js wc3          # 仅构建 wc3.exe
//   node scripts/build-rust.js confuse      # 仅构建 wc3-confuse.exe
//
// 两个 crate 互相独立，并行构建以节省时间。

const path = require('path');
const fs = require('fs');
const { spawn } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const BIN_DIR = path.join(ROOT, 'bin');
const TARGET_RELEASE = path.join(ROOT, 'target', 'release');

const TARGETS = {
    wc3: {
        label: 'wc3.exe',
        // workspace 成员，可直接 -p
        args: ['build', '-p', 'wc3-cli', '--release'],
        artifacts: ['wc3.exe', 'wc3'],
    },
    confuse: {
        label: 'wc3-confuse.exe',
        // 独立 crate：必须指定 manifest；并显式 --target-dir 指向 workspace 的 target/，
        // 否则产物会落到 crates/wc3-confuse/target/ 而无法统一拷贝。
        args: [
            'build',
            '--manifest-path', 'crates/wc3-confuse/Cargo.toml',
            '--target-dir', 'target',
            '--release',
        ],
        artifacts: ['wc3-confuse.exe', 'wc3-confuse'],
    },
};

function runCargo(target) {
    return new Promise((resolve, reject) => {
        const proc = spawn('cargo', target.args, {
            cwd: ROOT,
            stdio: 'inherit',
            shell: process.platform === 'win32',
        });
        proc.on('error', reject);
        proc.on('close', (code) => {
            if (code !== 0) {
                reject(new Error(`${target.label}: cargo exited with ${code}`));
            } else {
                resolve();
            }
        });
    });
}

function copyArtifact(target) {
    const src = target.artifacts
        .map((name) => path.join(TARGET_RELEASE, name))
        .find((candidate) => fs.existsSync(candidate));

    if (!src) {
        throw new Error(`${target.label}: artifact not found under ${TARGET_RELEASE}`);
    }

    fs.mkdirSync(BIN_DIR, { recursive: true });
    const dst = path.join(BIN_DIR, path.basename(src));
    fs.copyFileSync(src, dst);
    console.log(`copied ${path.relative(ROOT, src)} -> ${path.relative(ROOT, dst)}`);
}

async function buildOne(key) {
    const target = TARGETS[key];
    console.log(`\n=== building ${target.label} ===`);
    await runCargo(target);
    copyArtifact(target);
}

async function main() {
    const requested = process.argv.slice(2);
    const keys = requested.filter((k) => k in TARGETS);
    if (keys.length === 0) {
        keys.push(...Object.keys(TARGETS));
    }

    // 两个 crate 互相独立，并行构建。
    const results = await Promise.allSettled(keys.map(buildOne));

    let failed = false;
    for (let i = 0; i < keys.length; i++) {
        const r = results[i];
        if (r.status === 'rejected') {
            failed = true;
            console.error(`\n[FAIL] ${TARGETS[keys[i]].label}: ${r.reason.message}`);
        } else {
            console.log(`[OK]   ${TARGETS[keys[i]].label}`);
        }
    }

    if (failed) {
        process.exit(1);
    }
}

main();
