
import * as path from 'path';
import * as fs from 'fs-extra';

import { program } from 'commander';
import { objediting } from './app/objediting';

import { runtime } from './env/runtime';
import { env } from './env';
import { debugCompiler, releaseCompiler } from './app/compiler';
import { debugPacker, releasePacker } from './app/packer';
import { LuaConfusionType } from './globals';

export class App {

    async execute(projectPath: string, output: string, target: string, classic: boolean, release: boolean, luaconfusion: string) {
        if (!projectPath) {
            console.error('Invalid arguments');
            return;
        }
        runtime.rootPath = projectPath;
        await env.config.reload();
        env.config.isClassic = classic;
        env.config.isRelease = release;
        env.config.projectConfig.mapdir = path.isAbsolute(target) ? path.resolve(target) : path.resolve(projectPath, target);
        env.config.luaConfusion = LuaConfusionType[luaconfusion] || LuaConfusionType.Disable
        await objediting.execute();
        if (!release) {
            await debugCompiler.execute();
            await debugPacker.execute();
        } else {
            await releaseCompiler.execute();
            await releasePacker.execute();
        }
        if (output.length > 0) {
            await fs.mkdirp(path.dirname(output));
            await fs.copyFile(env.outFilePath, output);
        }
        console.log('finished!');
    }

    cli() {
        program
            .command('pack')
            .argument('[project path]')
            .description('Pack map')
            .option('-o --output <output>', 'Output map path', '')
            .option('-t --target <map>', 'Map file/folder path', '')
            .option('-c --classic', 'Compile Classic Edition', false)
            .option('-r --release', 'Compile Debug/Release?', false)
            .option('-l --luaconfusion', 'Lua Confusion level: Disable (default), Minify, Weak, Medium, Strong', '')
            .action(async (projectPath: string, opts: { output: string, target: string, classic: boolean, release: boolean, luaconfusion: string }) => {
                await this.execute(projectPath, opts.output, opts.target, opts.classic, opts.release, opts.luaconfusion);
            });
        program.parse(process.argv);
    }
}

export const app = new App();
