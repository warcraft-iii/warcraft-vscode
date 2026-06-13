-- data.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 3/11/2019, 10:53:10 PM

local type, rawget, rawequal, setmetatable = type, rawget, rawequal, setmetatable
local shallowcopy = table.shallowcopy

local function constructor(obj, cls, ...)
    if not cls then
        return
    end
    constructor(obj, cls:getSuper(), ...)

    local ctor = rawget(cls, 'constructor')
    if type(ctor) == 'function' then
        ctor(obj, ...)
    end
    return obj
end

local function inherit(cls, super)
    if not super then
        return
    end
    inherit(cls, super:getSuper())

    local inh = rawget(super, 'inherit')
    if type(inh) == 'function' then
        inh(cls)
    end
end

---@class object
object = {}

object.meta = { __index = object, __type = object, __name = 'object' }

local object = object

---getSuper
---@return object
function object:getSuper()
    return self.meta.__super
end

---getType
---@return object
function object:getType()
    return self.meta.__type
end

local function new(cls, ...)
    if not isClass(cls) then
        error('bad argument #self to `new` (class expected)', 2)
    end
    return constructor(setmetatable({}, cls.meta), cls, ...)
end

---new
---@generic T
---@vararg any
---@return T
function object:new(...)
    if not isClass(self) then
        error('bad argument #self to `new` (class expected)', 2)
    end

    local destructor = rawget(self, 'destructor')
    if destructor then
        self.meta.__gc = destructor
    end
    self.new = new
    return new(self, ...)
end

local mtDestroyed = {
    __index = function()
        error('object destroyed', 2)
    end,
    __newindex = function()
        error('object destroyed', 2)
    end
}

---delete
---@return void
function object:delete()
    local destructor = rawget(self:getType(), 'destructor')
    if destructor then
        destructor(self)
    end

    table.wipe(self)
    setmetatable(self, mtDestroyed)
end

---isClass
---@param cls any
---@return boolean
function isClass(cls)
    if type(cls) ~= 'table' then
        return false
    end
    local meta = rawget(cls, 'meta')
    if not meta then
        return false
    end
    return meta.__type == cls
end

---isObject
---@param obj any
---@return boolean
function isObject(obj)
    if type(obj) ~= 'table' then
        return false
    end
    if rawget(obj, 'meta') then
        return false
    end
    local meta = obj.meta
    if not meta then
        return false
    end
    return isClass(meta.__type)
end

---isInheritOf
---@param cls object
---@param base object
function isInheritOf(cls, base)
    if not isClass(cls) then
        return false
    end
    if not isClass(base) then
        return false
    end
    local super = cls:getSuper()
    if rawequal(super, base) then
        return true
    end
    return isInheritOf(super, base)
end

---isInstanceOf
---@param obj any
---@param cls object
---@return boolean
function isInstanceOf(obj, cls)
    if not isObject(obj) then
        return false
    end
    if not isClass(cls) then
        return false
    end
    if rawequal(obj:getType(), cls) then
        return true
    end
    return isInheritOf(obj:getType(), cls)
end

---class
---@param name string
---@param super object
---@return object
function class(name, super)
    if type(name) ~= 'string' then
        error('bad argument #1 to `class` (string expected)', 2)
    end
    if super and not isClass(super) then
        error('bad argument #2 to `class` (class expected)', 2)
    end
    super = super or object
    local cls = setmetatable({}, super.meta)
    local meta = shallowcopy(super.meta)

    cls.meta = meta
    meta.__gc = nil
    meta.__super = super
    meta.__index = cls
    meta.__type = cls
    meta.__name = name

    inherit(cls, super)
    return cls
end

_G.object = object
_G.isClass = isClass
_G.isObject = isObject
_G.isInheritOf = isInheritOf
_G.isInstanceOf = isInstanceOf
_G.class = class
