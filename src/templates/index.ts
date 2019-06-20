/**
 * @File   : index.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 6/20/2019, 3:21:02 PM
 */

import DEBUG_MAIN from '../../templates/debug/main.lua';
import DEBUG_FILE from '../../templates/debug/file.lua';
import RELEASE_MAIN from '../../templates/release/main.lua';
import RELEASE_FILE from '../../templates/release/file.lua';

export namespace templates {
    export namespace debug {
        export const main = DEBUG_MAIN;
        export const file = DEBUG_FILE;
    }

    export namespace release {
        export const main = RELEASE_MAIN;
        export const file = RELEASE_FILE;
    }
}
