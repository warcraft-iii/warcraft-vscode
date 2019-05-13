--[[%= war3map %]]

do
local _PRELOADED = {}

--[[%= code %]]

local function findfile(module)
    if _PRELOADED[module] then
        return _PRELOADED[module]
    end

    module = module .. '.init'
    if _PRELOADED[module] then
        return _PRELOADED[module]
    end

    error('not found ' .. module, 4)
end

local function loadfile(k)
    local code = findfile(k)
    local f, err = load(code, '@' .. k:gsub('%.', '/') .. '.lua')
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

local _LOADED = setmetatable({}, { __index = function(t, k)
    t[k] = loadfile(k)
    return t[k]
end })

function require(module)
    return _LOADED[module]
end
end

local orig_main = main
function main()
    orig_main()
    require('lib')
    require('main')
end
