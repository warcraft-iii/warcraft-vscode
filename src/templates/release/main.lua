package = {}
package.path = '--[[%> print(package.path.join(";")) %]]'

CURRENT_VERSION = '--[[%= version %]]'
--[[%> print("MAP_ID = ", id) %]]

local P
do
    local preloadType, preload, _errorhandler
    do
        preloadType = 'function'
        preload = function(chunk, _, _, env)
            return function(...)
                return chunk(env or _G, ...)
            end
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

    --[[%>  if (!classic) { print('--[==['); } %]]
    local orgRequire = require
    --[[%>  if (!classic) { print(']==]--'); } %]]

    function require(module)
        local loaded = _LOADED_MODULES[module]
        if loaded then
            return loaded
        end

        local filename = resolvefile(module)
        if not filename then
            --[[%>  if (!classic) { print('--[==['); } %]]
            if orgRequire then
                return orgRequire(module)
            end
            --[[%>  if (!classic) { print(']==]--'); } %]]
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

--[[%= code %]]
--[[%>  if (classic) { print('--[==['); } %]]
dofile('origwar3map.lua')
local __main = main
--[[%>  if (classic) { print(']==]--'); } %]]
function main()
    xpcall(function()
        --[[%>  if (classic) { print('--[==['); } %]]
        __main()
        --[[%>  if (classic) { print(']==]--'); } %]]
        dofile('main.lua')
    end, function(msg)
        local handler = geterrorhandler()
        if handler and msg then
            return handler(msg)
        end
    end)
end

--[[%>  if (!classic) { print('--[==['); } %]]
main()
--[[%>  if (!classic) { print(']==]--'); } %]]
