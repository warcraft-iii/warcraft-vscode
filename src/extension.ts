import * as vscode from "vscode";
import { Project } from "./project";

export async function activate(context: vscode.ExtensionContext) {
    const project = Project.get();

    let disposables = [
        vscode.commands.registerCommand("extension.warcraft.compile.debug", () => project.compileDebug()),
        vscode.commands.registerCommand("extension.warcraft.map.pack", () => project.packMap()),
        vscode.commands.registerCommand("extension.warcraft.run.game", () => project.runGame()),
        vscode.commands.registerCommand("extension.warcraft.run.we", () => project.runWorldEditor()),
        vscode.commands.registerCommand("extension.warcraft.library.add", () => project.addLibrary())
    ];

    context.subscriptions.push(...disposables);
}

export function deactivate() {}
