/**
 * @File   : progress.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 5/22/2019, 11:28:10 PM
 */

import { runtime, ProgressLocation } from '../env/runtime';
import * as utils from './utils';

class Context {
    private reporter?: any;
    private resolver?: any;
    private enabled = false;

    private wait() {
        return new Promise<void>(resolve => {
            if (this.resolver) {
                resolve();
                return;
            }

            runtime.withProgress(
                {
                    cancellable: false,
                    location: ProgressLocation.Notification,
                    title: '[Warcraft vscode] '
                },
                async (reporter: any) => {
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
        descriptor.value = async function (...args: any[]) {
            await context.report(message);
            // tslint:disable-next-line: no-invalid-this
            return await orig.apply(this, args);
        };
        return descriptor;
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
