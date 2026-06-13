BuffDefinition = class('BuffDefinition')
_G.BuffDefinition = BuffDefinition

function BuffDefinition:constructor(id, superId)
    self.def = createDefinition(DefinitionType.Buff, id, superId)
end

function BuffDefinition:setName(level, value)
    checktype(level, 'integer', 'setName', 1)
    checktype(value, 'string', 'setName', 2)
    self.def:setLvlDataString('fnam', level, 0, value)
end

function BuffDefinition:setEditorSuffix(level, value)
    checktype(level, 'integer', 'setEditorSuffix', 1)
    checktype(value, 'string', 'setEditorSuffix', 2)
    self.def:setLvlDataString('fnsf', level, 0, value)
end

function BuffDefinition:setRace(level, value)
    checktype(level, 'integer', 'setRace', 1)
    checktype(value, 'string', 'setRace', 2)
    self.def:setLvlDataString('frac', level, 0, value)
end

function BuffDefinition:setIconNormal(level, value)
    checktype(level, 'integer', 'setIconNormal', 1)
    checktype(value, 'string', 'setIconNormal', 2)
    self.def:setLvlDataString('fart', level, 0, value)
    --[[ Sets the icon's path for the buff obj, add "@!!" as prefix of the icon name to overide the default path by a custom path ]]--
end

function BuffDefinition:setCaster(level, value)
    checktype(level, 'integer', 'setCaster', 1)
    checktype(value, 'string', 'setCaster', 2)
    self.def:setLvlDataString('fcat', level, 0, value)
end

function BuffDefinition:setTarget(level, value)
    checktype(level, 'integer', 'setTarget', 1)
    checktype(value, 'string', 'setTarget', 2)
    self.def:setLvlDataString('ftat', level, 0, value)
end

function BuffDefinition:setArtTarget(level, value)
    checktype(level, 'integer', 'setArtTarget', 1)
    checktype(value, 'string', 'setArtTarget', 2)
    self.def:setLvlDataString('ftat', level, 0, value)
end

function BuffDefinition:setSpecial(level, value)
    checktype(level, 'integer', 'setSpecial', 1)
    checktype(value, 'string', 'setSpecial', 2)
    self.def:setLvlDataString('fsat', level, 0, value)
end

function BuffDefinition:setArtSpecial(level, value)
    checktype(level, 'integer', 'setArtSpecial', 1)
    checktype(value, 'string', 'setArtSpecial', 2)
    self.def:setLvlDataString('fsat', level, 0, value)
end

function BuffDefinition:setEffect(level, value)
    checktype(level, 'integer', 'setEffect', 1)
    checktype(value, 'string', 'setEffect', 2)
    self.def:setLvlDataString('feat', level, 0, value)
end

function BuffDefinition:setAreaEffect(level, value)
    checktype(level, 'integer', 'setAreaEffect', 1)
    checktype(value, 'string', 'setAreaEffect', 2)
    self.def:setLvlDataString('faea', level, 0, value)
end

function BuffDefinition:setMissileArt(level, value)
    checktype(level, 'integer', 'setMissileArt', 1)
    checktype(value, 'string', 'setMissileArt', 2)
    self.def:setLvlDataString('fmat', level, 0, value)
end

function BuffDefinition:setMissileSpeed(level, value)
    checktype(level, 'integer', 'setMissileSpeed', 1)
    checktype(value, 'integer', 'setMissileSpeed', 2)
    self.def:setLvlDataInt('fmsp', level, 0, value)
end

function BuffDefinition:setMissileArc(level, value)
    checktype(level, 'integer', 'setMissileArc', 1)
    checktype(value, 'float', 'setMissileArc', 2)
    self.def:setLvlDataReal('fmac', level, 0, value)
end

function BuffDefinition:setMissileHomingEnabled(level, value)
    checktype(level, 'integer', 'setMissileHomingEnabled', 1)
    checktype(value, 'boolean', 'setMissileHomingEnabled', 2)
    self.def:setLvlDataBoolean('fmho', level, 0, value)
end

function BuffDefinition:setTargetAttachments(level, value)
    checktype(level, 'integer', 'setTargetAttachments', 1)
    checktype(value, 'integer', 'setTargetAttachments', 2)
    self.def:setLvlDataInt('ftac', level, 0, value)
end

function BuffDefinition:setTargetAttachmentPoint0(level, value)
    checktype(level, 'integer', 'setTargetAttachmentPoint0', 1)
    checktype(value, 'string', 'setTargetAttachmentPoint0', 2)
    self.def:setLvlDataString('fta0', level, 0, value)
end

function BuffDefinition:setTargetAttachmentPoint1(level, value)
    checktype(level, 'integer', 'setTargetAttachmentPoint1', 1)
    checktype(value, 'string', 'setTargetAttachmentPoint1', 2)
    self.def:setLvlDataString('fta1', level, 0, value)
end

function BuffDefinition:setTargetAttachmentPoint2(level, value)
    checktype(level, 'integer', 'setTargetAttachmentPoint2', 1)
    checktype(value, 'string', 'setTargetAttachmentPoint2', 2)
    self.def:setLvlDataString('fta2', level, 0, value)
end

function BuffDefinition:setTargetAttachmentPoint3(level, value)
    checktype(level, 'integer', 'setTargetAttachmentPoint3', 1)
    checktype(value, 'string', 'setTargetAttachmentPoint3', 2)
    self.def:setLvlDataString('fta3', level, 0, value)
end

function BuffDefinition:setTargetAttachmentPoint4(level, value)
    checktype(level, 'integer', 'setTargetAttachmentPoint4', 1)
    checktype(value, 'string', 'setTargetAttachmentPoint4', 2)
    self.def:setLvlDataString('fta4', level, 0, value)
end

function BuffDefinition:setTargetAttachmentPoint5(level, value)
    checktype(level, 'integer', 'setTargetAttachmentPoint5', 1)
    checktype(value, 'string', 'setTargetAttachmentPoint5', 2)
    self.def:setLvlDataString('fta5', level, 0, value)
end

function BuffDefinition:setCasterAttachments(level, value)
    checktype(level, 'integer', 'setCasterAttachments', 1)
    checktype(value, 'integer', 'setCasterAttachments', 2)
    self.def:setLvlDataInt('fcac', level, 0, value)
end

function BuffDefinition:setSpecialAttachmentPoint(level, value)
    checktype(level, 'integer', 'setSpecialAttachmentPoint', 1)
    checktype(value, 'string', 'setSpecialAttachmentPoint', 2)
    self.def:setLvlDataString('fspt', level, 0, value)
end

function BuffDefinition:setTooltipNormal(level, value)
    checktype(level, 'integer', 'setTooltipNormal', 1)
    checktype(value, 'string', 'setTooltipNormal', 2)
    self.def:setLvlDataString('ftip', level, 0, value)
end

function BuffDefinition:setTooltipNormalExtended(level, value)
    checktype(level, 'integer', 'setTooltipNormalExtended', 1)
    checktype(value, 'string', 'setTooltipNormalExtended', 2)
    self.def:setLvlDataString('fube', level, 0, value)
end

function BuffDefinition:setEffectSound(level, value)
    checktype(level, 'integer', 'setEffectSound', 1)
    checktype(value, 'string', 'setEffectSound', 2)
    self.def:setLvlDataString('fefs', level, 0, value)
end

function BuffDefinition:setEffectSoundLooping(level, value)
    checktype(level, 'integer', 'setEffectSoundLooping', 1)
    checktype(value, 'string', 'setEffectSoundLooping', 2)
    self.def:setLvlDataString('fefl', level, 0, value)
end
