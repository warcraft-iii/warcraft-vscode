import * as vscode from 'vscode';

import { env } from './env';
import { app } from './app';
import { registerCommands } from './commands';
import { debugCompiler } from './compiler';

export async function activate(context: vscode.ExtensionContext) {
    await env.init(context);
    await debugCompiler.init();

    context.subscriptions.push(...registerCommands());
    context.subscriptions.push(app);
}

export function deactivate() {}
