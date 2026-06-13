-- object.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/10/2019, 4:39:42 PM

---@class FieldType
FieldType = {Int = 0, Real = 1, Unreal = 2, String = 3}

---@class DefinitionType
DefinitionType = {
    Unit = 'w3u',
    Item = 'w3t',
    Destructable = 'w3b',
    Buff = 'w3h',

    -- level
    Doodad = 'w3d',
    Ability = 'w3a',
    Upgrade = 'w3q',
}

---@class Filed
---@field id string
---@field type FieldType
---@field value any
---@field level number
---@field column number

---@class Definition
---@field id string
---@field superId string
---@field type DefinitionType
---@field fields table<string, Filed>

---@class ObjectDefinition: object
---@field def Definition
ObjectDefinition = class('ObjectDefinition')

function ObjectDefinition:constructor(defType, id, superId)
    local def = type(defType) == 'table' and defType or {id = id, superId = superId, type = defType}
    def.fields = def.fields or {}
    self.def = def
end

---setRaw
---@private
---@param id string
---@param type FieldType
---@param value any
---@param level integer
---@param column integer
---@return void
function ObjectDefinition:setRaw(id, type, value, level, column)
    self.def.fields[id .. (level or 'NONE') .. (column or 'NONE')] = {id = id, type = type, value = value, level = level, column = column}
end

---setInt
---@param id string
---@param value integer
---@return void
function ObjectDefinition:setInt(id, value)
    return self:setRaw(id, FieldType.Int, value)
end

---setBoolean
---@param id string
---@param value boolean
---@return void
function ObjectDefinition:setBoolean(id, value)
    return self:setInt(id, value and 1 or 0)
end

---setString
---@param id string
---@param value string
---@return void
function ObjectDefinition:setString(id, value)
    return self:setRaw(id, FieldType.String, value)
end

---setReal
---@param id string
---@param value float
---@return void
function ObjectDefinition:setReal(id, value)
    return self:setRaw(id, FieldType.Real, value)
end

---setUnread
---@param id string
---@param value number
---@return void
function ObjectDefinition:setUnreal(id, value)
    return self:setRaw(id, FieldType.Unreal, value)
end

---setLvlInt
---@param id string
---@param level integer
---@param value integer
function ObjectDefinition:setLvlInt(id, level, value)
    return self:setRaw(id, FieldType.Int, value, level)
end

---setLvlString
---@param id string
---@param level integer
---@param value string
function ObjectDefinition:setLvlString(id, level, value)
    return self:setRaw(id, FieldType.String, value, level)
end

---setLvlReal
---@param id string
---@param level integer
---@param value float
function ObjectDefinition:setLvlReal(id, level, value)
    return self:setRaw(id, FieldType.Real, value, level)
end

---setLvlUnreal
---@param id string
---@param level integer
---@param value float
function ObjectDefinition:setLvlUnreal(id, level, value)
    return self:setRaw(id, FieldType.Unreal, value, level)
end

---setLvlDataInt
---@param id string
---@param level integer
---@param column integer
---@param value string
function ObjectDefinition:setLvlDataInt(id, level, column, value)
    if type(value) == 'boolean' then
       value = value and 1 or 0
    end
    return self:setRaw(id, FieldType.Int, value, level, column)
end

---setLvlDataString
---@param id string
---@param level integer
---@param column integer
---@param value integer
function ObjectDefinition:setLvlDataString(id, level, column, value)
    return self:setRaw(id, FieldType.String, value, level, column)
end

---setLvlDataReal
---@param id string
---@param level integer
---@param column integer
---@param value float
function ObjectDefinition:setLvlDataReal(id, level, column, value)
    return self:setRaw(id, FieldType.Real, value, level, column)
end

---setLvlDataUnreal
---@param id string
---@param level integer
---@param column integer
---@param value float
function ObjectDefinition:setLvlDataUnreal(id, level, column, value)
    return self:setRaw(id, FieldType.Unreal, value, level, column)
end

---setLvlDataBoolean
---@param id string
---@param level integer
---@param column integer
---@param value boolean
function ObjectDefinition:setLvlDataBoolean(id, level, column, value)
    return self:setLvlDataInt(id, level, column, value and 1 or 0)
end

DEFINITIONS = {}
---@type table<DefinitionType, table<string, Definition>>
TYPED_DEFINITIONS = setmetatable({}, {
    __index = function(t, k)
        t[k] = {}
        return t[k]
    end,
})

local DEFINITIONS = DEFINITIONS
local TYPED_DEFINITIONS = TYPED_DEFINITIONS
local CREATED_DEFINITIONS = {}

---@param defType DefinitionType
---@param id string
---@param superId string
function createDefinition(defType, id, superId)
    if type(id) == 'number' then
        id = string.pack('>I', id)
    end
    if type(superId) == 'number' then
        superId = string.pack('>I', superId)
    end
    
    if CREATED_DEFINITIONS[id] then
        error(string.format('%s already exists', id), 2)
    end

    local def = DEFINITIONS[id]
    if def and (def.superId ~= superId or def.type ~= defType) then
        error(string.format([[%s's super id and define type must same as war3map object]], def.superId, superId,
                            def.type, defType), 2)
    end

    CREATED_DEFINITIONS[id] = true

    local obj = def and ObjectDefinition:new(def) or ObjectDefinition:new(defType, id, superId)

    DEFINITIONS[id] = def
    TYPED_DEFINITIONS[defType][id] = obj.def

    return obj
end

_G.FieldType = FieldType
_G.DefinitionType = DefinitionType
