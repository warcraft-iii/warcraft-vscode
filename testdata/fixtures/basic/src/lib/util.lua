local mod = require('mod')
local M = {}
M.from = mod.who
function M.add(a, b)
    return a + b
end
return M
