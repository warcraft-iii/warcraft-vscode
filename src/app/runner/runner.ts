/**
 * @File   : runner.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/23/2019, 11:14:13 AM
 */

export enum RunnerType {
    Game,
    Editor
}

export interface Runner {
    type(): RunnerType;
    isAlive(): boolean;
    execute(): Promise<void>;
    kill(): Promise<void>;
    check(): Promise<boolean>;
}
