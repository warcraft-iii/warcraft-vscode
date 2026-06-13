-- init.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/12/2019, 1:27:11 PM

package.path = table.concat({
    package.path, --
    './src/lua/?.lua', --
    './src/lua/?/init.lua', --
}, ';')

require('base')

local env = setmetatable({}, {__index = _G})

local files = {
'core/checker.lua',
'core/object.lua',
'core/readbuffer.lua',
'core/writebuffer.lua',
'core/objectreader.lua',
'core/objectwriter.lua',
'application.lua',
}

for _, file in ipairs(files) do
    assert(loadfile('src/lua/' .. file, nil, env))()
end
