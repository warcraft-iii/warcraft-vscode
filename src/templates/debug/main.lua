--[[%= war3map %]] --
package = {}
package.path = '--[[%> print(package.path.join(";")) %]]'

local P = (function(preloadType, load)
    local _G = _G
    local _PRELOADED = {}
    local package = package

    local function resolveFiles(module)
        module = module:gsub('[./\\]+', '/')

        return coroutine.wrap(function()
            for item in package.path:gmatch('[^;]+') do
                local file = item:gsub('^%.[/\\]+', ''):gsub('%?', module)
                coroutine.yield(file)
            end
        end)
    end

    local function findmodule(module, level)
        for filename in resolveFiles(module) do
            local code = _PRELOADED[filename]
            if code then
                return code, filename
            end
        end

        error('not found module ' .. module, level or 2)
    end

    local function domodule(module)
        local code, filename = findmodule(module, 5)
        local f, err = load(code, '@' .. filename)
        if not f then
            error(err)
        end

        local ret = f(module, filename)
        return ret or true
    end

    local _LOADED = setmetatable({}, {
        __index = function(t, k)
            t[k] = domodule(k)
            return t[k]
        end,
    })

    function require(module)
        return _LOADED[module]
    end

    local function _loadfile(filename, mode, env, level)
        local code = _PRELOADED[filename]
        if not code then
            error(string.format('cannot open %s: No such file or directory', filename), level + 1)
        end
        return load(code, '@' .. filename, mode, env or _G)
    end

    function loadfile(filename, mode, env)
        return _loadfile(filename, mode, env, 2)
    end

    function dofile(filename)
        _loadfile(filename, nil, nil, 2)()
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
end)('string', load)

--[[%= code %]]

local orig_main = main
function main()
    local ok, err = pcall(function()
        orig_main()
        dofile('main.lua')
    end)
    if not ok then
        print(err)
    end
end
