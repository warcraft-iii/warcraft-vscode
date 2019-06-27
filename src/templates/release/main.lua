package = {}
package.path = '--[[%> print(package.path.join(";")) %]]'

local P
do
    local preloadType = 'function'
    local preload = function(chunk, _, _, env)
        return function(...)
            return chunk(env or _G, ...)
        end
    end

    local package = package
    local _G = _G
    local _PRELOADED = {}
    local _LOADING = {}
    local _errorhandler

    local function errorhandler(msg)
        if _errorhandler and msg then
            return _errorhandler(msg)
        end
    end

    local function resolvefiles(module)
        module = module:gsub('[./\\]+', '/')

        return coroutine.wrap(function()
            for item in package.path:gmatch('[^;]+') do
                local file = item:gsub('^%.[/\\]+', ''):gsub('%?', module)
                coroutine.yield(file)
            end
        end)
    end

    local function findmodule(module, level)
        for filename in resolvefiles(module) do
            local code = _PRELOADED[filename]
            if code then
                return code, filename
            end
        end
    end

    local function domodule(module)
        local code, filename = findmodule(module, 5)
        if not code then
            error('not found module ' .. module, 4)
        end

        if _LOADING[filename] then
            error('critical dependency', 4)
        end

        local f, err = preload(code, '@' .. filename)
        if not f then
            error(err, 4)
        end

        _LOADING[filename] = true

        local ok, ret = xpcall(f, errorhandler, module, filename)

        _LOADING[filename] = nil

        if not ok then
            error()
        end
        return ret or true
    end

    local _LOADED = setmetatable({}, {
        __index = function(t, k)
            local m = domodule(k)
            t[k] = m
            return m
        end,
    })

    local function _loadfile(filename, mode, env, level)
        local code = _PRELOADED[filename]
        if not code then
            error(string.format('cannot open %s: No such file or directory', filename), level + 1)
        end
        return preload(code, '@' .. filename, mode, env or _G)
    end

    function require(module)
        return _LOADED[module]
    end

    function loadfile(filename, mode, env)
        return _loadfile(filename, mode, env, 2)
    end

    function dofile(filename)
        _loadfile(filename, nil, nil, 2)()
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
        local apis = {
            {'TimerStart', 4, 4}, {'ForGroup', 2, 2}, {'ForForce', 2, 2}, {'Condition', 1, 1}, {'Filter', 1, 1},
            {'EnumDestructablesInRect', 3, 3}, {'EnumItemsInRect', 3, 3}, {'TriggerAddAction', 2, 2},
        }

        local function genReturn(ok, ...)
            if ok then
                return ...
            end
        end

        local gens = {}
        local function gen(index, count)
            local k = index << 16 | count
            if gens[k] then
                return gens[k]
            end

            local args = {}
            for i = 1, count do
                table.insert(args, 'ARG' .. i)
            end
            args = table.concat(args, ',')

            local code = [[
local o, r, e = ...
return function({ARGS})
    if ARG{N} then
        local c = ARG{N}
        ARG{N} = function(...)
            return r(xpcall(c, e, ...))
        end
    end
    return o({ARGS})
end
]]

            code = code:gsub('{N}', tostring(index)):gsub('{ARGS}', args)

            gens[k] = load(code)
            return gens[k]
        end

        for _, v in ipairs(apis) do
            local name, index, count = v[1], v[2], v[3]
            _G[name] = gen(index, count)(_G[name], genReturn, errorhandler)
        end
    end

    P = setmetatable({}, {
        __newindex = function(t, k, v)
            if type(v) ~= preloadType then
                error('PRELOADED value must be ' .. preloadType)
            end
            _PRELOADED[k] = v
        end,
        __index = function(t, k)
            error('Can`t read')
        end,
        __metatable = false,
    })
end

--[[%= code %]]

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
