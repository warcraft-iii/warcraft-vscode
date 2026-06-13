/**
 * @File   : diagnostics.ts
 * @Date   : 6/13/2026
 *
 * 构建错误 Diagnostics：当 wc3.exe 报告带 file/line 的脚本错误时，
 * 在编辑器中显示红色波浪线并定位到出错行。每次构建前自动清除上一次的诊断。
 */

import * as vscode from 'vscode';
import * as path from 'path';
import { env } from '../env';
import { WarcraftBuildError } from './bridge';

const collection = vscode.languages.createDiagnosticCollection('warcraft');

/** 构建开始前调用——清除旧诊断 */
export function clearDiagnostics() {
    collection.clear();
}

/** 构建失败时调用——如果错误携带 file/line 则推送 diagnostic + 打开文件 */
export async function reportBuildError(error: WarcraftBuildError) {
    if (!error.file) {
        return;
    }
    const filePath = path.resolve(env.rootPath!, error.file);
    const uri = vscode.Uri.file(filePath);
    const line = Math.max(0, (error.line || 1) - 1); // 0-based

    const range = new vscode.Range(line, 0, line, 1000);
    const diagnostic = new vscode.Diagnostic(range, error.message, vscode.DiagnosticSeverity.Error);
    diagnostic.source = 'wc3';
    collection.set(uri, [diagnostic]);

    // 打开出错文件并跳转到对应行
    try {
        const doc = await vscode.workspace.openTextDocument(uri);
        const editor = await vscode.window.showTextDocument(doc, { preview: true });
        editor.revealRange(range, vscode.TextEditorRevealType.InCenter);
    } catch { /* 文件不存在时静默（如 origwar3map.lua） */ }
}

export function dispose() {
    collection.dispose();
}
