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
            }
        ]
    }
};
module.exports = config;
