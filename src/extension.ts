import * as vscode from "vscode";
import { Project } from "./project";

export async function activate(context: vscode.ExtensionContext) {
    const project = Project.get();

    let disposables = [
        vscode.commands.registerCommand("extension.warcraft.compile.debug", () => project.compileDebug()),
        vscode.commands.registerCommand("extension.warcraft.pack", () => project.packMap())
    ];

    console.log(process.arch, process.platform, process.versions);

    context.subscriptions.push(...disposables);
}

export function deactivate() {}
