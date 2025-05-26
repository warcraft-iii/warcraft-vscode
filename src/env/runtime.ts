

import { globals } from '../globals/globals'
import * as path from 'path';

/**
  * The configuration target
  */
export enum ConfigurationTarget {
    /**
     * Global configuration
    */
    Global = 1,

    /**
     * Workspace configuration
     */
    Workspace = 2,

    /**
     * Workspace folder configuration
     */
    WorkspaceFolder = 3
}

/**
 * A location in the editor at which progress information can be shown. It depends on the
 * location how progress is visually represented.
 */
export enum ProgressLocation {

    /**
     * Show progress for the source control viewlet, as overlay for the icon and as progress bar
     * inside the viewlet (when visible). Neither supports cancellation nor discrete progress.
     */
    SourceControl = 1,

    /**
     * Show progress in the status bar of the editor. Neither supports cancellation nor discrete progress.
     */
    Window = 10,

    /**
     * Show progress as notification with an optional cancel button. Supports to show infinite and discrete progress.
     */
    Notification = 15
}

interface WorkspaceConfiguration {

    /**
     * Return a value from this configuration.
     *
     * @param section Configuration name, supports _dotted_ names.
     * @return The value `section` denotes or `undefined`.
     */
    get<T>(section: string): T | undefined;

    /**
     * Return a value from this configuration.
     *
     * @param section Configuration name, supports _dotted_ names.
     * @param defaultValue A value should be returned when no value could be found, is `undefined`.
     * @return The value `section` denotes or the default.
     */
    get<T>(section: string, defaultValue: T): T;

    /**
     * Check if this configuration has a certain value.
     *
     * @param section Configuration name, supports _dotted_ names.
     * @return `true` if the section doesn't resolve to `undefined`.
     */
    has(section: string): boolean;

    /**
     * Retrieve all information about a configuration setting. A configuration value
     * often consists of a *default* value, a global or installation-wide value,
     * a workspace-specific value, folder-specific value
     * and language-specific values (if [WorkspaceConfiguration](#WorkspaceConfiguration) is scoped to a language).
     *
     * Also provides all language ids under which the given configuration setting is defined.
     *
     * *Note:* The configuration name must denote a leaf in the configuration tree
     * (`editor.fontSize` vs `editor`) otherwise no result is returned.
     *
     * @param section Configuration name, supports _dotted_ names.
     * @return Information about a configuration setting or `undefined`.
     */
    inspect<T>(section: string): {
        key: string;

        defaultValue?: T;
        globalValue?: T;
        workspaceValue?: T,
        workspaceFolderValue?: T,

        defaultLanguageValue?: T;
        globalLanguageValue?: T;
        workspaceLanguageValue?: T;
        workspaceFolderLanguageValue?: T;

        languageIds?: string[];

    } | undefined;

    /**
     * Update a configuration value. The updated configuration values are persisted.
     *
     * A value can be changed in
     *
     * - [Global settings](#ConfigurationTarget.Global): Changes the value for all instances of the editor.
     * - [Workspace settings](#ConfigurationTarget.Workspace): Changes the value for current workspace, if available.
     * - [Workspace folder settings](#ConfigurationTarget.WorkspaceFolder): Changes the value for settings from one of the [Workspace Folders](#workspace.workspaceFolders) under which the requested resource belongs to.
     * - Language settings: Changes the value for the requested languageId.
     *
     * *Note:* To remove a configuration value use `undefined`, like so: `config.update('somekey', undefined)`
     *
     * @param section Configuration name, supports _dotted_ names.
     * @param value The new value.
     * @param configurationTarget The [configuration target](#ConfigurationTarget) or a boolean value.
     *    - If `true` updates [Global settings](#ConfigurationTarget.Global).
     *    - If `false` updates [Workspace settings](#ConfigurationTarget.Workspace).
     *    - If `undefined` or `null` updates to [Workspace folder settings](#ConfigurationTarget.WorkspaceFolder) if configuration is resource specific,
     *     otherwise to [Workspace settings](#ConfigurationTarget.Workspace).
     * @param overrideInLanguage Whether to update the value in the scope of requested languageId or not.
     *    - If `true` updates the value under the requested languageId.
     *    - If `undefined` updates the value under the requested languageId only if the configuration is defined for the language.
     * @throws error while updating
     *    - configuration which is not registered.
     *    - window configuration to workspace folder
     *    - configuration to workspace or workspace folder when no workspace is opened.
     *    - configuration to workspace folder when there is no workspace folder settings.
     *    - configuration to workspace folder when [WorkspaceConfiguration](#WorkspaceConfiguration) is not scoped to a resource.
     */
    update(section: string, value: any, configurationTarget?: ConfigurationTarget | boolean, overrideInLanguage?: boolean): Thenable<void>;

    /**
     * Readable dictionary that backs this configuration.
     */
    readonly [key: string]: any;
}


class Runtime {

    private vscode?: any;
    rootPath: string;

    constructor() {
        try {
            this.vscode = require('vscode');
        } catch (error) {
        }
    }

    get workspace() {
        return this.vscode?.workspace;
    }

    getConfiguration(section?: string | undefined, scope?: any | null): WorkspaceConfiguration {
        return this.workspace?.getConfiguration(section, scope);
    }

    get workspaceFolders() {
        return this.workspace?.workspaceFolders as any[];
    }

    get workspaceFolder() {
        return this.workspaceFolders ? this.workspaceFolders[0].uri.fsPath : this.rootPath;
    }

    get extensionFolder(): string {
        let p = this.vscode?.extensions.getExtension(globals.EXTENSION_ID)?.extensionPath;
        if (!p) {
            p = path.resolve(__dirname, '../');
        }
        return p;
    }

    get inVscode() {
        return this.vscode != undefined;
    }

    showWarningMessage(message: string, ...items: string[]): Thenable<string | undefined> {
        if (!this.vscode) {
            console.error(message, ...items);
        }
        return this.vscode?.window.showWarningMessage(message, ...items);;
    }

    withProgress<R>(options: any, task: any): Thenable<R> {
        return this.vscode?.window.withProgress(options, task);
    }

    showInformationMessage<T>(message: string, options: any, ...items: T[]): Thenable<T | undefined> {
        return this.vscode?.window.showInformationMessage(message, options, ...items);
    }

    showOpenDialog(options?: any): Thenable<any[] | undefined> {
        return this.vscode?.window.showOpenDialog(options);
    }

    showQuickPick<T>(items: T[] | Thenable<T[]>, options?: any, token?: any): Thenable<T | undefined> {
        return this.vscode?.window.showQuickPick(items, options, token);
    }

    executeCommand<T>(command: string, ...rest: any[]): Thenable<T | undefined> {
        return this.vscode?.commands.executeCommand(command, ...rest);
    }
}

export const runtime = new Runtime();
