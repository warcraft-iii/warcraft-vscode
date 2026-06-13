W3TDefinition = class('W3TDefinition')
_G.W3TDefinition = W3TDefinition

function W3TDefinition:constructor(id, superId)
    self.def = createDefinition(DefinitionType.Item, id, superId)
end

function W3TDefinition:setTooltipExtended(data)
    checktype(data, 'string', 'setTooltipExtended', 1)
    self.def:setString('utub', data)
end

function W3TDefinition:setTooltipBasic(data)
    checktype(data, 'string', 'setTooltipBasic', 1)
    self.def:setString('utip', data)
end

function W3TDefinition:setRequirementsLevels(data)
    checktype(data, 'string', 'setRequirementsLevels', 1)
    self.def:setString('urqa', data)
end

function W3TDefinition:setRequirements(data)
    checktype(data, 'string', 'setRequirements', 1)
    self.def:setString('ureq', data)
end

function W3TDefinition:setName(data)
    checktype(data, 'string', 'setName', 1)
    self.def:setString('unam', data)
end

function W3TDefinition:setHotkey(data)
    checktype(data, 'string', 'setHotkey', 1)
    self.def:setString('uhot', data)
end

function W3TDefinition:setDescription(data)
    checktype(data, 'string', 'setDescription', 1)
    self.def:setString('ides', data)
end

function W3TDefinition:setButtonPositionY(data)
    checktype(data, 'integer', 'setButtonPositionY', 1)
    self.def:setInt('ubpy', data)
end

function W3TDefinition:setButtonPositionX(data)
    checktype(data, 'integer', 'setButtonPositionX', 1)
    self.def:setInt('ubpx', data)
end

ItemDefinition = class('ItemDefinition', W3TDefinition)
_G.ItemDefinition = ItemDefinition

function ItemDefinition:setAbilities(data)
    checktype(data, 'string', 'setAbilities', 1)
    self.def:setString('iabi', data)
end

function ItemDefinition:setArmorType(data)
    checkenum(data, 'ArmorType', 'setArmorType', 1)
    self.def:setString('iarm', data)
end

function ItemDefinition:setClassification(data)
    checktype(data, 'string', 'setClassification', 1)
    self.def:setString('icla', data)
end

function ItemDefinition:setTintingColor3Blue(data)
    checktype(data, 'integer', 'setTintingColor3Blue', 1)
    self.def:setInt('iclb', data)
end

function ItemDefinition:setTintingColor2Green(data)
    checktype(data, 'integer', 'setTintingColor2Green', 1)
    self.def:setInt('iclg', data)
end

function ItemDefinition:setTintingColor1Red(data)
    checktype(data, 'integer', 'setTintingColor1Red', 1)
    self.def:setInt('iclr', data)
end

function ItemDefinition:setCooldownGroup(data)
    checktype(data, 'string', 'setCooldownGroup', 1)
    self.def:setString('icid', data)
end

function ItemDefinition:setDroppedWhenCarrierDies(data)
    checktype(data, 'boolean', 'setDroppedWhenCarrierDies', 1)
    self.def:setBoolean('idrp', data)
end

function ItemDefinition:setCanBeDropped(data)
    checktype(data, 'boolean', 'setCanBeDropped', 1)
    self.def:setBoolean('idro', data)
end

function ItemDefinition:setModelUsed(data)
    checktype(data, 'string', 'setModelUsed', 1)
    self.def:setString('ifil', data)
end

function ItemDefinition:setGoldCost(data)
    checktype(data, 'integer', 'setGoldCost', 1)
    self.def:setInt('igol', data)
end

function ItemDefinition:setHitPoints(data)
    checktype(data, 'integer', 'setHitPoints', 1)
    self.def:setInt('ihtp', data)
end

function ItemDefinition:setIgnoreCooldown(data)
    checktype(data, 'boolean', 'setIgnoreCooldown', 1)
    self.def:setBoolean('iicd', data)
end

function ItemDefinition:setLevel(data)
    checktype(data, 'integer', 'setLevel', 1)
    self.def:setInt('ilev', data)
end

function ItemDefinition:setLumberCost(data)
    checktype(data, 'integer', 'setLumberCost', 1)
    self.def:setInt('ilum', data)
end

function ItemDefinition:setValidTargetForTransformation(data)
    checktype(data, 'boolean', 'setValidTargetForTransformation', 1)
    self.def:setBoolean('imor', data)
end

function ItemDefinition:setLevelUnclassified(data)
    checktype(data, 'integer', 'setLevelUnclassified', 1)
    self.def:setInt('ilvo', data)
end

function ItemDefinition:setPerishable(data)
    checktype(data, 'boolean', 'setPerishable', 1)
    self.def:setBoolean('iper', data)
end

function ItemDefinition:setIncludeAsRandomChoice(data)
    checktype(data, 'boolean', 'setIncludeAsRandomChoice', 1)
    self.def:setBoolean('iprn', data)
end

function ItemDefinition:setUseAutomaticallyWhenAcquired(data)
    checktype(data, 'boolean', 'setUseAutomaticallyWhenAcquired', 1)
    self.def:setBoolean('ipow', data)
end

function ItemDefinition:setPriority(data)
    checktype(data, 'integer', 'setPriority', 1)
    self.def:setInt('ipri', data)
end

function ItemDefinition:setScalingValue(data)
    checktype(data, 'float', 'setScalingValue', 1)
    self.def:setReal('isca', data)
end

function ItemDefinition:setCanBeSoldByMerchants(data)
    checktype(data, 'boolean', 'setCanBeSoldByMerchants', 1)
    self.def:setBoolean('isel', data)
end

function ItemDefinition:setCanBeSoldToMerchants(data)
    checktype(data, 'boolean', 'setCanBeSoldToMerchants', 1)
    self.def:setBoolean('ipaw', data)
end

function ItemDefinition:setStockMaximum(data)
    checktype(data, 'integer', 'setStockMaximum', 1)
    self.def:setInt('isto', data)
end

function ItemDefinition:setStockReplenishInterval(data)
    checktype(data, 'integer', 'setStockReplenishInterval', 1)
    self.def:setInt('istr', data)
end

function ItemDefinition:setStockStartDelay(data)
    checktype(data, 'integer', 'setStockStartDelay', 1)
    self.def:setInt('isst', data)
end

function ItemDefinition:setActivelyUsed(data)
    checktype(data, 'boolean', 'setActivelyUsed', 1)
    self.def:setBoolean('iusa', data)
end

function ItemDefinition:setNumberofCharges(data)
    checktype(data, 'integer', 'setNumberofCharges', 1)
    self.def:setInt('iuse', data)
end

function ItemDefinition:setInterfaceIcon(data)
    checktype(data, 'string', 'setInterfaceIcon', 1)
    self.def:setString('iico', data)
end

function ItemDefinition:setMaxStack(data)
    checktype(data, 'integer', 'setMaxStack', 1)
    self.def:setInt('ista', data)
end

function ItemDefinition:setSelectCircleSize(data)
    checktype(data, 'float', 'setSelectCircleSize', 1)
    self.def:setReal('issc', data)
end
