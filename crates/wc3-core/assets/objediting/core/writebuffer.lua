-- writebuffer.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/10/2019, 8:03:06 PM

---@class WriteBuffer: object
WriteBuffer = class('WriteBuffer')

function WriteBuffer:constructor()
    self.buf = {}
end

function WriteBuffer:add(value)
    table.insert(self.buf, value)
end

function WriteBuffer:addString(value)
    self:add(value)
end

function WriteBuffer:addNullTerminator()
    self:add('\0')
end

function WriteBuffer:addNewLine()
    self:add('\r\n')
end

function WriteBuffer:addChar(value)
    if #value ~= 1 then
        error('bad argument', 2)
    end
    self:add(value)
end

function WriteBuffer:addInt(value)
    self:add(string.pack('i4<', value))
end

function WriteBuffer:addShort(value)
    self:add(string.pack('i2<', value))
end

function WriteBuffer:addFloat(value)
    self:add(string.pack('f<', value))
end

function WriteBuffer:addByte(value)
    self:add(string.char(value))
end

function WriteBuffer:getBuffer()
    return table.concat(self.buf)
end

return WriteBuffer
