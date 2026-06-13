W3QDefinition = class('W3QDefinition')
_G.W3QDefinition = W3QDefinition

function W3QDefinition:constructor(id, superId)
    self.def = createDefinition(DefinitionType.Upgrade, id, superId)
end

function W3QDefinition:setButtonPositionX(value)
    checktype(value, 'integer', 'setButtonPositionX', 1)
    self.def:setLvlDataInt('gbpx', 0, 0, value)
end

function W3QDefinition:setButtonPositionY(value)
    checktype(value, 'integer', 'setButtonPositionY', 1)
    self.def:setLvlDataInt('gbpy', 0, 0, value)
end

function W3QDefinition:setClass(value)
    checkenum(value, 'UpgradeClass', 'setClass', 1)
    self.def:setLvlDataString('gcls', 0, 0, value)
end

function W3QDefinition:setGoldCostBase(value)
    checktype(value, 'integer', 'setGoldCostBase', 1)
    self.def:setLvlDataInt('gglb', 0, 0, value)
end

function W3QDefinition:setGoldCostIncrement(value)
    checktype(value, 'integer', 'setGoldCostIncrement', 1)
    self.def:setLvlDataInt('gglm', 0, 0, value)
end

function W3QDefinition:setLevels(value)
    checktype(value, 'integer', 'setLevels', 1)
    self.def:setLvlDataInt('glvl', 0, 0, value)
end

function W3QDefinition:setLumberCostBase(value)
    checktype(value, 'integer', 'setLumberCostBase', 1)
    self.def:setLvlDataInt('glmb', 0, 0, value)
end

function W3QDefinition:setLumberCostIncrement(value)
    checktype(value, 'integer', 'setLumberCostIncrement', 1)
    self.def:setLvlDataInt('glmm', 0, 0, value)
end

function W3QDefinition:setRace(value)
    checkenum(value, 'Race', 'setRace', 1)
    self.def:setLvlDataString('grac', 0, 0, value)
end

function W3QDefinition:setTimeBase(value)
    checktype(value, 'integer', 'setTimeBase', 1)
    self.def:setLvlDataInt('gtib', 0, 0, value)
end

function W3QDefinition:setTimeIncrement(value)
    checktype(value, 'integer', 'setTimeIncrement', 1)
    self.def:setLvlDataInt('gtim', 0, 0, value)
end

function W3QDefinition:setTransferWithUnitOwnership(value)
    checktype(value, 'boolean', 'setTransferWithUnitOwnership', 1)
    self.def:setLvlDataInt('ginh', 0, 0, value)
end

function W3QDefinition:setIcon(level, value)
    checktype(level, 'integer', 'setIcon', 1)
    checktype(value, 'string', 'setIcon', 2)
    self.def:setLvlDataString('gar1', level, 0, value)
    --[[ Comma separated list of ids for tech requirements. ]]--
end

function W3QDefinition:setRequirements(level, value)
    checktype(level, 'integer', 'setRequirements', 1)
    checktype(value, 'string', 'setRequirements', 2)
    self.def:setLvlDataString('greq', level, 0, value)
    --[[ Comma separated list of ints corresponding to list of tech requirements
    provided by setRequirements. ]]--
end

function W3QDefinition:setRequirementsLevels(level, value)
    checktype(level, 'integer', 'setRequirementsLevels', 1)
    checktype(value, 'string', 'setRequirementsLevels', 2)
    self.def:setLvlDataString('grqc', level, 0, value)
end

function W3QDefinition:setEditorSuffix(level, value)
    checktype(level, 'integer', 'setEditorSuffix', 1)
    checktype(value, 'string', 'setEditorSuffix', 2)
    self.def:setLvlDataString('gnsf', level, 0, value)
end

function W3QDefinition:setHotkey(level, value)
    checktype(level, 'integer', 'setHotkey', 1)
    checktype(value, 'string', 'setHotkey', 2)
    self.def:setLvlDataString('ghk1', level, 0, value)
end

function W3QDefinition:setName(level, value)
    checktype(level, 'integer', 'setName', 1)
    checktype(value, 'string', 'setName', 2)
    self.def:setLvlDataString('gnam', level, 0, value)
end

function W3QDefinition:setTooltip(level, value)
    checktype(level, 'integer', 'setTooltip', 1)
    checktype(value, 'string', 'setTooltip', 2)
    self.def:setLvlDataString('gtp1', level, 0, value)
end

function W3QDefinition:setTooltipExtended(level, value)
    checktype(level, 'integer', 'setTooltipExtended', 1)
    checktype(value, 'string', 'setTooltipExtended', 2)
    self.def:setLvlDataString('gub1', level, 0, value)
end

function W3QDefinition:setEffectType(effectIndex, effectType)
    checktype(effectIndex, 'integer', 'setEffectType', 1)
    checkenum(effectType, 'UpgradeEffectType', 'setEffectType', 2)
    self.def:setLvlDataString('gef' .. effectIndex, 0, 0, effectType)
end

function W3QDefinition:setEffectBase(effectIndex, value)
    checktype(effectIndex, 'integer', 'setEffectBase', 1)
    checktype(value, 'float', 'setEffectBase', 2)
    self.def:setLvlDataUnreal('gba' .. effectIndex, 0, 0, value)
end

function W3QDefinition:setEffectIncrement(effectIndex, value)
    checktype(effectIndex, 'integer', 'setEffectIncrement', 1)
    checktype(value, 'float', 'setEffectIncrement', 2)
    self.def:setLvlDataUnreal('gmo' .. effectIndex, 0, 0, value)
end

function W3QDefinition:setEffectCode(effectIndex, value)
    checktype(effectIndex, 'integer', 'setEffectCode', 1)
    checktype(value, 'string', 'setEffectCode', 2)
    self.def:setLvlDataString('gco' .. effectIndex, 0, 0, value)
end

UpgradeDefinition = class('UpgradeDefinition', W3QDefinition)
_G.UpgradeDefinition = UpgradeDefinition
