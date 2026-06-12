package = {}
package.path = './?.lua;./?/init.lua'

local P
do
    local preloadType, preload, _errorhandler
    do
        preloadType = 'string'
        preload = load
        _errorhandler = function(msg)
            return print(msg)
        end
    end

    local _G = _G
    local package = package
    local string, table = string, table
    local error, xpcall, type, setmetatable, tostring, ipairs, load = error, xpcall, type, setmetatable, tostring,
                                                                      ipairs, load

    local _FILES = {}
    local _LOADED_MODULES = {}
    local _LOADED_FILES = {}
    local _LOADING_FILES = {}

    local function errorhandler(msg)
        if _errorhandler and msg then
            return _errorhandler(msg)
        end
    end

    local function resolvefile(module)
        module = module:gsub('[./\\]+', '/')

        for item in package.path:gmatch('[^;]+') do
            local filename = item:gsub('^%.[/\\]+', ''):gsub('%?', module)
            if _FILES[filename] then
                return filename
            end
        end
    end

    local function compilefile(filename, mode, env, level)
        local code = _FILES[filename]
        if not code then
            error(string.format('cannot open %s: No such file or directory', filename), (level or 1) + 1)
        end
        return preload(code, '@' .. filename, mode, env or _G)
    end

    --[==[
    local orgRequire = require
    ]==]--

    function require(module)
        local loaded = _LOADED_MODULES[module]
        if loaded then
            return loaded
        end

        local filename = resolvefile(module)
        if not filename then
            --[==[
            if orgRequire then
                return orgRequire(module)
            end
            ]==]--
            error(string.format('module \'%s\' not found', module), 2)
        end

        loaded = _LOADED_FILES[filename]
        if loaded then
            return loaded
        end

        if _LOADING_FILES[filename] then
            error('critical dependency', 2)
        end

        local f, err = compilefile(filename, nil, nil, 2)
        if not f then
            error(err, 2)
        end

        _LOADING_FILES[filename] = true
        local ok, ret = xpcall(f, errorhandler, module, filename)
        _LOADING_FILES[filename] = false
        if not ok then
            error()
        end

        ret = ret or true

        _LOADED_MODULES[module] = ret
        _LOADED_FILES[filename] = ret

        return ret
    end

    function loadfile(filename, mode, env)
        return compilefile(filename, mode, env, 2)
    end

    function dofile(filename)
        compilefile(filename, nil, nil, 2)()
    end

    function seterrorhandler(handler)
        if type(handler) ~= 'function' then
            error(string.format('bad argument #1 to `seterrorhandler` (function expected, got %s)', type(handler)), 2)
        end
        _errorhandler = handler
    end

    function geterrorhandler()
        return _errorhandler
    end

    -- hook for errorhandler
    do
        local function tryreturn(ok, ...)
            if ok then
                return ...
            end
        end

        local function generate(index, count)
            local args = {}
            for i = 1, count do
                table.insert(args, 'ARG' .. i)
            end
            args = table.concat(args, ',')

            local code = [[
local o, r, e = ...
return function({ARGS})
    if type(ARG{N}) == 'function' then
        local c = ARG{N}
        ARG{N} = function(...)
            return r(xpcall(c, e, ...))
        end
    end
    return o({ARGS})
end
]]
            code = code:gsub('{N}', tostring(index)):gsub('{ARGS}', args)

            return load(code)
        end

        local apis = {
            {'TimerStart', 4, 4}, {'ForGroup', 2, 2}, {'ForForce', 2, 2}, {'Condition', 1, 1}, {'Filter', 1, 1},
            {'EnumDestructablesInRect', 3, 3}, {'EnumItemsInRect', 3, 3}, {'TriggerAddAction', 2, 2},
        }

        for _, v in ipairs(apis) do
            local name, index, count = v[1], v[2], v[3]
            _G[name] = generate(index, count)(_G[name], tryreturn, errorhandler)
        end
    end

    P = setmetatable({}, {
        __newindex = function(t, k, v)
            if type(v) ~= preloadType then
                error('PRELOADED value must be ' .. preloadType)
            end
            _FILES[k] = v
        end,
        __index = function(t, k)
            error('Can`t read')
        end,
        __metatable = false,
    })
end

P['lib/extra.lua'] = [[RESULT = RESULT or {}
RESULT.extra = true]]

P['lib/util.lua'] = [[local mod = require('mod')
local M = {}
M.from = mod.who
function M.add(a, b)
    return a + b
end
return M]]

P['main.lua'] = [======[local util = require('lib.util')
local strutil = require 'strutil'
RESULT = RESULT or {}
RESULT.mode = 'common'
--@debug@
RESULT.debug = true
--@end-debug@
--[==[@release@
RESULT.release = true
--@end-release@]==]
--[[@release@
RESULT.release_uncommented = true
--@end-release@]]
--[===[@non-debug@
RESULT.non_debug = true
--@end-non-debug@]===]
--@non-release@
RESULT.non_release = true
--@end-non-release@
--[====[@classic@
RESULT.classic = true
--@end-classic@]====]
--@reforge@
RESULT.reforge = true
--@end-reforge@
--@non-classic@
RESULT.non_classic = true
--@end-non-classic@
--[=====[@non-reforge@
RESULT.non_reforge = true
--@end-non-reforge@]=====]
--[=[@remove@
RESULT.removed = true
--@end-remove@]=]
RESULT.sum = util.add(1, 2)
RESULT.cn = require('中文目录.数据').value
RESULT.modwho = require('mod').who
RESULT.sugar = strutil.tag
dofile('lib/extra.lua')
--[====[@classic@
require('jass.common')
--@end-classic@]====]
return RESULT]======]

P['mod/init.lua'] = [[return { who = 'init' }]]

P['strutil.lua'] = [[return { tag = 'sugar-ok' }]]

P['中文目录/数据.lua'] = [[return { value = 42 }]]

P['origwar3map.lua'] = [[function InitGlobals()
end
function main()
    RESULT = RESULT or {}
    RESULT.orig_main = true
end]]


dofile('origwar3map.lua')
local __main = main

function main()
    xpcall(function()
        
        __main()
        
        dofile('main.lua')
    end, function(msg)
        local handler = geterrorhandler()
        if handler and msg then
            return handler(msg)
        end
    end)
end

--[==[
main()
]==]--
