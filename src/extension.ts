import * as vscode from 'vscode';

export async function activate(context: vscode.ExtensionContext) {
    context.subscriptions.push((await import('./app')).app);
}

export function deactivate() {}
