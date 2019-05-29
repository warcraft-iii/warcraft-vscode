--[[%= war3map %]]

do
local _PRELOADED = {}

--[[%= code %]]

local function findpreload(module)
    if _PRELOADED[module] then
        return _PRELOADED[module]
    end

    module = module .. '.init'
    if _PRELOADED[module] then
        return _PRELOADED[module]
    end

    error('not found ' .. module, 5)
end

local function loadfile(k)
    local preload = findpreload(k)
    local ok, r = pcall(preload)
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
    local ok, err = pcall(function()
        orig_main()
        require('lib')
        require('main')
    end)
    if not ok then
        print(err)
    end
end
