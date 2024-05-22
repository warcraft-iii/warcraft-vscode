//@ts-check

"use strict";

const path = require("path");

/**@type {import('webpack').Configuration}*/
const config = {
    target: "node",

    entry: {
        extension: "./src/extension.ts",
        cli: "./src/cli.ts",
    },
    output: {
        path: path.resolve(__dirname, "out"),
        filename: "[name].js",
        libraryTarget: "commonjs2",
        devtoolModuleFilenameTemplate: "../[resource-path]"
    },
    devtool: "source-map",
    externals: {
        vscode: "commonjs vscode",
        wasmoon: "./wasmoon",
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
                        options: {
                            interpolate: /\-\-\[\[%\=([\s\S]+?)%\]\]/g,
                            evaluate: /\-\-\[\[%\>([\s\S]+?)%\]\]/g
                        }
                    }
                ]
            },
            {
                test: /\.proto$/i,
                use: {
                    loader: "pbjs-loader",
                    options: {
                        create: true,
                        encode: true,
                        decode: true,
                        verify: false,
                        convert: true,
                        delimited: false,
                        beautify: false,
                        comments: false,
                        wrap: 'commonjs', // by default
                        target: 'static-module' // by default
                    },
                }
            }
        ]
    }
};
module.exports = config;
