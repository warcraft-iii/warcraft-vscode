
import { env } from '../env';
import * as fs from 'fs-extra';
import { LuaFactory } from 'wasmoon';
import * as path from 'path';
import { LuaConfusionType } from '../globals';

export class Prometheus {

    static async mountDir(factory: LuaFactory, dirPath: string, rootPath: string) {

        const files = await fs.readdir(dirPath);

        for (const f of files) {
            const p = path.resolve(dirPath, f);
            const stat = await fs.stat(p);
            if (stat.isDirectory()) {
                await this.mountDir(factory, path.resolve(dirPath, f), rootPath);
            } else {
                const relative = path.relative(rootPath, p).replace(/\\/g, '/');
                await factory.mountFile(relative, await fs.promises.readFile(p));
            }
        }
    }

    static async compile(level: LuaConfusionType, scriptFile: string) {
        const factory = new LuaFactory(
            (() => {
                const p = env.asExetensionPath('out/glue.wasm');
                return fs.existsSync(p) ? p : undefined;
            })()
        );
        const luaEngine = await factory.createEngine();

        const apis = {
            io: {
                readFile: (fileName: string) => fs.readFileSync(fileName, { encoding: 'utf-8' }),
                writeFile: (fileName: string, content: string) => fs.writeFileSync(fileName, content, { encoding: 'utf-8' }),
            }
        };

        for (const [t, v] of Object.entries(apis)) {
            luaEngine.global.getTable(t, (idx) => {
                for (const [n, f] of Object.entries(v)) {
                    luaEngine.global.setField(idx, n, f);
                }
            });
        }

        const lua = env.asExetensionPath('bin/lua')
        const cli = path.resolve(lua, 'cli.lua')
        const relativeRunFile = path.resolve(process.cwd(), cli);
        const relativeScriptFile = path.resolve(process.cwd(), scriptFile);
        await factory.mountFile(relativeRunFile, await fs.promises.readFile(relativeRunFile))
        await factory.mountFile(relativeScriptFile, await fs.promises.readFile(relativeScriptFile))

        await this.mountDir(factory, lua, lua);

        await luaEngine.doString(`
            arg = {"--Lua51", "--preset", "${LuaConfusionType[level]}", "--out", [[${relativeScriptFile}]], [[${relativeScriptFile}]]}
            local _open = io.open
            io.open = function(f, m)
                if m == 'w' then
                    return {
                        close = function()
                        end,
                        write = function(_, content)
                            io.writeFile(f, content)
                        end
                    }
                else
                    return _open(f, m)
                end
            end
        `);
        return luaEngine.doFile(relativeRunFile);
    }
}
