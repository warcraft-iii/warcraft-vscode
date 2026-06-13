-- readbuffer.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/10/2019, 10:17:42 PM

---@class ReadBuffer: object
ReadBuffer = class('ReadBuffer')

function ReadBuffer:constructor(buffer)
    self.buf = buffer
    self.offset = 1
end

function ReadBuffer:readRaw(n)
    local buf = self.buf:sub(self.offset, self.offset + n - 1)
    self.offset = self.offset + n
    return buf
end

function ReadBuffer:readInt()
    return string.unpack('i4<', self:readRaw(4))
end

function ReadBuffer:readShort()
    return string.unpack('i2<', self:readRaw(2))
end

function ReadBuffer:readFloat()
    return string.unpack('f<', self:readRaw(4))
end

function ReadBuffer:readString(n)
    if n then
        return self:readRaw(n)
    end
    local s = {}
    while true do
        local char = self:readRaw(1)
        if char == '\0' then
            break
        end
        s[#s + 1] = char
    end
    return table.concat(s)
end

function ReadBuffer:readByte()
    return self:readRaw(1):byte(1)
end

return ReadBuffer
