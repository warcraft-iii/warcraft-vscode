import * as vscode from 'vscode';

import { env } from './environment';
import { registerCommands } from './commands';
import { debugCompiler } from './compiler';

export async function activate(context: vscode.ExtensionContext) {
    await env.init(context);
    await debugCompiler.init();

    context.subscriptions.push(...registerCommands());
}

export function deactivate() {}
