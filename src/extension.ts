import * as vscode from 'vscode';

export async function activate(context: vscode.ExtensionContext) {
    context.subscriptions.push(...(await (await import('./init')).init(context)));
}

export function deactivate() {}
