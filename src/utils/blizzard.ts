import * as fs from 'fs-extra';
import { runtime } from '../env/runtime';

const proto = require('./pb/product.proto');

export async function getUID(db: string) {
    try {
        const buf = await fs.readFile(db);
        const info = proto.product.InstallHandshake.decode(buf);
        return info.uid;
    } catch (error) {
        runtime.showWarningMessage(`[Warcraft vscode] ${error.message}`);
        return '';
    }
}
