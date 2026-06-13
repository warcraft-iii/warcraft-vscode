-- objectwriter.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/12/2019, 11:17:25 AM

---@class ObjectWriter: object
---@param type DefinitionType
ObjectWriter = class('ObjectWriter')

---@param type DefinitionType
---@param version integer|nil
function ObjectWriter:constructor(type, version)
    self.type = type
    self.version = version or 2
    self.buffer = WriteBuffer:new()

    -- file version
    self.buffer:addInt(self.version)
end

---@return string
function ObjectWriter:getBuffer()
    return self.buffer:getBuffer()
end

---@param defs table<any, Definition>
function ObjectWriter:write(defs)
    defs = table.values(defs)

    table.sort(defs, function(a, b)
        return a.id < b.id
    end)

    local original = table.filter(defs, function(def)
        return not def.superId
    end)
    local custom = table.filter(defs, function(def)
        return def.superId
    end)

    self.buffer:addInt(#original)
    for def in vipairs(original) do
        self:writeDefinition(def)
    end

    self.buffer:addInt(#custom)
    for def in vipairs(custom) do
        self:writeDefinition(def)
    end
end

---@param def Definition
function ObjectWriter:writeDefinition(def)
    if self.type ~= def.type then
        error('', 2)
    end

    if def.superId then
        self.buffer:addString(def.superId)
        self.buffer:addString(def.id)
    else
        self.buffer:addString(def.id)
        self.buffer:addInt(0)
    end

    -- Reforged (file version >= 3) writes two extra ints in each object header
    -- between the IDs and the field count.
    if self.version >= 3 then
        self.buffer:addInt(1)
        self.buffer:addInt(0)
    end

    local fields = table.values(def.fields)

    self.buffer:addInt(#fields)

    for _, field in spairs(fields) do
        self.buffer:addString(field.id)
        self.buffer:addInt(field.type)

        if self.type == DefinitionType.Doodad or self.type == DefinitionType.Ability or self.type ==
            DefinitionType.Upgrade then
            self.buffer:addInt(field.level or 0)
            self.buffer:addInt(field.column or 0)
        end

        if field.type == FieldType.Int then
            self.buffer:addInt(field.value)
        elseif field.type == FieldType.Real or field.type == FieldType.Unreal then
            self.buffer:addFloat(field.value)
        elseif field.type == FieldType.String then
            self.buffer:addString(field.value)
            self.buffer:addNullTerminator()
        end

        if def.superId then
            self.buffer:addInt(0)
        else
            self.buffer:addString(def.id)
        end
    end
end

return ObjectWriter
