package = {}
package.path = '--[[%> print(package.path.join(";")) %]]'

local P = (function(preloadType, load, _errorhandler)
    local package = package
    local _G = _G
    local _PRELOADED = {}
    local _LOADING = {}

    local function errorhandler(...)
        if _errorhandler then
            return _errorhandler(...)
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

        local f, err = load(code, '@' .. filename)
        if not f then
            error(err, 4)
        end

        _LOADING[filename] = true

        local ok, ret = xpcall(f, errorhandler, module, filename)

        _LOADING[filename] = nil

        if not ok then
            return
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
        return load(code, '@' .. filename, mode, env or _G)
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

    return setmetatable({}, {
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
end)('function', function(chunk, _, _, env)
    return function(...)
        return chunk(env or _G, ...)
    end
end)

--[[%= code %]]

dofile('origwar3map.lua')

local __main = main
function main()
    xpcall(function()
        __main()
        dofile('main.lua')
    end, function(...)
        local handler = geterrorhandler()
        if handler then
            return handler(...)
        end
    end)
end
