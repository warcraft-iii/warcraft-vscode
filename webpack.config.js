//@ts-check

"use strict";

const path = require("path");

/**@type {import('webpack').Configuration}*/
const config = {
    target: "node",

    entry: "./src/extension.ts",
    output: {
        path: path.resolve(__dirname, "out"),
        filename: "extension.js",
        libraryTarget: "commonjs2",
        devtoolModuleFilenameTemplate: "../[resource-path]"
    },
    devtool: "source-map",
    externals: {
        vscode: "commonjs vscode"
    },
    resolve: {
        extensions: [".ts", ".js"]
    },
    module: {
        unknownContextCritical: false,
        exprContextCritical: false,
        rules: [
            {
                test: /\.ts$/,
                exclude: /node_modules/,
                use: [
                    {
                        loader: "ts-loader"
                    }
                ]
            },
            {
                test: /\.lua$/,
                use: [
                    {
                        loader: "underscore-template-loader",
                        query: {
                            interpolate: /\-\-\[\[%\=([\s\S]+?)%\]\]/g,
                            evaluate: /\-\-\[\[%\>([\s\S]+?)%\]\]/g
                        }
                    }
                ]
            },
            {
                test: /\.proto$/,
                use: {
                    loader: 'protobufjs-loader-webpack4',
                    options: {
                        /* controls the "target" flag to pbjs - true for
                         * json-module, false for static-module.
                         * default: false
                         */
                        json: false,

                        /* import paths provided to pbjs.
                         * default: webpack import paths (i.e. config.resolve.modules)
                         */
                        paths: ['./'],

                        /* additional command line arguments passed to
                         * pbjs, see https://github.com/dcodeIO/ProtoBuf.js/#pbjs-for-javascript
                         * for a list of what's available.
                         * default: []
                         */
                        pbjsArgs: ['--no-encode']
                    }
                }
            }
        ]
    }
};
module.exports = config;
