--[[%= war3map %]] --
local P = (function()
    local _G = _G
    local _PRELOADED = {}

    local function findmodule(module, level)
        local files = {module:gsub('%.+', '/') .. '.lua', module:gsub('%.+', '/') .. '/init.lua'}

        for _, filename in ipairs(files) do
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
            if type(v) ~= 'string' then
                error('PRELOADED value must be string')
            end
            _PRELOADED[k] = v
        end,
        __index = function(t, k)
            error('Can`t read')
        end,
        __metatable = false,
    })
end)()

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
