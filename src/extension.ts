import * as vscode from 'vscode';
import { app, commands } from './app';

export async function activate(context: vscode.ExtensionContext) {
    context.subscriptions.push(app, ...commands);
}

export function deactivate() {}
