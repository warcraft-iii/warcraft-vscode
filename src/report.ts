/**
 * @File   : progress.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/22/2019, 11:28:10 PM
 */

import * as vscode from 'vscode';
import * as utils from './utils';

type Reporter = vscode.Progress<{ message?: string; increment?: number }>;

class Context {
    private reporter?: Reporter;
    private resolver?: any;
    private enabled = false;

    private wait(): Promise<void> {
        return new Promise(resolve => {
            if (this.resolver) {
                resolve();
                return;
            }

            vscode.window.withProgress(
                {
                    cancellable: false,
                    location: vscode.ProgressLocation.Notification,
                    title: 'Warcraft: '
                },
                async p => {
                    this.reporter = p;
                    await new Promise(resolver => {
                        this.resolver = resolver;
                        resolve();
                    });
                    this.reporter = undefined;
                }
            );
        });
    }

    async report(message: string) {
        if (!this.enabled) {
            return;
        }
        await this.wait();
        if (this.reporter) {
            this.reporter.report({ message });
        }
        await utils.sleep(2000);
    }

    enter() {
        this.enabled = true;
    }

    leave() {
        if (this.resolver) {
            this.resolver();
        }
        this.resolver = undefined;
        this.reporter = undefined;
        this.enabled = false;
    }
}

const context = new Context();

export function Report(message: string) {
    return (_target: any, _key: string, descriptor: any) => {
        const orig = descriptor.value;
        descriptor.value = async function(...args: any[]) {
            await context.report(message);
            // tslint:disable-next-line: no-invalid-this
            return await orig.apply(this, args);
        };
    };
}

export function Progress(_target: any, _key: string, descriptor: any) {
    const orig = descriptor.value;
    descriptor.value = async function(...args: any[]) {
        try {
            context.enter();
            // tslint:disable-next-line: no-invalid-this
            await orig.apply(this, ...args);
            context.leave();
        } catch (error) {
            context.leave();
            throw error;
        }
    };
}
