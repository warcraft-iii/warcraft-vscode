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

    private wait() {
        return new Promise<void>(resolve => {
            if (this.resolver) {
                resolve();
                return;
            }

            vscode.window.withProgress(
                {
                    cancellable: false,
                    location: vscode.ProgressLocation.Notification,
                    title: '[Warcraft vscode] '
                },
                async reporter => {
                    this.reporter = reporter;
                    await new Promise<void>(resolver => {
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
        await utils.sleep(100);
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

export function report(message: string) {
    return (_target: any, _key: string, descriptor: PropertyDescriptor) => {
        const orig = descriptor.value;
        descriptor.value = async function(...args: any[]) {
            await context.report(message);
            // tslint:disable-next-line: no-invalid-this
            return await orig.apply(this, args);
        };
    };
}

export async function withReport(task: () => Promise<void>) {
    context.enter();

    try {
        await task();
    } catch (error) {
        throw error;
    } finally {
        context.leave();
    }
}
