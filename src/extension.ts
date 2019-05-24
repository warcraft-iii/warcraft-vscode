import * as vscode from 'vscode';
import { env } from './env';
import { app, commands } from './app';

export async function activate(context: vscode.ExtensionContext) {
    await env.init();
    context.subscriptions.push(app, ...commands);
}

export function deactivate() {}
