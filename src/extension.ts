import * as vscode from "vscode";
import { Project } from "./project";
import { Option } from "./option";

export async function activate(context: vscode.ExtensionContext) {
    const project = Project.get();
    const option = Option.get();

    await project.init();

    context.subscriptions.push(
        vscode.commands.registerCommand("extension.warcraft.compile.debug", () => project.commandCompileDebug()),
        vscode.commands.registerCommand("extension.warcraft.map.pack", () => project.commandPackMap()),
        vscode.commands.registerCommand("extension.warcraft.run.game", () => project.commandRunGame()),
        vscode.commands.registerCommand("extension.warcraft.run.we", () => project.commandRunWorldEditor()),
        vscode.commands.registerCommand("extension.warcraft.library.add", () => project.commandAddLibrary()),
        vscode.commands.registerCommand("extension.warcraft.project.clean", () => project.commandClean()),
        vscode.commands.registerCommand("extension.warcraft.option.open", () => option.open())
    );
}

export function deactivate() {}
