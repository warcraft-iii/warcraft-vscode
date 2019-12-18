import * as vscode from 'vscode';
import * as fs from 'fs-extra';

const pb = require('../pb/product.proto');

export async function getUID(db: string) {
    try {
        const buf = await fs.readFile(db);
        const product = pb.product.InstallHandshake.decode(buf);
        return product ? product.uid : '';
    } catch (error) {
        vscode.window.showWarningMessage(`[Warcraft vscode] ${error.message}`);
    }
}
