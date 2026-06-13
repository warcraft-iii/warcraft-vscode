-- table.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/1/2019 2:47 PM

local pairs, ipairs, select, type = pairs, ipairs, select, type
local table = table

---@class integer: number
---@class float: number

---@generic V
---@alias array V[]|table<integer, V>

local function riter(t, i)
    i = i - 1
    if i > 0 then
        return i, t[i]
    end
end

---ripairs
---@generic V
---@param t array
---@return fun(t:array):number,V
function ripairs(t)
    return riter, t, #t + 1
end

---spairs
---@generic V
---@param t table<string, V>|V[]
---@return fun(tbl: table<string, V>):string, V
function spairs(t)
    local i = 0
    local keys = table.keys(t)
    table.sort(keys)

    return function()
        i = i + 1
        local k = keys[i]
        if k then
            return k, t[k]
        end
    end
end

---vipairs
---@generic V
---@param t array
---@return fun(t:array):V
function vipairs(t)
    local i = 0
    return function()
        i = i + 1
        return t[i]
    end
end

---vpairs
---@generic K
---@generic V
---@param t table<K, V>
---@return fun(): V
function vpairs(t)
    local k
    return function()
        k = next(t, k)
        if not k then
            return
        end
        return t[k]
    end
end

---wipe
---@param t T
---@return T
function table.wipe(t)
    for k, v in pairs(t) do
        t[k] = nil
    end
    return t
end

---reduce
---@generic V, T
---@param t array
---@param callback fun(r:any, v:V, i:integer, t:array):T
---@param initialValue T
---@return T
function table.reduce(t, callback, initialValue)
    local r = initialValue
    for i, v in ipairs(t) do
        r = callback(r, v, i, t) or r
    end
    return r
end

---filter
---@generic V
---@param t array
---@param callback fun(v:V, i:integer, t:array):boolean
---@return array
function table.filter(t, callback)
    return table.reduce(t, function(r, v, i, _t)
        if callback(v, i, _t) then
            table.insert(r, v)
        end
    end, {})
end

---map
---@generic V, O
---@param t array
---@param callback fun(v:V, i:integer, t:array):O
---@return O[]|table<integer,O>
function table.map(t, callback)
    return table.reduce(t, function(r, v, i, _t)
        r[i] = callback(v, i, _t)
    end, {})
end

---every
---@generic V
---@param t array
---@param callback fun(v:V, i:integer, t:array):boolean
---@return boolean
function table.every(t, callback)
    for i, v in ipairs(t) do
        if not callback(v, i, t) then
            return false
        end
    end
    return true
end

---shallowcopy
---@generic T
---@param t T
---@return T
function table.shallowcopy(t)
    local r = {}
    for k, v in pairs(t) do
        r[k] = v
    end
    return r
end

---arraycopy
---@generic T
---@param t T
---@return T
function table.arraycopy(t)
    local r = {}
    for i, v in ipairs(t) do
        r[i] = v
    end
    return r
end

---indexof
---@generic V
---@param t array
---@param item V
---@return integer|nil
function table.indexof(t, item)
    for i, v in ipairs(t) do
        if v == item then
            return i
        end
    end
end

---contains
---@generic V
---@param t array
---@param item V
---@return boolean
function table.contains(t, item)
    return not not table.indexof(t, item)
end

---isempty
---@param t table
---@return boolean
function table.isempty(t)
    return next(t) == nil
end

---keys
---@param t table
function table.keys(t)
    local r = {}
    for k in pairs(t) do
        table.insert(r, k)
    end
    return r
end

---values
---@generic T
---@param t table<any, T>
---@return T[]
function table.values(t)
    local r = {}
    for _, v in pairs(t) do
        table.insert(r, v)
    end
    return r
end

---join
---@generic T
---@vararg T
---@return T
function table.join(...)
    local r = {}
    local t

    for i = 1, select('#', ...) do
        t = select(i, ...)
        if type(t) == 'table' then
            for _, v in ipairs(t) do
                table.insert(r, v)
            end
        else
            table.insert(r, t)
        end
    end
    return r
end

---merge
---@vararg table
---@return table
function table.merge(...)
    local r = {}
    for i = 1, select('#', ...) do
        for k, v in pairs(select(i, ...)) do
            r[k] = v
        end
    end
    return r
end

---random
---@generic T
---@param t T[]
---@return T
function table.random(t)
    if #t == 1 then
        return t[1]
    end
    return t[math.random(1, #t)]
end

_G.ripairs = ripairs
_G.spairs = spairs
_G.vipairs = vipairs
_G.vpairs = vpairs
