# warcraft-vscode

This extension is a Warcraft III map development tool set of Lua.

## Install

[![Build Status](https://travis-ci.com/warcraft-iii/warcraft-vscode.svg?branch=master)](https://travis-ci.com/warcraft-iii/warcraft-vscode)

[warcraft-vscode](https://marketplace.visualstudio.com/items?itemName=Dencer.warcraft-vscode)

## Features

- Compile script for Debug
- Pack map
- Run map
- Open world editor
- Add libraries

## Commands

- **Warcraft: Create Project**
    - Create a map project for Warcraft III
- **Warcraft: Clean Project**
    - Remove the `.build` folder
- **Warcraft: Add Library**
    - Add a library for project
- **Warcraft: Compile Debug**
    - Compile script for Debug
- **Warcraft: Pack Map**
    - Compile script for Debug
    - Pack map to w3x
- **Warcraft: Run Map**
    - Compile script for Debug
    - Pack map to w3x
    - Run map in **Warcraft III**
- **Warcraft: Open World Editor**
    - Open the map folder with **World Editor**

## Quick Start

1. Press `F1` in vscode
2. Input `warcraft create` and Press `Enter` to create a Warcraft III map project
3. Open the project folder and execute the Commands of this extension

## Usage

#### Compile Script

##### Macros
1. In Release
    - `--@debug@` turn into `--[===[@debug@`
    - `--@end-debug@` turn into `--@end-debug@]===]`
    - `--[===[@non-debug@` turn into `--@non-debug`
    - `--@end-debug]===]` turn into `--@end-debug`
2. In Debug & Release
    - `--@remove@` turn into `--[===[@remove@`
    - `--@end-remove@` turn into `--@end-remove@]===]`

##### Pack

## Known Issues

## TODOs

- For Release
- Use other github users or organizations to add libraries
- Support compile time
- Support for macOS

**Enjoy!**
