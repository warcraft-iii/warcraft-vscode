import * as vscode from 'vscode';
import * as fs from 'fs-extra';

import { product } from './pb/product';

export async function getUID(db: string) {
    try {
        const buf = await fs.readFile(db);
        const info = product.InstallHandshake.decode(buf);
        return info.uid;
    } catch (error) {
        vscode.window.showWarningMessage(`[Warcraft vscode] ${error.message}`);
        return '';
    }
}
