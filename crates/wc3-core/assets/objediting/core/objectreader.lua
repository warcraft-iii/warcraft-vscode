-- objectreader.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/12/2019, 1:26:31 PM

---@class ObjectReader: object
ObjectReader = class('ObjectReader')

function ObjectReader:constructor(type, data)
    self.buffer = ReadBuffer:new(data)
    self.definitions = {}
    self.type = type
end

---@return table<string, Definition>
function ObjectReader:read()
    -- file version
    self.version = self.buffer:readInt()
    self:readDefinitions()
    self:readDefinitions()
    return self.definitions
end

function ObjectReader:readDefinitions()
    local n = self.buffer:readInt()
    for i = 1, n do
        ---@type Definition
        local def = {}
        def.type = self.type
        def.fields = {}

        local superId = self.buffer:readString(4)
        local id = self.buffer:readString(4)

        if id == '\0\0\0\0' then
            def.id = superId
        else
            def.id = id
            def.superId = superId
        end

        -- Reforged (file version >= 3) adds two extra ints in each object header:
        -- a "set count" (usually 1) and a reserved/zero int. Skip them so the
        -- field count and subsequent fields don't get misaligned.
        if self.version and self.version >= 3 then
            self.buffer:readInt()
            self.buffer:readInt()
        end

        local fieldCount = self.buffer:readInt()

        for j = 1, fieldCount do
            ---@type Filed
            local field = {}

            field.id = self.buffer:readString(4)
            field.type = self.buffer:readInt()

            if self.type == DefinitionType.Doodad or self.type == DefinitionType.Ability or self.type ==
                DefinitionType.Upgrade then
                field.level = self.buffer:readInt()
                field.column = self.buffer:readInt()
            end

            if field.type == FieldType.Int then
                field.value = self.buffer:readInt()
            elseif field.type == FieldType.Real or field.type == FieldType.Unreal then
                field.value = self.buffer:readFloat()
            elseif field.type == FieldType.String then
                field.value = self.buffer:readString()
            else
                assert(false)
            end

            self.buffer:readInt()

            def.fields[field.id .. (field.level or 'NONE') .. (field.column or 'NONE')] = field
        end

        self.definitions[def.id] = def
    end
end
