import * as vscode from "vscode";
import { Project } from "./project";

export async function activate(context: vscode.ExtensionContext) {
    const project = Project.get();

    let disposables = [
        vscode.commands.registerCommand("extension.warcraft.merge", () => project.compileDebug()),
        vscode.commands.registerCommand("extension.warcraft.pack", () => project.packMap())
    ];

    context.subscriptions.push(...disposables);
}

export function deactivate() {}
