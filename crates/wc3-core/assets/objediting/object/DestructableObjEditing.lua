W3BDefinition = class('W3BDefinition')
_G.W3BDefinition = W3BDefinition

function W3BDefinition:constructor(id, superId)
    self.def = createDefinition(DefinitionType.Destructable, id, superId)
end

DestructableDefinition = class('DestructableDefinition', W3BDefinition)
_G.DestructableDefinition = DestructableDefinition

function DestructableDefinition:setTexture(data)
    checktype(data, 'string', 'setTexture', 1)
    self.def:setString('btxf', data)
end

function DestructableDefinition:setTextureId(data)
    checktype(data, 'integer', 'setTextureId', 1)
    self.def:setInt('btxi', data)
end

function DestructableDefinition:setCategory(data)
    checktype(data, 'string', 'setCategory', 1)
    self.def:setString('bcat', data)
end

function DestructableDefinition:setName(data)
    checktype(data, 'string', 'setName', 1)
    self.def:setString('bnam', data)
end

function DestructableDefinition:setPath(data)
    checktype(data, 'string', 'setPath', 1)
    self.def:setString('bptx', data)
end

function DestructableDefinition:setModel(data)
    checktype(data, 'string', 'setModel', 1)
    self.def:setString('bfil', data)
end

function DestructableDefinition:setSoundOnDestroy(data)
    checktype(data, 'string', 'setSoundOnDestroy', 1)
    self.def:setString('bdsn', data)
end

function DestructableDefinition:setNumModelVariable(data)
    checktype(data, 'integer', 'setTextureId', 1)
    self.def:setString('bvar', data)
end
