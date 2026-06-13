-- string.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/1/2019 4:15 PM

local string, table = string, table

---trimleft
---@param s string
---@return string
function string.trimleft(s)
    return (s:gsub('^%s+', ''))
end

---trimright
---@param s string
---@return string
function string.trimright(s)
    return (s:gsub('%s+$', ''))
end

---trim
---@param s string
---@return string
function string.trim(s)
    return s:trimleft():trimright()
end

---split
---@param s string
---@param pattern string
---@param plain boolean
---@param maxTokens integer
---@return string[]
function string.split(s, pattern, plain, maxTokens)
    local pos = 0
    local start, stop
    local r = {}

    while true do
        start, stop = s:find(pattern, pos, plain)
        if not start then
            break
        end

        table.insert(r, s:sub(pos, start - 1))
        pos = stop + 1

        if maxTokens then
            maxTokens = maxTokens - 1
            if maxTokens == 0 then
                break
            end
        end
    end
    table.insert(r, s:sub(pos))
    return r
end

---startswith
---@param s string
---@param pattern string
---@param plain boolean
---@return boolean
function string.startswith(s, pattern, plain)
    if plain then
        pattern = pattern:escapepattern()
    end
    pattern = '^' .. pattern
    return not not s:find(pattern)
end

---endswith
---@param s string
---@param pattern string
---@param plain boolean
---@return boolean
function string.endswith(s, pattern, plain)
    if plain then
        pattern = pattern:escapepattern()
    end
    pattern = pattern .. '$'
    return not not s:find(pattern)
end

---escapepattern
---@param s string
---@return string
function string.escapepattern(s)
    return s:gsub('[%(%)%.%%%+%-%*%?%[%]%^%$]', '%%%0')
end
