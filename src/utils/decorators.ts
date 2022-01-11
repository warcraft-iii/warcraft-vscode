/**
 * @File   : decorators.ts
 * @Author : Dencer (tdaddon@163.com)
 * @Link   : https://dengsir.github.io
 * @Date   : 6/20/2019, 1:26:01 PM
 */

import once_ from 'lodash-es/once';
import debounce_ from 'lodash-es/debounce';

export function once(_target: any, _key: any, descriptor: PropertyDescriptor) {
    if (descriptor.value) {
        descriptor.value = once_(descriptor.value);
    }
    return descriptor;
}

export function debounce(wait?: number) {
    return (_target: any, _key: any, descriptor: PropertyDescriptor) => {
        if (descriptor.value) {
            descriptor.value = debounce_(descriptor.value, wait);
        }
        return descriptor;
    };
}
