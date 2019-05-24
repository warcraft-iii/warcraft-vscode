/**
 * @File   : init.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/24/2019, 5:04:30 PM
 */

import * as vscode from 'vscode';

import { env } from './env';

export async function init(ctx: vscode.ExtensionContext) {
    await env.init(ctx);

    const commands = await import('./commands');
    const app = await import('./app');

    return [...commands.commands, app.app];
}
