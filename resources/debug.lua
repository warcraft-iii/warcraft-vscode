-- debug.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/18/2019, 9:21:32 PM

local _PRELOADED = {}
do
    local _LOADED = {}

    local function _find(module)
        if _PRELOADED[module] then
            return _PRELOADED[module]
        end

        module = module .. '.init'
        if _PRELOADED[module] then
            return _PRELOADED[module]
        end

        error('not found ' .. module, 4)
    end

    local function _load(k)
        local c = _find(k)
        local f, err = load(c, '@' .. k:gsub('%.', '/') .. '.lua')
        if not f then
            print(err)
            return false
        end

        local ok, r = pcall(f)
        if not ok then
            print(r)
            return false
        end
        return r or true
    end

    setmetatable(_LOADED, { __index = function(t, k)
        t[k] = _load(k)
        return t[k]
    end })

    function require(module)
        return _LOADED[module]
    end
end
