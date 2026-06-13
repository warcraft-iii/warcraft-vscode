AbilityDefinition = class('AbilityDefinition')
_G.AbilityDefinition = AbilityDefinition

function AbilityDefinition:constructor(id, superId)
    if superId then
        self.def = createDefinition(DefinitionType.Ability, id, superId)
    end
end

function AbilityDefinition:setName(value)
    checktype(value, 'string', 'setName', 1)
    self.def:setLvlDataString('anam', 0, 0, value)
end

function AbilityDefinition:setEditorSuffix(value)
    checktype(value, 'string', 'setEditorSuffix', 1)
    self.def:setLvlDataString('ansf', 0, 0, value)
end

function AbilityDefinition:setHeroAbility(value)
    checktype(value, 'boolean', 'setHeroAbility', 1)
    self.def:setLvlDataBoolean('aher', 0, 0, value)
end

function AbilityDefinition:setItemAbility(value)
    checktype(value, 'boolean', 'setItemAbility', 1)
    self.def:setLvlDataBoolean('aite', 0, 0, value)
end

function AbilityDefinition:setRace(rce)
    checkenum(rce, 'Race', 'setRace', 1)
    self.def:setLvlDataString('arac', 0, 0, rce)
end

function AbilityDefinition:setButtonPositionNormalX(value)
    checktype(value, 'integer', 'setButtonPositionNormalX', 1)
    self.def:setLvlDataInt('abpx', 0, 0, value)
end

function AbilityDefinition:setButtonPositionNormalY(value)
    checktype(value, 'integer', 'setButtonPositionNormalY', 1)
    self.def:setLvlDataInt('abpy', 0, 0, value)
end

function AbilityDefinition:setButtonPositionTurnOffX(value)
    checktype(value, 'integer', 'setButtonPositionTurnOffX', 1)
    self.def:setLvlDataInt('aubx', 0, 0, value)
end

function AbilityDefinition:setButtonPositionTurnOffY(value)
    checktype(value, 'integer', 'setButtonPositionTurnOffY', 1)
    self.def:setLvlDataInt('auby', 0, 0, value)
end

function AbilityDefinition:setButtonPositionResearchX(value)
    checktype(value, 'integer', 'setButtonPositionResearchX', 1)
    self.def:setLvlDataInt('arpx', 0, 0, value)
end

function AbilityDefinition:setButtonPositionResearchY(value)
    checktype(value, 'integer', 'setButtonPositionResearchY', 1)
    self.def:setLvlDataInt('arpy', 0, 0, value)
end

function AbilityDefinition:setIconNormal(value)
    checktype(value, 'string', 'setIconNormal', 1)
    self.def:setLvlDataString('aart', 0, 0, value)
end

function AbilityDefinition:setIconTurnOff(value)
    checktype(value, 'string', 'setIconTurnOff', 1)
    self.def:setLvlDataString('auar', 0, 0, value)
end

function AbilityDefinition:setIconResearch(value)
    checktype(value, 'string', 'setIconResearch', 1)
    self.def:setLvlDataString('arar', 0, 0, value)
end

function AbilityDefinition:setArtCaster(value)
    checktype(value, 'string', 'setArtCaster', 1)
    self.def:setLvlDataString('acat', 0, 0, value)
end

function AbilityDefinition:setArtTarget(value)
    checktype(value, 'string', 'setArtTarget', 1)
    self.def:setLvlDataString('atat', 0, 0, value)
end

function AbilityDefinition:setArtSpecial(value)
    checktype(value, 'string', 'setArtSpecial', 1)
    self.def:setLvlDataString('asat', 0, 0, value)
end

function AbilityDefinition:setArtEffect(value)
    checktype(value, 'string', 'setArtEffect', 1)
    self.def:setLvlDataString('aeat', 0, 0, value)
end

function AbilityDefinition:setAreaEffect(value)
    checktype(value, 'string', 'setAreaEffect', 1)
    self.def:setLvlDataString('aaea', 0, 0, value)
end

function AbilityDefinition:setLightningEffects(value)
    checktype(value, 'string', 'setLightningEffects', 1)
    self.def:setLvlDataString('alig', 0, 0, value)
end

function AbilityDefinition:setMissileArt(value)
    checktype(value, 'string', 'setMissileArt', 1)
    self.def:setLvlDataString('amat', 0, 0, value)
end

function AbilityDefinition:setMissileSpeed(value)
    checktype(value, 'integer', 'setMissileSpeed', 1)
    self.def:setLvlDataInt('amsp', 0, 0, value)
end

function AbilityDefinition:setMissileArc(value)
    checktype(value, 'float', 'setMissileArc', 1)
    self.def:setLvlDataUnreal('amac', 0, 0, value)
end

function AbilityDefinition:setMissileHomingEnabled(value)
    checktype(value, 'boolean', 'setMissileHomingEnabled', 1)
    self.def:setLvlDataBoolean('amho', 0, 0, value)
end

function AbilityDefinition:setTargetAttachments(value)
    checktype(value, 'integer', 'setTargetAttachments', 1)
    self.def:setLvlDataInt('atac', 0, 0, value)
end

function AbilityDefinition:setTargetAttachmentPoint(value)
    checktype(value, 'string', 'setTargetAttachmentPoint', 1)
    self.def:setLvlDataString('ata0', 0, 0, value)
end

function AbilityDefinition:setTargetAttachmentPoint1(value)
    checktype(value, 'string', 'setTargetAttachmentPoint1', 1)
    self.def:setLvlDataString('ata1', 0, 0, value)
end

function AbilityDefinition:setTargetAttachmentPoint2(value)
    checktype(value, 'string', 'setTargetAttachmentPoint2', 1)
    self.def:setLvlDataString('ata2', 0, 0, value)
end

function AbilityDefinition:setTargetAttachmentPoint3(value)
    checktype(value, 'string', 'setTargetAttachmentPoint3', 1)
    self.def:setLvlDataString('ata3', 0, 0, value)
end

function AbilityDefinition:setTargetAttachmentPoint4(value)
    checktype(value, 'string', 'setTargetAttachmentPoint4', 1)
    self.def:setLvlDataString('ata4', 0, 0, value)
end

function AbilityDefinition:setTargetAttachmentPoint5(value)
    checktype(value, 'string', 'setTargetAttachmentPoint5', 1)
    self.def:setLvlDataString('ata5', 0, 0, value)
end

function AbilityDefinition:setCasterAttachments(value)
    checktype(value, 'integer', 'setCasterAttachments', 1)
    self.def:setLvlDataInt('acac', 0, 0, value)
end

function AbilityDefinition:setCasterAttachmentPoint(value)
    checktype(value, 'string', 'setCasterAttachmentPoint', 1)
    self.def:setLvlDataString('acap', 0, 0, value)
end

function AbilityDefinition:setCasterAttachmentPoint1(value)
    checktype(value, 'string', 'setCasterAttachmentPoint1', 1)
    self.def:setLvlDataString('aca1', 0, 0, value)
end

function AbilityDefinition:setSpecialAttachmentPoint(value)
    checktype(value, 'string', 'setSpecialAttachmentPoint', 1)
    self.def:setLvlDataString('aspt', 0, 0, value)
end

function AbilityDefinition:setAnimationNames(value)
    checktype(value, 'string', 'setAnimationNames', 1)
    self.def:setLvlDataString('aani', 0, 0, value)
end

function AbilityDefinition:setTooltipNormal(level, value)
    checktype(level, 'integer', 'setTooltipNormal', 1)
    checktype(value, 'string', 'setTooltipNormal', 2)
    self.def:setLvlDataString('atp1', level, 0, value)
end

function AbilityDefinition:setTooltipTurnOff(level, value)
    checktype(level, 'integer', 'setTooltipTurnOff', 1)
    checktype(value, 'string', 'setTooltipTurnOff', 2)
    self.def:setLvlDataString('aut1', level, 0, value)
end

function AbilityDefinition:setTooltipNormalExtended(level, value)
    checktype(level, 'integer', 'setTooltipNormalExtended', 1)
    checktype(value, 'string', 'setTooltipNormalExtended', 2)
    self.def:setLvlDataString('aub1', level, 0, value)
end

function AbilityDefinition:setTooltipTurnOffExtended(level, value)
    checktype(level, 'integer', 'setTooltipTurnOffExtended', 1)
    checktype(value, 'string', 'setTooltipTurnOffExtended', 2)
    self.def:setLvlDataString('auu1', level, 0, value)
end

function AbilityDefinition:setTooltipLearn(value)
    checktype(value, 'string', 'setTooltipLearn', 1)
    self.def:setLvlDataString('aret', 0, 0, value)
end

function AbilityDefinition:setTooltipLearnExtended(value)
    checktype(value, 'string', 'setTooltipLearnExtended', 1)
    self.def:setLvlDataString('arut', 0, 0, value)
end

function AbilityDefinition:setHotkeyLearn(value)
    checktype(value, 'string', 'setHotkeyLearn', 1)
    self.def:setLvlDataString('arhk', 0, 0, value)
end

function AbilityDefinition:setHotkeyNormal(value)
    checktype(value, 'string', 'setHotkeyNormal', 1)
    self.def:setLvlDataString('ahky', 0, 0, value)
end

function AbilityDefinition:setHotkeyTurnOff(value)
    checktype(value, 'string', 'setHotkeyTurnOff', 1)
    self.def:setLvlDataString('auhk', 0, 0, value)
end

function AbilityDefinition:setRequirements(value)
    checktype(self.def, 'table', 'setRequirements', 0)
    checktype(value, 'string', 'setRequirements', 1)
    self.def:setLvlDataString('areq', 0, 0, value)
end

function AbilityDefinition:setRequirementsLevels(value)
    checktype(value, 'string', 'setRequirementsLevels', 1)
    self.def:setLvlDataString('arqa', 0, 0, value)
end

function AbilityDefinition:setCheckDependencies(value)
    checktype(value, 'boolean', 'setCheckDependencies', 1)
    self.def:setLvlDataBoolean('achd', 0, 0, value)
end

function AbilityDefinition:setPriorityforSpellSteal(value)
    checktype(value, 'integer', 'setPriorityforSpellSteal', 1)
    self.def:setLvlDataInt('apri', 0, 0, value)
end

function AbilityDefinition:setOrderStringUseTurnOn(value)
    checktype(value, 'string', 'setOrderStringUseTurnOn', 1)
    self.def:setLvlDataString('aord', 0, 0, value)
end

function AbilityDefinition:setOrderStringTurnOff(value)
    checktype(value, 'string', 'setOrderStringTurnOff', 1)
    self.def:setLvlDataString('aoru', 0, 0, value)
end

function AbilityDefinition:setOrderStringActivate(value)
    checktype(value, 'string', 'setOrderStringActivate', 1)
    self.def:setLvlDataString('aoro', 0, 0, value)
end

function AbilityDefinition:setOrderStringDeactivate(value)
    checktype(value, 'string', 'setOrderStringDeactivate', 1)
    self.def:setLvlDataString('aorf', 0, 0, value)
end

function AbilityDefinition:setEffectSound(value)
    checktype(value, 'string', 'setEffectSound', 1)
    self.def:setLvlDataString('aefs', 0, 0, value)
end

function AbilityDefinition:setEffectSoundLooping(value)
    checktype(value, 'string', 'setEffectSoundLooping', 1)
    self.def:setLvlDataString('aefl', 0, 0, value)
end

function AbilityDefinition:setLevels(value)
    checktype(value, 'integer', 'setLevels', 1)
    self.def:setLvlDataInt('alev', 0, 0, value)
end

function AbilityDefinition:setRequiredLevel(value)
    checktype(value, 'integer', 'setRequiredLevel', 1)
    self.def:setLvlDataInt('arlv', 0, 0, value)
end

function AbilityDefinition:setLevelSkipRequirement(value)
    checktype(value, 'integer', 'setLevelSkipRequirement', 1)
    self.def:setLvlDataInt('alsk', 0, 0, value)
end

function AbilityDefinition:setTargetsAllowed(level, value)
    checktype(level, 'integer', 'setTargetsAllowed', 1)
    checktype(value, 'string', 'setTargetsAllowed', 2)
    self.def:setLvlDataString('atar', level, 0, value)
end

function AbilityDefinition:setCastingTime(level, value)
    checktype(level, 'integer', 'setCastingTime', 1)
    checktype(value, 'float', 'setCastingTime', 2)
    self.def:setLvlDataUnreal('acas', level, 0, value)
end

function AbilityDefinition:setDurationNormal(level, value)
    checktype(level, 'integer', 'setDurationNormal', 1)
    checktype(value, 'float', 'setDurationNormal', 2)
    self.def:setLvlDataUnreal('adur', level, 0, value)
end

function AbilityDefinition:setDurationHero(level, value)
    checktype(level, 'integer', 'setDurationHero', 1)
    checktype(value, 'float', 'setDurationHero', 2)
    self.def:setLvlDataUnreal('ahdu', level, 0, value)
end

function AbilityDefinition:setCooldown(level, value)
    checktype(level, 'integer', 'setCooldown', 1)
    checktype(value, 'float', 'setCooldown', 2)
    self.def:setLvlDataUnreal('acdn', level, 0, value)
end

function AbilityDefinition:setManaCost(level, value)
    checktype(level, 'integer', 'setManaCost', 1)
    checktype(value, 'integer', 'setManaCost', 2)
    self.def:setLvlDataInt('amcs', level, 0, value)
end

function AbilityDefinition:setAreaofEffect(level, value)
    checktype(level, 'integer', 'setAreaofEffect', 1)
    checktype(value, 'float', 'setAreaofEffect', 2)
    self.def:setLvlDataUnreal('aare', level, 0, value)
end

function AbilityDefinition:setCastRange(level, value)
    checktype(level, 'integer', 'setCastRange', 1)
    checktype(value, 'float', 'setCastRange', 2)
    self.def:setLvlDataUnreal('aran', level, 0, value)
end

function AbilityDefinition:setBuffs(level, value)
    checktype(level, 'integer', 'setBuffs', 1)
    checktype(value, 'string', 'setBuffs', 2)
    self.def:setLvlDataString('abuf', level, 0, value)
end

function AbilityDefinition:setEffects(level, value)
    checktype(level, 'integer', 'setEffects', 1)
    checktype(value, 'string', 'setEffects', 2)
    self.def:setLvlDataString('aeff', level, 0, value)
end

AbilityDefinitionTaunt = class('AbilityDefinitionTaunt', AbilityDefinition)
_G.AbilityDefinitionTaunt = AbilityDefinitionTaunt

function AbilityDefinitionTaunt:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Atau')
end

function AbilityDefinitionTaunt:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'integer', 'setPreferFriendlies', 2)
    self.def:setLvlDataInt('Tau2', level, 2, value)
end

function AbilityDefinitionTaunt:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'integer', 'setPreferHostiles', 2)
    self.def:setLvlDataInt('Tau1', level, 1, value)
end

function AbilityDefinitionTaunt:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Tau3', level, 3, value)
end

AbilityDefinitionPoisonArrows = class('AbilityDefinitionPoisonArrows', AbilityDefinition)
_G.AbilityDefinitionPoisonArrows = AbilityDefinitionPoisonArrows

function AbilityDefinitionPoisonArrows:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEpa')
end

function AbilityDefinitionPoisonArrows:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poa3', level, 3, value)
end

function AbilityDefinitionPoisonArrows:setStackingType(level, value)
    checktype(level, 'integer', 'setStackingType', 1)
    checktype(value, 'integer', 'setStackingType', 2)
    self.def:setLvlDataInt('Poa5', level, 4, value)
end

function AbilityDefinitionPoisonArrows:setExtraDamage(level, value)
    checktype(level, 'integer', 'setExtraDamage', 1)
    checktype(value, 'float', 'setExtraDamage', 2)
    self.def:setLvlDataUnreal('Poa1', level, 1, value)
end

function AbilityDefinitionPoisonArrows:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poa4', level, 4, value)
end

function AbilityDefinitionPoisonArrows:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Poa2', level, 2, value)
end

AbilityDefinitionRangerColdArrows = class('AbilityDefinitionRangerColdArrows', AbilityDefinition)
_G.AbilityDefinitionRangerColdArrows = AbilityDefinitionRangerColdArrows

function AbilityDefinitionRangerColdArrows:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHca')
end

function AbilityDefinitionRangerColdArrows:setStackFlags(level, value)
    checktype(level, 'integer', 'setStackFlags', 1)
    checktype(value, 'integer', 'setStackFlags', 2)
    self.def:setLvlDataInt('Hca4', level, 4, value)
end

function AbilityDefinitionRangerColdArrows:setExtraDamage(level, value)
    checktype(level, 'integer', 'setExtraDamage', 1)
    checktype(value, 'float', 'setExtraDamage', 2)
    self.def:setLvlDataUnreal('Hca1', level, 1, value)
end

function AbilityDefinitionRangerColdArrows:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Hca3', level, 3, value)
end

function AbilityDefinitionRangerColdArrows:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Hca2', level, 2, value)
end

AbilityDefinitionSeaWitchTornado = class('AbilityDefinitionSeaWitchTornado', AbilityDefinition)
_G.AbilityDefinitionSeaWitchTornado = AbilityDefinitionSeaWitchTornado

function AbilityDefinitionSeaWitchTornado:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANto')
end

function AbilityDefinitionSeaWitchTornado:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Ntou', level, 0, value)
end

AbilityDefinitionAgilityBonusPlus4 = class('AbilityDefinitionAgilityBonusPlus4', AbilityDefinition)
_G.AbilityDefinitionAgilityBonusPlus4 = AbilityDefinitionAgilityBonusPlus4

function AbilityDefinitionAgilityBonusPlus4:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIa4')
end

function AbilityDefinitionAgilityBonusPlus4:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAgilityBonusPlus4:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAgilityBonusPlus4:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAgilityBonusPlus4:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionAlchemistTransmute = class('AbilityDefinitionAlchemistTransmute', AbilityDefinition)
_G.AbilityDefinitionAlchemistTransmute = AbilityDefinitionAlchemistTransmute

function AbilityDefinitionAlchemistTransmute:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANtm')
end

function AbilityDefinitionAlchemistTransmute:setLumberCostFactor(level, value)
    checktype(level, 'integer', 'setLumberCostFactor', 1)
    checktype(value, 'float', 'setLumberCostFactor', 2)
    self.def:setLvlDataUnreal('Ntm2', level, 2, value)
end

function AbilityDefinitionAlchemistTransmute:setAllowBounty(level, value)
    checktype(level, 'integer', 'setAllowBounty', 1)
    checktype(value, 'boolean', 'setAllowBounty', 2)
    self.def:setLvlDataBoolean('Ntm4', level, 4, value)
end

function AbilityDefinitionAlchemistTransmute:setMaxCreepLevel(level, value)
    checktype(level, 'integer', 'setMaxCreepLevel', 1)
    checktype(value, 'integer', 'setMaxCreepLevel', 2)
    self.def:setLvlDataInt('Ntm3', level, 3, value)
end

function AbilityDefinitionAlchemistTransmute:setGoldCostFactor(level, value)
    checktype(level, 'integer', 'setGoldCostFactor', 1)
    checktype(value, 'float', 'setGoldCostFactor', 2)
    self.def:setLvlDataUnreal('Ntm1', level, 1, value)
end

AbilityDefinitionAgilityBonusPlus3 = class('AbilityDefinitionAgilityBonusPlus3', AbilityDefinition)
_G.AbilityDefinitionAgilityBonusPlus3 = AbilityDefinitionAgilityBonusPlus3

function AbilityDefinitionAgilityBonusPlus3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIa3')
end

function AbilityDefinitionAgilityBonusPlus3:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAgilityBonusPlus3:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAgilityBonusPlus3:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAgilityBonusPlus3:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionAgilityBonusPlus1 = class('AbilityDefinitionAgilityBonusPlus1', AbilityDefinition)
_G.AbilityDefinitionAgilityBonusPlus1 = AbilityDefinitionAgilityBonusPlus1

function AbilityDefinitionAgilityBonusPlus1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIa1')
end

function AbilityDefinitionAgilityBonusPlus1:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAgilityBonusPlus1:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAgilityBonusPlus1:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAgilityBonusPlus1:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionThornyShieldCreep = class('AbilityDefinitionThornyShieldCreep', AbilityDefinition)
_G.AbilityDefinitionThornyShieldCreep = AbilityDefinitionThornyShieldCreep

function AbilityDefinitionThornyShieldCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANth')
end

function AbilityDefinitionThornyShieldCreep:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'float', 'setDefenseBonus', 2)
    self.def:setLvlDataUnreal('Uts3', level, 3, value)
end

function AbilityDefinitionThornyShieldCreep:setReceivedDamageFactor(level, value)
    checktype(level, 'integer', 'setReceivedDamageFactor', 1)
    checktype(value, 'float', 'setReceivedDamageFactor', 2)
    self.def:setLvlDataUnreal('Uts2', level, 2, value)
end

function AbilityDefinitionThornyShieldCreep:setReturnedDamageFactor(level, value)
    checktype(level, 'integer', 'setReturnedDamageFactor', 1)
    checktype(value, 'float', 'setReturnedDamageFactor', 2)
    self.def:setLvlDataUnreal('Uts1', level, 1, value)
end

AbilityDefinitionAgilityBonusPlus6 = class('AbilityDefinitionAgilityBonusPlus6', AbilityDefinition)
_G.AbilityDefinitionAgilityBonusPlus6 = AbilityDefinitionAgilityBonusPlus6

function AbilityDefinitionAgilityBonusPlus6:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIa6')
end

function AbilityDefinitionAgilityBonusPlus6:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAgilityBonusPlus6:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAgilityBonusPlus6:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAgilityBonusPlus6:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionBloodMageSiphonMana = class('AbilityDefinitionBloodMageSiphonMana', AbilityDefinition)
_G.AbilityDefinitionBloodMageSiphonMana = AbilityDefinitionBloodMageSiphonMana

function AbilityDefinitionBloodMageSiphonMana:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHdr')
end

function AbilityDefinitionBloodMageSiphonMana:setBonusLifeDecay(level, value)
    checktype(level, 'integer', 'setBonusLifeDecay', 1)
    checktype(value, 'float', 'setBonusLifeDecay', 2)
    self.def:setLvlDataUnreal('Ndr7', level, 7, value)
end

function AbilityDefinitionBloodMageSiphonMana:setDrainIntervalseconds(level, value)
    checktype(level, 'integer', 'setDrainIntervalseconds', 1)
    checktype(value, 'float', 'setDrainIntervalseconds', 2)
    self.def:setLvlDataUnreal('Ndr3', level, 3, value)
end

function AbilityDefinitionBloodMageSiphonMana:setHitPointsDrained(level, value)
    checktype(level, 'integer', 'setHitPointsDrained', 1)
    checktype(value, 'float', 'setHitPointsDrained', 2)
    self.def:setLvlDataUnreal('Ndr1', level, 1, value)
end

function AbilityDefinitionBloodMageSiphonMana:setBonusLifeFactor(level, value)
    checktype(level, 'integer', 'setBonusLifeFactor', 1)
    checktype(value, 'float', 'setBonusLifeFactor', 2)
    self.def:setLvlDataUnreal('Ndr6', level, 6, value)
end

function AbilityDefinitionBloodMageSiphonMana:setManaPointsDrained(level, value)
    checktype(level, 'integer', 'setManaPointsDrained', 1)
    checktype(value, 'float', 'setManaPointsDrained', 2)
    self.def:setLvlDataUnreal('Ndr2', level, 2, value)
end

function AbilityDefinitionBloodMageSiphonMana:setManaTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setManaTransferredPerSecond', 1)
    checktype(value, 'float', 'setManaTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr5', level, 5, value)
end

function AbilityDefinitionBloodMageSiphonMana:setBonusManaDecay(level, value)
    checktype(level, 'integer', 'setBonusManaDecay', 1)
    checktype(value, 'float', 'setBonusManaDecay', 2)
    self.def:setLvlDataUnreal('Ndr9', level, 9, value)
end

function AbilityDefinitionBloodMageSiphonMana:setBonusManaFactor(level, value)
    checktype(level, 'integer', 'setBonusManaFactor', 1)
    checktype(value, 'float', 'setBonusManaFactor', 2)
    self.def:setLvlDataUnreal('Ndr8', level, 8, value)
end

function AbilityDefinitionBloodMageSiphonMana:setLifeTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setLifeTransferredPerSecond', 1)
    checktype(value, 'float', 'setLifeTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr4', level, 4, value)
end

AbilityDefinitionPossessioncreep = class('AbilityDefinitionPossessioncreep', AbilityDefinition)
_G.AbilityDefinitionPossessioncreep = AbilityDefinitionPossessioncreep

function AbilityDefinitionPossessioncreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACps')
end

function AbilityDefinitionPossessioncreep:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Pos1', level, 1, value)
end

AbilityDefinitionPaladinDivineShield = class('AbilityDefinitionPaladinDivineShield', AbilityDefinition)
_G.AbilityDefinitionPaladinDivineShield = AbilityDefinitionPaladinDivineShield

function AbilityDefinitionPaladinDivineShield:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHds')
end

function AbilityDefinitionPaladinDivineShield:setCanDeactivate(level, value)
    checktype(level, 'integer', 'setCanDeactivate', 1)
    checktype(value, 'boolean', 'setCanDeactivate', 2)
    self.def:setLvlDataBoolean('Hds1', level, 1, value)
end

AbilityDefinitionPurgeCreep = class('AbilityDefinitionPurgeCreep', AbilityDefinition)
_G.AbilityDefinitionPurgeCreep = AbilityDefinitionPurgeCreep

function AbilityDefinitionPurgeCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACpu')
end

function AbilityDefinitionPurgeCreep:setHeroPauseDuration(level, value)
    checktype(level, 'integer', 'setHeroPauseDuration', 1)
    checktype(value, 'float', 'setHeroPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg5', level, 5, value)
end

function AbilityDefinitionPurgeCreep:setUnitPauseDuration(level, value)
    checktype(level, 'integer', 'setUnitPauseDuration', 1)
    checktype(value, 'float', 'setUnitPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg4', level, 4, value)
end

function AbilityDefinitionPurgeCreep:setMovementUpdateFrequency(level, value)
    checktype(level, 'integer', 'setMovementUpdateFrequency', 1)
    checktype(value, 'integer', 'setMovementUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg1', level, 1, value)
end

function AbilityDefinitionPurgeCreep:setAttackUpdateFrequency(level, value)
    checktype(level, 'integer', 'setAttackUpdateFrequency', 1)
    checktype(value, 'integer', 'setAttackUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg2', level, 2, value)
end

function AbilityDefinitionPurgeCreep:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Prg6', level, 6, value)
end

function AbilityDefinitionPurgeCreep:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Prg3', level, 3, value)
end

AbilityDefinitionRoarcreepSkeletalOrc = class('AbilityDefinitionRoarcreepSkeletalOrc', AbilityDefinition)
_G.AbilityDefinitionRoarcreepSkeletalOrc = AbilityDefinitionRoarcreepSkeletalOrc

function AbilityDefinitionRoarcreepSkeletalOrc:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACr1')
end

function AbilityDefinitionRoarcreepSkeletalOrc:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Roa1', level, 1, value)
end

function AbilityDefinitionRoarcreepSkeletalOrc:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Roa2', level, 2, value)
end

function AbilityDefinitionRoarcreepSkeletalOrc:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionRoarcreepSkeletalOrc:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

function AbilityDefinitionRoarcreepSkeletalOrc:setLifeRegenerationRate(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRate', 1)
    checktype(value, 'float', 'setLifeRegenerationRate', 2)
    self.def:setLvlDataUnreal('Roa3', level, 3, value)
end

function AbilityDefinitionRoarcreepSkeletalOrc:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionRoarcreepSkeletalOrc:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

AbilityDefinitionTauntCreep = class('AbilityDefinitionTauntCreep', AbilityDefinition)
_G.AbilityDefinitionTauntCreep = AbilityDefinitionTauntCreep

function AbilityDefinitionTauntCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANta')
end

function AbilityDefinitionTauntCreep:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'integer', 'setPreferFriendlies', 2)
    self.def:setLvlDataInt('Tau2', level, 2, value)
end

function AbilityDefinitionTauntCreep:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'integer', 'setPreferHostiles', 2)
    self.def:setLvlDataInt('Tau1', level, 1, value)
end

function AbilityDefinitionTauntCreep:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Tau3', level, 3, value)
end

AbilityDefinitionRejuvinationFurbolg = class('AbilityDefinitionRejuvinationFurbolg', AbilityDefinition)
_G.AbilityDefinitionRejuvinationFurbolg = AbilityDefinitionRejuvinationFurbolg

function AbilityDefinitionRejuvinationFurbolg:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACr2')
end

function AbilityDefinitionRejuvinationFurbolg:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'float', 'setManaPointsGained', 2)
    self.def:setLvlDataUnreal('Rej2', level, 2, value)
end

function AbilityDefinitionRejuvinationFurbolg:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('Rej4', level, 4, value)
end

function AbilityDefinitionRejuvinationFurbolg:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Rej1', level, 1, value)
end

function AbilityDefinitionRejuvinationFurbolg:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('Rej3', level, 3, value)
end

AbilityDefinitionPulverizecreep = class('AbilityDefinitionPulverizecreep', AbilityDefinition)
_G.AbilityDefinitionPulverizecreep = AbilityDefinitionPulverizecreep

function AbilityDefinitionPulverizecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACpv')
end

function AbilityDefinitionPulverizecreep:setHalfDamageRadius(level, value)
    checktype(level, 'integer', 'setHalfDamageRadius', 1)
    checktype(value, 'float', 'setHalfDamageRadius', 2)
    self.def:setLvlDataUnreal('War4', level, 4, value)
end

function AbilityDefinitionPulverizecreep:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('War2', level, 2, value)
end

function AbilityDefinitionPulverizecreep:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('War3', level, 3, value)
end

function AbilityDefinitionPulverizecreep:setChancetoStomp(level, value)
    checktype(level, 'integer', 'setChancetoStomp', 1)
    checktype(value, 'float', 'setChancetoStomp', 2)
    self.def:setLvlDataUnreal('War1', level, 1, value)
end

AbilityDefinitionBeastMasterSummonHawk = class('AbilityDefinitionBeastMasterSummonHawk', AbilityDefinition)
_G.AbilityDefinitionBeastMasterSummonHawk = AbilityDefinitionBeastMasterSummonHawk

function AbilityDefinitionBeastMasterSummonHawk:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANsw')
end

function AbilityDefinitionBeastMasterSummonHawk:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionBeastMasterSummonHawk:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionTinkererSummonFactoryLevel0 = class('AbilityDefinitionTinkererSummonFactoryLevel0', AbilityDefinition)
_G.AbilityDefinitionTinkererSummonFactoryLevel0 = AbilityDefinitionTinkererSummonFactoryLevel0

function AbilityDefinitionTinkererSummonFactoryLevel0:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANsy')
end

function AbilityDefinitionTinkererSummonFactoryLevel0:setSpawnInterval(level, value)
    checktype(level, 'integer', 'setSpawnInterval', 1)
    checktype(value, 'float', 'setSpawnInterval', 2)
    self.def:setLvlDataUnreal('Nsy1', level, 1, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel0:setLeashRange(level, value)
    checktype(level, 'integer', 'setLeashRange', 1)
    checktype(value, 'float', 'setLeashRange', 2)
    self.def:setLvlDataUnreal('Nsy5', level, 5, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel0:setSpawnUnitID(level, value)
    checktype(level, 'integer', 'setSpawnUnitID', 1)
    checktype(value, 'string', 'setSpawnUnitID', 2)
    self.def:setLvlDataString('Nsy2', level, 2, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel0:setFactoryUnitID(level, value)
    checktype(level, 'integer', 'setFactoryUnitID', 1)
    checktype(value, 'string', 'setFactoryUnitID', 2)
    self.def:setLvlDataString('Nsyu', level, 0, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel0:setSpawnUnitOffset(level, value)
    checktype(level, 'integer', 'setSpawnUnitOffset', 1)
    checktype(value, 'float', 'setSpawnUnitOffset', 2)
    self.def:setLvlDataUnreal('Nsy4', level, 4, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel0:setSpawnUnitDuration(level, value)
    checktype(level, 'integer', 'setSpawnUnitDuration', 1)
    checktype(value, 'float', 'setSpawnUnitDuration', 2)
    self.def:setLvlDataUnreal('Nsy3', level, 3, value)
end

AbilityDefinitionPolymorphcreep = class('AbilityDefinitionPolymorphcreep', AbilityDefinition)
_G.AbilityDefinitionPolymorphcreep = AbilityDefinitionPolymorphcreep

function AbilityDefinitionPolymorphcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACpy')
end

function AbilityDefinitionPolymorphcreep:setMorphUnitsGround(level, value)
    checktype(level, 'integer', 'setMorphUnitsGround', 1)
    checktype(value, 'string', 'setMorphUnitsGround', 2)
    self.def:setLvlDataString('Ply2', level, 2, value)
end

function AbilityDefinitionPolymorphcreep:setMorphUnitsWater(level, value)
    checktype(level, 'integer', 'setMorphUnitsWater', 1)
    checktype(value, 'string', 'setMorphUnitsWater', 2)
    self.def:setLvlDataString('Ply5', level, 5, value)
end

function AbilityDefinitionPolymorphcreep:setMorphUnitsAmphibious(level, value)
    checktype(level, 'integer', 'setMorphUnitsAmphibious', 1)
    checktype(value, 'string', 'setMorphUnitsAmphibious', 2)
    self.def:setLvlDataString('Ply4', level, 4, value)
end

function AbilityDefinitionPolymorphcreep:setMorphUnitsAir(level, value)
    checktype(level, 'integer', 'setMorphUnitsAir', 1)
    checktype(value, 'string', 'setMorphUnitsAir', 2)
    self.def:setLvlDataString('Ply3', level, 3, value)
end

function AbilityDefinitionPolymorphcreep:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Ply1', level, 1, value)
end

AbilityDefinitionBeastMasterStampede = class('AbilityDefinitionBeastMasterStampede', AbilityDefinition)
_G.AbilityDefinitionBeastMasterStampede = AbilityDefinitionBeastMasterStampede

function AbilityDefinitionBeastMasterStampede:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANst')
end

function AbilityDefinitionBeastMasterStampede:setBeastsPerSecond(level, value)
    checktype(level, 'integer', 'setBeastsPerSecond', 1)
    checktype(value, 'integer', 'setBeastsPerSecond', 2)
    self.def:setLvlDataInt('Nst1', level, 1, value)
end

function AbilityDefinitionBeastMasterStampede:setDamageDelay(level, value)
    checktype(level, 'integer', 'setDamageDelay', 1)
    checktype(value, 'float', 'setDamageDelay', 2)
    self.def:setLvlDataUnreal('Nst5', level, 5, value)
end

function AbilityDefinitionBeastMasterStampede:setDamageRadius(level, value)
    checktype(level, 'integer', 'setDamageRadius', 1)
    checktype(value, 'float', 'setDamageRadius', 2)
    self.def:setLvlDataUnreal('Nst4', level, 4, value)
end

function AbilityDefinitionBeastMasterStampede:setBeastCollisionRadius(level, value)
    checktype(level, 'integer', 'setBeastCollisionRadius', 1)
    checktype(value, 'float', 'setBeastCollisionRadius', 2)
    self.def:setLvlDataUnreal('Nst2', level, 2, value)
end

function AbilityDefinitionBeastMasterStampede:setDamageAmount(level, value)
    checktype(level, 'integer', 'setDamageAmount', 1)
    checktype(value, 'float', 'setDamageAmount', 2)
    self.def:setLvlDataUnreal('Nst3', level, 3, value)
end

AbilityDefinitionFirelordSoulBurn = class('AbilityDefinitionFirelordSoulBurn', AbilityDefinition)
_G.AbilityDefinitionFirelordSoulBurn = AbilityDefinitionFirelordSoulBurn

function AbilityDefinitionFirelordSoulBurn:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANso')
end

function AbilityDefinitionFirelordSoulBurn:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Nso5', level, 5, value)
end

function AbilityDefinitionFirelordSoulBurn:setDamageAmount(level, value)
    checktype(level, 'integer', 'setDamageAmount', 1)
    checktype(value, 'float', 'setDamageAmount', 2)
    self.def:setLvlDataUnreal('Nso1', level, 1, value)
end

function AbilityDefinitionFirelordSoulBurn:setDamagePeriod(level, value)
    checktype(level, 'integer', 'setDamagePeriod', 1)
    checktype(value, 'float', 'setDamagePeriod', 2)
    self.def:setLvlDataUnreal('Nso2', level, 2, value)
end

function AbilityDefinitionFirelordSoulBurn:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Nso4', level, 4, value)
end

function AbilityDefinitionFirelordSoulBurn:setDamagePenalty(level, value)
    checktype(level, 'integer', 'setDamagePenalty', 1)
    checktype(value, 'float', 'setDamagePenalty', 2)
    self.def:setLvlDataUnreal('Nso3', level, 3, value)
end

AbilityDefinitionBeastMasterSummonQuilbeast = class('AbilityDefinitionBeastMasterSummonQuilbeast', AbilityDefinition)
_G.AbilityDefinitionBeastMasterSummonQuilbeast = AbilityDefinitionBeastMasterSummonQuilbeast

function AbilityDefinitionBeastMasterSummonQuilbeast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANsq')
end

function AbilityDefinitionBeastMasterSummonQuilbeast:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionBeastMasterSummonQuilbeast:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionFrenzy = class('AbilityDefinitionFrenzy', AbilityDefinition)
_G.AbilityDefinitionFrenzy = AbilityDefinitionFrenzy

function AbilityDefinitionFrenzy:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afzy')
end

function AbilityDefinitionFrenzy:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Blo2', level, 2, value)
end

function AbilityDefinitionFrenzy:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Blo1', level, 1, value)
end

function AbilityDefinitionFrenzy:setScalingFactor(level, value)
    checktype(level, 'integer', 'setScalingFactor', 1)
    checktype(value, 'float', 'setScalingFactor', 2)
    self.def:setLvlDataUnreal('Blo3', level, 3, value)
end

AbilityDefinitionMalganisSoulPreservation = class('AbilityDefinitionMalganisSoulPreservation', AbilityDefinition)
_G.AbilityDefinitionMalganisSoulPreservation = AbilityDefinitionMalganisSoulPreservation

function AbilityDefinitionMalganisSoulPreservation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANsl')
end

function AbilityDefinitionMalganisSoulPreservation:setUnittoPreserve(level, value)
    checktype(level, 'integer', 'setUnittoPreserve', 1)
    checktype(value, 'string', 'setUnittoPreserve', 2)
    self.def:setLvlDataString('Nsl1', level, 0, value)
end

AbilityDefinitionBeastMasterSummonBear = class('AbilityDefinitionBeastMasterSummonBear', AbilityDefinition)
_G.AbilityDefinitionBeastMasterSummonBear = AbilityDefinitionBeastMasterSummonBear

function AbilityDefinitionBeastMasterSummonBear:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANsg')
end

function AbilityDefinitionBeastMasterSummonBear:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionBeastMasterSummonBear:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionDarkRangerSilence = class('AbilityDefinitionDarkRangerSilence', AbilityDefinition)
_G.AbilityDefinitionDarkRangerSilence = AbilityDefinitionDarkRangerSilence

function AbilityDefinitionDarkRangerSilence:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANsi')
end

function AbilityDefinitionDarkRangerSilence:setAttackSpeedModifier(level, value)
    checktype(level, 'integer', 'setAttackSpeedModifier', 1)
    checktype(value, 'float', 'setAttackSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi4', level, 4, value)
end

function AbilityDefinitionDarkRangerSilence:setMovementSpeedModifier(level, value)
    checktype(level, 'integer', 'setMovementSpeedModifier', 1)
    checktype(value, 'float', 'setMovementSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi3', level, 3, value)
end

function AbilityDefinitionDarkRangerSilence:setChanceToMiss(level, value)
    checktype(level, 'integer', 'setChanceToMiss', 1)
    checktype(value, 'float', 'setChanceToMiss', 2)
    self.def:setLvlDataUnreal('Nsi2', level, 2, value)
end

function AbilityDefinitionDarkRangerSilence:setAttacksPrevented(level, value)
    checktype(level, 'integer', 'setAttacksPrevented', 1)
    checktype(value, 'integer', 'setAttacksPrevented', 2)
    self.def:setLvlDataInt('Nsi1', level, 1, value)
end

AbilityDefinitionSanctuary = class('AbilityDefinitionSanctuary', AbilityDefinition)
_G.AbilityDefinitionSanctuary = AbilityDefinitionSanctuary

function AbilityDefinitionSanctuary:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANsa')
end

function AbilityDefinitionSanctuary:setHitPointsPerSecond(level, value)
    checktype(level, 'integer', 'setHitPointsPerSecond', 1)
    checktype(value, 'float', 'setHitPointsPerSecond', 2)
    self.def:setLvlDataUnreal('Nsa5', level, 5, value)
end

function AbilityDefinitionSanctuary:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Nsa4', level, 4, value)
end

function AbilityDefinitionSanctuary:setBuildingTypesAllowed(level, value)
    checktype(level, 'integer', 'setBuildingTypesAllowed', 1)
    checktype(value, 'string', 'setBuildingTypesAllowed', 2)
    self.def:setLvlDataString('Nsa1', level, 1, value)
end

function AbilityDefinitionSanctuary:setHeroRegenerationDelay(level, value)
    checktype(level, 'integer', 'setHeroRegenerationDelay', 1)
    checktype(value, 'float', 'setHeroRegenerationDelay', 2)
    self.def:setLvlDataUnreal('Nsa2', level, 2, value)
end

function AbilityDefinitionSanctuary:setUnitRegenerationDelay(level, value)
    checktype(level, 'integer', 'setUnitRegenerationDelay', 1)
    checktype(value, 'float', 'setUnitRegenerationDelay', 2)
    self.def:setLvlDataUnreal('Nsa3', level, 3, value)
end

AbilityDefinitionShadowMeldInstant = class('AbilityDefinitionShadowMeldInstant', AbilityDefinition)
_G.AbilityDefinitionShadowMeldInstant = AbilityDefinitionShadowMeldInstant

function AbilityDefinitionShadowMeldInstant:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sshm')
end

function AbilityDefinitionShadowMeldInstant:setDayNightDuration(level, value)
    checktype(level, 'integer', 'setDayNightDuration', 1)
    checktype(value, 'float', 'setDayNightDuration', 2)
    self.def:setLvlDataUnreal('Shm2', level, 2, value)
end

function AbilityDefinitionShadowMeldInstant:setActionDuration(level, value)
    checktype(level, 'integer', 'setActionDuration', 1)
    checktype(value, 'float', 'setActionDuration', 2)
    self.def:setLvlDataUnreal('Shm3', level, 3, value)
end

function AbilityDefinitionShadowMeldInstant:setFadeDuration(level, value)
    checktype(level, 'integer', 'setFadeDuration', 1)
    checktype(value, 'float', 'setFadeDuration', 2)
    self.def:setLvlDataUnreal('Shm1', level, 1, value)
end

AbilityDefinitionSpellShieldAOE = class('AbilityDefinitionSpellShieldAOE', AbilityDefinition)
_G.AbilityDefinitionSpellShieldAOE = AbilityDefinitionSpellShieldAOE

function AbilityDefinitionSpellShieldAOE:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANse')
end

function AbilityDefinitionSpellShieldAOE:setShieldCooldownTime(level, value)
    checktype(level, 'integer', 'setShieldCooldownTime', 1)
    checktype(value, 'float', 'setShieldCooldownTime', 2)
    self.def:setLvlDataUnreal('Nse1', level, 1, value)
end

AbilityDefinitionItemAuraEndurance = class('AbilityDefinitionItemAuraEndurance', AbilityDefinition)
_G.AbilityDefinitionItemAuraEndurance = AbilityDefinitionItemAuraEndurance

function AbilityDefinitionItemAuraEndurance:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIae')
end

function AbilityDefinitionItemAuraEndurance:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Oae1', level, 1, value)
end

function AbilityDefinitionItemAuraEndurance:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Oae2', level, 2, value)
end

AbilityDefinitionSpiritPigcreep = class('AbilityDefinitionSpiritPigcreep', AbilityDefinition)
_G.AbilityDefinitionSpiritPigcreep = AbilityDefinitionSpiritPigcreep

function AbilityDefinitionSpiritPigcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACs9')
end

function AbilityDefinitionSpiritPigcreep:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Osf1', level, 0, value)
end

function AbilityDefinitionSpiritPigcreep:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Osf2', level, 2, value)
end

AbilityDefinitionUnstableConcoction = class('AbilityDefinitionUnstableConcoction', AbilityDefinition)
_G.AbilityDefinitionUnstableConcoction = AbilityDefinitionUnstableConcoction

function AbilityDefinitionUnstableConcoction:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Auco')
end

function AbilityDefinitionUnstableConcoction:setPartialDamageAmount(level, value)
    checktype(level, 'integer', 'setPartialDamageAmount', 1)
    checktype(value, 'float', 'setPartialDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda4', level, 4, value)
end

function AbilityDefinitionUnstableConcoction:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda1', level, 1, value)
end

function AbilityDefinitionUnstableConcoction:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda2', level, 2, value)
end

function AbilityDefinitionUnstableConcoction:setMoveSpeedBonus(level, value)
    checktype(level, 'integer', 'setMoveSpeedBonus', 1)
    checktype(value, 'float', 'setMoveSpeedBonus', 2)
    self.def:setLvlDataUnreal('Uco6', level, 6, value)
end

function AbilityDefinitionUnstableConcoction:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Uco5', level, 5, value)
end

function AbilityDefinitionUnstableConcoction:setPartialDamageRadius(level, value)
    checktype(level, 'integer', 'setPartialDamageRadius', 1)
    checktype(value, 'float', 'setPartialDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda3', level, 3, value)
end

AbilityDefinitionItemAuraDevotion = class('AbilityDefinitionItemAuraDevotion', AbilityDefinition)
_G.AbilityDefinitionItemAuraDevotion = AbilityDefinitionItemAuraDevotion

function AbilityDefinitionItemAuraDevotion:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIad')
end

function AbilityDefinitionItemAuraDevotion:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Had2', level, 2, value)
end

function AbilityDefinitionItemAuraDevotion:setArmorBonus(level, value)
    checktype(level, 'integer', 'setArmorBonus', 1)
    checktype(value, 'float', 'setArmorBonus', 2)
    self.def:setLvlDataUnreal('Had1', level, 1, value)
end

AbilityDefinitionAttackMod = class('AbilityDefinitionAttackMod', AbilityDefinition)
_G.AbilityDefinitionAttackMod = AbilityDefinitionAttackMod

function AbilityDefinitionAttackMod:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIaa')
end

function AbilityDefinitionAttackMod:setAttackModification(level, value)
    checktype(level, 'integer', 'setAttackModification', 1)
    checktype(value, 'integer', 'setAttackModification', 2)
    self.def:setLvlDataInt('Iaa1', level, 1, value)
end

AbilityDefinitionMountainKingAvatar = class('AbilityDefinitionMountainKingAvatar', AbilityDefinition)
_G.AbilityDefinitionMountainKingAvatar = AbilityDefinitionMountainKingAvatar

function AbilityDefinitionMountainKingAvatar:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHav')
end

function AbilityDefinitionMountainKingAvatar:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Hav4', level, 4, value)
end

function AbilityDefinitionMountainKingAvatar:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'float', 'setDefenseBonus', 2)
    self.def:setLvlDataUnreal('Hav1', level, 1, value)
end

function AbilityDefinitionMountainKingAvatar:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Hav3', level, 3, value)
end

function AbilityDefinitionMountainKingAvatar:setHitPointBonus(level, value)
    checktype(level, 'integer', 'setHitPointBonus', 1)
    checktype(value, 'float', 'setHitPointBonus', 2)
    self.def:setLvlDataUnreal('Hav2', level, 2, value)
end

AbilityDefinitionAIab = class('AbilityDefinitionAIab', AbilityDefinition)
_G.AbilityDefinitionAIab = AbilityDefinitionAIab

function AbilityDefinitionAIab:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIab')
end

function AbilityDefinitionAIab:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAIab:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAIab:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAIab:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionMannorothReincarnation = class('AbilityDefinitionMannorothReincarnation', AbilityDefinition)
_G.AbilityDefinitionMannorothReincarnation = AbilityDefinitionMannorothReincarnation

function AbilityDefinitionMannorothReincarnation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANrn')
end

function AbilityDefinitionMannorothReincarnation:setReincarnationDelay(level, value)
    checktype(level, 'integer', 'setReincarnationDelay', 1)
    checktype(value, 'float', 'setReincarnationDelay', 2)
    self.def:setLvlDataUnreal('Ore1', level, 1, value)
end

AbilityDefinitionAnimateDead = class('AbilityDefinitionAnimateDead', AbilityDefinition)
_G.AbilityDefinitionAnimateDead = AbilityDefinitionAnimateDead

function AbilityDefinitionAnimateDead:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIan')
end

function AbilityDefinitionAnimateDead:setRaisedUnitsAreInvulnerable(level, value)
    checktype(level, 'integer', 'setRaisedUnitsAreInvulnerable', 1)
    checktype(value, 'boolean', 'setRaisedUnitsAreInvulnerable', 2)
    self.def:setLvlDataBoolean('Hre2', level, 2, value)
end

function AbilityDefinitionAnimateDead:setNumberofCorpsesRaised(level, value)
    checktype(level, 'integer', 'setNumberofCorpsesRaised', 1)
    checktype(value, 'integer', 'setNumberofCorpsesRaised', 2)
    self.def:setLvlDataInt('Cad1', level, 1, value)
end

function AbilityDefinitionAnimateDead:setInheritUpgrades(level, value)
    checktype(level, 'integer', 'setInheritUpgrades', 1)
    checktype(value, 'boolean', 'setInheritUpgrades', 2)
    self.def:setLvlDataBoolean('Uan3', level, 3, value)
end

AbilityDefinitionAgilityMod = class('AbilityDefinitionAgilityMod', AbilityDefinition)
_G.AbilityDefinitionAgilityMod = AbilityDefinitionAgilityMod

function AbilityDefinitionAgilityMod:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIam')
end

function AbilityDefinitionAgilityMod:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAgilityMod:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAgilityMod:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAgilityMod:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionRainofFirecreep = class('AbilityDefinitionRainofFirecreep', AbilityDefinition)
_G.AbilityDefinitionRainofFirecreep = AbilityDefinitionRainofFirecreep

function AbilityDefinitionRainofFirecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACrf')
end

function AbilityDefinitionRainofFirecreep:setMaximumDamageperWave(level, value)
    checktype(level, 'integer', 'setMaximumDamageperWave', 1)
    checktype(value, 'float', 'setMaximumDamageperWave', 2)
    self.def:setLvlDataUnreal('Hbz6', level, 6, value)
end

function AbilityDefinitionRainofFirecreep:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Hbz5', level, 5, value)
end

function AbilityDefinitionRainofFirecreep:setNumberofWaves(level, value)
    checktype(level, 'integer', 'setNumberofWaves', 1)
    checktype(value, 'integer', 'setNumberofWaves', 2)
    self.def:setLvlDataInt('Hbz1', level, 1, value)
end

function AbilityDefinitionRainofFirecreep:setNumberofShards(level, value)
    checktype(level, 'integer', 'setNumberofShards', 1)
    checktype(value, 'integer', 'setNumberofShards', 2)
    self.def:setLvlDataInt('Hbz3', level, 3, value)
end

function AbilityDefinitionRainofFirecreep:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Hbz4', level, 4, value)
end

function AbilityDefinitionRainofFirecreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Hbz2', level, 2, value)
end

AbilityDefinitionDreadlordSleep = class('AbilityDefinitionDreadlordSleep', AbilityDefinition)
_G.AbilityDefinitionDreadlordSleep = AbilityDefinitionDreadlordSleep

function AbilityDefinitionDreadlordSleep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUsl')
end

function AbilityDefinitionDreadlordSleep:setStunDuration(level, value)
    checktype(level, 'integer', 'setStunDuration', 1)
    checktype(value, 'float', 'setStunDuration', 2)
    self.def:setLvlDataUnreal('Usl1', level, 1, value)
end

AbilityDefinitionRaiseDeadCreep = class('AbilityDefinitionRaiseDeadCreep', AbilityDefinition)
_G.AbilityDefinitionRaiseDeadCreep = AbilityDefinitionRaiseDeadCreep

function AbilityDefinitionRaiseDeadCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACrd')
end

function AbilityDefinitionRaiseDeadCreep:setUnitsSummonedTypeOne(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeOne', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeOne', 2)
    self.def:setLvlDataInt('Rai1', level, 1, value)
end

function AbilityDefinitionRaiseDeadCreep:setUnitTypeForLimitCheck(level, value)
    checktype(level, 'integer', 'setUnitTypeForLimitCheck', 1)
    checktype(value, 'string', 'setUnitTypeForLimitCheck', 2)
    self.def:setLvlDataString('Raiu', level, 0, value)
end

function AbilityDefinitionRaiseDeadCreep:setUnitsSummonedTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeTwo', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeTwo', 2)
    self.def:setLvlDataInt('Rai2', level, 2, value)
end

function AbilityDefinitionRaiseDeadCreep:setUnitTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitTypeTwo', 1)
    checktype(value, 'string', 'setUnitTypeTwo', 2)
    self.def:setLvlDataString('Rai4', level, 4, value)
end

function AbilityDefinitionRaiseDeadCreep:setUnitTypeOne(level, value)
    checktype(level, 'integer', 'setUnitTypeOne', 1)
    checktype(value, 'string', 'setUnitTypeOne', 2)
    self.def:setLvlDataString('Rai3', level, 3, value)
end

AbilityDefinitionFaerieFireAfa2 = class('AbilityDefinitionFaerieFireAfa2', AbilityDefinition)
_G.AbilityDefinitionFaerieFireAfa2 = AbilityDefinitionFaerieFireAfa2

function AbilityDefinitionFaerieFireAfa2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afa2')
end

function AbilityDefinitionFaerieFireAfa2:setAlwaysAutocast(level, value)
    checktype(level, 'integer', 'setAlwaysAutocast', 1)
    checktype(value, 'boolean', 'setAlwaysAutocast', 2)
    self.def:setLvlDataBoolean('Fae2', level, 2, value)
end

function AbilityDefinitionFaerieFireAfa2:setDefenseReduction(level, value)
    checktype(level, 'integer', 'setDefenseReduction', 1)
    checktype(value, 'integer', 'setDefenseReduction', 2)
    self.def:setLvlDataInt('Fae1', level, 1, value)
end

AbilityDefinitionUnholyFrenzyWarlock = class('AbilityDefinitionUnholyFrenzyWarlock', AbilityDefinition)
_G.AbilityDefinitionUnholyFrenzyWarlock = AbilityDefinitionUnholyFrenzyWarlock

function AbilityDefinitionUnholyFrenzyWarlock:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Suhf')
end

function AbilityDefinitionUnholyFrenzyWarlock:setAttackSpeedBonus(level, value)
    checktype(level, 'integer', 'setAttackSpeedBonus', 1)
    checktype(value, 'float', 'setAttackSpeedBonus', 2)
    self.def:setLvlDataUnreal('Uhf1', level, 1, value)
end

function AbilityDefinitionUnholyFrenzyWarlock:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Uhf2', level, 2, value)
end

AbilityDefinitionPaladinDevotionAura = class('AbilityDefinitionPaladinDevotionAura', AbilityDefinition)
_G.AbilityDefinitionPaladinDevotionAura = AbilityDefinitionPaladinDevotionAura

function AbilityDefinitionPaladinDevotionAura:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHad')
end

function AbilityDefinitionPaladinDevotionAura:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Had2', level, 2, value)
end

function AbilityDefinitionPaladinDevotionAura:setArmorBonus(level, value)
    checktype(level, 'integer', 'setArmorBonus', 1)
    checktype(value, 'float', 'setArmorBonus', 2)
    self.def:setLvlDataUnreal('Had1', level, 1, value)
end

AbilityDefinitionTinkererRoboGoblinLevel0 = class('AbilityDefinitionTinkererRoboGoblinLevel0', AbilityDefinition)
_G.AbilityDefinitionTinkererRoboGoblinLevel0 = AbilityDefinitionTinkererRoboGoblinLevel0

function AbilityDefinitionTinkererRoboGoblinLevel0:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANrg')
end

function AbilityDefinitionTinkererRoboGoblinLevel0:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Nrg5', level, 5, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel0:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel0:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel0:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel0:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel0:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Nrg6', level, 6, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel0:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionRejuvinationcreep = class('AbilityDefinitionRejuvinationcreep', AbilityDefinition)
_G.AbilityDefinitionRejuvinationcreep = AbilityDefinitionRejuvinationcreep

function AbilityDefinitionRejuvinationcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACrj')
end

function AbilityDefinitionRejuvinationcreep:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'float', 'setManaPointsGained', 2)
    self.def:setLvlDataUnreal('Rej2', level, 2, value)
end

function AbilityDefinitionRejuvinationcreep:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('Rej4', level, 4, value)
end

function AbilityDefinitionRejuvinationcreep:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Rej1', level, 1, value)
end

function AbilityDefinitionRejuvinationcreep:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('Rej3', level, 3, value)
end

AbilityDefinitionRainofFire = class('AbilityDefinitionRainofFire', AbilityDefinition)
_G.AbilityDefinitionRainofFire = AbilityDefinitionRainofFire

function AbilityDefinitionRainofFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANrf')
end

function AbilityDefinitionRainofFire:setMaximumDamageperWave(level, value)
    checktype(level, 'integer', 'setMaximumDamageperWave', 1)
    checktype(value, 'float', 'setMaximumDamageperWave', 2)
    self.def:setLvlDataUnreal('Hbz6', level, 6, value)
end

function AbilityDefinitionRainofFire:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Hbz5', level, 5, value)
end

function AbilityDefinitionRainofFire:setNumberofWaves(level, value)
    checktype(level, 'integer', 'setNumberofWaves', 1)
    checktype(value, 'integer', 'setNumberofWaves', 2)
    self.def:setLvlDataInt('Hbz1', level, 1, value)
end

function AbilityDefinitionRainofFire:setNumberofShards(level, value)
    checktype(level, 'integer', 'setNumberofShards', 1)
    checktype(value, 'integer', 'setNumberofShards', 2)
    self.def:setLvlDataInt('Hbz3', level, 3, value)
end

function AbilityDefinitionRainofFire:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Hbz4', level, 4, value)
end

function AbilityDefinitionRainofFire:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Hbz2', level, 2, value)
end

AbilityDefinitionItemAuraVampiric = class('AbilityDefinitionItemAuraVampiric', AbilityDefinition)
_G.AbilityDefinitionItemAuraVampiric = AbilityDefinitionItemAuraVampiric

function AbilityDefinitionItemAuraVampiric:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIav')
end

function AbilityDefinitionItemAuraVampiric:setAttackDamageStolen(level, value)
    checktype(level, 'integer', 'setAttackDamageStolen', 1)
    checktype(value, 'float', 'setAttackDamageStolen', 2)
    self.def:setLvlDataUnreal('Uav1', level, 1, value)
end

AbilityDefinitionItemAuraUnholy = class('AbilityDefinitionItemAuraUnholy', AbilityDefinition)
_G.AbilityDefinitionItemAuraUnholy = AbilityDefinitionItemAuraUnholy

function AbilityDefinitionItemAuraUnholy:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIau')
end

function AbilityDefinitionItemAuraUnholy:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Uau3', level, 3, value)
end

function AbilityDefinitionItemAuraUnholy:setLifeRegenerationIncrease(level, value)
    checktype(level, 'integer', 'setLifeRegenerationIncrease', 1)
    checktype(value, 'float', 'setLifeRegenerationIncrease', 2)
    self.def:setLvlDataUnreal('Uau2', level, 2, value)
end

function AbilityDefinitionItemAuraUnholy:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Uau1', level, 1, value)
end

AbilityDefinitionArchMageBrillianceAura = class('AbilityDefinitionArchMageBrillianceAura', AbilityDefinition)
_G.AbilityDefinitionArchMageBrillianceAura = AbilityDefinitionArchMageBrillianceAura

function AbilityDefinitionArchMageBrillianceAura:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHab')
end

function AbilityDefinitionArchMageBrillianceAura:setManaRegenerationIncrease(level, value)
    checktype(level, 'integer', 'setManaRegenerationIncrease', 1)
    checktype(value, 'float', 'setManaRegenerationIncrease', 2)
    self.def:setLvlDataUnreal('Hab1', level, 1, value)
end

function AbilityDefinitionArchMageBrillianceAura:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Hab2', level, 2, value)
end

AbilityDefinitionNeutralRegenmanaonly = class('AbilityDefinitionNeutralRegenmanaonly', AbilityDefinition)
_G.AbilityDefinitionNeutralRegenmanaonly = AbilityDefinitionNeutralRegenmanaonly

function AbilityDefinitionNeutralRegenmanaonly:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANre')
end

function AbilityDefinitionNeutralRegenmanaonly:setPercentage(level, value)
    checktype(level, 'integer', 'setPercentage', 1)
    checktype(value, 'boolean', 'setPercentage', 2)
    self.def:setLvlDataBoolean('Arm2', level, 2, value)
end

function AbilityDefinitionNeutralRegenmanaonly:setAmountRegenerated(level, value)
    checktype(level, 'integer', 'setAmountRegenerated', 1)
    checktype(value, 'float', 'setAmountRegenerated', 2)
    self.def:setLvlDataUnreal('Arm1', level, 1, value)
end

AbilityDefinitionRoarcreep = class('AbilityDefinitionRoarcreep', AbilityDefinition)
_G.AbilityDefinitionRoarcreep = AbilityDefinitionRoarcreep

function AbilityDefinitionRoarcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACro')
end

function AbilityDefinitionRoarcreep:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Roa1', level, 1, value)
end

function AbilityDefinitionRoarcreep:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Roa2', level, 2, value)
end

function AbilityDefinitionRoarcreep:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionRoarcreep:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

function AbilityDefinitionRoarcreep:setLifeRegenerationRate(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRate', 1)
    checktype(value, 'float', 'setLifeRegenerationRate', 2)
    self.def:setLvlDataUnreal('Roa3', level, 3, value)
end

function AbilityDefinitionRoarcreep:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionRoarcreep:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

AbilityDefinitionAttackBonus = class('AbilityDefinitionAttackBonus', AbilityDefinition)
_G.AbilityDefinitionAttackBonus = AbilityDefinitionAttackBonus

function AbilityDefinitionAttackBonus:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIat')
end

function AbilityDefinitionAttackBonus:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionAIas = class('AbilityDefinitionAIas', AbilityDefinition)
_G.AbilityDefinitionAIas = AbilityDefinitionAIas

function AbilityDefinitionAIas:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIas')
end

function AbilityDefinitionAIas:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Isx1', level, 1, value)
end

AbilityDefinitionReincarnationcreep = class('AbilityDefinitionReincarnationcreep', AbilityDefinition)
_G.AbilityDefinitionReincarnationcreep = AbilityDefinitionReincarnationcreep

function AbilityDefinitionReincarnationcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACrn')
end

function AbilityDefinitionReincarnationcreep:setReincarnationDelay(level, value)
    checktype(level, 'integer', 'setReincarnationDelay', 1)
    checktype(value, 'float', 'setReincarnationDelay', 2)
    self.def:setLvlDataUnreal('Ore1', level, 1, value)
end

AbilityDefinitionItemAuraTrueshot = class('AbilityDefinitionItemAuraTrueshot', AbilityDefinition)
_G.AbilityDefinitionItemAuraTrueshot = AbilityDefinitionItemAuraTrueshot

function AbilityDefinitionItemAuraTrueshot:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIar')
end

function AbilityDefinitionItemAuraTrueshot:setFlatBonus(level, value)
    checktype(level, 'integer', 'setFlatBonus', 1)
    checktype(value, 'boolean', 'setFlatBonus', 2)
    self.def:setLvlDataBoolean('Ear4', level, 4, value)
end

function AbilityDefinitionItemAuraTrueshot:setRangedBonus(level, value)
    checktype(level, 'integer', 'setRangedBonus', 1)
    checktype(value, 'boolean', 'setRangedBonus', 2)
    self.def:setLvlDataBoolean('Ear3', level, 3, value)
end

function AbilityDefinitionItemAuraTrueshot:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Ear1', level, 1, value)
end

function AbilityDefinitionItemAuraTrueshot:setMeleeBonus(level, value)
    checktype(level, 'integer', 'setMeleeBonus', 1)
    checktype(value, 'boolean', 'setMeleeBonus', 2)
    self.def:setLvlDataBoolean('Ear2', level, 2, value)
end

AbilityDefinitionThunderClapThunderLizard = class('AbilityDefinitionThunderClapThunderLizard', AbilityDefinition)
_G.AbilityDefinitionThunderClapThunderLizard = AbilityDefinitionThunderClapThunderLizard

function AbilityDefinitionThunderClapThunderLizard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACt2')
end

function AbilityDefinitionThunderClapThunderLizard:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ctc1', level, 1, value)
end

function AbilityDefinitionThunderClapThunderLizard:setExtraDamageToTarget(level, value)
    checktype(level, 'integer', 'setExtraDamageToTarget', 1)
    checktype(value, 'float', 'setExtraDamageToTarget', 2)
    self.def:setLvlDataUnreal('Ctc2', level, 2, value)
end

function AbilityDefinitionThunderClapThunderLizard:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Ctc4', level, 4, value)
end

function AbilityDefinitionThunderClapThunderLizard:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Ctc3', level, 3, value)
end

AbilityDefinitionWardenShadowStrike = class('AbilityDefinitionWardenShadowStrike', AbilityDefinition)
_G.AbilityDefinitionWardenShadowStrike = AbilityDefinitionWardenShadowStrike

function AbilityDefinitionWardenShadowStrike:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEsh')
end

function AbilityDefinitionWardenShadowStrike:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Esh2', level, 2, value)
end

function AbilityDefinitionWardenShadowStrike:setInitialDamage(level, value)
    checktype(level, 'integer', 'setInitialDamage', 1)
    checktype(value, 'float', 'setInitialDamage', 2)
    self.def:setLvlDataUnreal('Esh5', level, 5, value)
end

function AbilityDefinitionWardenShadowStrike:setDecayPower(level, value)
    checktype(level, 'integer', 'setDecayPower', 1)
    checktype(value, 'float', 'setDecayPower', 2)
    self.def:setLvlDataUnreal('Esh4', level, 4, value)
end

function AbilityDefinitionWardenShadowStrike:setDecayingDamage(level, value)
    checktype(level, 'integer', 'setDecayingDamage', 1)
    checktype(value, 'float', 'setDecayingDamage', 2)
    self.def:setLvlDataUnreal('Esh1', level, 1, value)
end

function AbilityDefinitionWardenShadowStrike:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Esh3', level, 3, value)
end

AbilityDefinitionBloodMageBanish = class('AbilityDefinitionBloodMageBanish', AbilityDefinition)
_G.AbilityDefinitionBloodMageBanish = AbilityDefinitionBloodMageBanish

function AbilityDefinitionBloodMageBanish:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHbn')
end

function AbilityDefinitionBloodMageBanish:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Hbn2', level, 2, value)
end

function AbilityDefinitionBloodMageBanish:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Hbn1', level, 1, value)
end

AbilityDefinitionItemAuraBrilliance = class('AbilityDefinitionItemAuraBrilliance', AbilityDefinition)
_G.AbilityDefinitionItemAuraBrilliance = AbilityDefinitionItemAuraBrilliance

function AbilityDefinitionItemAuraBrilliance:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIba')
end

function AbilityDefinitionItemAuraBrilliance:setManaRegenerationIncrease(level, value)
    checktype(level, 'integer', 'setManaRegenerationIncrease', 1)
    checktype(value, 'float', 'setManaRegenerationIncrease', 2)
    self.def:setLvlDataUnreal('Hab1', level, 1, value)
end

function AbilityDefinitionItemAuraBrilliance:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Hab2', level, 2, value)
end

AbilityDefinitionRainofChaos = class('AbilityDefinitionRainofChaos', AbilityDefinition)
_G.AbilityDefinitionRainofChaos = AbilityDefinitionRainofChaos

function AbilityDefinitionRainofChaos:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANrc')
end

function AbilityDefinitionRainofChaos:setAbilityforUnitCreation(level, value)
    checktype(level, 'integer', 'setAbilityforUnitCreation', 1)
    checktype(value, 'string', 'setAbilityforUnitCreation', 2)
    self.def:setLvlDataString('Nrc1', level, 1, value)
end

function AbilityDefinitionRainofChaos:setNumberofUnitsCreated(level, value)
    checktype(level, 'integer', 'setNumberofUnitsCreated', 1)
    checktype(value, 'integer', 'setNumberofUnitsCreated', 2)
    self.def:setLvlDataInt('Nrc2', level, 2, value)
end

AbilityDefinitionBuildTinyGreatHall = class('AbilityDefinitionBuildTinyGreatHall', AbilityDefinition)
_G.AbilityDefinitionBuildTinyGreatHall = AbilityDefinitionBuildTinyGreatHall

function AbilityDefinitionBuildTinyGreatHall:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIbg')
end

function AbilityDefinitionBuildTinyGreatHall:setUnitCreatedperplayerrace(level, value)
    checktype(level, 'integer', 'setUnitCreatedperplayerrace', 1)
    checktype(value, 'string', 'setUnitCreatedperplayerrace', 2)
    self.def:setLvlDataString('Ibl1', level, 0, value)
end

AbilityDefinitionCryptLordSpikedCarapace = class('AbilityDefinitionCryptLordSpikedCarapace', AbilityDefinition)
_G.AbilityDefinitionCryptLordSpikedCarapace = AbilityDefinitionCryptLordSpikedCarapace

function AbilityDefinitionCryptLordSpikedCarapace:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUts')
end

function AbilityDefinitionCryptLordSpikedCarapace:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'float', 'setDefenseBonus', 2)
    self.def:setLvlDataUnreal('Uts3', level, 3, value)
end

function AbilityDefinitionCryptLordSpikedCarapace:setReceivedDamageFactor(level, value)
    checktype(level, 'integer', 'setReceivedDamageFactor', 1)
    checktype(value, 'float', 'setReceivedDamageFactor', 2)
    self.def:setLvlDataUnreal('Uts2', level, 2, value)
end

function AbilityDefinitionCryptLordSpikedCarapace:setReturnedDamageFactor(level, value)
    checktype(level, 'integer', 'setReturnedDamageFactor', 1)
    checktype(value, 'float', 'setReturnedDamageFactor', 2)
    self.def:setLvlDataUnreal('Uts1', level, 1, value)
end

AbilityDefinitionCenariusBeefyStarfall = class('AbilityDefinitionCenariusBeefyStarfall', AbilityDefinition)
_G.AbilityDefinitionCenariusBeefyStarfall = AbilityDefinitionCenariusBeefyStarfall

function AbilityDefinitionCenariusBeefyStarfall:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEsb')
end

function AbilityDefinitionCenariusBeefyStarfall:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Esf1', level, 1, value)
end

function AbilityDefinitionCenariusBeefyStarfall:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Esf2', level, 2, value)
end

function AbilityDefinitionCenariusBeefyStarfall:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Esf3', level, 3, value)
end

AbilityDefinitionMoonPriestessStarfall = class('AbilityDefinitionMoonPriestessStarfall', AbilityDefinition)
_G.AbilityDefinitionMoonPriestessStarfall = AbilityDefinitionMoonPriestessStarfall

function AbilityDefinitionMoonPriestessStarfall:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEsf')
end

function AbilityDefinitionMoonPriestessStarfall:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Esf1', level, 1, value)
end

function AbilityDefinitionMoonPriestessStarfall:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Esf2', level, 2, value)
end

function AbilityDefinitionMoonPriestessStarfall:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Esf3', level, 3, value)
end

AbilityDefinitionArchMageBlizzard = class('AbilityDefinitionArchMageBlizzard', AbilityDefinition)
_G.AbilityDefinitionArchMageBlizzard = AbilityDefinitionArchMageBlizzard

function AbilityDefinitionArchMageBlizzard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHbz')
end

function AbilityDefinitionArchMageBlizzard:setMaximumDamageperWave(level, value)
    checktype(level, 'integer', 'setMaximumDamageperWave', 1)
    checktype(value, 'float', 'setMaximumDamageperWave', 2)
    self.def:setLvlDataUnreal('Hbz6', level, 6, value)
end

function AbilityDefinitionArchMageBlizzard:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Hbz5', level, 5, value)
end

function AbilityDefinitionArchMageBlizzard:setNumberofWaves(level, value)
    checktype(level, 'integer', 'setNumberofWaves', 1)
    checktype(value, 'integer', 'setNumberofWaves', 2)
    self.def:setLvlDataInt('Hbz1', level, 1, value)
end

function AbilityDefinitionArchMageBlizzard:setNumberofShards(level, value)
    checktype(level, 'integer', 'setNumberofShards', 1)
    checktype(value, 'integer', 'setNumberofShards', 2)
    self.def:setLvlDataInt('Hbz3', level, 3, value)
end

function AbilityDefinitionArchMageBlizzard:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Hbz4', level, 4, value)
end

function AbilityDefinitionArchMageBlizzard:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Hbz2', level, 2, value)
end

AbilityDefinitionDefenseBonusPlus1 = class('AbilityDefinitionDefenseBonusPlus1', AbilityDefinition)
_G.AbilityDefinitionDefenseBonusPlus1 = AbilityDefinitionDefenseBonusPlus1

function AbilityDefinitionDefenseBonusPlus1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AId1')
end

function AbilityDefinitionDefenseBonusPlus1:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionSearingArrowscreep = class('AbilityDefinitionSearingArrowscreep', AbilityDefinition)
_G.AbilityDefinitionSearingArrowscreep = AbilityDefinitionSearingArrowscreep

function AbilityDefinitionSearingArrowscreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACsa')
end

function AbilityDefinitionSearingArrowscreep:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Hfa1', level, 1, value)
end

AbilityDefinitionTinkererSummonFactoryLevel1 = class('AbilityDefinitionTinkererSummonFactoryLevel1', AbilityDefinition)
_G.AbilityDefinitionTinkererSummonFactoryLevel1 = AbilityDefinitionTinkererSummonFactoryLevel1

function AbilityDefinitionTinkererSummonFactoryLevel1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANs1')
end

function AbilityDefinitionTinkererSummonFactoryLevel1:setSpawnInterval(level, value)
    checktype(level, 'integer', 'setSpawnInterval', 1)
    checktype(value, 'float', 'setSpawnInterval', 2)
    self.def:setLvlDataUnreal('Nsy1', level, 1, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel1:setLeashRange(level, value)
    checktype(level, 'integer', 'setLeashRange', 1)
    checktype(value, 'float', 'setLeashRange', 2)
    self.def:setLvlDataUnreal('Nsy5', level, 5, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel1:setSpawnUnitID(level, value)
    checktype(level, 'integer', 'setSpawnUnitID', 1)
    checktype(value, 'string', 'setSpawnUnitID', 2)
    self.def:setLvlDataString('Nsy2', level, 2, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel1:setFactoryUnitID(level, value)
    checktype(level, 'integer', 'setFactoryUnitID', 1)
    checktype(value, 'string', 'setFactoryUnitID', 2)
    self.def:setLvlDataString('Nsyu', level, 0, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel1:setSpawnUnitOffset(level, value)
    checktype(level, 'integer', 'setSpawnUnitOffset', 1)
    checktype(value, 'float', 'setSpawnUnitOffset', 2)
    self.def:setLvlDataUnreal('Nsy4', level, 4, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel1:setSpawnUnitDuration(level, value)
    checktype(level, 'integer', 'setSpawnUnitDuration', 1)
    checktype(value, 'float', 'setSpawnUnitDuration', 2)
    self.def:setLvlDataUnreal('Nsy3', level, 3, value)
end

AbilityDefinitionDefenseBonusPlus3 = class('AbilityDefinitionDefenseBonusPlus3', AbilityDefinition)
_G.AbilityDefinitionDefenseBonusPlus3 = AbilityDefinitionDefenseBonusPlus3

function AbilityDefinitionDefenseBonusPlus3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AId3')
end

function AbilityDefinitionDefenseBonusPlus3:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionDefenseBonusPlus2 = class('AbilityDefinitionDefenseBonusPlus2', AbilityDefinition)
_G.AbilityDefinitionDefenseBonusPlus2 = AbilityDefinitionDefenseBonusPlus2

function AbilityDefinitionDefenseBonusPlus2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AId2')
end

function AbilityDefinitionDefenseBonusPlus2:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionTinkererSummonFactoryLevel3 = class('AbilityDefinitionTinkererSummonFactoryLevel3', AbilityDefinition)
_G.AbilityDefinitionTinkererSummonFactoryLevel3 = AbilityDefinitionTinkererSummonFactoryLevel3

function AbilityDefinitionTinkererSummonFactoryLevel3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANs3')
end

function AbilityDefinitionTinkererSummonFactoryLevel3:setSpawnInterval(level, value)
    checktype(level, 'integer', 'setSpawnInterval', 1)
    checktype(value, 'float', 'setSpawnInterval', 2)
    self.def:setLvlDataUnreal('Nsy1', level, 1, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel3:setLeashRange(level, value)
    checktype(level, 'integer', 'setLeashRange', 1)
    checktype(value, 'float', 'setLeashRange', 2)
    self.def:setLvlDataUnreal('Nsy5', level, 5, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel3:setSpawnUnitID(level, value)
    checktype(level, 'integer', 'setSpawnUnitID', 1)
    checktype(value, 'string', 'setSpawnUnitID', 2)
    self.def:setLvlDataString('Nsy2', level, 2, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel3:setFactoryUnitID(level, value)
    checktype(level, 'integer', 'setFactoryUnitID', 1)
    checktype(value, 'string', 'setFactoryUnitID', 2)
    self.def:setLvlDataString('Nsyu', level, 0, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel3:setSpawnUnitOffset(level, value)
    checktype(level, 'integer', 'setSpawnUnitOffset', 1)
    checktype(value, 'float', 'setSpawnUnitOffset', 2)
    self.def:setLvlDataUnreal('Nsy4', level, 4, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel3:setSpawnUnitDuration(level, value)
    checktype(level, 'integer', 'setSpawnUnitDuration', 1)
    checktype(value, 'float', 'setSpawnUnitDuration', 2)
    self.def:setLvlDataUnreal('Nsy3', level, 3, value)
end

AbilityDefinitionSpiritWolfcreep = class('AbilityDefinitionSpiritWolfcreep', AbilityDefinition)
_G.AbilityDefinitionSpiritWolfcreep = AbilityDefinitionSpiritWolfcreep

function AbilityDefinitionSpiritWolfcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACsf')
end

function AbilityDefinitionSpiritWolfcreep:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Osf1', level, 0, value)
end

function AbilityDefinitionSpiritWolfcreep:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Osf2', level, 2, value)
end

AbilityDefinitionTinkererSummonFactoryLevel2 = class('AbilityDefinitionTinkererSummonFactoryLevel2', AbilityDefinition)
_G.AbilityDefinitionTinkererSummonFactoryLevel2 = AbilityDefinitionTinkererSummonFactoryLevel2

function AbilityDefinitionTinkererSummonFactoryLevel2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANs2')
end

function AbilityDefinitionTinkererSummonFactoryLevel2:setSpawnInterval(level, value)
    checktype(level, 'integer', 'setSpawnInterval', 1)
    checktype(value, 'float', 'setSpawnInterval', 2)
    self.def:setLvlDataUnreal('Nsy1', level, 1, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel2:setLeashRange(level, value)
    checktype(level, 'integer', 'setLeashRange', 1)
    checktype(value, 'float', 'setLeashRange', 2)
    self.def:setLvlDataUnreal('Nsy5', level, 5, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel2:setSpawnUnitID(level, value)
    checktype(level, 'integer', 'setSpawnUnitID', 1)
    checktype(value, 'string', 'setSpawnUnitID', 2)
    self.def:setLvlDataString('Nsy2', level, 2, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel2:setFactoryUnitID(level, value)
    checktype(level, 'integer', 'setFactoryUnitID', 1)
    checktype(value, 'string', 'setFactoryUnitID', 2)
    self.def:setLvlDataString('Nsyu', level, 0, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel2:setSpawnUnitOffset(level, value)
    checktype(level, 'integer', 'setSpawnUnitOffset', 1)
    checktype(value, 'float', 'setSpawnUnitOffset', 2)
    self.def:setLvlDataUnreal('Nsy4', level, 4, value)
end

function AbilityDefinitionTinkererSummonFactoryLevel2:setSpawnUnitDuration(level, value)
    checktype(level, 'integer', 'setSpawnUnitDuration', 1)
    checktype(value, 'float', 'setSpawnUnitDuration', 2)
    self.def:setLvlDataUnreal('Nsy3', level, 3, value)
end

AbilityDefinitionMaxManaBonusMost = class('AbilityDefinitionMaxManaBonusMost', AbilityDefinition)
_G.AbilityDefinitionMaxManaBonusMost = AbilityDefinitionMaxManaBonusMost

function AbilityDefinitionMaxManaBonusMost:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIbm')
end

function AbilityDefinitionMaxManaBonusMost:setMaxManaGained(level, value)
    checktype(level, 'integer', 'setMaxManaGained', 1)
    checktype(value, 'integer', 'setMaxManaGained', 2)
    self.def:setLvlDataInt('Iman', level, 1, value)
end

AbilityDefinitionShockwaveCreep = class('AbilityDefinitionShockwaveCreep', AbilityDefinition)
_G.AbilityDefinitionShockwaveCreep = AbilityDefinitionShockwaveCreep

function AbilityDefinitionShockwaveCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACsh')
end

function AbilityDefinitionShockwaveCreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Osh1', level, 1, value)
end

function AbilityDefinitionShockwaveCreep:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Osh3', level, 3, value)
end

function AbilityDefinitionShockwaveCreep:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Osh4', level, 4, value)
end

function AbilityDefinitionShockwaveCreep:setMaximumDamage(level, value)
    checktype(level, 'integer', 'setMaximumDamage', 1)
    checktype(value, 'float', 'setMaximumDamage', 2)
    self.def:setLvlDataUnreal('Osh2', level, 2, value)
end

AbilityDefinitionBuildTinyCastle = class('AbilityDefinitionBuildTinyCastle', AbilityDefinition)
_G.AbilityDefinitionBuildTinyCastle = AbilityDefinitionBuildTinyCastle

function AbilityDefinitionBuildTinyCastle:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIbl')
end

function AbilityDefinitionBuildTinyCastle:setUnitCreatedperplayerrace(level, value)
    checktype(level, 'integer', 'setUnitCreatedperplayerrace', 1)
    checktype(value, 'string', 'setUnitCreatedperplayerrace', 2)
    self.def:setLvlDataString('Ibl1', level, 0, value)
end

AbilityDefinitionSilenceCreep = class('AbilityDefinitionSilenceCreep', AbilityDefinition)
_G.AbilityDefinitionSilenceCreep = AbilityDefinitionSilenceCreep

function AbilityDefinitionSilenceCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACsi')
end

function AbilityDefinitionSilenceCreep:setAttackSpeedModifier(level, value)
    checktype(level, 'integer', 'setAttackSpeedModifier', 1)
    checktype(value, 'float', 'setAttackSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi4', level, 4, value)
end

function AbilityDefinitionSilenceCreep:setMovementSpeedModifier(level, value)
    checktype(level, 'integer', 'setMovementSpeedModifier', 1)
    checktype(value, 'float', 'setMovementSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi3', level, 3, value)
end

function AbilityDefinitionSilenceCreep:setChanceToMiss(level, value)
    checktype(level, 'integer', 'setChanceToMiss', 1)
    checktype(value, 'float', 'setChanceToMiss', 2)
    self.def:setLvlDataUnreal('Nsi2', level, 2, value)
end

function AbilityDefinitionSilenceCreep:setAttacksPrevented(level, value)
    checktype(level, 'integer', 'setAttacksPrevented', 1)
    checktype(value, 'integer', 'setAttacksPrevented', 2)
    self.def:setLvlDataInt('Nsi1', level, 1, value)
end

AbilityDefinitionSleepcreep = class('AbilityDefinitionSleepcreep', AbilityDefinition)
_G.AbilityDefinitionSleepcreep = AbilityDefinitionSleepcreep

function AbilityDefinitionSleepcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACsl')
end

function AbilityDefinitionSleepcreep:setStunDuration(level, value)
    checktype(level, 'integer', 'setStunDuration', 1)
    checktype(value, 'float', 'setStunDuration', 2)
    self.def:setLvlDataUnreal('Usl1', level, 1, value)
end

AbilityDefinitionBashitem = class('AbilityDefinitionBashitem', AbilityDefinition)
_G.AbilityDefinitionBashitem = AbilityDefinitionBashitem

function AbilityDefinitionBashitem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIbx')
end

function AbilityDefinitionBashitem:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Hbh5', level, 5, value)
end

AbilityDefinitionDefenseBonusPlus5 = class('AbilityDefinitionDefenseBonusPlus5', AbilityDefinition)
_G.AbilityDefinitionDefenseBonusPlus5 = AbilityDefinitionDefenseBonusPlus5

function AbilityDefinitionDefenseBonusPlus5:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AId5')
end

function AbilityDefinitionDefenseBonusPlus5:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionMountainKingBash = class('AbilityDefinitionMountainKingBash', AbilityDefinition)
_G.AbilityDefinitionMountainKingBash = AbilityDefinitionMountainKingBash

function AbilityDefinitionMountainKingBash:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHbh')
end

function AbilityDefinitionMountainKingBash:setChancetoBash(level, value)
    checktype(level, 'integer', 'setChancetoBash', 1)
    checktype(value, 'float', 'setChancetoBash', 2)
    self.def:setLvlDataUnreal('Hbh1', level, 1, value)
end

function AbilityDefinitionMountainKingBash:setChancetoMiss(level, value)
    checktype(level, 'integer', 'setChancetoMiss', 1)
    checktype(value, 'float', 'setChancetoMiss', 2)
    self.def:setLvlDataUnreal('Hbh4', level, 4, value)
end

function AbilityDefinitionMountainKingBash:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Hbh3', level, 3, value)
end

function AbilityDefinitionMountainKingBash:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Hbh5', level, 5, value)
end

function AbilityDefinitionMountainKingBash:setDamageMultiplier(level, value)
    checktype(level, 'integer', 'setDamageMultiplier', 1)
    checktype(value, 'float', 'setDamageMultiplier', 2)
    self.def:setLvlDataUnreal('Hbh2', level, 2, value)
end

AbilityDefinitionSiphonManaCreep = class('AbilityDefinitionSiphonManaCreep', AbilityDefinition)
_G.AbilityDefinitionSiphonManaCreep = AbilityDefinitionSiphonManaCreep

function AbilityDefinitionSiphonManaCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACsm')
end

function AbilityDefinitionSiphonManaCreep:setBonusLifeDecay(level, value)
    checktype(level, 'integer', 'setBonusLifeDecay', 1)
    checktype(value, 'float', 'setBonusLifeDecay', 2)
    self.def:setLvlDataUnreal('Ndr7', level, 7, value)
end

function AbilityDefinitionSiphonManaCreep:setManaTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setManaTransferredPerSecond', 1)
    checktype(value, 'float', 'setManaTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr5', level, 5, value)
end

function AbilityDefinitionSiphonManaCreep:setBonusManaDecay(level, value)
    checktype(level, 'integer', 'setBonusManaDecay', 1)
    checktype(value, 'float', 'setBonusManaDecay', 2)
    self.def:setLvlDataUnreal('Ndr9', level, 9, value)
end

function AbilityDefinitionSiphonManaCreep:setBonusLifeFactor(level, value)
    checktype(level, 'integer', 'setBonusLifeFactor', 1)
    checktype(value, 'float', 'setBonusLifeFactor', 2)
    self.def:setLvlDataUnreal('Ndr6', level, 6, value)
end

function AbilityDefinitionSiphonManaCreep:setBonusManaFactor(level, value)
    checktype(level, 'integer', 'setBonusManaFactor', 1)
    checktype(value, 'float', 'setBonusManaFactor', 2)
    self.def:setLvlDataUnreal('Ndr8', level, 8, value)
end

function AbilityDefinitionSiphonManaCreep:setLifeTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setLifeTransferredPerSecond', 1)
    checktype(value, 'float', 'setLifeTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr4', level, 4, value)
end

AbilityDefinitionDefenseBonusPlus4 = class('AbilityDefinitionDefenseBonusPlus4', AbilityDefinition)
_G.AbilityDefinitionDefenseBonusPlus4 = AbilityDefinitionDefenseBonusPlus4

function AbilityDefinitionDefenseBonusPlus4:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AId4')
end

function AbilityDefinitionDefenseBonusPlus4:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionBuildTinyScoutTower = class('AbilityDefinitionBuildTinyScoutTower', AbilityDefinition)
_G.AbilityDefinitionBuildTinyScoutTower = AbilityDefinitionBuildTinyScoutTower

function AbilityDefinitionBuildTinyScoutTower:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIbt')
end

function AbilityDefinitionBuildTinyScoutTower:setUnitCreatedperplayerrace(level, value)
    checktype(level, 'integer', 'setUnitCreatedperplayerrace', 1)
    checktype(value, 'string', 'setUnitCreatedperplayerrace', 2)
    self.def:setLvlDataString('Ibl1', level, 0, value)
end

AbilityDefinitionItemCloakOfFlames = class('AbilityDefinitionItemCloakOfFlames', AbilityDefinition)
_G.AbilityDefinitionItemCloakOfFlames = AbilityDefinitionItemCloakOfFlames

function AbilityDefinitionItemCloakOfFlames:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIcf')
end

function AbilityDefinitionItemCloakOfFlames:setExtraManaRequired(level, value)
    checktype(level, 'integer', 'setExtraManaRequired', 1)
    checktype(value, 'integer', 'setExtraManaRequired', 2)
    self.def:setLvlDataInt('Icfx', level, 3, value)
end

function AbilityDefinitionItemCloakOfFlames:setDamagePerDuration(level, value)
    checktype(level, 'integer', 'setDamagePerDuration', 1)
    checktype(value, 'integer', 'setDamagePerDuration', 2)
    self.def:setLvlDataInt('Icfd', level, 1, value)
end

function AbilityDefinitionItemCloakOfFlames:setManaUsedPerSecond(level, value)
    checktype(level, 'integer', 'setManaUsedPerSecond', 1)
    checktype(value, 'integer', 'setManaUsedPerSecond', 2)
    self.def:setLvlDataInt('Icfm', level, 2, value)
end

AbilityDefinitionItemAuraCommand = class('AbilityDefinitionItemAuraCommand', AbilityDefinition)
_G.AbilityDefinitionItemAuraCommand = AbilityDefinitionItemAuraCommand

function AbilityDefinitionItemAuraCommand:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIcd')
end

function AbilityDefinitionItemAuraCommand:setRangedBonus(level, value)
    checktype(level, 'integer', 'setRangedBonus', 1)
    checktype(value, 'boolean', 'setRangedBonus', 2)
    self.def:setLvlDataBoolean('Ear3', level, 3, value)
end

function AbilityDefinitionItemAuraCommand:setFlatBonus(level, value)
    checktype(level, 'integer', 'setFlatBonus', 1)
    checktype(value, 'boolean', 'setFlatBonus', 2)
    self.def:setLvlDataBoolean('Ear4', level, 4, value)
end

function AbilityDefinitionItemAuraCommand:setAttackDamageIncrease(level, value)
    checktype(level, 'integer', 'setAttackDamageIncrease', 1)
    checktype(value, 'float', 'setAttackDamageIncrease', 2)
    self.def:setLvlDataUnreal('Cac1', level, 1, value)
end

function AbilityDefinitionItemAuraCommand:setMeleeBonus(level, value)
    checktype(level, 'integer', 'setMeleeBonus', 1)
    checktype(value, 'boolean', 'setMeleeBonus', 2)
    self.def:setLvlDataBoolean('Ear2', level, 2, value)
end

AbilityDefinitionHarvest = class('AbilityDefinitionHarvest', AbilityDefinition)
_G.AbilityDefinitionHarvest = AbilityDefinitionHarvest

function AbilityDefinitionHarvest:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahar')
end

function AbilityDefinitionHarvest:setGoldCapacity(level, value)
    checktype(level, 'integer', 'setGoldCapacity', 1)
    checktype(value, 'integer', 'setGoldCapacity', 2)
    self.def:setLvlDataInt('Har3', level, 3, value)
end

function AbilityDefinitionHarvest:setLumberCapacity(level, value)
    checktype(level, 'integer', 'setLumberCapacity', 1)
    checktype(value, 'integer', 'setLumberCapacity', 2)
    self.def:setLvlDataInt('Har2', level, 2, value)
end

function AbilityDefinitionHarvest:setDamagetoTree(level, value)
    checktype(level, 'integer', 'setDamagetoTree', 1)
    checktype(value, 'integer', 'setDamagetoTree', 2)
    self.def:setLvlDataInt('Har1', level, 1, value)
end

AbilityDefinitionMagicImmunityDragons = class('AbilityDefinitionMagicImmunityDragons', AbilityDefinition)
_G.AbilityDefinitionMagicImmunityDragons = AbilityDefinitionMagicImmunityDragons

function AbilityDefinitionMagicImmunityDragons:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACm3')
end

function AbilityDefinitionMagicImmunityDragons:setMagicDamageFactor(level, value)
    checktype(level, 'integer', 'setMagicDamageFactor', 1)
    checktype(value, 'float', 'setMagicDamageFactor', 2)
    self.def:setLvlDataUnreal('mim1', level, 1, value)
end

AbilityDefinitionMagicImmunityArchimonde = class('AbilityDefinitionMagicImmunityArchimonde', AbilityDefinition)
_G.AbilityDefinitionMagicImmunityArchimonde = AbilityDefinitionMagicImmunityArchimonde

function AbilityDefinitionMagicImmunityArchimonde:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACm2')
end

function AbilityDefinitionMagicImmunityArchimonde:setMagicDamageFactor(level, value)
    checktype(level, 'integer', 'setMagicDamageFactor', 1)
    checktype(value, 'float', 'setMagicDamageFactor', 2)
    self.def:setLvlDataUnreal('mim1', level, 1, value)
end

AbilityDefinitionOrbofCorruption = class('AbilityDefinitionOrbofCorruption', AbilityDefinition)
_G.AbilityDefinitionOrbofCorruption = AbilityDefinitionOrbofCorruption

function AbilityDefinitionOrbofCorruption:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIcb')
end

function AbilityDefinitionOrbofCorruption:setArmorPenalty(level, value)
    checktype(level, 'integer', 'setArmorPenalty', 1)
    checktype(value, 'integer', 'setArmorPenalty', 2)
    self.def:setLvlDataInt('Iarp', level, 2, value)
end

function AbilityDefinitionOrbofCorruption:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionOrbofCorruption:setDamageBonusDice(level, value)
    checktype(level, 'integer', 'setDamageBonusDice', 1)
    checktype(value, 'integer', 'setDamageBonusDice', 2)
    self.def:setLvlDataInt('Idic', level, 1, value)
end

AbilityDefinitionWardenSpiritofVengeance = class('AbilityDefinitionWardenSpiritofVengeance', AbilityDefinition)
_G.AbilityDefinitionWardenSpiritofVengeance = AbilityDefinitionWardenSpiritofVengeance

function AbilityDefinitionWardenSpiritofVengeance:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEsv')
end

function AbilityDefinitionWardenSpiritofVengeance:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Esvu', level, 0, value)
end

function AbilityDefinitionWardenSpiritofVengeance:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Esv1', level, 1, value)
end

AbilityDefinitionItemChangeTOD = class('AbilityDefinitionItemChangeTOD', AbilityDefinition)
_G.AbilityDefinitionItemChangeTOD = AbilityDefinitionItemChangeTOD

function AbilityDefinitionItemChangeTOD:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIct')
end

function AbilityDefinitionItemChangeTOD:setNewTimeofDayMinute(level, value)
    checktype(level, 'integer', 'setNewTimeofDayMinute', 1)
    checktype(value, 'integer', 'setNewTimeofDayMinute', 2)
    self.def:setLvlDataInt('ict2', level, 2, value)
end

function AbilityDefinitionItemChangeTOD:setNewTimeofDayHour(level, value)
    checktype(level, 'integer', 'setNewTimeofDayHour', 1)
    checktype(value, 'integer', 'setNewTimeofDayHour', 2)
    self.def:setLvlDataInt('ict1', level, 1, value)
end

AbilityDefinitionMoonPriestessScout = class('AbilityDefinitionMoonPriestessScout', AbilityDefinition)
_G.AbilityDefinitionMoonPriestessScout = AbilityDefinitionMoonPriestessScout

function AbilityDefinitionMoonPriestessScout:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEst')
end

function AbilityDefinitionMoonPriestessScout:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionMoonPriestessScout:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionCycloneAIcy = class('AbilityDefinitionCycloneAIcy', AbilityDefinition)
_G.AbilityDefinitionCycloneAIcy = AbilityDefinitionCycloneAIcy

function AbilityDefinitionCycloneAIcy:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIcy')
end

function AbilityDefinitionCycloneAIcy:setCanBeDispelled(level, value)
    checktype(level, 'integer', 'setCanBeDispelled', 1)
    checktype(value, 'boolean', 'setCanBeDispelled', 2)
    self.def:setLvlDataBoolean('cyc1', level, 1, value)
end

AbilityDefinitionExhume = class('AbilityDefinitionExhume', AbilityDefinition)
_G.AbilityDefinitionExhume = AbilityDefinitionExhume

function AbilityDefinitionExhume:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aexh')
end

function AbilityDefinitionExhume:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('exhu', level, 0, value)
end

function AbilityDefinitionExhume:setMaximumNumberofCorpses(level, value)
    checktype(level, 'integer', 'setMaximumNumberofCorpses', 1)
    checktype(value, 'integer', 'setMaximumNumberofCorpses', 2)
    self.def:setLvlDataInt('exh1', level, 1, value)
end

AbilityDefinitionItemCommand = class('AbilityDefinitionItemCommand', AbilityDefinition)
_G.AbilityDefinitionItemCommand = AbilityDefinitionItemCommand

function AbilityDefinitionItemCommand:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIco')
end

function AbilityDefinitionItemCommand:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Icre', level, 1, value)
end

AbilityDefinitionExperienceModgreater = class('AbilityDefinitionExperienceModgreater', AbilityDefinition)
_G.AbilityDefinitionExperienceModgreater = AbilityDefinitionExperienceModgreater

function AbilityDefinitionExperienceModgreater:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIe2')
end

function AbilityDefinitionExperienceModgreater:setExperienceGained(level, value)
    checktype(level, 'integer', 'setExperienceGained', 1)
    checktype(value, 'integer', 'setExperienceGained', 2)
    self.def:setLvlDataInt('Ixpg', level, 1, value)
end

AbilityDefinitionAIde = class('AbilityDefinitionAIde', AbilityDefinition)
_G.AbilityDefinitionAIde = AbilityDefinitionAIde

function AbilityDefinitionAIde:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIde')
end

function AbilityDefinitionAIde:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionDefendItem = class('AbilityDefinitionDefendItem', AbilityDefinition)
_G.AbilityDefinitionDefendItem = AbilityDefinitionDefendItem

function AbilityDefinitionDefendItem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIdd')
end

function AbilityDefinitionDefendItem:setDamageTaken(level, value)
    checktype(level, 'integer', 'setDamageTaken', 1)
    checktype(value, 'float', 'setDamageTaken', 2)
    self.def:setLvlDataUnreal('Def1', level, 1, value)
end

function AbilityDefinitionDefendItem:setChancetoDeflect(level, value)
    checktype(level, 'integer', 'setChancetoDeflect', 1)
    checktype(value, 'float', 'setChancetoDeflect', 2)
    self.def:setLvlDataUnreal('Def6', level, 6, value)
end

function AbilityDefinitionDefendItem:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Def3', level, 3, value)
end

function AbilityDefinitionDefendItem:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Def4', level, 4, value)
end

function AbilityDefinitionDefendItem:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Def2', level, 2, value)
end

function AbilityDefinitionDefendItem:setDeflectDamageTakenSpells(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenSpells', 1)
    checktype(value, 'float', 'setDeflectDamageTakenSpells', 2)
    self.def:setLvlDataUnreal('Def8', level, 8, value)
end

function AbilityDefinitionDefendItem:setDeflectDamageTakenPiercing(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenPiercing', 1)
    checktype(value, 'float', 'setDeflectDamageTakenPiercing', 2)
    self.def:setLvlDataUnreal('Def7', level, 7, value)
end

function AbilityDefinitionDefendItem:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Def5', level, 5, value)
end

AbilityDefinitionOrbofDarkness = class('AbilityDefinitionOrbofDarkness', AbilityDefinition)
_G.AbilityDefinitionOrbofDarkness = AbilityDefinitionOrbofDarkness

function AbilityDefinitionOrbofDarkness:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIdf')
end

function AbilityDefinitionOrbofDarkness:setChanceToHitUnits(level, value)
    checktype(level, 'integer', 'setChanceToHitUnits', 1)
    checktype(value, 'float', 'setChanceToHitUnits', 2)
    self.def:setLvlDataUnreal('Iob2', level, 2, value)
end

function AbilityDefinitionOrbofDarkness:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionOrbofDarkness:setChanceToHitSummons(level, value)
    checktype(level, 'integer', 'setChanceToHitSummons', 1)
    checktype(value, 'float', 'setChanceToHitSummons', 2)
    self.def:setLvlDataUnreal('Iob4', level, 4, value)
end

function AbilityDefinitionOrbofDarkness:setChanceToHitHeros(level, value)
    checktype(level, 'integer', 'setChanceToHitHeros', 1)
    checktype(value, 'float', 'setChanceToHitHeros', 2)
    self.def:setLvlDataUnreal('Iob3', level, 3, value)
end

function AbilityDefinitionOrbofDarkness:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

function AbilityDefinitionOrbofDarkness:setEffectAbility(level, value)
    checktype(level, 'integer', 'setEffectAbility', 1)
    checktype(value, 'string', 'setEffectAbility', 2)
    self.def:setLvlDataString('Iobu', level, 0, value)
end

AbilityDefinitionItemDispelAoe = class('AbilityDefinitionItemDispelAoe', AbilityDefinition)
_G.AbilityDefinitionItemDispelAoe = AbilityDefinitionItemDispelAoe

function AbilityDefinitionItemDispelAoe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIdi')
end

function AbilityDefinitionItemDispelAoe:setDamageToSummonedUnits(level, value)
    checktype(level, 'integer', 'setDamageToSummonedUnits', 1)
    checktype(value, 'integer', 'setDamageToSummonedUnits', 2)
    self.def:setLvlDataInt('Idid', level, 2, value)
end

function AbilityDefinitionItemDispelAoe:setManaLossPerUnit(level, value)
    checktype(level, 'integer', 'setManaLossPerUnit', 1)
    checktype(value, 'integer', 'setManaLossPerUnit', 2)
    self.def:setLvlDataInt('Idim', level, 1, value)
end

AbilityDefinitionLightningShieldcreep = class('AbilityDefinitionLightningShieldcreep', AbilityDefinition)
_G.AbilityDefinitionLightningShieldcreep = AbilityDefinitionLightningShieldcreep

function AbilityDefinitionLightningShieldcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACls')
end

function AbilityDefinitionLightningShieldcreep:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Lsh1', level, 1, value)
end

AbilityDefinitionCargoHoldShip = class('AbilityDefinitionCargoHoldShip', AbilityDefinition)
_G.AbilityDefinitionCargoHoldShip = AbilityDefinitionCargoHoldShip

function AbilityDefinitionCargoHoldShip:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sch5')
end

function AbilityDefinitionCargoHoldShip:setCargoCapacity(level, value)
    checktype(level, 'integer', 'setCargoCapacity', 1)
    checktype(value, 'integer', 'setCargoCapacity', 2)
    self.def:setLvlDataInt('Car1', level, 1, value)
end

AbilityDefinitionCannibalize = class('AbilityDefinitionCannibalize', AbilityDefinition)
_G.AbilityDefinitionCannibalize = AbilityDefinitionCannibalize

function AbilityDefinitionCannibalize:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acan')
end

function AbilityDefinitionCannibalize:setMaxHitPoints(level, value)
    checktype(level, 'integer', 'setMaxHitPoints', 1)
    checktype(value, 'float', 'setMaxHitPoints', 2)
    self.def:setLvlDataUnreal('Can2', level, 2, value)
end

function AbilityDefinitionCannibalize:setHitPointsperSecond(level, value)
    checktype(level, 'integer', 'setHitPointsperSecond', 1)
    checktype(value, 'float', 'setHitPointsperSecond', 2)
    self.def:setLvlDataUnreal('Can1', level, 1, value)
end

AbilityDefinitionCargoHoldTank = class('AbilityDefinitionCargoHoldTank', AbilityDefinition)
_G.AbilityDefinitionCargoHoldTank = AbilityDefinitionCargoHoldTank

function AbilityDefinitionCargoHoldTank:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sch4')
end

function AbilityDefinitionCargoHoldTank:setCargoCapacity(level, value)
    checktype(level, 'integer', 'setCargoCapacity', 1)
    checktype(value, 'integer', 'setCargoCapacity', 2)
    self.def:setLvlDataInt('Car1', level, 1, value)
end

AbilityDefinitionItemDefenseAoe = class('AbilityDefinitionItemDefenseAoe', AbilityDefinition)
_G.AbilityDefinitionItemDefenseAoe = AbilityDefinitionItemDefenseAoe

function AbilityDefinitionItemDefenseAoe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIda')
end

function AbilityDefinitionItemDefenseAoe:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihp2', level, 2, value)
end

function AbilityDefinitionItemDefenseAoe:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'integer', 'setManaPointsGained', 2)
    self.def:setLvlDataInt('Imp2', level, 3, value)
end

function AbilityDefinitionItemDefenseAoe:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionCargoHoldTransport = class('AbilityDefinitionCargoHoldTransport', AbilityDefinition)
_G.AbilityDefinitionCargoHoldTransport = AbilityDefinitionCargoHoldTransport

function AbilityDefinitionCargoHoldTransport:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sch3')
end

function AbilityDefinitionCargoHoldTransport:setCargoCapacity(level, value)
    checktype(level, 'integer', 'setCargoCapacity', 1)
    checktype(value, 'integer', 'setCargoCapacity', 2)
    self.def:setLvlDataInt('Car1', level, 1, value)
end

AbilityDefinitionCargoHoldMeatWagon = class('AbilityDefinitionCargoHoldMeatWagon', AbilityDefinition)
_G.AbilityDefinitionCargoHoldMeatWagon = AbilityDefinitionCargoHoldMeatWagon

function AbilityDefinitionCargoHoldMeatWagon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sch2')
end

function AbilityDefinitionCargoHoldMeatWagon:setCargoCapacity(level, value)
    checktype(level, 'integer', 'setCargoCapacity', 1)
    checktype(value, 'integer', 'setCargoCapacity', 2)
    self.def:setLvlDataInt('Car1', level, 1, value)
end

AbilityDefinitionItemDispelChain = class('AbilityDefinitionItemDispelChain', AbilityDefinition)
_G.AbilityDefinitionItemDispelChain = AbilityDefinitionItemDispelChain

function AbilityDefinitionItemDispelChain:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIdc')
end

function AbilityDefinitionItemDispelChain:setMaximumDispelledUnits(level, value)
    checktype(level, 'integer', 'setMaximumDispelledUnits', 1)
    checktype(value, 'integer', 'setMaximumDispelledUnits', 2)
    self.def:setLvlDataInt('idc3', level, 3, value)
end

function AbilityDefinitionItemDispelChain:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('idc2', level, 2, value)
end

function AbilityDefinitionItemDispelChain:setManaLossPerUnit(level, value)
    checktype(level, 'integer', 'setManaLossPerUnit', 1)
    checktype(value, 'float', 'setManaLossPerUnit', 2)
    self.def:setLvlDataUnreal('idc1', level, 1, value)
end

AbilityDefinitionTaurenChieftainEnduranceAura = class('AbilityDefinitionTaurenChieftainEnduranceAura', AbilityDefinition)
_G.AbilityDefinitionTaurenChieftainEnduranceAura = AbilityDefinitionTaurenChieftainEnduranceAura

function AbilityDefinitionTaurenChieftainEnduranceAura:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOae')
end

function AbilityDefinitionTaurenChieftainEnduranceAura:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Oae1', level, 1, value)
end

function AbilityDefinitionTaurenChieftainEnduranceAura:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Oae2', level, 2, value)
end

AbilityDefinitionItemDefenseAoePlusHealing = class('AbilityDefinitionItemDefenseAoePlusHealing', AbilityDefinition)
_G.AbilityDefinitionItemDefenseAoePlusHealing = AbilityDefinitionItemDefenseAoePlusHealing

function AbilityDefinitionItemDefenseAoePlusHealing:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIdb')
end

function AbilityDefinitionItemDefenseAoePlusHealing:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihp2', level, 2, value)
end

function AbilityDefinitionItemDefenseAoePlusHealing:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'integer', 'setManaPointsGained', 2)
    self.def:setLvlDataInt('Imp2', level, 3, value)
end

function AbilityDefinitionItemDefenseAoePlusHealing:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Idef', level, 1, value)
end

AbilityDefinitionMagicImmunityCreep = class('AbilityDefinitionMagicImmunityCreep', AbilityDefinition)
_G.AbilityDefinitionMagicImmunityCreep = AbilityDefinitionMagicImmunityCreep

function AbilityDefinitionMagicImmunityCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACmi')
end

function AbilityDefinitionMagicImmunityCreep:setMagicDamageFactor(level, value)
    checktype(level, 'integer', 'setMagicDamageFactor', 1)
    checktype(value, 'float', 'setMagicDamageFactor', 2)
    self.def:setLvlDataUnreal('mim1', level, 1, value)
end

AbilityDefinitionKeeperoftheGroveTranquility = class('AbilityDefinitionKeeperoftheGroveTranquility', AbilityDefinition)
_G.AbilityDefinitionKeeperoftheGroveTranquility = AbilityDefinitionKeeperoftheGroveTranquility

function AbilityDefinitionKeeperoftheGroveTranquility:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEtq')
end

function AbilityDefinitionKeeperoftheGroveTranquility:setHealInterval(level, value)
    checktype(level, 'integer', 'setHealInterval', 1)
    checktype(value, 'float', 'setHealInterval', 2)
    self.def:setLvlDataUnreal('Etq2', level, 2, value)
end

function AbilityDefinitionKeeperoftheGroveTranquility:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Etq3', level, 3, value)
end

function AbilityDefinitionKeeperoftheGroveTranquility:setLifeHealed(level, value)
    checktype(level, 'integer', 'setLifeHealed', 1)
    checktype(value, 'float', 'setLifeHealed', 2)
    self.def:setLvlDataUnreal('Etq1', level, 1, value)
end

AbilityDefinitionWindWalk = class('AbilityDefinitionWindWalk', AbilityDefinition)
_G.AbilityDefinitionWindWalk = AbilityDefinitionWindWalk

function AbilityDefinitionWindWalk:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANwk')
end

function AbilityDefinitionWindWalk:setBackstabDamage(level, value)
    checktype(level, 'integer', 'setBackstabDamage', 1)
    checktype(value, 'float', 'setBackstabDamage', 2)
    self.def:setLvlDataUnreal('Owk3', level, 3, value)
end

function AbilityDefinitionWindWalk:setBackstabDamage(level, value)
    checktype(level, 'integer', 'setBackstabDamage', 1)
    checktype(value, 'boolean', 'setBackstabDamage', 2)
    self.def:setLvlDataBoolean('Owk4', level, 4, value)
end

function AbilityDefinitionWindWalk:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Owk2', level, 2, value)
end

function AbilityDefinitionWindWalk:setTransitionTime(level, value)
    checktype(level, 'integer', 'setTransitionTime', 1)
    checktype(value, 'float', 'setTransitionTime', 2)
    self.def:setLvlDataUnreal('Owk1', level, 1, value)
end

AbilityDefinitionManaShieldCreep = class('AbilityDefinitionManaShieldCreep', AbilityDefinition)
_G.AbilityDefinitionManaShieldCreep = AbilityDefinitionManaShieldCreep

function AbilityDefinitionManaShieldCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACmf')
end

function AbilityDefinitionManaShieldCreep:setDamageAbsorbed(level, value)
    checktype(level, 'integer', 'setDamageAbsorbed', 1)
    checktype(value, 'float', 'setDamageAbsorbed', 2)
    self.def:setLvlDataUnreal('Nms2', level, 2, value)
end

function AbilityDefinitionManaShieldCreep:setManaperHitPoint(level, value)
    checktype(level, 'integer', 'setManaperHitPoint', 1)
    checktype(value, 'float', 'setManaperHitPoint', 2)
    self.def:setLvlDataUnreal('Nms1', level, 1, value)
end

AbilityDefinitionWateryMinion = class('AbilityDefinitionWateryMinion', AbilityDefinition)
_G.AbilityDefinitionWateryMinion = AbilityDefinitionWateryMinion

function AbilityDefinitionWateryMinion:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANwm')
end

function AbilityDefinitionWateryMinion:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionWateryMinion:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionItemDispelAoeWithCooldown = class('AbilityDefinitionItemDispelAoeWithCooldown', AbilityDefinition)
_G.AbilityDefinitionItemDispelAoeWithCooldown = AbilityDefinitionItemDispelAoeWithCooldown

function AbilityDefinitionItemDispelAoeWithCooldown:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIds')
end

function AbilityDefinitionItemDispelAoeWithCooldown:setDamageToSummonedUnits(level, value)
    checktype(level, 'integer', 'setDamageToSummonedUnits', 1)
    checktype(value, 'integer', 'setDamageToSummonedUnits', 2)
    self.def:setLvlDataInt('Idid', level, 2, value)
end

function AbilityDefinitionItemDispelAoeWithCooldown:setManaLossPerUnit(level, value)
    checktype(level, 'integer', 'setManaLossPerUnit', 1)
    checktype(value, 'integer', 'setManaLossPerUnit', 2)
    self.def:setLvlDataInt('Idim', level, 1, value)
end

AbilityDefinitionEvilIllidanMetamorphosis = class('AbilityDefinitionEvilIllidanMetamorphosis', AbilityDefinition)
_G.AbilityDefinitionEvilIllidanMetamorphosis = AbilityDefinitionEvilIllidanMetamorphosis

function AbilityDefinitionEvilIllidanMetamorphosis:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEvi')
end

function AbilityDefinitionEvilIllidanMetamorphosis:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionEvilIllidanMetamorphosis:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionEvilIllidanMetamorphosis:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionEvilIllidanMetamorphosis:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionEvilIllidanMetamorphosis:setAlternateFormHitPointBonus(level, value)
    checktype(level, 'integer', 'setAlternateFormHitPointBonus', 1)
    checktype(value, 'float', 'setAlternateFormHitPointBonus', 2)
    self.def:setLvlDataUnreal('Eme5', level, 5, value)
end

function AbilityDefinitionEvilIllidanMetamorphosis:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionImpaleCreep = class('AbilityDefinitionImpaleCreep', AbilityDefinition)
_G.AbilityDefinitionImpaleCreep = AbilityDefinitionImpaleCreep

function AbilityDefinitionImpaleCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACmp')
end

function AbilityDefinitionImpaleCreep:setWaveTimeseconds(level, value)
    checktype(level, 'integer', 'setWaveTimeseconds', 1)
    checktype(value, 'float', 'setWaveTimeseconds', 2)
    self.def:setLvlDataUnreal('Uim2', level, 2, value)
end

function AbilityDefinitionImpaleCreep:setAirTimeseconds(level, value)
    checktype(level, 'integer', 'setAirTimeseconds', 1)
    checktype(value, 'float', 'setAirTimeseconds', 2)
    self.def:setLvlDataUnreal('Uim4', level, 4, value)
end

function AbilityDefinitionImpaleCreep:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Uim3', level, 3, value)
end

function AbilityDefinitionImpaleCreep:setWaveDistance(level, value)
    checktype(level, 'integer', 'setWaveDistance', 1)
    checktype(value, 'float', 'setWaveDistance', 2)
    self.def:setLvlDataUnreal('Uim1', level, 1, value)
end

AbilityDefinitionMonsooncreep = class('AbilityDefinitionMonsooncreep', AbilityDefinition)
_G.AbilityDefinitionMonsooncreep = AbilityDefinitionMonsooncreep

function AbilityDefinitionMonsooncreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACmo')
end

function AbilityDefinitionMonsooncreep:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Esf1', level, 1, value)
end

function AbilityDefinitionMonsooncreep:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Esf2', level, 2, value)
end

function AbilityDefinitionMonsooncreep:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Esf3', level, 3, value)
end

AbilityDefinitionDevourMagic = class('AbilityDefinitionDevourMagic', AbilityDefinition)
_G.AbilityDefinitionDevourMagic = AbilityDefinitionDevourMagic

function AbilityDefinitionDevourMagic:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Advm')
end

function AbilityDefinitionDevourMagic:setManaPerBuff(level, value)
    checktype(level, 'integer', 'setManaPerBuff', 1)
    checktype(value, 'float', 'setManaPerBuff', 2)
    self.def:setLvlDataUnreal('dvm4', level, 4, value)
end

function AbilityDefinitionDevourMagic:setLifePerUnit(level, value)
    checktype(level, 'integer', 'setLifePerUnit', 1)
    checktype(value, 'float', 'setLifePerUnit', 2)
    self.def:setLvlDataUnreal('dvm1', level, 1, value)
end

function AbilityDefinitionDevourMagic:setManaPerUnit(level, value)
    checktype(level, 'integer', 'setManaPerUnit', 1)
    checktype(value, 'float', 'setManaPerUnit', 2)
    self.def:setLvlDataUnreal('dvm2', level, 2, value)
end

function AbilityDefinitionDevourMagic:setIgnoreFriendlyBuffs(level, value)
    checktype(level, 'integer', 'setIgnoreFriendlyBuffs', 1)
    checktype(value, 'boolean', 'setIgnoreFriendlyBuffs', 2)
    self.def:setLvlDataBoolean('dvm6', level, 6, value)
end

function AbilityDefinitionDevourMagic:setLifePerBuff(level, value)
    checktype(level, 'integer', 'setLifePerBuff', 1)
    checktype(value, 'float', 'setLifePerBuff', 2)
    self.def:setLvlDataUnreal('dvm3', level, 3, value)
end

function AbilityDefinitionDevourMagic:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('dvm5', level, 5, value)
end

AbilityDefinitionEvasion = class('AbilityDefinitionEvasion', AbilityDefinition)
_G.AbilityDefinitionEvasion = AbilityDefinitionEvasion

function AbilityDefinitionEvasion:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACev')
end

function AbilityDefinitionEvasion:setChancetoEvade(level, value)
    checktype(level, 'integer', 'setChancetoEvade', 1)
    checktype(value, 'float', 'setChancetoEvade', 2)
    self.def:setLvlDataUnreal('Eev1', level, 1, value)
end

AbilityDefinitionCargoHoldDevour = class('AbilityDefinitionCargoHoldDevour', AbilityDefinition)
_G.AbilityDefinitionCargoHoldDevour = AbilityDefinitionCargoHoldDevour

function AbilityDefinitionCargoHoldDevour:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Advc')
end

function AbilityDefinitionCargoHoldDevour:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Dev2', level, 2, value)
end

function AbilityDefinitionCargoHoldDevour:setCargoCapacity(level, value)
    checktype(level, 'integer', 'setCargoCapacity', 1)
    checktype(value, 'integer', 'setCargoCapacity', 2)
    self.def:setLvlDataInt('Car1', level, 1, value)
end

function AbilityDefinitionCargoHoldDevour:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Dev3', level, 3, value)
end

AbilityDefinitionExperienceMod = class('AbilityDefinitionExperienceMod', AbilityDefinition)
_G.AbilityDefinitionExperienceMod = AbilityDefinitionExperienceMod

function AbilityDefinitionExperienceMod:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIem')
end

function AbilityDefinitionExperienceMod:setExperienceGained(level, value)
    checktype(level, 'integer', 'setExperienceGained', 1)
    checktype(value, 'integer', 'setExperienceGained', 2)
    self.def:setLvlDataInt('Ixpg', level, 1, value)
end

AbilityDefinitionCloudofFogItem = class('AbilityDefinitionCloudofFogItem', AbilityDefinition)
_G.AbilityDefinitionCloudofFogItem = AbilityDefinitionCloudofFogItem

function AbilityDefinitionCloudofFogItem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfg')
end

function AbilityDefinitionCloudofFogItem:setAttackSpeedModifier(level, value)
    checktype(level, 'integer', 'setAttackSpeedModifier', 1)
    checktype(value, 'float', 'setAttackSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi4', level, 4, value)
end

function AbilityDefinitionCloudofFogItem:setMovementSpeedModifier(level, value)
    checktype(level, 'integer', 'setMovementSpeedModifier', 1)
    checktype(value, 'float', 'setMovementSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi3', level, 3, value)
end

function AbilityDefinitionCloudofFogItem:setChanceToMiss(level, value)
    checktype(level, 'integer', 'setChanceToMiss', 1)
    checktype(value, 'float', 'setChanceToMiss', 2)
    self.def:setLvlDataUnreal('Nsi2', level, 2, value)
end

function AbilityDefinitionCloudofFogItem:setAttacksPrevented(level, value)
    checktype(level, 'integer', 'setAttacksPrevented', 1)
    checktype(value, 'integer', 'setAttacksPrevented', 2)
    self.def:setLvlDataInt('Nsi1', level, 1, value)
end

AbilityDefinitionDisenchantold = class('AbilityDefinitionDisenchantold', AbilityDefinition)
_G.AbilityDefinitionDisenchantold = AbilityDefinitionDisenchantold

function AbilityDefinitionDisenchantold:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adch')
end

function AbilityDefinitionDisenchantold:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'float', 'setManaLoss', 2)
    self.def:setLvlDataUnreal('Adm1', level, 1, value)
end

function AbilityDefinitionDisenchantold:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Adm2', level, 2, value)
end

AbilityDefinitionPillage = class('AbilityDefinitionPillage', AbilityDefinition)
_G.AbilityDefinitionPillage = AbilityDefinitionPillage

function AbilityDefinitionPillage:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asal')
end

function AbilityDefinitionPillage:setAccumulationStep(level, value)
    checktype(level, 'integer', 'setAccumulationStep', 1)
    checktype(value, 'integer', 'setAccumulationStep', 2)
    self.def:setLvlDataInt('Sal2', level, 2, value)
end

function AbilityDefinitionPillage:setSalvageCostRatio(level, value)
    checktype(level, 'integer', 'setSalvageCostRatio', 1)
    checktype(value, 'float', 'setSalvageCostRatio', 2)
    self.def:setLvlDataUnreal('Sal1', level, 1, value)
end

AbilityDefinitionInventoryPackMule = class('AbilityDefinitionInventoryPackMule', AbilityDefinition)
_G.AbilityDefinitionInventoryPackMule = AbilityDefinitionInventoryPackMule

function AbilityDefinitionInventoryPackMule:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apak')
end

function AbilityDefinitionInventoryPackMule:setCanDropItems(level, value)
    checktype(level, 'integer', 'setCanDropItems', 1)
    checktype(value, 'boolean', 'setCanDropItems', 2)
    self.def:setLvlDataBoolean('inv5', level, 5, value)
end

function AbilityDefinitionInventoryPackMule:setCanUseItems(level, value)
    checktype(level, 'integer', 'setCanUseItems', 1)
    checktype(value, 'boolean', 'setCanUseItems', 2)
    self.def:setLvlDataBoolean('inv3', level, 3, value)
end

function AbilityDefinitionInventoryPackMule:setDropItemsOnDeath(level, value)
    checktype(level, 'integer', 'setDropItemsOnDeath', 1)
    checktype(value, 'boolean', 'setDropItemsOnDeath', 2)
    self.def:setLvlDataBoolean('inv2', level, 2, value)
end

function AbilityDefinitionInventoryPackMule:setCanGetItems(level, value)
    checktype(level, 'integer', 'setCanGetItems', 1)
    checktype(value, 'boolean', 'setCanGetItems', 2)
    self.def:setLvlDataBoolean('inv4', level, 4, value)
end

function AbilityDefinitionInventoryPackMule:setItemCapacity(level, value)
    checktype(level, 'integer', 'setItemCapacity', 1)
    checktype(value, 'integer', 'setItemCapacity', 2)
    self.def:setLvlDataInt('inv1', level, 1, value)
end

AbilityDefinitionFigurineFurbolg = class('AbilityDefinitionFigurineFurbolg', AbilityDefinition)
_G.AbilityDefinitionFigurineFurbolg = AbilityDefinitionFigurineFurbolg

function AbilityDefinitionFigurineFurbolg:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIff')
end

function AbilityDefinitionFigurineFurbolg:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineFurbolg:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineFurbolg:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineFurbolg:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionFigurineFelHound = class('AbilityDefinitionFigurineFelHound', AbilityDefinition)
_G.AbilityDefinitionFigurineFelHound = AbilityDefinitionFigurineFelHound

function AbilityDefinitionFigurineFelHound:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfh')
end

function AbilityDefinitionFigurineFelHound:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineFelHound:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineFelHound:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineFelHound:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionFireDamageBonus = class('AbilityDefinitionFireDamageBonus', AbilityDefinition)
_G.AbilityDefinitionFireDamageBonus = AbilityDefinitionFireDamageBonus

function AbilityDefinitionFireDamageBonus:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfb')
end

function AbilityDefinitionFireDamageBonus:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionFireDamageBonus:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

AbilityDefinitionDetectMagicSentinel = class('AbilityDefinitionDetectMagicSentinel', AbilityDefinition)
_G.AbilityDefinitionDetectMagicSentinel = AbilityDefinitionDetectMagicSentinel

function AbilityDefinitionDetectMagicSentinel:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adts')
end

function AbilityDefinitionDetectMagicSentinel:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionFirelordVolcano = class('AbilityDefinitionFirelordVolcano', AbilityDefinition)
_G.AbilityDefinitionFirelordVolcano = AbilityDefinitionFirelordVolcano

function AbilityDefinitionFirelordVolcano:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANvc')
end

function AbilityDefinitionFirelordVolcano:setDestructibleID(level, value)
    checktype(level, 'integer', 'setDestructibleID', 1)
    checktype(value, 'string', 'setDestructibleID', 2)
    self.def:setLvlDataString('Nvcu', level, 0, value)
end

function AbilityDefinitionFirelordVolcano:setBuildingDamageFactor(level, value)
    checktype(level, 'integer', 'setBuildingDamageFactor', 1)
    checktype(value, 'float', 'setBuildingDamageFactor', 2)
    self.def:setLvlDataUnreal('Nvc4', level, 4, value)
end

function AbilityDefinitionFirelordVolcano:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('Nvc5', level, 5, value)
end

function AbilityDefinitionFirelordVolcano:setRockRingCount(level, value)
    checktype(level, 'integer', 'setRockRingCount', 1)
    checktype(value, 'integer', 'setRockRingCount', 2)
    self.def:setLvlDataInt('Nvc1', level, 1, value)
end

function AbilityDefinitionFirelordVolcano:setWaveInterval(level, value)
    checktype(level, 'integer', 'setWaveInterval', 1)
    checktype(value, 'float', 'setWaveInterval', 2)
    self.def:setLvlDataUnreal('Nvc3', level, 3, value)
end

function AbilityDefinitionFirelordVolcano:setHalfDamageFactor(level, value)
    checktype(level, 'integer', 'setHalfDamageFactor', 1)
    checktype(value, 'float', 'setHalfDamageFactor', 2)
    self.def:setLvlDataUnreal('Nvc6', level, 6, value)
end

function AbilityDefinitionFirelordVolcano:setWaveCount(level, value)
    checktype(level, 'integer', 'setWaveCount', 1)
    checktype(value, 'integer', 'setWaveCount', 2)
    self.def:setLvlDataInt('Nvc2', level, 2, value)
end

AbilityDefinitionFigurineRedDrake = class('AbilityDefinitionFigurineRedDrake', AbilityDefinition)
_G.AbilityDefinitionFigurineRedDrake = AbilityDefinitionFigurineRedDrake

function AbilityDefinitionFigurineRedDrake:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfd')
end

function AbilityDefinitionFigurineRedDrake:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineRedDrake:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineRedDrake:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineRedDrake:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionHealingWard = class('AbilityDefinitionHealingWard', AbilityDefinition)
_G.AbilityDefinitionHealingWard = AbilityDefinitionHealingWard

function AbilityDefinitionHealingWard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahwd')
end

function AbilityDefinitionHealingWard:setWardUnitType(level, value)
    checktype(level, 'integer', 'setWardUnitType', 1)
    checktype(value, 'string', 'setWardUnitType', 2)
    self.def:setLvlDataString('hwdu', level, 0, value)
end

AbilityDefinitionFlareGun = class('AbilityDefinitionFlareGun', AbilityDefinition)
_G.AbilityDefinitionFlareGun = AbilityDefinitionFlareGun

function AbilityDefinitionFlareGun:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfa')
end

function AbilityDefinitionFlareGun:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Ifa1', level, 1, value)
end

function AbilityDefinitionFlareGun:setDelayForTargetEffect(level, value)
    checktype(level, 'integer', 'setDelayForTargetEffect', 1)
    checktype(value, 'float', 'setDelayForTargetEffect', 2)
    self.def:setLvlDataUnreal('Idel', level, 2, value)
end

AbilityDefinitionLoadEntangledGoldMine = class('AbilityDefinitionLoadEntangledGoldMine', AbilityDefinition)
_G.AbilityDefinitionLoadEntangledGoldMine = AbilityDefinitionLoadEntangledGoldMine

function AbilityDefinitionLoadEntangledGoldMine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Slo2')
end

function AbilityDefinitionLoadEntangledGoldMine:setAllowedUnitType(level, value)
    checktype(level, 'integer', 'setAllowedUnitType', 1)
    checktype(value, 'string', 'setAllowedUnitType', 2)
    self.def:setLvlDataString('Loa1', level, 0, value)
end

AbilityDefinitionNeutralRegenhealthonly = class('AbilityDefinitionNeutralRegenhealthonly', AbilityDefinition)
_G.AbilityDefinitionNeutralRegenhealthonly = AbilityDefinitionNeutralRegenhealthonly

function AbilityDefinitionNeutralRegenhealthonly:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACnr')
end

function AbilityDefinitionNeutralRegenhealthonly:setPercentage(level, value)
    checktype(level, 'integer', 'setPercentage', 1)
    checktype(value, 'boolean', 'setPercentage', 2)
    self.def:setLvlDataBoolean('Oar2', level, 2, value)
end

function AbilityDefinitionNeutralRegenhealthonly:setAmountofHitPointsRegenerated(level, value)
    checktype(level, 'integer', 'setAmountofHitPointsRegenerated', 1)
    checktype(value, 'float', 'setAmountofHitPointsRegenerated', 2)
    self.def:setLvlDataUnreal('Oar1', level, 1, value)
end

AbilityDefinitionAuraRegenerationHealingWard = class('AbilityDefinitionAuraRegenerationHealingWard', AbilityDefinition)
_G.AbilityDefinitionAuraRegenerationHealingWard = AbilityDefinitionAuraRegenerationHealingWard

function AbilityDefinitionAuraRegenerationHealingWard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aoar')
end

function AbilityDefinitionAuraRegenerationHealingWard:setPercentage(level, value)
    checktype(level, 'integer', 'setPercentage', 1)
    checktype(value, 'boolean', 'setPercentage', 2)
    self.def:setLvlDataBoolean('Oar2', level, 2, value)
end

function AbilityDefinitionAuraRegenerationHealingWard:setAmountofHitPointsRegenerated(level, value)
    checktype(level, 'integer', 'setAmountofHitPointsRegenerated', 1)
    checktype(value, 'float', 'setAmountofHitPointsRegenerated', 2)
    self.def:setLvlDataUnreal('Oar1', level, 1, value)
end

AbilityDefinitionLoadNavies = class('AbilityDefinitionLoadNavies', AbilityDefinition)
_G.AbilityDefinitionLoadNavies = AbilityDefinitionLoadNavies

function AbilityDefinitionLoadNavies:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Slo3')
end

function AbilityDefinitionLoadNavies:setAllowedUnitType(level, value)
    checktype(level, 'integer', 'setAllowedUnitType', 1)
    checktype(value, 'string', 'setAllowedUnitType', 2)
    self.def:setLvlDataString('Loa1', level, 0, value)
end

AbilityDefinitionInvisibility = class('AbilityDefinitionInvisibility', AbilityDefinition)
_G.AbilityDefinitionInvisibility = AbilityDefinitionInvisibility

function AbilityDefinitionInvisibility:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aivs')
end

function AbilityDefinitionInvisibility:setTransitionTimeseconds(level, value)
    checktype(level, 'integer', 'setTransitionTimeseconds', 1)
    checktype(value, 'float', 'setTransitionTimeseconds', 2)
    self.def:setLvlDataUnreal('Ivs1', level, 1, value)
end

AbilityDefinitionSentryWard = class('AbilityDefinitionSentryWard', AbilityDefinition)
_G.AbilityDefinitionSentryWard = AbilityDefinitionSentryWard

function AbilityDefinitionSentryWard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aeye')
end

function AbilityDefinitionSentryWard:setWardUnitType(level, value)
    checktype(level, 'integer', 'setWardUnitType', 1)
    checktype(value, 'string', 'setWardUnitType', 2)
    self.def:setLvlDataString('hwdu', level, 0, value)
end

AbilityDefinitionFigurineRockGolem = class('AbilityDefinitionFigurineRockGolem', AbilityDefinition)
_G.AbilityDefinitionFigurineRockGolem = AbilityDefinitionFigurineRockGolem

function AbilityDefinitionFigurineRockGolem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfr')
end

function AbilityDefinitionFigurineRockGolem:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineRockGolem:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineRockGolem:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineRockGolem:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionFigurineSkeleton = class('AbilityDefinitionFigurineSkeleton', AbilityDefinition)
_G.AbilityDefinitionFigurineSkeleton = AbilityDefinitionFigurineSkeleton

function AbilityDefinitionFigurineSkeleton:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfs')
end

function AbilityDefinitionFigurineSkeleton:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineSkeleton:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineSkeleton:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineSkeleton:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionSubmergeMyrmidon = class('AbilityDefinitionSubmergeMyrmidon', AbilityDefinition)
_G.AbilityDefinitionSubmergeMyrmidon = AbilityDefinitionSubmergeMyrmidon

function AbilityDefinitionSubmergeMyrmidon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asb1')
end

function AbilityDefinitionSubmergeMyrmidon:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionSubmergeMyrmidon:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionSubmergeMyrmidon:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionSubmergeMyrmidon:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionSubmergeRoyalGuard = class('AbilityDefinitionSubmergeRoyalGuard', AbilityDefinition)
_G.AbilityDefinitionSubmergeRoyalGuard = AbilityDefinitionSubmergeRoyalGuard

function AbilityDefinitionSubmergeRoyalGuard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asb2')
end

function AbilityDefinitionSubmergeRoyalGuard:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionSubmergeRoyalGuard:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionSubmergeRoyalGuard:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionSubmergeRoyalGuard:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionFigurineDoomGuard = class('AbilityDefinitionFigurineDoomGuard', AbilityDefinition)
_G.AbilityDefinitionFigurineDoomGuard = AbilityDefinitionFigurineDoomGuard

function AbilityDefinitionFigurineDoomGuard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIfu')
end

function AbilityDefinitionFigurineDoomGuard:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineDoomGuard:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineDoomGuard:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineDoomGuard:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionSubmergeSnapDragon = class('AbilityDefinitionSubmergeSnapDragon', AbilityDefinition)
_G.AbilityDefinitionSubmergeSnapDragon = AbilityDefinitionSubmergeSnapDragon

function AbilityDefinitionSubmergeSnapDragon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asb3')
end

function AbilityDefinitionSubmergeSnapDragon:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionSubmergeSnapDragon:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionSubmergeSnapDragon:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionSubmergeSnapDragon:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionItemHealLesser = class('AbilityDefinitionItemHealLesser', AbilityDefinition)
_G.AbilityDefinitionItemHealLesser = AbilityDefinitionItemHealLesser

function AbilityDefinitionItemHealLesser:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIh1')
end

function AbilityDefinitionItemHealLesser:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihpg', level, 1, value)
end

AbilityDefinitionItemHealGreater = class('AbilityDefinitionItemHealGreater', AbilityDefinition)
_G.AbilityDefinitionItemHealGreater = AbilityDefinitionItemHealGreater

function AbilityDefinitionItemHealGreater:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIh2')
end

function AbilityDefinitionItemHealGreater:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihpg', level, 1, value)
end

AbilityDefinitionItemHealLeast = class('AbilityDefinitionItemHealLeast', AbilityDefinition)
_G.AbilityDefinitionItemHealLeast = AbilityDefinitionItemHealLeast

function AbilityDefinitionItemHealLeast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIh3')
end

function AbilityDefinitionItemHealLeast:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihpg', level, 1, value)
end

AbilityDefinitionGiveGold = class('AbilityDefinitionGiveGold', AbilityDefinition)
_G.AbilityDefinitionGiveGold = AbilityDefinitionGiveGold

function AbilityDefinitionGiveGold:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIgo')
end

function AbilityDefinitionGiveGold:setGoldGiven(level, value)
    checktype(level, 'integer', 'setGoldGiven', 1)
    checktype(value, 'integer', 'setGoldGiven', 2)
    self.def:setLvlDataInt('Igol', level, 1, value)
end

AbilityDefinitionIntelligenceBonusPlus1 = class('AbilityDefinitionIntelligenceBonusPlus1', AbilityDefinition)
_G.AbilityDefinitionIntelligenceBonusPlus1 = AbilityDefinitionIntelligenceBonusPlus1

function AbilityDefinitionIntelligenceBonusPlus1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIi1')
end

function AbilityDefinitionIntelligenceBonusPlus1:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionIntelligenceBonusPlus1:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionIntelligenceBonusPlus1:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionIntelligenceBonusPlus1:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionBurrowscarablvl2 = class('AbilityDefinitionBurrowscarablvl2', AbilityDefinition)
_G.AbilityDefinitionBurrowscarablvl2 = AbilityDefinitionBurrowscarablvl2

function AbilityDefinitionBurrowscarablvl2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abu2')
end

function AbilityDefinitionBurrowscarablvl2:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionBurrowscarablvl2:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionBurrowscarablvl2:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionBurrowscarablvl2:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionBurrowscarablvl2:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionIntelligenceBonusPlus4 = class('AbilityDefinitionIntelligenceBonusPlus4', AbilityDefinition)
_G.AbilityDefinitionIntelligenceBonusPlus4 = AbilityDefinitionIntelligenceBonusPlus4

function AbilityDefinitionIntelligenceBonusPlus4:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIi4')
end

function AbilityDefinitionIntelligenceBonusPlus4:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionIntelligenceBonusPlus4:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionIntelligenceBonusPlus4:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionIntelligenceBonusPlus4:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionFirelordSummonLavaSpawn = class('AbilityDefinitionFirelordSummonLavaSpawn', AbilityDefinition)
_G.AbilityDefinitionFirelordSummonLavaSpawn = AbilityDefinitionFirelordSummonLavaSpawn

function AbilityDefinitionFirelordSummonLavaSpawn:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANlm')
end

function AbilityDefinitionFirelordSummonLavaSpawn:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionFirelordSummonLavaSpawn:setLifeDurationSplitBonus(level, value)
    checktype(level, 'integer', 'setLifeDurationSplitBonus', 1)
    checktype(value, 'float', 'setLifeDurationSplitBonus', 2)
    self.def:setLvlDataUnreal('Nlm5', level, 5, value)
end

function AbilityDefinitionFirelordSummonLavaSpawn:setMaxHitpointFactor(level, value)
    checktype(level, 'integer', 'setMaxHitpointFactor', 1)
    checktype(value, 'float', 'setMaxHitpointFactor', 2)
    self.def:setLvlDataUnreal('Nlm4', level, 4, value)
end

function AbilityDefinitionFirelordSummonLavaSpawn:setGenerationCount(level, value)
    checktype(level, 'integer', 'setGenerationCount', 1)
    checktype(value, 'integer', 'setGenerationCount', 2)
    self.def:setLvlDataInt('Nlm6', level, 6, value)
end

function AbilityDefinitionFirelordSummonLavaSpawn:setSplitDelay(level, value)
    checktype(level, 'integer', 'setSplitDelay', 1)
    checktype(value, 'float', 'setSplitDelay', 2)
    self.def:setLvlDataUnreal('Nlm2', level, 2, value)
end

function AbilityDefinitionFirelordSummonLavaSpawn:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

function AbilityDefinitionFirelordSummonLavaSpawn:setSplitAttackCount(level, value)
    checktype(level, 'integer', 'setSplitAttackCount', 1)
    checktype(value, 'integer', 'setSplitAttackCount', 2)
    self.def:setLvlDataInt('Nlm3', level, 3, value)
end

AbilityDefinitionBurrowscarablvl3 = class('AbilityDefinitionBurrowscarablvl3', AbilityDefinition)
_G.AbilityDefinitionBurrowscarablvl3 = AbilityDefinitionBurrowscarablvl3

function AbilityDefinitionBurrowscarablvl3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abu3')
end

function AbilityDefinitionBurrowscarablvl3:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionBurrowscarablvl3:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionBurrowscarablvl3:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionBurrowscarablvl3:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionBurrowscarablvl3:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionHeal = class('AbilityDefinitionHeal', AbilityDefinition)
_G.AbilityDefinitionHeal = AbilityDefinitionHeal

function AbilityDefinitionHeal:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahea')
end

function AbilityDefinitionHeal:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Hea1', level, 1, value)
end

AbilityDefinitionIntelligenceBonusPlus3 = class('AbilityDefinitionIntelligenceBonusPlus3', AbilityDefinition)
_G.AbilityDefinitionIntelligenceBonusPlus3 = AbilityDefinitionIntelligenceBonusPlus3

function AbilityDefinitionIntelligenceBonusPlus3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIi3')
end

function AbilityDefinitionIntelligenceBonusPlus3:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionIntelligenceBonusPlus3:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionIntelligenceBonusPlus3:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionIntelligenceBonusPlus3:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionIntelligenceBonusPlus6 = class('AbilityDefinitionIntelligenceBonusPlus6', AbilityDefinition)
_G.AbilityDefinitionIntelligenceBonusPlus6 = AbilityDefinitionIntelligenceBonusPlus6

function AbilityDefinitionIntelligenceBonusPlus6:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIi6')
end

function AbilityDefinitionIntelligenceBonusPlus6:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionIntelligenceBonusPlus6:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionIntelligenceBonusPlus6:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionIntelligenceBonusPlus6:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionBeserk = class('AbilityDefinitionBeserk', AbilityDefinition)
_G.AbilityDefinitionBeserk = AbilityDefinitionBeserk

function AbilityDefinitionBeserk:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Absk')
end

function AbilityDefinitionBeserk:setDamageTakenIncrease(level, value)
    checktype(level, 'integer', 'setDamageTakenIncrease', 1)
    checktype(value, 'float', 'setDamageTakenIncrease', 2)
    self.def:setLvlDataUnreal('bsk3', level, 3, value)
end

function AbilityDefinitionBeserk:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('bsk1', level, 1, value)
end

function AbilityDefinitionBeserk:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('bsk2', level, 2, value)
end

AbilityDefinitionReplenishLifeMana = class('AbilityDefinitionReplenishLifeMana', AbilityDefinition)
_G.AbilityDefinitionReplenishLifeMana = AbilityDefinitionReplenishLifeMana

function AbilityDefinitionReplenishLifeMana:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arpb')
end

function AbilityDefinitionReplenishLifeMana:setMinimumManaRequired(level, value)
    checktype(level, 'integer', 'setMinimumManaRequired', 1)
    checktype(value, 'float', 'setMinimumManaRequired', 2)
    self.def:setLvlDataUnreal('Rpb4', level, 4, value)
end

function AbilityDefinitionReplenishLifeMana:setMaximumUnitsChargedToCaster(level, value)
    checktype(level, 'integer', 'setMaximumUnitsChargedToCaster', 1)
    checktype(value, 'integer', 'setMaximumUnitsChargedToCaster', 2)
    self.def:setLvlDataInt('Rpb5', level, 5, value)
end

function AbilityDefinitionReplenishLifeMana:setMinimumLifeRequired(level, value)
    checktype(level, 'integer', 'setMinimumLifeRequired', 1)
    checktype(value, 'float', 'setMinimumLifeRequired', 2)
    self.def:setLvlDataUnreal('Rpb3', level, 3, value)
end

function AbilityDefinitionReplenishLifeMana:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'float', 'setManaPointsGained', 2)
    self.def:setLvlDataUnreal('Rej2', level, 2, value)
end

function AbilityDefinitionReplenishLifeMana:setMaximumUnitsAffected(level, value)
    checktype(level, 'integer', 'setMaximumUnitsAffected', 1)
    checktype(value, 'integer', 'setMaximumUnitsAffected', 2)
    self.def:setLvlDataInt('Rpb6', level, 0, value)
end

function AbilityDefinitionReplenishLifeMana:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Rej1', level, 1, value)
end

AbilityDefinitionUltraVisionGlyph = class('AbilityDefinitionUltraVisionGlyph', AbilityDefinition)
_G.AbilityDefinitionUltraVisionGlyph = AbilityDefinitionUltraVisionGlyph

function AbilityDefinitionUltraVisionGlyph:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIgu')
end

function AbilityDefinitionUltraVisionGlyph:setUpgradeLevels(level, value)
    checktype(level, 'integer', 'setUpgradeLevels', 1)
    checktype(value, 'integer', 'setUpgradeLevels', 2)
    self.def:setLvlDataInt('Igl1', level, 1, value)
end

function AbilityDefinitionUltraVisionGlyph:setUpgradeType(level, value)
    checktype(level, 'integer', 'setUpgradeType', 1)
    checktype(value, 'string', 'setUpgradeType', 2)
    self.def:setLvlDataString('Iglu', level, 0, value)
end

AbilityDefinitionReplenishLife = class('AbilityDefinitionReplenishLife', AbilityDefinition)
_G.AbilityDefinitionReplenishLife = AbilityDefinitionReplenishLife

function AbilityDefinitionReplenishLife:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arpl')
end

function AbilityDefinitionReplenishLife:setMinimumLifeRequired(level, value)
    checktype(level, 'integer', 'setMinimumLifeRequired', 1)
    checktype(value, 'float', 'setMinimumLifeRequired', 2)
    self.def:setLvlDataUnreal('Rpb3', level, 3, value)
end

function AbilityDefinitionReplenishLife:setMaximumUnitsChargedToCaster(level, value)
    checktype(level, 'integer', 'setMaximumUnitsChargedToCaster', 1)
    checktype(value, 'integer', 'setMaximumUnitsChargedToCaster', 2)
    self.def:setLvlDataInt('Rpb5', level, 5, value)
end

function AbilityDefinitionReplenishLife:setMaximumUnitsAffected(level, value)
    checktype(level, 'integer', 'setMaximumUnitsAffected', 1)
    checktype(value, 'integer', 'setMaximumUnitsAffected', 2)
    self.def:setLvlDataInt('Rpb6', level, 0, value)
end

function AbilityDefinitionReplenishLife:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Rej1', level, 1, value)
end

AbilityDefinitionInventory2slotunitUndead = class('AbilityDefinitionInventory2slotunitUndead', AbilityDefinition)
_G.AbilityDefinitionInventory2slotunitUndead = AbilityDefinitionInventory2slotunitUndead

function AbilityDefinitionInventory2slotunitUndead:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aiun')
end

function AbilityDefinitionInventory2slotunitUndead:setCanDropItems(level, value)
    checktype(level, 'integer', 'setCanDropItems', 1)
    checktype(value, 'boolean', 'setCanDropItems', 2)
    self.def:setLvlDataBoolean('inv5', level, 5, value)
end

function AbilityDefinitionInventory2slotunitUndead:setCanUseItems(level, value)
    checktype(level, 'integer', 'setCanUseItems', 1)
    checktype(value, 'boolean', 'setCanUseItems', 2)
    self.def:setLvlDataBoolean('inv3', level, 3, value)
end

function AbilityDefinitionInventory2slotunitUndead:setDropItemsOnDeath(level, value)
    checktype(level, 'integer', 'setDropItemsOnDeath', 1)
    checktype(value, 'boolean', 'setDropItemsOnDeath', 2)
    self.def:setLvlDataBoolean('inv2', level, 2, value)
end

function AbilityDefinitionInventory2slotunitUndead:setCanGetItems(level, value)
    checktype(level, 'integer', 'setCanGetItems', 1)
    checktype(value, 'boolean', 'setCanGetItems', 2)
    self.def:setLvlDataBoolean('inv4', level, 4, value)
end

function AbilityDefinitionInventory2slotunitUndead:setItemCapacity(level, value)
    checktype(level, 'integer', 'setItemCapacity', 1)
    checktype(value, 'integer', 'setItemCapacity', 2)
    self.def:setLvlDataInt('inv1', level, 1, value)
end

AbilityDefinitionManaBattery = class('AbilityDefinitionManaBattery', AbilityDefinition)
_G.AbilityDefinitionManaBattery = AbilityDefinitionManaBattery

function AbilityDefinitionManaBattery:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ambt')
end

function AbilityDefinitionManaBattery:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Mbt2', level, 2, value)
end

function AbilityDefinitionManaBattery:setWaterHeight(level, value)
    checktype(level, 'integer', 'setWaterHeight', 1)
    checktype(value, 'float', 'setWaterHeight', 2)
    self.def:setLvlDataUnreal('Mbt4', level, 4, value)
end

function AbilityDefinitionManaBattery:setAutocastRequirement(level, value)
    checktype(level, 'integer', 'setAutocastRequirement', 1)
    checktype(value, 'float', 'setAutocastRequirement', 2)
    self.def:setLvlDataUnreal('Mbt3', level, 3, value)
end

function AbilityDefinitionManaBattery:setManaGained(level, value)
    checktype(level, 'integer', 'setManaGained', 1)
    checktype(value, 'float', 'setManaGained', 2)
    self.def:setLvlDataUnreal('Mbt1', level, 1, value)
end

function AbilityDefinitionManaBattery:setRegenerateOnlyAtNight(level, value)
    checktype(level, 'integer', 'setRegenerateOnlyAtNight', 1)
    checktype(value, 'boolean', 'setRegenerateOnlyAtNight', 2)
    self.def:setLvlDataBoolean('Mbt5', level, 5, value)
end

AbilityDefinitionReplenishMana = class('AbilityDefinitionReplenishMana', AbilityDefinition)
_G.AbilityDefinitionReplenishMana = AbilityDefinitionReplenishMana

function AbilityDefinitionReplenishMana:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arpm')
end

function AbilityDefinitionReplenishMana:setMinimumManaRequired(level, value)
    checktype(level, 'integer', 'setMinimumManaRequired', 1)
    checktype(value, 'float', 'setMinimumManaRequired', 2)
    self.def:setLvlDataUnreal('Rpb4', level, 4, value)
end

function AbilityDefinitionReplenishMana:setMaximumUnitsChargedToCaster(level, value)
    checktype(level, 'integer', 'setMaximumUnitsChargedToCaster', 1)
    checktype(value, 'integer', 'setMaximumUnitsChargedToCaster', 2)
    self.def:setLvlDataInt('Rpb5', level, 5, value)
end

function AbilityDefinitionReplenishMana:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'float', 'setManaPointsGained', 2)
    self.def:setLvlDataUnreal('Rej2', level, 2, value)
end

function AbilityDefinitionReplenishMana:setMaximumUnitsAffected(level, value)
    checktype(level, 'integer', 'setMaximumUnitsAffected', 1)
    checktype(value, 'integer', 'setMaximumUnitsAffected', 2)
    self.def:setLvlDataInt('Rpb6', level, 0, value)
end

AbilityDefinitionHealCreepNormal = class('AbilityDefinitionHealCreepNormal', AbilityDefinition)
_G.AbilityDefinitionHealCreepNormal = AbilityDefinitionHealCreepNormal

function AbilityDefinitionHealCreepNormal:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Anh1')
end

function AbilityDefinitionHealCreepNormal:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Hea1', level, 1, value)
end

AbilityDefinitionHealCreepHigh = class('AbilityDefinitionHealCreepHigh', AbilityDefinition)
_G.AbilityDefinitionHealCreepHigh = AbilityDefinitionHealCreepHigh

function AbilityDefinitionHealCreepHigh:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Anh2')
end

function AbilityDefinitionHealCreepHigh:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Hea1', level, 1, value)
end

AbilityDefinitionAuraSlow = class('AbilityDefinitionAuraSlow', AbilityDefinition)
_G.AbilityDefinitionAuraSlow = AbilityDefinitionAuraSlow

function AbilityDefinitionAuraSlow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aasl')
end

function AbilityDefinitionAuraSlow:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo1', level, 1, value)
end

function AbilityDefinitionAuraSlow:setAlwaysAutocast(level, value)
    checktype(level, 'integer', 'setAlwaysAutocast', 1)
    checktype(value, 'boolean', 'setAlwaysAutocast', 2)
    self.def:setLvlDataBoolean('Slo3', level, 3, value)
end

function AbilityDefinitionAuraSlow:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo2', level, 2, value)
end

AbilityDefinitionCurse = class('AbilityDefinitionCurse', AbilityDefinition)
_G.AbilityDefinitionCurse = AbilityDefinitionCurse

function AbilityDefinitionCurse:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acrs')
end

function AbilityDefinitionCurse:setChancetoMiss(level, value)
    checktype(level, 'integer', 'setChancetoMiss', 1)
    checktype(value, 'float', 'setChancetoMiss', 2)
    self.def:setLvlDataUnreal('Crs', level, 1, value)
end

AbilityDefinitionSuperEarthquake = class('AbilityDefinitionSuperEarthquake', AbilityDefinition)
_G.AbilityDefinitionSuperEarthquake = AbilityDefinitionSuperEarthquake

function AbilityDefinitionSuperEarthquake:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'SNeq')
end

function AbilityDefinitionSuperEarthquake:setUnitsSlowed(level, value)
    checktype(level, 'integer', 'setUnitsSlowed', 1)
    checktype(value, 'float', 'setUnitsSlowed', 2)
    self.def:setLvlDataUnreal('Oeq3', level, 3, value)
end

function AbilityDefinitionSuperEarthquake:setEffectDelay(level, value)
    checktype(level, 'integer', 'setEffectDelay', 1)
    checktype(value, 'float', 'setEffectDelay', 2)
    self.def:setLvlDataUnreal('Oeq1', level, 1, value)
end

function AbilityDefinitionSuperEarthquake:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Oeq4', level, 4, value)
end

function AbilityDefinitionSuperEarthquake:setDamageperSecondtoBuildings(level, value)
    checktype(level, 'integer', 'setDamageperSecondtoBuildings', 1)
    checktype(value, 'float', 'setDamageperSecondtoBuildings', 2)
    self.def:setLvlDataUnreal('Oeq2', level, 2, value)
end

AbilityDefinitionFortificationGlyph = class('AbilityDefinitionFortificationGlyph', AbilityDefinition)
_G.AbilityDefinitionFortificationGlyph = AbilityDefinitionFortificationGlyph

function AbilityDefinitionFortificationGlyph:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIgf')
end

function AbilityDefinitionFortificationGlyph:setUpgradeLevels(level, value)
    checktype(level, 'integer', 'setUpgradeLevels', 1)
    checktype(value, 'integer', 'setUpgradeLevels', 2)
    self.def:setLvlDataInt('Igl1', level, 1, value)
end

function AbilityDefinitionFortificationGlyph:setUpgradeType(level, value)
    checktype(level, 'integer', 'setUpgradeType', 1)
    checktype(value, 'string', 'setUpgradeType', 2)
    self.def:setLvlDataString('Iglu', level, 0, value)
end

AbilityDefinitionManaBurndemonAmbd = class('AbilityDefinitionManaBurndemonAmbd', AbilityDefinition)
_G.AbilityDefinitionManaBurndemonAmbd = AbilityDefinitionManaBurndemonAmbd

function AbilityDefinitionManaBurndemonAmbd:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ambd')
end

function AbilityDefinitionManaBurndemonAmbd:setMaxManaDrained(level, value)
    checktype(level, 'integer', 'setMaxManaDrained', 1)
    checktype(value, 'float', 'setMaxManaDrained', 2)
    self.def:setLvlDataUnreal('Emb1', level, 1, value)
end

function AbilityDefinitionManaBurndemonAmbd:setBoltLifetime(level, value)
    checktype(level, 'integer', 'setBoltLifetime', 1)
    checktype(value, 'float', 'setBoltLifetime', 2)
    self.def:setLvlDataUnreal('Emb3', level, 3, value)
end

function AbilityDefinitionManaBurndemonAmbd:setBoltDelay(level, value)
    checktype(level, 'integer', 'setBoltDelay', 1)
    checktype(value, 'float', 'setBoltDelay', 2)
    self.def:setLvlDataUnreal('Emb2', level, 2, value)
end

AbilityDefinitionFarseerFarSight = class('AbilityDefinitionFarseerFarSight', AbilityDefinition)
_G.AbilityDefinitionFarseerFarSight = AbilityDefinitionFarseerFarSight

function AbilityDefinitionFarseerFarSight:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOfs')
end

function AbilityDefinitionFarseerFarSight:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Ofs1', level, 1, value)
end

AbilityDefinitionAgilityModPlus2 = class('AbilityDefinitionAgilityModPlus2', AbilityDefinition)
_G.AbilityDefinitionAgilityModPlus2 = AbilityDefinitionAgilityModPlus2

function AbilityDefinitionAgilityModPlus2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIgm')
end

function AbilityDefinitionAgilityModPlus2:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAgilityModPlus2:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAgilityModPlus2:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAgilityModPlus2:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionHarvestLumberArchimondeghouls = class('AbilityDefinitionHarvestLumberArchimondeghouls', AbilityDefinition)
_G.AbilityDefinitionHarvestLumberArchimondeghouls = AbilityDefinitionHarvestLumberArchimondeghouls

function AbilityDefinitionHarvestLumberArchimondeghouls:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahr2')
end

function AbilityDefinitionHarvestLumberArchimondeghouls:setLumberCapacity(level, value)
    checktype(level, 'integer', 'setLumberCapacity', 1)
    checktype(value, 'integer', 'setLumberCapacity', 2)
    self.def:setLvlDataInt('Har2', level, 2, value)
end

function AbilityDefinitionHarvestLumberArchimondeghouls:setDamagetoTree(level, value)
    checktype(level, 'integer', 'setDamagetoTree', 1)
    checktype(value, 'integer', 'setDamagetoTree', 2)
    self.def:setLvlDataInt('Har1', level, 1, value)
end

AbilityDefinitionHealingWardAIhw = class('AbilityDefinitionHealingWardAIhw', AbilityDefinition)
_G.AbilityDefinitionHealingWardAIhw = AbilityDefinitionHealingWardAIhw

function AbilityDefinitionHealingWardAIhw:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIhw')
end

function AbilityDefinitionHealingWardAIhw:setWardUnitType(level, value)
    checktype(level, 'integer', 'setWardUnitType', 1)
    checktype(value, 'string', 'setWardUnitType', 2)
    self.def:setLvlDataString('hwdu', level, 0, value)
end

AbilityDefinitionIllidanMetamorphosis = class('AbilityDefinitionIllidanMetamorphosis', AbilityDefinition)
_G.AbilityDefinitionIllidanMetamorphosis = AbilityDefinitionIllidanMetamorphosis

function AbilityDefinitionIllidanMetamorphosis:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEIl')
end

function AbilityDefinitionIllidanMetamorphosis:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionIllidanMetamorphosis:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionIllidanMetamorphosis:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionIllidanMetamorphosis:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionIllidanMetamorphosis:setAlternateFormHitPointBonus(level, value)
    checktype(level, 'integer', 'setAlternateFormHitPointBonus', 1)
    checktype(value, 'float', 'setAlternateFormHitPointBonus', 2)
    self.def:setLvlDataUnreal('Eme5', level, 5, value)
end

function AbilityDefinitionIllidanMetamorphosis:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionHexCreep = class('AbilityDefinitionHexCreep', AbilityDefinition)
_G.AbilityDefinitionHexCreep = AbilityDefinitionHexCreep

function AbilityDefinitionHexCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AChx')
end

function AbilityDefinitionHexCreep:setMorphUnitsGround(level, value)
    checktype(level, 'integer', 'setMorphUnitsGround', 1)
    checktype(value, 'string', 'setMorphUnitsGround', 2)
    self.def:setLvlDataString('Ply2', level, 2, value)
end

function AbilityDefinitionHexCreep:setMorphUnitsWater(level, value)
    checktype(level, 'integer', 'setMorphUnitsWater', 1)
    checktype(value, 'string', 'setMorphUnitsWater', 2)
    self.def:setLvlDataString('Ply5', level, 5, value)
end

function AbilityDefinitionHexCreep:setMorphUnitsAmphibious(level, value)
    checktype(level, 'integer', 'setMorphUnitsAmphibious', 1)
    checktype(value, 'string', 'setMorphUnitsAmphibious', 2)
    self.def:setLvlDataString('Ply4', level, 4, value)
end

function AbilityDefinitionHexCreep:setMorphUnitsAir(level, value)
    checktype(level, 'integer', 'setMorphUnitsAir', 1)
    checktype(value, 'string', 'setMorphUnitsAir', 2)
    self.def:setLvlDataString('Ply3', level, 3, value)
end

function AbilityDefinitionHexCreep:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Ply1', level, 1, value)
end

AbilityDefinitionHealingWardcreep = class('AbilityDefinitionHealingWardcreep', AbilityDefinition)
_G.AbilityDefinitionHealingWardcreep = AbilityDefinitionHealingWardcreep

function AbilityDefinitionHealingWardcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AChw')
end

function AbilityDefinitionHealingWardcreep:setWardUnitType(level, value)
    checktype(level, 'integer', 'setWardUnitType', 1)
    checktype(value, 'string', 'setWardUnitType', 2)
    self.def:setLvlDataString('hwdu', level, 0, value)
end

AbilityDefinitionBattlestations = class('AbilityDefinitionBattlestations', AbilityDefinition)
_G.AbilityDefinitionBattlestations = AbilityDefinitionBattlestations

function AbilityDefinitionBattlestations:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abtl')
end

function AbilityDefinitionBattlestations:setSummonBusyUnits(level, value)
    checktype(level, 'integer', 'setSummonBusyUnits', 1)
    checktype(value, 'boolean', 'setSummonBusyUnits', 2)
    self.def:setLvlDataBoolean('Btl2', level, 2, value)
end

function AbilityDefinitionBattlestations:setAllowedUnitType(level, value)
    checktype(level, 'integer', 'setAllowedUnitType', 1)
    checktype(value, 'string', 'setAllowedUnitType', 2)
    self.def:setLvlDataString('Btl1', level, 0, value)
end

AbilityDefinitionHealingWaveCreep = class('AbilityDefinitionHealingWaveCreep', AbilityDefinition)
_G.AbilityDefinitionHealingWaveCreep = AbilityDefinitionHealingWaveCreep

function AbilityDefinitionHealingWaveCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AChv')
end

function AbilityDefinitionHealingWaveCreep:setDamageperTarget(level, value)
    checktype(level, 'integer', 'setDamageperTarget', 1)
    checktype(value, 'float', 'setDamageperTarget', 2)
    self.def:setLvlDataUnreal('Ocl1', level, 1, value)
end

function AbilityDefinitionHealingWaveCreep:setNumberofTargetsHit(level, value)
    checktype(level, 'integer', 'setNumberofTargetsHit', 1)
    checktype(value, 'integer', 'setNumberofTargetsHit', 2)
    self.def:setLvlDataInt('Ocl2', level, 2, value)
end

function AbilityDefinitionHealingWaveCreep:setDamageReductionperTarget(level, value)
    checktype(level, 'integer', 'setDamageReductionperTarget', 1)
    checktype(value, 'float', 'setDamageReductionperTarget', 2)
    self.def:setLvlDataUnreal('Ocl3', level, 3, value)
end

AbilityDefinitionInnerFireCreep = class('AbilityDefinitionInnerFireCreep', AbilityDefinition)
_G.AbilityDefinitionInnerFireCreep = AbilityDefinitionInnerFireCreep

function AbilityDefinitionInnerFireCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACif')
end

function AbilityDefinitionInnerFireCreep:setAutocastRange(level, value)
    checktype(level, 'integer', 'setAutocastRange', 1)
    checktype(value, 'float', 'setAutocastRange', 2)
    self.def:setLvlDataUnreal('Inf3', level, 3, value)
end

function AbilityDefinitionInnerFireCreep:setLifeRegenRate(level, value)
    checktype(level, 'integer', 'setLifeRegenRate', 1)
    checktype(value, 'float', 'setLifeRegenRate', 2)
    self.def:setLvlDataUnreal('Inf4', level, 4, value)
end

function AbilityDefinitionInnerFireCreep:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Inf2', level, 2, value)
end

function AbilityDefinitionInnerFireCreep:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Inf1', level, 1, value)
end

AbilityDefinitionAncestralSpirit = class('AbilityDefinitionAncestralSpirit', AbilityDefinition)
_G.AbilityDefinitionAncestralSpirit = AbilityDefinitionAncestralSpirit

function AbilityDefinitionAncestralSpirit:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aast')
end

function AbilityDefinitionAncestralSpirit:setLifeRestoredFactor(level, value)
    checktype(level, 'integer', 'setLifeRestoredFactor', 1)
    checktype(value, 'float', 'setLifeRestoredFactor', 2)
    self.def:setLvlDataUnreal('ast1', level, 1, value)
end

function AbilityDefinitionAncestralSpirit:setManaRestoredFactor(level, value)
    checktype(level, 'integer', 'setManaRestoredFactor', 1)
    checktype(value, 'float', 'setManaRestoredFactor', 2)
    self.def:setLvlDataUnreal('ast2', level, 2, value)
end

AbilityDefinitionHarvestLumbershredder = class('AbilityDefinitionHarvestLumbershredder', AbilityDefinition)
_G.AbilityDefinitionHarvestLumbershredder = AbilityDefinitionHarvestLumbershredder

function AbilityDefinitionHarvestLumbershredder:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahr3')
end

function AbilityDefinitionHarvestLumbershredder:setLumberCapacity(level, value)
    checktype(level, 'integer', 'setLumberCapacity', 1)
    checktype(value, 'integer', 'setLumberCapacity', 2)
    self.def:setLvlDataInt('Har2', level, 2, value)
end

function AbilityDefinitionHarvestLumbershredder:setDamagetoTree(level, value)
    checktype(level, 'integer', 'setDamagetoTree', 1)
    checktype(value, 'integer', 'setDamagetoTree', 2)
    self.def:setLvlDataInt('Har1', level, 1, value)
end

AbilityDefinitionItemHealAoeGreater = class('AbilityDefinitionItemHealAoeGreater', AbilityDefinition)
_G.AbilityDefinitionItemHealAoeGreater = AbilityDefinitionItemHealAoeGreater

function AbilityDefinitionItemHealAoeGreater:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIhb')
end

function AbilityDefinitionItemHealAoeGreater:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihpg', level, 1, value)
end

AbilityDefinitionPulverize = class('AbilityDefinitionPulverize', AbilityDefinition)
_G.AbilityDefinitionPulverize = AbilityDefinitionPulverize

function AbilityDefinitionPulverize:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awar')
end

function AbilityDefinitionPulverize:setHalfDamageRadius(level, value)
    checktype(level, 'integer', 'setHalfDamageRadius', 1)
    checktype(value, 'float', 'setHalfDamageRadius', 2)
    self.def:setLvlDataUnreal('War4', level, 4, value)
end

function AbilityDefinitionPulverize:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('War2', level, 2, value)
end

function AbilityDefinitionPulverize:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('War3', level, 3, value)
end

function AbilityDefinitionPulverize:setChancetoStomp(level, value)
    checktype(level, 'integer', 'setChancetoStomp', 1)
    checktype(value, 'float', 'setChancetoStomp', 2)
    self.def:setLvlDataUnreal('War1', level, 1, value)
end

AbilityDefinitionItemHealAoe = class('AbilityDefinitionItemHealAoe', AbilityDefinition)
_G.AbilityDefinitionItemHealAoe = AbilityDefinitionItemHealAoe

function AbilityDefinitionItemHealAoe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIha')
end

function AbilityDefinitionItemHealAoe:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihpg', level, 1, value)
end

AbilityDefinitionAIhe = class('AbilityDefinitionAIhe', AbilityDefinition)
_G.AbilityDefinitionAIhe = AbilityDefinitionAIhe

function AbilityDefinitionAIhe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIhe')
end

function AbilityDefinitionAIhe:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'integer', 'setHitPointsGained', 2)
    self.def:setLvlDataInt('Ihpg', level, 1, value)
end

AbilityDefinitionFarseerEarthquake = class('AbilityDefinitionFarseerEarthquake', AbilityDefinition)
_G.AbilityDefinitionFarseerEarthquake = AbilityDefinitionFarseerEarthquake

function AbilityDefinitionFarseerEarthquake:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOeq')
end

function AbilityDefinitionFarseerEarthquake:setUnitsSlowed(level, value)
    checktype(level, 'integer', 'setUnitsSlowed', 1)
    checktype(value, 'float', 'setUnitsSlowed', 2)
    self.def:setLvlDataUnreal('Oeq3', level, 3, value)
end

function AbilityDefinitionFarseerEarthquake:setEffectDelay(level, value)
    checktype(level, 'integer', 'setEffectDelay', 1)
    checktype(value, 'float', 'setEffectDelay', 2)
    self.def:setLvlDataUnreal('Oeq1', level, 1, value)
end

function AbilityDefinitionFarseerEarthquake:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Oeq4', level, 4, value)
end

function AbilityDefinitionFarseerEarthquake:setDamageperSecondtoBuildings(level, value)
    checktype(level, 'integer', 'setDamageperSecondtoBuildings', 1)
    checktype(value, 'float', 'setDamageperSecondtoBuildings', 2)
    self.def:setLvlDataUnreal('Oeq2', level, 2, value)
end

AbilityDefinitionDemonHunterImmolation = class('AbilityDefinitionDemonHunterImmolation', AbilityDefinition)
_G.AbilityDefinitionDemonHunterImmolation = AbilityDefinitionDemonHunterImmolation

function AbilityDefinitionDemonHunterImmolation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEim')
end

function AbilityDefinitionDemonHunterImmolation:setManaDrainedperSecond(level, value)
    checktype(level, 'integer', 'setManaDrainedperSecond', 1)
    checktype(value, 'float', 'setManaDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Eim2', level, 2, value)
end

function AbilityDefinitionDemonHunterImmolation:setBufferManaRequired(level, value)
    checktype(level, 'integer', 'setBufferManaRequired', 1)
    checktype(value, 'float', 'setBufferManaRequired', 2)
    self.def:setLvlDataUnreal('Eim3', level, 3, value)
end

function AbilityDefinitionDemonHunterImmolation:setDamageperInterval(level, value)
    checktype(level, 'integer', 'setDamageperInterval', 1)
    checktype(value, 'float', 'setDamageperInterval', 2)
    self.def:setLvlDataUnreal('Eim1', level, 1, value)
end

AbilityDefinitionNeutralDetectionRevealability = class('AbilityDefinitionNeutralDetectionRevealability', AbilityDefinition)
_G.AbilityDefinitionNeutralDetectionRevealability = AbilityDefinitionNeutralDetectionRevealability

function AbilityDefinitionNeutralDetectionRevealability:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Andt')
end

function AbilityDefinitionNeutralDetectionRevealability:setLumberCost(level, value)
    checktype(level, 'integer', 'setLumberCost', 1)
    checktype(value, 'integer', 'setLumberCost', 2)
    self.def:setLvlDataInt('Ndt2', level, 2, value)
end

function AbilityDefinitionNeutralDetectionRevealability:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Ndt3', level, 3, value)
end

function AbilityDefinitionNeutralDetectionRevealability:setGoldCost(level, value)
    checktype(level, 'integer', 'setGoldCost', 1)
    checktype(value, 'integer', 'setGoldCost', 2)
    self.def:setLvlDataInt('Ndt1', level, 1, value)
end

AbilityDefinitionWeb = class('AbilityDefinitionWeb', AbilityDefinition)
_G.AbilityDefinitionWeb = AbilityDefinitionWeb

function AbilityDefinitionWeb:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aweb')
end

function AbilityDefinitionWeb:setAirUnitHeight(level, value)
    checktype(level, 'integer', 'setAirUnitHeight', 1)
    checktype(value, 'float', 'setAirUnitHeight', 2)
    self.def:setLvlDataUnreal('Ens2', level, 2, value)
end

function AbilityDefinitionWeb:setAirUnitLowerDuration(level, value)
    checktype(level, 'integer', 'setAirUnitLowerDuration', 1)
    checktype(value, 'float', 'setAirUnitLowerDuration', 2)
    self.def:setLvlDataUnreal('Ens1', level, 1, value)
end

function AbilityDefinitionWeb:setMeleeAttackRange(level, value)
    checktype(level, 'integer', 'setMeleeAttackRange', 1)
    checktype(value, 'float', 'setMeleeAttackRange', 2)
    self.def:setLvlDataUnreal('Ens3', level, 3, value)
end

AbilityDefinitionFigurineIceRevenant = class('AbilityDefinitionFigurineIceRevenant', AbilityDefinition)
_G.AbilityDefinitionFigurineIceRevenant = AbilityDefinitionFigurineIceRevenant

function AbilityDefinitionFigurineIceRevenant:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIir')
end

function AbilityDefinitionFigurineIceRevenant:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineIceRevenant:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineIceRevenant:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineIceRevenant:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionSuperDeathandDecay = class('AbilityDefinitionSuperDeathandDecay', AbilityDefinition)
_G.AbilityDefinitionSuperDeathandDecay = AbilityDefinitionSuperDeathandDecay

function AbilityDefinitionSuperDeathandDecay:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'SNdd')
end

function AbilityDefinitionSuperDeathandDecay:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Udd2', level, 2, value)
end

function AbilityDefinitionSuperDeathandDecay:setMaxLifeDrainedperSecond(level, value)
    checktype(level, 'integer', 'setMaxLifeDrainedperSecond', 1)
    checktype(value, 'float', 'setMaxLifeDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Udd1', level, 1, value)
end

AbilityDefinitionDarkConversionFast = class('AbilityDefinitionDarkConversionFast', AbilityDefinition)
_G.AbilityDefinitionDarkConversionFast = AbilityDefinitionDarkConversionFast

function AbilityDefinitionDarkConversionFast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'SNdc')
end

function AbilityDefinitionDarkConversionFast:setConversionUnit(level, value)
    checktype(level, 'integer', 'setConversionUnit', 1)
    checktype(value, 'string', 'setConversionUnit', 2)
    self.def:setLvlDataString('Ndc2', level, 0, value)
end

function AbilityDefinitionDarkConversionFast:setRacetoConvert(level, value)
    checktype(level, 'integer', 'setRacetoConvert', 1)
    checktype(value, 'string', 'setRacetoConvert', 2)
    self.def:setLvlDataString('Ndc1', level, 1, value)
end

AbilityDefinitionImmolationcreep = class('AbilityDefinitionImmolationcreep', AbilityDefinition)
_G.AbilityDefinitionImmolationcreep = AbilityDefinitionImmolationcreep

function AbilityDefinitionImmolationcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACim')
end

function AbilityDefinitionImmolationcreep:setManaDrainedperSecond(level, value)
    checktype(level, 'integer', 'setManaDrainedperSecond', 1)
    checktype(value, 'float', 'setManaDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Eim2', level, 2, value)
end

function AbilityDefinitionImmolationcreep:setBufferManaRequired(level, value)
    checktype(level, 'integer', 'setBufferManaRequired', 1)
    checktype(value, 'float', 'setBufferManaRequired', 2)
    self.def:setLvlDataUnreal('Eim3', level, 3, value)
end

function AbilityDefinitionImmolationcreep:setDamageperInterval(level, value)
    checktype(level, 'integer', 'setDamageperInterval', 1)
    checktype(value, 'float', 'setDamageperInterval', 2)
    self.def:setLvlDataUnreal('Eim1', level, 1, value)
end

AbilityDefinitionIntelligenceMod = class('AbilityDefinitionIntelligenceMod', AbilityDefinition)
_G.AbilityDefinitionIntelligenceMod = AbilityDefinitionIntelligenceMod

function AbilityDefinitionIntelligenceMod:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIim')
end

function AbilityDefinitionIntelligenceMod:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionIntelligenceMod:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionIntelligenceMod:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionIntelligenceMod:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionItemInferno = class('AbilityDefinitionItemInferno', AbilityDefinition)
_G.AbilityDefinitionItemInferno = AbilityDefinitionItemInferno

function AbilityDefinitionItemInferno:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIin')
end

function AbilityDefinitionItemInferno:setDuration(level, value)
    checktype(level, 'integer', 'setDuration', 1)
    checktype(value, 'float', 'setDuration', 2)
    self.def:setLvlDataUnreal('Uin2', level, 2, value)
end

function AbilityDefinitionItemInferno:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Uin1', level, 1, value)
end

function AbilityDefinitionItemInferno:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Uin4', level, 0, value)
end

function AbilityDefinitionItemInferno:setImpactDelay(level, value)
    checktype(level, 'integer', 'setImpactDelay', 1)
    checktype(value, 'float', 'setImpactDelay', 2)
    self.def:setLvlDataUnreal('Uin3', level, 3, value)
end

AbilityDefinitionItemIllusion = class('AbilityDefinitionItemIllusion', AbilityDefinition)
_G.AbilityDefinitionItemIllusion = AbilityDefinitionItemIllusion

function AbilityDefinitionItemIllusion:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIil')
end

function AbilityDefinitionItemIllusion:setDamageReceivedMultiplier(level, value)
    checktype(level, 'integer', 'setDamageReceivedMultiplier', 1)
    checktype(value, 'float', 'setDamageReceivedMultiplier', 2)
    self.def:setLvlDataUnreal('Iilw', level, 2, value)
end

function AbilityDefinitionItemIllusion:setDamageDealtofnormal(level, value)
    checktype(level, 'integer', 'setDamageDealtofnormal', 1)
    checktype(value, 'float', 'setDamageDealtofnormal', 2)
    self.def:setLvlDataUnreal('Iild', level, 1, value)
end

AbilityDefinitionMagicDefense = class('AbilityDefinitionMagicDefense', AbilityDefinition)
_G.AbilityDefinitionMagicDefense = AbilityDefinitionMagicDefense

function AbilityDefinitionMagicDefense:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amdf')
end

function AbilityDefinitionMagicDefense:setDamageTaken(level, value)
    checktype(level, 'integer', 'setDamageTaken', 1)
    checktype(value, 'float', 'setDamageTaken', 2)
    self.def:setLvlDataUnreal('Def1', level, 1, value)
end

function AbilityDefinitionMagicDefense:setChancetoDeflect(level, value)
    checktype(level, 'integer', 'setChancetoDeflect', 1)
    checktype(value, 'float', 'setChancetoDeflect', 2)
    self.def:setLvlDataUnreal('Def6', level, 6, value)
end

function AbilityDefinitionMagicDefense:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Def3', level, 3, value)
end

function AbilityDefinitionMagicDefense:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Def4', level, 4, value)
end

function AbilityDefinitionMagicDefense:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Def2', level, 2, value)
end

function AbilityDefinitionMagicDefense:setDeflectDamageTakenSpells(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenSpells', 1)
    checktype(value, 'float', 'setDeflectDamageTakenSpells', 2)
    self.def:setLvlDataUnreal('Def8', level, 8, value)
end

function AbilityDefinitionMagicDefense:setDeflectDamageTakenPiercing(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenPiercing', 1)
    checktype(value, 'float', 'setDeflectDamageTakenPiercing', 2)
    self.def:setLvlDataUnreal('Def7', level, 7, value)
end

function AbilityDefinitionMagicDefense:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Def5', level, 5, value)
end

AbilityDefinitionAvengerForm = class('AbilityDefinitionAvengerForm', AbilityDefinition)
_G.AbilityDefinitionAvengerForm = AbilityDefinitionAvengerForm

function AbilityDefinitionAvengerForm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aave')
end

function AbilityDefinitionAvengerForm:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionAvengerForm:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionAvengerForm:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionAvengerForm:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionAvengerForm:setLifeRegenerationRatepersecond(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRatepersecond', 1)
    checktype(value, 'float', 'setLifeRegenerationRatepersecond', 2)
    self.def:setLvlDataUnreal('ave5', level, 5, value)
end

function AbilityDefinitionAvengerForm:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionHarvestLumber = class('AbilityDefinitionHarvestLumber', AbilityDefinition)
_G.AbilityDefinitionHarvestLumber = AbilityDefinitionHarvestLumber

function AbilityDefinitionHarvestLumber:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahrl')
end

function AbilityDefinitionHarvestLumber:setLumberCapacity(level, value)
    checktype(level, 'integer', 'setLumberCapacity', 1)
    checktype(value, 'integer', 'setLumberCapacity', 2)
    self.def:setLvlDataInt('Har2', level, 2, value)
end

function AbilityDefinitionHarvestLumber:setDamagetoTree(level, value)
    checktype(level, 'integer', 'setDamagetoTree', 1)
    checktype(value, 'integer', 'setDamagetoTree', 2)
    self.def:setLvlDataInt('Har1', level, 1, value)
end

AbilityDefinitionNeutralBuilding = class('AbilityDefinitionNeutralBuilding', AbilityDefinition)
_G.AbilityDefinitionNeutralBuilding = AbilityDefinitionNeutralBuilding

function AbilityDefinitionNeutralBuilding:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aneu')
end

function AbilityDefinitionNeutralBuilding:setShowUnitIndicator(level, value)
    checktype(level, 'integer', 'setShowUnitIndicator', 1)
    checktype(value, 'boolean', 'setShowUnitIndicator', 2)
    self.def:setLvlDataBoolean('Neu4', level, 4, value)
end

function AbilityDefinitionNeutralBuilding:setActivationRadius(level, value)
    checktype(level, 'integer', 'setActivationRadius', 1)
    checktype(value, 'float', 'setActivationRadius', 2)
    self.def:setLvlDataUnreal('Neu1', level, 1, value)
end

function AbilityDefinitionNeutralBuilding:setShowSelectUnitButton(level, value)
    checktype(level, 'integer', 'setShowSelectUnitButton', 1)
    checktype(value, 'boolean', 'setShowSelectUnitButton', 2)
    self.def:setLvlDataBoolean('Neu3', level, 3, value)
end

function AbilityDefinitionNeutralBuilding:setInteractionType(level, value)
    checktype(level, 'integer', 'setInteractionType', 1)
    checktype(value, 'integer', 'setInteractionType', 2)
    self.def:setLvlDataInt('Neu2', level, 2, value)
end

AbilityDefinitionShopSharing = class('AbilityDefinitionShopSharing', AbilityDefinition)
_G.AbilityDefinitionShopSharing = AbilityDefinitionShopSharing

function AbilityDefinitionShopSharing:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aall')
end

function AbilityDefinitionShopSharing:setShowUnitIndicator(level, value)
    checktype(level, 'integer', 'setShowUnitIndicator', 1)
    checktype(value, 'boolean', 'setShowUnitIndicator', 2)
    self.def:setLvlDataBoolean('Neu4', level, 4, value)
end

function AbilityDefinitionShopSharing:setActivationRadius(level, value)
    checktype(level, 'integer', 'setActivationRadius', 1)
    checktype(value, 'float', 'setActivationRadius', 2)
    self.def:setLvlDataUnreal('Neu1', level, 1, value)
end

function AbilityDefinitionShopSharing:setShowSelectUnitButton(level, value)
    checktype(level, 'integer', 'setShowSelectUnitButton', 1)
    checktype(value, 'boolean', 'setShowSelectUnitButton', 2)
    self.def:setLvlDataBoolean('Neu3', level, 3, value)
end

function AbilityDefinitionShopSharing:setInteractionType(level, value)
    checktype(level, 'integer', 'setInteractionType', 1)
    checktype(value, 'integer', 'setInteractionType', 2)
    self.def:setLvlDataInt('Neu2', level, 2, value)
end

AbilityDefinitionRepairHuman = class('AbilityDefinitionRepairHuman', AbilityDefinition)
_G.AbilityDefinitionRepairHuman = AbilityDefinitionRepairHuman

function AbilityDefinitionRepairHuman:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahrp')
end

function AbilityDefinitionRepairHuman:setPowerbuildRate(level, value)
    checktype(level, 'integer', 'setPowerbuildRate', 1)
    checktype(value, 'float', 'setPowerbuildRate', 2)
    self.def:setLvlDataUnreal('Rep4', level, 4, value)
end

function AbilityDefinitionRepairHuman:setNavalRangeBonus(level, value)
    checktype(level, 'integer', 'setNavalRangeBonus', 1)
    checktype(value, 'float', 'setNavalRangeBonus', 2)
    self.def:setLvlDataUnreal('Rep5', level, 5, value)
end

function AbilityDefinitionRepairHuman:setRepairTimeRatio(level, value)
    checktype(level, 'integer', 'setRepairTimeRatio', 1)
    checktype(value, 'float', 'setRepairTimeRatio', 2)
    self.def:setLvlDataUnreal('Rep2', level, 2, value)
end

function AbilityDefinitionRepairHuman:setRepairCostRatio(level, value)
    checktype(level, 'integer', 'setRepairCostRatio', 1)
    checktype(value, 'float', 'setRepairCostRatio', 2)
    self.def:setLvlDataUnreal('Rep1', level, 1, value)
end

function AbilityDefinitionRepairHuman:setPowerbuildCost(level, value)
    checktype(level, 'integer', 'setPowerbuildCost', 1)
    checktype(value, 'float', 'setPowerbuildCost', 2)
    self.def:setLvlDataUnreal('Rep3', level, 3, value)
end

AbilityDefinitionAhrs = class('AbilityDefinitionAhrs', AbilityDefinition)
_G.AbilityDefinitionAhrs = AbilityDefinitionAhrs

function AbilityDefinitionAhrs:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahrs')
end

function AbilityDefinitionAhrs:setTerrainDeformationAmplitude(level, value)
    checktype(level, 'integer', 'setTerrainDeformationAmplitude', 1)
    checktype(value, 'float', 'setTerrainDeformationAmplitude', 2)
    self.def:setLvlDataUnreal('Wrs2', level, 2, value)
end

function AbilityDefinitionAhrs:setTerrainDeformationDurationms(level, value)
    checktype(level, 'integer', 'setTerrainDeformationDurationms', 1)
    checktype(value, 'integer', 'setTerrainDeformationDurationms', 2)
    self.def:setLvlDataInt('Wrs3', level, 3, value)
end

function AbilityDefinitionAhrs:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Wrs1', level, 1, value)
end

AbilityDefinitionFirelordIncinerate = class('AbilityDefinitionFirelordIncinerate', AbilityDefinition)
_G.AbilityDefinitionFirelordIncinerate = AbilityDefinitionFirelordIncinerate

function AbilityDefinitionFirelordIncinerate:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANic')
end

function AbilityDefinitionFirelordIncinerate:setDeathDamageHalfAmount(level, value)
    checktype(level, 'integer', 'setDeathDamageHalfAmount', 1)
    checktype(value, 'float', 'setDeathDamageHalfAmount', 2)
    self.def:setLvlDataUnreal('Nic4', level, 4, value)
end

function AbilityDefinitionFirelordIncinerate:setDeathDamageFullArea(level, value)
    checktype(level, 'integer', 'setDeathDamageFullArea', 1)
    checktype(value, 'float', 'setDeathDamageFullArea', 2)
    self.def:setLvlDataUnreal('Nic3', level, 3, value)
end

function AbilityDefinitionFirelordIncinerate:setBonusDamageMultiplier(level, value)
    checktype(level, 'integer', 'setBonusDamageMultiplier', 1)
    checktype(value, 'float', 'setBonusDamageMultiplier', 2)
    self.def:setLvlDataUnreal('Nic1', level, 1, value)
end

function AbilityDefinitionFirelordIncinerate:setDeathDamageFullAmount(level, value)
    checktype(level, 'integer', 'setDeathDamageFullAmount', 1)
    checktype(value, 'float', 'setDeathDamageFullAmount', 2)
    self.def:setLvlDataUnreal('Nic2', level, 2, value)
end

function AbilityDefinitionFirelordIncinerate:setDeathDamageDelay(level, value)
    checktype(level, 'integer', 'setDeathDamageDelay', 1)
    checktype(value, 'float', 'setDeathDamageDelay', 2)
    self.def:setLvlDataUnreal('Nic6', level, 6, value)
end

function AbilityDefinitionFirelordIncinerate:setDeathDamageHalfArea(level, value)
    checktype(level, 'integer', 'setDeathDamageHalfArea', 1)
    checktype(value, 'float', 'setDeathDamageHalfArea', 2)
    self.def:setLvlDataUnreal('Nic5', level, 5, value)
end

AbilityDefinitionFirelordIncinerateArrow = class('AbilityDefinitionFirelordIncinerateArrow', AbilityDefinition)
_G.AbilityDefinitionFirelordIncinerateArrow = AbilityDefinitionFirelordIncinerateArrow

function AbilityDefinitionFirelordIncinerateArrow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANia')
end

function AbilityDefinitionFirelordIncinerateArrow:setDeathDamageHalfAmount(level, value)
    checktype(level, 'integer', 'setDeathDamageHalfAmount', 1)
    checktype(value, 'float', 'setDeathDamageHalfAmount', 2)
    self.def:setLvlDataUnreal('Nic4', level, 4, value)
end

function AbilityDefinitionFirelordIncinerateArrow:setDeathDamageFullArea(level, value)
    checktype(level, 'integer', 'setDeathDamageFullArea', 1)
    checktype(value, 'float', 'setDeathDamageFullArea', 2)
    self.def:setLvlDataUnreal('Nic3', level, 3, value)
end

function AbilityDefinitionFirelordIncinerateArrow:setBonusDamageMultiplier(level, value)
    checktype(level, 'integer', 'setBonusDamageMultiplier', 1)
    checktype(value, 'float', 'setBonusDamageMultiplier', 2)
    self.def:setLvlDataUnreal('Nic1', level, 1, value)
end

function AbilityDefinitionFirelordIncinerateArrow:setDeathDamageFullAmount(level, value)
    checktype(level, 'integer', 'setDeathDamageFullAmount', 1)
    checktype(value, 'float', 'setDeathDamageFullAmount', 2)
    self.def:setLvlDataUnreal('Nic2', level, 2, value)
end

function AbilityDefinitionFirelordIncinerateArrow:setDeathDamageDelay(level, value)
    checktype(level, 'integer', 'setDeathDamageDelay', 1)
    checktype(value, 'float', 'setDeathDamageDelay', 2)
    self.def:setLvlDataUnreal('Nic6', level, 6, value)
end

function AbilityDefinitionFirelordIncinerateArrow:setDeathDamageHalfArea(level, value)
    checktype(level, 'integer', 'setDeathDamageHalfArea', 1)
    checktype(value, 'float', 'setDeathDamageHalfArea', 2)
    self.def:setLvlDataUnreal('Nic5', level, 5, value)
end

AbilityDefinitionBearform = class('AbilityDefinitionBearform', AbilityDefinition)
_G.AbilityDefinitionBearform = AbilityDefinitionBearform

function AbilityDefinitionBearform:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abrf')
end

function AbilityDefinitionBearform:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionBearform:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionBearform:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionBearform:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionBearform:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionCryptLordLocustSwarm = class('AbilityDefinitionCryptLordLocustSwarm', AbilityDefinition)
_G.AbilityDefinitionCryptLordLocustSwarm = AbilityDefinitionCryptLordLocustSwarm

function AbilityDefinitionCryptLordLocustSwarm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUls')
end

function AbilityDefinitionCryptLordLocustSwarm:setNumberofSwarmUnits(level, value)
    checktype(level, 'integer', 'setNumberofSwarmUnits', 1)
    checktype(value, 'integer', 'setNumberofSwarmUnits', 2)
    self.def:setLvlDataInt('Uls1', level, 1, value)
end

function AbilityDefinitionCryptLordLocustSwarm:setUnitReleaseIntervalseconds(level, value)
    checktype(level, 'integer', 'setUnitReleaseIntervalseconds', 1)
    checktype(value, 'float', 'setUnitReleaseIntervalseconds', 2)
    self.def:setLvlDataUnreal('Uls2', level, 2, value)
end

function AbilityDefinitionCryptLordLocustSwarm:setMaxSwarmUnitsPerTarget(level, value)
    checktype(level, 'integer', 'setMaxSwarmUnitsPerTarget', 1)
    checktype(value, 'integer', 'setMaxSwarmUnitsPerTarget', 2)
    self.def:setLvlDataInt('Uls3', level, 3, value)
end

function AbilityDefinitionCryptLordLocustSwarm:setSwarmUnitType(level, value)
    checktype(level, 'integer', 'setSwarmUnitType', 1)
    checktype(value, 'string', 'setSwarmUnitType', 2)
    self.def:setLvlDataString('Ulsu', level, 0, value)
end

function AbilityDefinitionCryptLordLocustSwarm:setDamageReturnThreshold(level, value)
    checktype(level, 'integer', 'setDamageReturnThreshold', 1)
    checktype(value, 'float', 'setDamageReturnThreshold', 2)
    self.def:setLvlDataUnreal('Uls5', level, 5, value)
end

function AbilityDefinitionCryptLordLocustSwarm:setDamageReturnFactor(level, value)
    checktype(level, 'integer', 'setDamageReturnFactor', 1)
    checktype(value, 'float', 'setDamageReturnFactor', 2)
    self.def:setLvlDataUnreal('Uls4', level, 4, value)
end

AbilityDefinitionRestoration = class('AbilityDefinitionRestoration', AbilityDefinition)
_G.AbilityDefinitionRestoration = AbilityDefinitionRestoration

function AbilityDefinitionRestoration:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arst')
end

function AbilityDefinitionRestoration:setPowerbuildRate(level, value)
    checktype(level, 'integer', 'setPowerbuildRate', 1)
    checktype(value, 'float', 'setPowerbuildRate', 2)
    self.def:setLvlDataUnreal('Rep4', level, 4, value)
end

function AbilityDefinitionRestoration:setNavalRangeBonus(level, value)
    checktype(level, 'integer', 'setNavalRangeBonus', 1)
    checktype(value, 'float', 'setNavalRangeBonus', 2)
    self.def:setLvlDataUnreal('Rep5', level, 5, value)
end

function AbilityDefinitionRestoration:setRepairTimeRatio(level, value)
    checktype(level, 'integer', 'setRepairTimeRatio', 1)
    checktype(value, 'float', 'setRepairTimeRatio', 2)
    self.def:setLvlDataUnreal('Rep2', level, 2, value)
end

function AbilityDefinitionRestoration:setRepairCostRatio(level, value)
    checktype(level, 'integer', 'setRepairCostRatio', 1)
    checktype(value, 'float', 'setRepairCostRatio', 2)
    self.def:setLvlDataUnreal('Rep1', level, 1, value)
end

function AbilityDefinitionRestoration:setPowerbuildCost(level, value)
    checktype(level, 'integer', 'setPowerbuildCost', 1)
    checktype(value, 'float', 'setPowerbuildCost', 2)
    self.def:setLvlDataUnreal('Rep3', level, 3, value)
end

AbilityDefinitionFarseerChainLightning = class('AbilityDefinitionFarseerChainLightning', AbilityDefinition)
_G.AbilityDefinitionFarseerChainLightning = AbilityDefinitionFarseerChainLightning

function AbilityDefinitionFarseerChainLightning:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOcl')
end

function AbilityDefinitionFarseerChainLightning:setDamageperTarget(level, value)
    checktype(level, 'integer', 'setDamageperTarget', 1)
    checktype(value, 'float', 'setDamageperTarget', 2)
    self.def:setLvlDataUnreal('Ocl1', level, 1, value)
end

function AbilityDefinitionFarseerChainLightning:setNumberofTargetsHit(level, value)
    checktype(level, 'integer', 'setNumberofTargetsHit', 1)
    checktype(value, 'integer', 'setNumberofTargetsHit', 2)
    self.def:setLvlDataInt('Ocl2', level, 2, value)
end

function AbilityDefinitionFarseerChainLightning:setDamageReductionperTarget(level, value)
    checktype(level, 'integer', 'setDamageReductionperTarget', 1)
    checktype(value, 'float', 'setDamageReductionperTarget', 2)
    self.def:setLvlDataUnreal('Ocl3', level, 3, value)
end

AbilityDefinitionMaxLifeBonusGreater = class('AbilityDefinitionMaxLifeBonusGreater', AbilityDefinition)
_G.AbilityDefinitionMaxLifeBonusGreater = AbilityDefinitionMaxLifeBonusGreater

function AbilityDefinitionMaxLifeBonusGreater:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIl2')
end

function AbilityDefinitionMaxLifeBonusGreater:setMaxLifeGained(level, value)
    checktype(level, 'integer', 'setMaxLifeGained', 1)
    checktype(value, 'integer', 'setMaxLifeGained', 2)
    self.def:setLvlDataInt('Ilif', level, 1, value)
end

AbilityDefinitionInferno = class('AbilityDefinitionInferno', AbilityDefinition)
_G.AbilityDefinitionInferno = AbilityDefinitionInferno

function AbilityDefinitionInferno:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANin')
end

function AbilityDefinitionInferno:setDuration(level, value)
    checktype(level, 'integer', 'setDuration', 1)
    checktype(value, 'float', 'setDuration', 2)
    self.def:setLvlDataUnreal('Uin2', level, 2, value)
end

function AbilityDefinitionInferno:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Uin1', level, 1, value)
end

function AbilityDefinitionInferno:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Uin4', level, 0, value)
end

function AbilityDefinitionInferno:setImpactDelay(level, value)
    checktype(level, 'integer', 'setImpactDelay', 1)
    checktype(value, 'float', 'setImpactDelay', 2)
    self.def:setLvlDataUnreal('Uin3', level, 3, value)
end

AbilityDefinitionMechanicalCritter = class('AbilityDefinitionMechanicalCritter', AbilityDefinition)
_G.AbilityDefinitionMechanicalCritter = AbilityDefinitionMechanicalCritter

function AbilityDefinitionMechanicalCritter:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amec')
end

function AbilityDefinitionMechanicalCritter:setNumberofUnitsCreated(level, value)
    checktype(level, 'integer', 'setNumberofUnitsCreated', 1)
    checktype(value, 'integer', 'setNumberofUnitsCreated', 2)
    self.def:setLvlDataInt('mec1', level, 1, value)
end

AbilityDefinitionMaxLifeBonusLesser = class('AbilityDefinitionMaxLifeBonusLesser', AbilityDefinition)
_G.AbilityDefinitionMaxLifeBonusLesser = AbilityDefinitionMaxLifeBonusLesser

function AbilityDefinitionMaxLifeBonusLesser:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIl1')
end

function AbilityDefinitionMaxLifeBonusLesser:setMaxLifeGained(level, value)
    checktype(level, 'integer', 'setMaxLifeGained', 1)
    checktype(value, 'integer', 'setMaxLifeGained', 2)
    self.def:setLvlDataInt('Ilif', level, 1, value)
end

AbilityDefinitionPurgeApg2 = class('AbilityDefinitionPurgeApg2', AbilityDefinition)
_G.AbilityDefinitionPurgeApg2 = AbilityDefinitionPurgeApg2

function AbilityDefinitionPurgeApg2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apg2')
end

function AbilityDefinitionPurgeApg2:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Prg6', level, 6, value)
end

AbilityDefinitionBladeMasterCriticalStrike = class('AbilityDefinitionBladeMasterCriticalStrike', AbilityDefinition)
_G.AbilityDefinitionBladeMasterCriticalStrike = AbilityDefinitionBladeMasterCriticalStrike

function AbilityDefinitionBladeMasterCriticalStrike:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOcr')
end

function AbilityDefinitionBladeMasterCriticalStrike:setDamageMultiplier(level, value)
    checktype(level, 'integer', 'setDamageMultiplier', 1)
    checktype(value, 'float', 'setDamageMultiplier', 2)
    self.def:setLvlDataUnreal('Ocr2', level, 2, value)
end

function AbilityDefinitionBladeMasterCriticalStrike:setChancetoCriticalStrike(level, value)
    checktype(level, 'integer', 'setChancetoCriticalStrike', 1)
    checktype(value, 'float', 'setChancetoCriticalStrike', 2)
    self.def:setLvlDataUnreal('Ocr1', level, 1, value)
end

function AbilityDefinitionBladeMasterCriticalStrike:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Ocr3', level, 3, value)
end

function AbilityDefinitionBladeMasterCriticalStrike:setChancetoEvade(level, value)
    checktype(level, 'integer', 'setChancetoEvade', 1)
    checktype(value, 'float', 'setChancetoEvade', 2)
    self.def:setLvlDataUnreal('Ocr4', level, 4, value)
end

function AbilityDefinitionBladeMasterCriticalStrike:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Ocr5', level, 5, value)
end

AbilityDefinitionAuraPlagueAbomination = class('AbilityDefinitionAuraPlagueAbomination', AbilityDefinition)
_G.AbilityDefinitionAuraPlagueAbomination = AbilityDefinitionAuraPlagueAbomination

function AbilityDefinitionAuraPlagueAbomination:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aap1')
end

function AbilityDefinitionAuraPlagueAbomination:setPlagueWardUnitType(level, value)
    checktype(level, 'integer', 'setPlagueWardUnitType', 1)
    checktype(value, 'string', 'setPlagueWardUnitType', 2)
    self.def:setLvlDataString('Aplu', level, 0, value)
end

function AbilityDefinitionAuraPlagueAbomination:setDurationofPlagueWard(level, value)
    checktype(level, 'integer', 'setDurationofPlagueWard', 1)
    checktype(value, 'float', 'setDurationofPlagueWard', 2)
    self.def:setLvlDataUnreal('Apl3', level, 3, value)
end

function AbilityDefinitionAuraPlagueAbomination:setAuraDuration(level, value)
    checktype(level, 'integer', 'setAuraDuration', 1)
    checktype(value, 'float', 'setAuraDuration', 2)
    self.def:setLvlDataUnreal('Apl1', level, 1, value)
end

function AbilityDefinitionAuraPlagueAbomination:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Apl2', level, 2, value)
end

AbilityDefinitionAuraPlagueCreep = class('AbilityDefinitionAuraPlagueCreep', AbilityDefinition)
_G.AbilityDefinitionAuraPlagueCreep = AbilityDefinitionAuraPlagueCreep

function AbilityDefinitionAuraPlagueCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aap3')
end

function AbilityDefinitionAuraPlagueCreep:setPlagueWardUnitType(level, value)
    checktype(level, 'integer', 'setPlagueWardUnitType', 1)
    checktype(value, 'string', 'setPlagueWardUnitType', 2)
    self.def:setLvlDataString('Aplu', level, 0, value)
end

function AbilityDefinitionAuraPlagueCreep:setDurationofPlagueWard(level, value)
    checktype(level, 'integer', 'setDurationofPlagueWard', 1)
    checktype(value, 'float', 'setDurationofPlagueWard', 2)
    self.def:setLvlDataUnreal('Apl3', level, 3, value)
end

function AbilityDefinitionAuraPlagueCreep:setAuraDuration(level, value)
    checktype(level, 'integer', 'setAuraDuration', 1)
    checktype(value, 'float', 'setAuraDuration', 2)
    self.def:setLvlDataUnreal('Apl1', level, 1, value)
end

function AbilityDefinitionAuraPlagueCreep:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Apl2', level, 2, value)
end

AbilityDefinitionPermanentImmolation = class('AbilityDefinitionPermanentImmolation', AbilityDefinition)
_G.AbilityDefinitionPermanentImmolation = AbilityDefinitionPermanentImmolation

function AbilityDefinitionPermanentImmolation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANpi')
end

function AbilityDefinitionPermanentImmolation:setManaDrainedperSecond(level, value)
    checktype(level, 'integer', 'setManaDrainedperSecond', 1)
    checktype(value, 'float', 'setManaDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Eim2', level, 2, value)
end

function AbilityDefinitionPermanentImmolation:setBufferManaRequired(level, value)
    checktype(level, 'integer', 'setBufferManaRequired', 1)
    checktype(value, 'float', 'setBufferManaRequired', 2)
    self.def:setLvlDataUnreal('Eim3', level, 3, value)
end

function AbilityDefinitionPermanentImmolation:setDamageperInterval(level, value)
    checktype(level, 'integer', 'setDamageperInterval', 1)
    checktype(value, 'float', 'setDamageperInterval', 2)
    self.def:setLvlDataUnreal('Eim1', level, 1, value)
end

AbilityDefinitionAuraPlaguePlagueWard = class('AbilityDefinitionAuraPlaguePlagueWard', AbilityDefinition)
_G.AbilityDefinitionAuraPlaguePlagueWard = AbilityDefinitionAuraPlaguePlagueWard

function AbilityDefinitionAuraPlaguePlagueWard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aap2')
end

function AbilityDefinitionAuraPlaguePlagueWard:setPlagueWardUnitType(level, value)
    checktype(level, 'integer', 'setPlagueWardUnitType', 1)
    checktype(value, 'string', 'setPlagueWardUnitType', 2)
    self.def:setLvlDataString('Aplu', level, 0, value)
end

function AbilityDefinitionAuraPlaguePlagueWard:setDurationofPlagueWard(level, value)
    checktype(level, 'integer', 'setDurationofPlagueWard', 1)
    checktype(value, 'float', 'setDurationofPlagueWard', 2)
    self.def:setLvlDataUnreal('Apl3', level, 3, value)
end

function AbilityDefinitionAuraPlaguePlagueWard:setAuraDuration(level, value)
    checktype(level, 'integer', 'setAuraDuration', 1)
    checktype(value, 'float', 'setAuraDuration', 2)
    self.def:setLvlDataUnreal('Apl1', level, 1, value)
end

function AbilityDefinitionAuraPlaguePlagueWard:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Apl2', level, 2, value)
end

AbilityDefinitionCyclonecreep = class('AbilityDefinitionCyclonecreep', AbilityDefinition)
_G.AbilityDefinitionCyclonecreep = AbilityDefinitionCyclonecreep

function AbilityDefinitionCyclonecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcy')
end

function AbilityDefinitionCyclonecreep:setCanBeDispelled(level, value)
    checktype(level, 'integer', 'setCanBeDispelled', 1)
    checktype(value, 'boolean', 'setCanBeDispelled', 2)
    self.def:setLvlDataBoolean('cyc1', level, 1, value)
end

AbilityDefinitionAuraPlagueCreepnodamage = class('AbilityDefinitionAuraPlagueCreepnodamage', AbilityDefinition)
_G.AbilityDefinitionAuraPlagueCreepnodamage = AbilityDefinitionAuraPlagueCreepnodamage

function AbilityDefinitionAuraPlagueCreepnodamage:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aap4')
end

function AbilityDefinitionAuraPlagueCreepnodamage:setPlagueWardUnitType(level, value)
    checktype(level, 'integer', 'setPlagueWardUnitType', 1)
    checktype(value, 'string', 'setPlagueWardUnitType', 2)
    self.def:setLvlDataString('Aplu', level, 0, value)
end

function AbilityDefinitionAuraPlagueCreepnodamage:setDurationofPlagueWard(level, value)
    checktype(level, 'integer', 'setDurationofPlagueWard', 1)
    checktype(value, 'float', 'setDurationofPlagueWard', 2)
    self.def:setLvlDataUnreal('Apl3', level, 3, value)
end

function AbilityDefinitionAuraPlagueCreepnodamage:setAuraDuration(level, value)
    checktype(level, 'integer', 'setAuraDuration', 1)
    checktype(value, 'float', 'setAuraDuration', 2)
    self.def:setLvlDataUnreal('Apl1', level, 1, value)
end

function AbilityDefinitionAuraPlagueCreepnodamage:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Apl2', level, 2, value)
end

AbilityDefinitionLightningDamageBonus = class('AbilityDefinitionLightningDamageBonus', AbilityDefinition)
_G.AbilityDefinitionLightningDamageBonus = AbilityDefinitionLightningDamageBonus

function AbilityDefinitionLightningDamageBonus:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIlb')
end

function AbilityDefinitionLightningDamageBonus:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionLightningDamageBonus:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

function AbilityDefinitionLightningDamageBonus:setDamageBonusDice(level, value)
    checktype(level, 'integer', 'setDamageBonusDice', 1)
    checktype(value, 'integer', 'setDamageBonusDice', 2)
    self.def:setLvlDataInt('Idic', level, 1, value)
end

AbilityDefinitionArtn = class('AbilityDefinitionArtn', AbilityDefinition)
_G.AbilityDefinitionArtn = AbilityDefinitionArtn

function AbilityDefinitionArtn:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Artn')
end

function AbilityDefinitionArtn:setAcceptsGold(level, value)
    checktype(level, 'integer', 'setAcceptsGold', 1)
    checktype(value, 'boolean', 'setAcceptsGold', 2)
    self.def:setLvlDataBoolean('Rtn1', level, 1, value)
end

function AbilityDefinitionArtn:setAcceptsLumber(level, value)
    checktype(level, 'integer', 'setAcceptsLumber', 1)
    checktype(value, 'boolean', 'setAcceptsLumber', 2)
    self.def:setLvlDataBoolean('Rtn2', level, 2, value)
end

AbilityDefinitionCrushingWave = class('AbilityDefinitionCrushingWave', AbilityDefinition)
_G.AbilityDefinitionCrushingWave = AbilityDefinitionCrushingWave

function AbilityDefinitionCrushingWave:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcv')
end

function AbilityDefinitionCrushingWave:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ucs2', level, 2, value)
end

function AbilityDefinitionCrushingWave:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ucs1', level, 1, value)
end

function AbilityDefinitionCrushingWave:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionCrushingWave:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionColdArrowscreep = class('AbilityDefinitionColdArrowscreep', AbilityDefinition)
_G.AbilityDefinitionColdArrowscreep = AbilityDefinitionColdArrowscreep

function AbilityDefinitionColdArrowscreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcw')
end

function AbilityDefinitionColdArrowscreep:setStackFlags(level, value)
    checktype(level, 'integer', 'setStackFlags', 1)
    checktype(value, 'integer', 'setStackFlags', 2)
    self.def:setLvlDataInt('Hca4', level, 4, value)
end

function AbilityDefinitionColdArrowscreep:setExtraDamage(level, value)
    checktype(level, 'integer', 'setExtraDamage', 1)
    checktype(value, 'float', 'setExtraDamage', 2)
    self.def:setLvlDataUnreal('Hca1', level, 1, value)
end

function AbilityDefinitionColdArrowscreep:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Hca3', level, 3, value)
end

function AbilityDefinitionColdArrowscreep:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Hca2', level, 2, value)
end

AbilityDefinitionEatTree = class('AbilityDefinitionEatTree', AbilityDefinition)
_G.AbilityDefinitionEatTree = AbilityDefinitionEatTree

function AbilityDefinitionEatTree:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aeat')
end

function AbilityDefinitionEatTree:setEatDelay(level, value)
    checktype(level, 'integer', 'setEatDelay', 1)
    checktype(value, 'float', 'setEatDelay', 2)
    self.def:setLvlDataUnreal('Eat2', level, 2, value)
end

function AbilityDefinitionEatTree:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Eat3', level, 3, value)
end

function AbilityDefinitionEatTree:setRipDelay(level, value)
    checktype(level, 'integer', 'setRipDelay', 1)
    checktype(value, 'float', 'setRipDelay', 2)
    self.def:setLvlDataUnreal('Eat1', level, 1, value)
end

AbilityDefinitionPreservation = class('AbilityDefinitionPreservation', AbilityDefinition)
_G.AbilityDefinitionPreservation = AbilityDefinitionPreservation

function AbilityDefinitionPreservation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANpr')
end

function AbilityDefinitionPreservation:setBuildingTypesAllowed(level, value)
    checktype(level, 'integer', 'setBuildingTypesAllowed', 1)
    checktype(value, 'string', 'setBuildingTypesAllowed', 2)
    self.def:setLvlDataString('Npr1', level, 1, value)
end

AbilityDefinitionShadowMeldAkama = class('AbilityDefinitionShadowMeldAkama', AbilityDefinition)
_G.AbilityDefinitionShadowMeldAkama = AbilityDefinitionShadowMeldAkama

function AbilityDefinitionShadowMeldAkama:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahid')
end

function AbilityDefinitionShadowMeldAkama:setDayNightDuration(level, value)
    checktype(level, 'integer', 'setDayNightDuration', 1)
    checktype(value, 'float', 'setDayNightDuration', 2)
    self.def:setLvlDataUnreal('Shm2', level, 2, value)
end

function AbilityDefinitionShadowMeldAkama:setActionDuration(level, value)
    checktype(level, 'integer', 'setActionDuration', 1)
    checktype(value, 'float', 'setActionDuration', 2)
    self.def:setLvlDataUnreal('Shm3', level, 3, value)
end

function AbilityDefinitionShadowMeldAkama:setFadeDuration(level, value)
    checktype(level, 'integer', 'setFadeDuration', 1)
    checktype(value, 'float', 'setFadeDuration', 2)
    self.def:setLvlDataUnreal('Shm1', level, 1, value)
end

AbilityDefinitionCripplecreep = class('AbilityDefinitionCripplecreep', AbilityDefinition)
_G.AbilityDefinitionCripplecreep = AbilityDefinitionCripplecreep

function AbilityDefinitionCripplecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcr')
end

function AbilityDefinitionCripplecreep:setDamageReduction(level, value)
    checktype(level, 'integer', 'setDamageReduction', 1)
    checktype(value, 'float', 'setDamageReduction', 2)
    self.def:setLvlDataUnreal('Cri3', level, 3, value)
end

function AbilityDefinitionCripplecreep:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Cri2', level, 2, value)
end

function AbilityDefinitionCripplecreep:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Cri1', level, 1, value)
end

AbilityDefinitionCursecreep = class('AbilityDefinitionCursecreep', AbilityDefinition)
_G.AbilityDefinitionCursecreep = AbilityDefinitionCursecreep

function AbilityDefinitionCursecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcs')
end

function AbilityDefinitionCursecreep:setChancetoMiss(level, value)
    checktype(level, 'integer', 'setChancetoMiss', 1)
    checktype(value, 'float', 'setChancetoMiss', 2)
    self.def:setLvlDataUnreal('Crs', level, 1, value)
end

AbilityDefinitionCriticalStrikecreep = class('AbilityDefinitionCriticalStrikecreep', AbilityDefinition)
_G.AbilityDefinitionCriticalStrikecreep = AbilityDefinitionCriticalStrikecreep

function AbilityDefinitionCriticalStrikecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACct')
end

function AbilityDefinitionCriticalStrikecreep:setDamageMultiplier(level, value)
    checktype(level, 'integer', 'setDamageMultiplier', 1)
    checktype(value, 'float', 'setDamageMultiplier', 2)
    self.def:setLvlDataUnreal('Ocr2', level, 2, value)
end

function AbilityDefinitionCriticalStrikecreep:setChancetoCriticalStrike(level, value)
    checktype(level, 'integer', 'setChancetoCriticalStrike', 1)
    checktype(value, 'float', 'setChancetoCriticalStrike', 2)
    self.def:setLvlDataUnreal('Ocr1', level, 1, value)
end

function AbilityDefinitionCriticalStrikecreep:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Ocr3', level, 3, value)
end

function AbilityDefinitionCriticalStrikecreep:setChancetoEvade(level, value)
    checktype(level, 'integer', 'setChancetoEvade', 1)
    checktype(value, 'float', 'setChancetoEvade', 2)
    self.def:setLvlDataUnreal('Ocr4', level, 4, value)
end

function AbilityDefinitionCriticalStrikecreep:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Ocr5', level, 5, value)
end

AbilityDefinitionCannibalizecreep = class('AbilityDefinitionCannibalizecreep', AbilityDefinition)
_G.AbilityDefinitionCannibalizecreep = AbilityDefinitionCannibalizecreep

function AbilityDefinitionCannibalizecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcn')
end

function AbilityDefinitionCannibalizecreep:setMaxHitPoints(level, value)
    checktype(level, 'integer', 'setMaxHitPoints', 1)
    checktype(value, 'float', 'setMaxHitPoints', 2)
    self.def:setLvlDataUnreal('Can2', level, 2, value)
end

function AbilityDefinitionCannibalizecreep:setHitPointsperSecond(level, value)
    checktype(level, 'integer', 'setHitPointsperSecond', 1)
    checktype(value, 'float', 'setHitPointsperSecond', 2)
    self.def:setLvlDataUnreal('Can1', level, 1, value)
end

AbilityDefinitionCycloneCenarius = class('AbilityDefinitionCycloneCenarius', AbilityDefinition)
_G.AbilityDefinitionCycloneCenarius = AbilityDefinitionCycloneCenarius

function AbilityDefinitionCycloneCenarius:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'SCc1')
end

function AbilityDefinitionCycloneCenarius:setCanBeDispelled(level, value)
    checktype(level, 'integer', 'setCanBeDispelled', 1)
    checktype(value, 'boolean', 'setCanBeDispelled', 2)
    self.def:setLvlDataBoolean('cyc1', level, 1, value)
end

AbilityDefinitionItemManaRestoreGreater = class('AbilityDefinitionItemManaRestoreGreater', AbilityDefinition)
_G.AbilityDefinitionItemManaRestoreGreater = AbilityDefinitionItemManaRestoreGreater

function AbilityDefinitionItemManaRestoreGreater:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIm2')
end

function AbilityDefinitionItemManaRestoreGreater:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'integer', 'setManaPointsGained', 2)
    self.def:setLvlDataInt('Impg', level, 1, value)
end

AbilityDefinitionItemManaRestoreLesser = class('AbilityDefinitionItemManaRestoreLesser', AbilityDefinition)
_G.AbilityDefinitionItemManaRestoreLesser = AbilityDefinitionItemManaRestoreLesser

function AbilityDefinitionItemManaRestoreLesser:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIm1')
end

function AbilityDefinitionItemManaRestoreLesser:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'integer', 'setManaPointsGained', 2)
    self.def:setLvlDataInt('Impg', level, 1, value)
end

AbilityDefinitionStoneForm = class('AbilityDefinitionStoneForm', AbilityDefinition)
_G.AbilityDefinitionStoneForm = AbilityDefinitionStoneForm

function AbilityDefinitionStoneForm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Astn')
end

function AbilityDefinitionStoneForm:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionStoneForm:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionStoneForm:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionStoneForm:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionStoneForm:setLifeRegenerationRatepersecond(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRatepersecond', 1)
    checktype(value, 'float', 'setLifeRegenerationRatepersecond', 2)
    self.def:setLvlDataUnreal('ave5', level, 5, value)
end

function AbilityDefinitionStoneForm:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionChainLightningcreep = class('AbilityDefinitionChainLightningcreep', AbilityDefinition)
_G.AbilityDefinitionChainLightningcreep = AbilityDefinitionChainLightningcreep

function AbilityDefinitionChainLightningcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcl')
end

function AbilityDefinitionChainLightningcreep:setDamageperTarget(level, value)
    checktype(level, 'integer', 'setDamageperTarget', 1)
    checktype(value, 'float', 'setDamageperTarget', 2)
    self.def:setLvlDataUnreal('Ocl1', level, 1, value)
end

function AbilityDefinitionChainLightningcreep:setNumberofTargetsHit(level, value)
    checktype(level, 'integer', 'setNumberofTargetsHit', 1)
    checktype(value, 'integer', 'setNumberofTargetsHit', 2)
    self.def:setLvlDataInt('Ocl2', level, 2, value)
end

function AbilityDefinitionChainLightningcreep:setDamageReductionperTarget(level, value)
    checktype(level, 'integer', 'setDamageReductionperTarget', 1)
    checktype(value, 'float', 'setDamageReductionperTarget', 2)
    self.def:setLvlDataUnreal('Ocl3', level, 3, value)
end

AbilityDefinitionFaerieFire = class('AbilityDefinitionFaerieFire', AbilityDefinition)
_G.AbilityDefinitionFaerieFire = AbilityDefinitionFaerieFire

function AbilityDefinitionFaerieFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afae')
end

function AbilityDefinitionFaerieFire:setAlwaysAutocast(level, value)
    checktype(level, 'integer', 'setAlwaysAutocast', 1)
    checktype(value, 'boolean', 'setAlwaysAutocast', 2)
    self.def:setLvlDataBoolean('Fae2', level, 2, value)
end

function AbilityDefinitionFaerieFire:setDefenseReduction(level, value)
    checktype(level, 'integer', 'setDefenseReduction', 1)
    checktype(value, 'integer', 'setDefenseReduction', 2)
    self.def:setLvlDataInt('Fae1', level, 1, value)
end

AbilityDefinitionCharm = class('AbilityDefinitionCharm', AbilityDefinition)
_G.AbilityDefinitionCharm = AbilityDefinitionCharm

function AbilityDefinitionCharm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACch')
end

function AbilityDefinitionCharm:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Nch1', level, 1, value)
end

AbilityDefinitionManaSteal = class('AbilityDefinitionManaSteal', AbilityDefinition)
_G.AbilityDefinitionManaSteal = AbilityDefinitionManaSteal

function AbilityDefinitionManaSteal:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aste')
end

function AbilityDefinitionManaSteal:setLeaveTargetAlive(level, value)
    checktype(level, 'integer', 'setLeaveTargetAlive', 1)
    checktype(value, 'boolean', 'setLeaveTargetAlive', 2)
    self.def:setLvlDataBoolean('Udp5', level, 5, value)
end

function AbilityDefinitionManaSteal:setLifeConvertedtoMana(level, value)
    checktype(level, 'integer', 'setLifeConvertedtoMana', 1)
    checktype(value, 'float', 'setLifeConvertedtoMana', 2)
    self.def:setLvlDataUnreal('Udp1', level, 1, value)
end

function AbilityDefinitionManaSteal:setLifeConvertedtoLife(level, value)
    checktype(level, 'integer', 'setLifeConvertedtoLife', 1)
    checktype(value, 'float', 'setLifeConvertedtoLife', 2)
    self.def:setLvlDataUnreal('Udp2', level, 2, value)
end

function AbilityDefinitionManaSteal:setLifeConversionAsPercent(level, value)
    checktype(level, 'integer', 'setLifeConversionAsPercent', 1)
    checktype(value, 'boolean', 'setLifeConversionAsPercent', 2)
    self.def:setLvlDataBoolean('Udp4', level, 4, value)
end

function AbilityDefinitionManaSteal:setManaConversionAsPercent(level, value)
    checktype(level, 'integer', 'setManaConversionAsPercent', 1)
    checktype(value, 'boolean', 'setManaConversionAsPercent', 2)
    self.def:setLvlDataBoolean('Udp3', level, 3, value)
end

AbilityDefinitionAuraEnduranceCreep = class('AbilityDefinitionAuraEnduranceCreep', AbilityDefinition)
_G.AbilityDefinitionAuraEnduranceCreep = AbilityDefinitionAuraEnduranceCreep

function AbilityDefinitionAuraEnduranceCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'SCae')
end

function AbilityDefinitionAuraEnduranceCreep:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Oae1', level, 1, value)
end

function AbilityDefinitionAuraEnduranceCreep:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Oae2', level, 2, value)
end

AbilityDefinitionTichondriusInferno = class('AbilityDefinitionTichondriusInferno', AbilityDefinition)
_G.AbilityDefinitionTichondriusInferno = AbilityDefinitionTichondriusInferno

function AbilityDefinitionTichondriusInferno:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'SNin')
end

function AbilityDefinitionTichondriusInferno:setDuration(level, value)
    checktype(level, 'integer', 'setDuration', 1)
    checktype(value, 'float', 'setDuration', 2)
    self.def:setLvlDataUnreal('Uin2', level, 2, value)
end

function AbilityDefinitionTichondriusInferno:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Uin1', level, 1, value)
end

function AbilityDefinitionTichondriusInferno:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Uin4', level, 0, value)
end

function AbilityDefinitionTichondriusInferno:setImpactDelay(level, value)
    checktype(level, 'integer', 'setImpactDelay', 1)
    checktype(value, 'float', 'setImpactDelay', 2)
    self.def:setLvlDataUnreal('Uin3', level, 3, value)
end

AbilityDefinitionCryptLordImpale = class('AbilityDefinitionCryptLordImpale', AbilityDefinition)
_G.AbilityDefinitionCryptLordImpale = AbilityDefinitionCryptLordImpale

function AbilityDefinitionCryptLordImpale:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUim')
end

function AbilityDefinitionCryptLordImpale:setWaveTimeseconds(level, value)
    checktype(level, 'integer', 'setWaveTimeseconds', 1)
    checktype(value, 'float', 'setWaveTimeseconds', 2)
    self.def:setLvlDataUnreal('Uim2', level, 2, value)
end

function AbilityDefinitionCryptLordImpale:setAirTimeseconds(level, value)
    checktype(level, 'integer', 'setAirTimeseconds', 1)
    checktype(value, 'float', 'setAirTimeseconds', 2)
    self.def:setLvlDataUnreal('Uim4', level, 4, value)
end

function AbilityDefinitionCryptLordImpale:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Uim3', level, 3, value)
end

function AbilityDefinitionCryptLordImpale:setWaveDistance(level, value)
    checktype(level, 'integer', 'setWaveDistance', 1)
    checktype(value, 'float', 'setWaveDistance', 2)
    self.def:setLvlDataUnreal('Uim1', level, 1, value)
end

AbilityDefinitionFrostBolt = class('AbilityDefinitionFrostBolt', AbilityDefinition)
_G.AbilityDefinitionFrostBolt = AbilityDefinitionFrostBolt

function AbilityDefinitionFrostBolt:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACcb')
end

function AbilityDefinitionFrostBolt:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Htb1', level, 1, value)
end

AbilityDefinitionCarrionSwarmcreep = class('AbilityDefinitionCarrionSwarmcreep', AbilityDefinition)
_G.AbilityDefinitionCarrionSwarmcreep = AbilityDefinitionCarrionSwarmcreep

function AbilityDefinitionCarrionSwarmcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACca')
end

function AbilityDefinitionCarrionSwarmcreep:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ucs2', level, 2, value)
end

function AbilityDefinitionCarrionSwarmcreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ucs1', level, 1, value)
end

function AbilityDefinitionCarrionSwarmcreep:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionCarrionSwarmcreep:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionDreadlordInferno = class('AbilityDefinitionDreadlordInferno', AbilityDefinition)
_G.AbilityDefinitionDreadlordInferno = AbilityDefinitionDreadlordInferno

function AbilityDefinitionDreadlordInferno:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUin')
end

function AbilityDefinitionDreadlordInferno:setDuration(level, value)
    checktype(level, 'integer', 'setDuration', 1)
    checktype(value, 'float', 'setDuration', 2)
    self.def:setLvlDataUnreal('Uin2', level, 2, value)
end

function AbilityDefinitionDreadlordInferno:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Uin1', level, 1, value)
end

function AbilityDefinitionDreadlordInferno:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Uin4', level, 0, value)
end

function AbilityDefinitionDreadlordInferno:setImpactDelay(level, value)
    checktype(level, 'integer', 'setImpactDelay', 1)
    checktype(value, 'float', 'setImpactDelay', 2)
    self.def:setLvlDataUnreal('Uin3', level, 3, value)
end

AbilityDefinitionWispHarvestInvulnerable = class('AbilityDefinitionWispHarvestInvulnerable', AbilityDefinition)
_G.AbilityDefinitionWispHarvestInvulnerable = AbilityDefinitionWispHarvestInvulnerable

function AbilityDefinitionWispHarvestInvulnerable:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awh2')
end

function AbilityDefinitionWispHarvestInvulnerable:setArtAttachmentHeight(level, value)
    checktype(level, 'integer', 'setArtAttachmentHeight', 1)
    checktype(value, 'float', 'setArtAttachmentHeight', 2)
    self.def:setLvlDataUnreal('Wha3', level, 3, value)
end

function AbilityDefinitionWispHarvestInvulnerable:setIntervalsBeforeChangingTrees(level, value)
    checktype(level, 'integer', 'setIntervalsBeforeChangingTrees', 1)
    checktype(value, 'integer', 'setIntervalsBeforeChangingTrees', 2)
    self.def:setLvlDataInt('Wha2', level, 2, value)
end

function AbilityDefinitionWispHarvestInvulnerable:setLumberperInterval(level, value)
    checktype(level, 'integer', 'setLumberperInterval', 1)
    checktype(value, 'float', 'setLumberperInterval', 2)
    self.def:setLvlDataUnreal('Wha1', level, 1, value)
end

AbilityDefinitionOrbofAnnihilation = class('AbilityDefinitionOrbofAnnihilation', AbilityDefinition)
_G.AbilityDefinitionOrbofAnnihilation = AbilityDefinitionOrbofAnnihilation

function AbilityDefinitionOrbofAnnihilation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afak')
end

function AbilityDefinitionOrbofAnnihilation:setSmallDamageFactor(level, value)
    checktype(level, 'integer', 'setSmallDamageFactor', 1)
    checktype(value, 'float', 'setSmallDamageFactor', 2)
    self.def:setLvlDataUnreal('fak3', level, 3, value)
end

function AbilityDefinitionOrbofAnnihilation:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('fak1', level, 1, value)
end

function AbilityDefinitionOrbofAnnihilation:setHalfDamageRadius(level, value)
    checktype(level, 'integer', 'setHalfDamageRadius', 1)
    checktype(value, 'float', 'setHalfDamageRadius', 2)
    self.def:setLvlDataUnreal('fak5', level, 5, value)
end

function AbilityDefinitionOrbofAnnihilation:setMediumDamageFactor(level, value)
    checktype(level, 'integer', 'setMediumDamageFactor', 1)
    checktype(value, 'float', 'setMediumDamageFactor', 2)
    self.def:setLvlDataUnreal('fak2', level, 2, value)
end

function AbilityDefinitionOrbofAnnihilation:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('fak4', level, 4, value)
end

AbilityDefinitionMaxManaBonusLeast = class('AbilityDefinitionMaxManaBonusLeast', AbilityDefinition)
_G.AbilityDefinitionMaxManaBonusLeast = AbilityDefinitionMaxManaBonusLeast

function AbilityDefinitionMaxManaBonusLeast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImb')
end

function AbilityDefinitionMaxManaBonusLeast:setMaxManaGained(level, value)
    checktype(level, 'integer', 'setMaxManaGained', 1)
    checktype(value, 'integer', 'setMaxManaGained', 2)
    self.def:setLvlDataInt('Iman', level, 1, value)
end

AbilityDefinitionNeutralBuildinganyunit = class('AbilityDefinitionNeutralBuildinganyunit', AbilityDefinition)
_G.AbilityDefinitionNeutralBuildinganyunit = AbilityDefinitionNeutralBuildinganyunit

function AbilityDefinitionNeutralBuildinganyunit:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ane2')
end

function AbilityDefinitionNeutralBuildinganyunit:setShowUnitIndicator(level, value)
    checktype(level, 'integer', 'setShowUnitIndicator', 1)
    checktype(value, 'boolean', 'setShowUnitIndicator', 2)
    self.def:setLvlDataBoolean('Neu4', level, 4, value)
end

function AbilityDefinitionNeutralBuildinganyunit:setActivationRadius(level, value)
    checktype(level, 'integer', 'setActivationRadius', 1)
    checktype(value, 'float', 'setActivationRadius', 2)
    self.def:setLvlDataUnreal('Neu1', level, 1, value)
end

function AbilityDefinitionNeutralBuildinganyunit:setShowSelectUnitButton(level, value)
    checktype(level, 'integer', 'setShowSelectUnitButton', 1)
    checktype(value, 'boolean', 'setShowSelectUnitButton', 2)
    self.def:setLvlDataBoolean('Neu3', level, 3, value)
end

function AbilityDefinitionNeutralBuildinganyunit:setInteractionType(level, value)
    checktype(level, 'integer', 'setInteractionType', 1)
    checktype(value, 'integer', 'setInteractionType', 2)
    self.def:setLvlDataInt('Neu2', level, 2, value)
end

AbilityDefinitionGhost = class('AbilityDefinitionGhost', AbilityDefinition)
_G.AbilityDefinitionGhost = AbilityDefinitionGhost

function AbilityDefinitionGhost:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Agho')
end

function AbilityDefinitionGhost:setDoesNotBlockBuildings(level, value)
    checktype(level, 'integer', 'setDoesNotBlockBuildings', 1)
    checktype(value, 'boolean', 'setDoesNotBlockBuildings', 2)
    self.def:setLvlDataBoolean('Gho3', level, 3, value)
end

function AbilityDefinitionGhost:setImmunetoMorphEffects(level, value)
    checktype(level, 'integer', 'setImmunetoMorphEffects', 1)
    checktype(value, 'boolean', 'setImmunetoMorphEffects', 2)
    self.def:setLvlDataBoolean('Gho2', level, 2, value)
end

function AbilityDefinitionGhost:setAutoAcquireAttackTargets(level, value)
    checktype(level, 'integer', 'setAutoAcquireAttackTargets', 1)
    checktype(value, 'boolean', 'setAutoAcquireAttackTargets', 2)
    self.def:setLvlDataBoolean('Gho1', level, 1, value)
end

AbilityDefinitionDevourCreep = class('AbilityDefinitionDevourCreep', AbilityDefinition)
_G.AbilityDefinitionDevourCreep = AbilityDefinitionDevourCreep

function AbilityDefinitionDevourCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACdv')
end

function AbilityDefinitionDevourCreep:setMaxCreepLevel(level, value)
    checktype(level, 'integer', 'setMaxCreepLevel', 1)
    checktype(value, 'integer', 'setMaxCreepLevel', 2)
    self.def:setLvlDataInt('Dev1', level, 1, value)
end

AbilityDefinitionGiveLumber = class('AbilityDefinitionGiveLumber', AbilityDefinition)
_G.AbilityDefinitionGiveLumber = AbilityDefinitionGiveLumber

function AbilityDefinitionGiveLumber:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIlu')
end

function AbilityDefinitionGiveLumber:setLumberGiven(level, value)
    checktype(level, 'integer', 'setLumberGiven', 1)
    checktype(value, 'integer', 'setLumberGiven', 2)
    self.def:setLvlDataInt('Ilum', level, 1, value)
end

AbilityDefinitionFireBoltwarlock = class('AbilityDefinitionFireBoltwarlock', AbilityDefinition)
_G.AbilityDefinitionFireBoltwarlock = AbilityDefinitionFireBoltwarlock

function AbilityDefinitionFireBoltwarlock:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awfb')
end

function AbilityDefinitionFireBoltwarlock:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Htb1', level, 1, value)
end

AbilityDefinitionDrainLifeCreep = class('AbilityDefinitionDrainLifeCreep', AbilityDefinition)
_G.AbilityDefinitionDrainLifeCreep = AbilityDefinitionDrainLifeCreep

function AbilityDefinitionDrainLifeCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACdr')
end

function AbilityDefinitionDrainLifeCreep:setBonusLifeDecay(level, value)
    checktype(level, 'integer', 'setBonusLifeDecay', 1)
    checktype(value, 'float', 'setBonusLifeDecay', 2)
    self.def:setLvlDataUnreal('Ndr7', level, 7, value)
end

function AbilityDefinitionDrainLifeCreep:setManaTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setManaTransferredPerSecond', 1)
    checktype(value, 'float', 'setManaTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr5', level, 5, value)
end

function AbilityDefinitionDrainLifeCreep:setBonusManaDecay(level, value)
    checktype(level, 'integer', 'setBonusManaDecay', 1)
    checktype(value, 'float', 'setBonusManaDecay', 2)
    self.def:setLvlDataUnreal('Ndr9', level, 9, value)
end

function AbilityDefinitionDrainLifeCreep:setBonusLifeFactor(level, value)
    checktype(level, 'integer', 'setBonusLifeFactor', 1)
    checktype(value, 'float', 'setBonusLifeFactor', 2)
    self.def:setLvlDataUnreal('Ndr6', level, 6, value)
end

function AbilityDefinitionDrainLifeCreep:setBonusManaFactor(level, value)
    checktype(level, 'integer', 'setBonusManaFactor', 1)
    checktype(value, 'float', 'setBonusManaFactor', 2)
    self.def:setLvlDataUnreal('Ndr8', level, 8, value)
end

function AbilityDefinitionDrainLifeCreep:setLifeTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setLifeTransferredPerSecond', 1)
    checktype(value, 'float', 'setLifeTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr4', level, 4, value)
end

AbilityDefinitionPaladinHolyLight = class('AbilityDefinitionPaladinHolyLight', AbilityDefinition)
_G.AbilityDefinitionPaladinHolyLight = AbilityDefinitionPaladinHolyLight

function AbilityDefinitionPaladinHolyLight:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHhb')
end

function AbilityDefinitionPaladinHolyLight:setAmountHealedDamaged(level, value)
    checktype(level, 'integer', 'setAmountHealedDamaged', 1)
    checktype(value, 'float', 'setAmountHealedDamaged', 2)
    self.def:setLvlDataUnreal('Hhb1', level, 1, value)
end

AbilityDefinitionLevelMod = class('AbilityDefinitionLevelMod', AbilityDefinition)
_G.AbilityDefinitionLevelMod = AbilityDefinitionLevelMod

function AbilityDefinitionLevelMod:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIlm')
end

function AbilityDefinitionLevelMod:setLevelsGained(level, value)
    checktype(level, 'integer', 'setLevelsGained', 1)
    checktype(value, 'integer', 'setLevelsGained', 2)
    self.def:setLvlDataInt('Ilev', level, 1, value)
end

AbilityDefinitionOrbofLightning = class('AbilityDefinitionOrbofLightning', AbilityDefinition)
_G.AbilityDefinitionOrbofLightning = AbilityDefinitionOrbofLightning

function AbilityDefinitionOrbofLightning:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIll')
end

function AbilityDefinitionOrbofLightning:setChanceToHitUnits(level, value)
    checktype(level, 'integer', 'setChanceToHitUnits', 1)
    checktype(value, 'float', 'setChanceToHitUnits', 2)
    self.def:setLvlDataUnreal('Iob2', level, 2, value)
end

function AbilityDefinitionOrbofLightning:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionOrbofLightning:setChanceToHitSummons(level, value)
    checktype(level, 'integer', 'setChanceToHitSummons', 1)
    checktype(value, 'float', 'setChanceToHitSummons', 2)
    self.def:setLvlDataUnreal('Iob4', level, 4, value)
end

function AbilityDefinitionOrbofLightning:setChanceToHitHeros(level, value)
    checktype(level, 'integer', 'setChanceToHitHeros', 1)
    checktype(value, 'float', 'setChanceToHitHeros', 2)
    self.def:setLvlDataUnreal('Iob3', level, 3, value)
end

function AbilityDefinitionOrbofLightning:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

function AbilityDefinitionOrbofLightning:setEffectAbility(level, value)
    checktype(level, 'integer', 'setEffectAbility', 1)
    checktype(value, 'string', 'setEffectAbility', 2)
    self.def:setLvlDataString('Iobu', level, 0, value)
end

AbilityDefinitionLightningShieldAIls = class('AbilityDefinitionLightningShieldAIls', AbilityDefinition)
_G.AbilityDefinitionLightningShieldAIls = AbilityDefinitionLightningShieldAIls

function AbilityDefinitionLightningShieldAIls:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIls')
end

function AbilityDefinitionLightningShieldAIls:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Idps', level, 1, value)
end

AbilityDefinitionAbolishMagicCreep = class('AbilityDefinitionAbolishMagicCreep', AbilityDefinition)
_G.AbilityDefinitionAbolishMagicCreep = AbilityDefinitionAbolishMagicCreep

function AbilityDefinitionAbolishMagicCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACdm')
end

function AbilityDefinitionAbolishMagicCreep:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'float', 'setManaLoss', 2)
    self.def:setLvlDataUnreal('Adm1', level, 1, value)
end

function AbilityDefinitionAbolishMagicCreep:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Adm2', level, 2, value)
end

AbilityDefinitionLightningPurge = class('AbilityDefinitionLightningPurge', AbilityDefinition)
_G.AbilityDefinitionLightningPurge = AbilityDefinitionLightningPurge

function AbilityDefinitionLightningPurge:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIlp')
end

function AbilityDefinitionLightningPurge:setHeroPauseDuration(level, value)
    checktype(level, 'integer', 'setHeroPauseDuration', 1)
    checktype(value, 'float', 'setHeroPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg5', level, 5, value)
end

function AbilityDefinitionLightningPurge:setUnitPauseDuration(level, value)
    checktype(level, 'integer', 'setUnitPauseDuration', 1)
    checktype(value, 'float', 'setUnitPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg4', level, 4, value)
end

function AbilityDefinitionLightningPurge:setMovementUpdateFrequency(level, value)
    checktype(level, 'integer', 'setMovementUpdateFrequency', 1)
    checktype(value, 'integer', 'setMovementUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg1', level, 1, value)
end

function AbilityDefinitionLightningPurge:setAttackUpdateFrequency(level, value)
    checktype(level, 'integer', 'setAttackUpdateFrequency', 1)
    checktype(value, 'integer', 'setAttackUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg2', level, 2, value)
end

function AbilityDefinitionLightningPurge:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Prg6', level, 6, value)
end

function AbilityDefinitionLightningPurge:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Prg3', level, 3, value)
end

AbilityDefinitionMaxLifeBonusLeast = class('AbilityDefinitionMaxLifeBonusLeast', AbilityDefinition)
_G.AbilityDefinitionMaxLifeBonusLeast = AbilityDefinitionMaxLifeBonusLeast

function AbilityDefinitionMaxLifeBonusLeast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIlf')
end

function AbilityDefinitionMaxLifeBonusLeast:setMaxLifeGained(level, value)
    checktype(level, 'integer', 'setMaxLifeGained', 1)
    checktype(value, 'integer', 'setMaxLifeGained', 2)
    self.def:setLvlDataInt('Ilif', level, 1, value)
end

AbilityDefinitionParasite = class('AbilityDefinitionParasite', AbilityDefinition)
_G.AbilityDefinitionParasite = AbilityDefinitionParasite

function AbilityDefinitionParasite:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANpa')
end

function AbilityDefinitionParasite:setStackingType(level, value)
    checktype(level, 'integer', 'setStackingType', 1)
    checktype(value, 'integer', 'setStackingType', 2)
    self.def:setLvlDataInt('Poi4', level, 4, value)
end

function AbilityDefinitionParasite:setSummonedUnitDuration(level, value)
    checktype(level, 'integer', 'setSummonedUnitDuration', 1)
    checktype(value, 'float', 'setSummonedUnitDuration', 2)
    self.def:setLvlDataUnreal('Npa6', level, 0, value)
end

function AbilityDefinitionParasite:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Npa5', level, 5, value)
end

function AbilityDefinitionParasite:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi2', level, 2, value)
end

function AbilityDefinitionParasite:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Poi1', level, 1, value)
end

function AbilityDefinitionParasite:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi3', level, 3, value)
end

function AbilityDefinitionParasite:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('ipmu', level, 0, value)
end

AbilityDefinitionDemonHunterMetamorphosis = class('AbilityDefinitionDemonHunterMetamorphosis', AbilityDefinition)
_G.AbilityDefinitionDemonHunterMetamorphosis = AbilityDefinitionDemonHunterMetamorphosis

function AbilityDefinitionDemonHunterMetamorphosis:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEme')
end

function AbilityDefinitionDemonHunterMetamorphosis:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionDemonHunterMetamorphosis:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionDemonHunterMetamorphosis:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionDemonHunterMetamorphosis:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionDemonHunterMetamorphosis:setAlternateFormHitPointBonus(level, value)
    checktype(level, 'integer', 'setAlternateFormHitPointBonus', 1)
    checktype(value, 'float', 'setAlternateFormHitPointBonus', 2)
    self.def:setLvlDataUnreal('Eme5', level, 5, value)
end

function AbilityDefinitionDemonHunterMetamorphosis:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionDevourMagiccreep = class('AbilityDefinitionDevourMagiccreep', AbilityDefinition)
_G.AbilityDefinitionDevourMagiccreep = AbilityDefinitionDevourMagiccreep

function AbilityDefinitionDevourMagiccreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACde')
end

function AbilityDefinitionDevourMagiccreep:setIgnoreFriendlyBuffs(level, value)
    checktype(level, 'integer', 'setIgnoreFriendlyBuffs', 1)
    checktype(value, 'boolean', 'setIgnoreFriendlyBuffs', 2)
    self.def:setLvlDataBoolean('dvm6', level, 6, value)
end

AbilityDefinitionAapl = class('AbilityDefinitionAapl', AbilityDefinition)
_G.AbilityDefinitionAapl = AbilityDefinitionAapl

function AbilityDefinitionAapl:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aapl')
end

function AbilityDefinitionAapl:setPlagueWardUnitType(level, value)
    checktype(level, 'integer', 'setPlagueWardUnitType', 1)
    checktype(value, 'string', 'setPlagueWardUnitType', 2)
    self.def:setLvlDataString('Aplu', level, 0, value)
end

function AbilityDefinitionAapl:setDurationofPlagueWard(level, value)
    checktype(level, 'integer', 'setDurationofPlagueWard', 1)
    checktype(value, 'float', 'setDurationofPlagueWard', 2)
    self.def:setLvlDataUnreal('Apl3', level, 3, value)
end

function AbilityDefinitionAapl:setAuraDuration(level, value)
    checktype(level, 'integer', 'setAuraDuration', 1)
    checktype(value, 'float', 'setAuraDuration', 2)
    self.def:setLvlDataUnreal('Apl1', level, 1, value)
end

function AbilityDefinitionAapl:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Apl2', level, 2, value)
end

AbilityDefinitionDeathCoilcreep = class('AbilityDefinitionDeathCoilcreep', AbilityDefinition)
_G.AbilityDefinitionDeathCoilcreep = AbilityDefinitionDeathCoilcreep

function AbilityDefinitionDeathCoilcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACdc')
end

function AbilityDefinitionDeathCoilcreep:setAmountHealedDamaged(level, value)
    checktype(level, 'integer', 'setAmountHealedDamaged', 1)
    checktype(value, 'float', 'setAmountHealedDamaged', 2)
    self.def:setLvlDataUnreal('Udc1', level, 1, value)
end

AbilityDefinitionDemonHunterManaBurn = class('AbilityDefinitionDemonHunterManaBurn', AbilityDefinition)
_G.AbilityDefinitionDemonHunterManaBurn = AbilityDefinitionDemonHunterManaBurn

function AbilityDefinitionDemonHunterManaBurn:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEmb')
end

function AbilityDefinitionDemonHunterManaBurn:setMaxManaDrained(level, value)
    checktype(level, 'integer', 'setMaxManaDrained', 1)
    checktype(value, 'float', 'setMaxManaDrained', 2)
    self.def:setLvlDataUnreal('Emb1', level, 1, value)
end

function AbilityDefinitionDemonHunterManaBurn:setBoltLifetime(level, value)
    checktype(level, 'integer', 'setBoltLifetime', 1)
    checktype(value, 'float', 'setBoltLifetime', 2)
    self.def:setLvlDataUnreal('Emb3', level, 3, value)
end

function AbilityDefinitionDemonHunterManaBurn:setBoltDelay(level, value)
    checktype(level, 'integer', 'setBoltDelay', 1)
    checktype(value, 'float', 'setBoltDelay', 2)
    self.def:setLvlDataUnreal('Emb2', level, 2, value)
end

AbilityDefinitionLichFrostArmorAutocast = class('AbilityDefinitionLichFrostArmorAutocast', AbilityDefinition)
_G.AbilityDefinitionLichFrostArmorAutocast = AbilityDefinitionLichFrostArmorAutocast

function AbilityDefinitionLichFrostArmorAutocast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUfu')
end

function AbilityDefinitionLichFrostArmorAutocast:setArmorDuration(level, value)
    checktype(level, 'integer', 'setArmorDuration', 1)
    checktype(value, 'float', 'setArmorDuration', 2)
    self.def:setLvlDataUnreal('Ufa1', level, 1, value)
end

function AbilityDefinitionLichFrostArmorAutocast:setArmorBonus(level, value)
    checktype(level, 'integer', 'setArmorBonus', 1)
    checktype(value, 'float', 'setArmorBonus', 2)
    self.def:setLvlDataUnreal('Ufa2', level, 2, value)
end

AbilityDefinitionAnimateDeaditemspecial = class('AbilityDefinitionAnimateDeaditemspecial', AbilityDefinition)
_G.AbilityDefinitionAnimateDeaditemspecial = AbilityDefinitionAnimateDeaditemspecial

function AbilityDefinitionAnimateDeaditemspecial:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AInd')
end

function AbilityDefinitionAnimateDeaditemspecial:setInheritUpgrades(level, value)
    checktype(level, 'integer', 'setInheritUpgrades', 1)
    checktype(value, 'boolean', 'setInheritUpgrades', 2)
    self.def:setLvlDataBoolean('Uan3', level, 3, value)
end

AbilityDefinitionFrostArmorcreep = class('AbilityDefinitionFrostArmorcreep', AbilityDefinition)
_G.AbilityDefinitionFrostArmorcreep = AbilityDefinitionFrostArmorcreep

function AbilityDefinitionFrostArmorcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACfa')
end

function AbilityDefinitionFrostArmorcreep:setArmorDuration(level, value)
    checktype(level, 'integer', 'setArmorDuration', 1)
    checktype(value, 'float', 'setArmorDuration', 2)
    self.def:setLvlDataUnreal('Ufa1', level, 1, value)
end

function AbilityDefinitionFrostArmorcreep:setArmorBonus(level, value)
    checktype(level, 'integer', 'setArmorBonus', 1)
    checktype(value, 'float', 'setArmorBonus', 2)
    self.def:setLvlDataUnreal('Ufa2', level, 2, value)
end

AbilityDefinitionManaBatteryObsidianStatue = class('AbilityDefinitionManaBatteryObsidianStatue', AbilityDefinition)
_G.AbilityDefinitionManaBatteryObsidianStatue = AbilityDefinitionManaBatteryObsidianStatue

function AbilityDefinitionManaBatteryObsidianStatue:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amb2')
end

function AbilityDefinitionManaBatteryObsidianStatue:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Mbt2', level, 2, value)
end

function AbilityDefinitionManaBatteryObsidianStatue:setWaterHeight(level, value)
    checktype(level, 'integer', 'setWaterHeight', 1)
    checktype(value, 'float', 'setWaterHeight', 2)
    self.def:setLvlDataUnreal('Mbt4', level, 4, value)
end

function AbilityDefinitionManaBatteryObsidianStatue:setAutocastRequirement(level, value)
    checktype(level, 'integer', 'setAutocastRequirement', 1)
    checktype(value, 'float', 'setAutocastRequirement', 2)
    self.def:setLvlDataUnreal('Mbt3', level, 3, value)
end

function AbilityDefinitionManaBatteryObsidianStatue:setManaGained(level, value)
    checktype(level, 'integer', 'setManaGained', 1)
    checktype(value, 'float', 'setManaGained', 2)
    self.def:setLvlDataUnreal('Mbt1', level, 1, value)
end

function AbilityDefinitionManaBatteryObsidianStatue:setRegenerateOnlyAtNight(level, value)
    checktype(level, 'integer', 'setRegenerateOnlyAtNight', 1)
    checktype(value, 'boolean', 'setRegenerateOnlyAtNight', 2)
    self.def:setLvlDataBoolean('Mbt5', level, 5, value)
end

AbilityDefinitionFireBoltcreep = class('AbilityDefinitionFireBoltcreep', AbilityDefinition)
_G.AbilityDefinitionFireBoltcreep = AbilityDefinitionFireBoltcreep

function AbilityDefinitionFireBoltcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACfb')
end

function AbilityDefinitionFireBoltcreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Htb1', level, 1, value)
end

AbilityDefinitionEvasioncreep100 = class('AbilityDefinitionEvasioncreep100', AbilityDefinition)
_G.AbilityDefinitionEvasioncreep100 = AbilityDefinitionEvasioncreep100

function AbilityDefinitionEvasioncreep100:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACes')
end

function AbilityDefinitionEvasioncreep100:setChancetoEvade(level, value)
    checktype(level, 'integer', 'setChancetoEvade', 1)
    checktype(value, 'float', 'setChancetoEvade', 2)
    self.def:setLvlDataUnreal('Eev1', level, 1, value)
end

AbilityDefinitionVenomSpears = class('AbilityDefinitionVenomSpears', AbilityDefinition)
_G.AbilityDefinitionVenomSpears = AbilityDefinitionVenomSpears

function AbilityDefinitionVenomSpears:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aven')
end

function AbilityDefinitionVenomSpears:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi2', level, 2, value)
end

function AbilityDefinitionVenomSpears:setStackingType(level, value)
    checktype(level, 'integer', 'setStackingType', 1)
    checktype(value, 'integer', 'setStackingType', 2)
    self.def:setLvlDataInt('Poi4', level, 4, value)
end

function AbilityDefinitionVenomSpears:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Poi1', level, 1, value)
end

function AbilityDefinitionVenomSpears:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi3', level, 3, value)
end

AbilityDefinitionEvasioncreep = class('AbilityDefinitionEvasioncreep', AbilityDefinition)
_G.AbilityDefinitionEvasioncreep = AbilityDefinitionEvasioncreep

function AbilityDefinitionEvasioncreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIev')
end

function AbilityDefinitionEvasioncreep:setChancetoEvade(level, value)
    checktype(level, 'integer', 'setChancetoEvade', 1)
    checktype(value, 'float', 'setChancetoEvade', 2)
    self.def:setLvlDataUnreal('Eev1', level, 1, value)
end

AbilityDefinitionCargoHoldBurrow = class('AbilityDefinitionCargoHoldBurrow', AbilityDefinition)
_G.AbilityDefinitionCargoHoldBurrow = AbilityDefinitionCargoHoldBurrow

function AbilityDefinitionCargoHoldBurrow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abun')
end

function AbilityDefinitionCargoHoldBurrow:setCargoCapacity(level, value)
    checktype(level, 'integer', 'setCargoCapacity', 1)
    checktype(value, 'integer', 'setCargoCapacity', 2)
    self.def:setLvlDataInt('Car1', level, 1, value)
end

AbilityDefinitionMagicImmunityAImx = class('AbilityDefinitionMagicImmunityAImx', AbilityDefinition)
_G.AbilityDefinitionMagicImmunityAImx = AbilityDefinitionMagicImmunityAImx

function AbilityDefinitionMagicImmunityAImx:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImx')
end

function AbilityDefinitionMagicImmunityAImx:setMagicDamageFactor(level, value)
    checktype(level, 'integer', 'setMagicDamageFactor', 1)
    checktype(value, 'float', 'setMagicDamageFactor', 2)
    self.def:setLvlDataUnreal('mim1', level, 1, value)
end

AbilityDefinitionBurrow = class('AbilityDefinitionBurrow', AbilityDefinition)
_G.AbilityDefinitionBurrow = AbilityDefinitionBurrow

function AbilityDefinitionBurrow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abur')
end

function AbilityDefinitionBurrow:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionBurrow:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionBurrow:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionBurrow:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionBurrow:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionCyclone = class('AbilityDefinitionCyclone', AbilityDefinition)
_G.AbilityDefinitionCyclone = AbilityDefinitionCyclone

function AbilityDefinitionCyclone:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acyc')
end

function AbilityDefinitionCyclone:setCanBeDispelled(level, value)
    checktype(level, 'integer', 'setCanBeDispelled', 1)
    checktype(value, 'boolean', 'setCanBeDispelled', 2)
    self.def:setLvlDataBoolean('cyc1', level, 1, value)
end

AbilityDefinitionItemManaRestoreAoe = class('AbilityDefinitionItemManaRestoreAoe', AbilityDefinition)
_G.AbilityDefinitionItemManaRestoreAoe = AbilityDefinitionItemManaRestoreAoe

function AbilityDefinitionItemManaRestoreAoe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImr')
end

function AbilityDefinitionItemManaRestoreAoe:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'integer', 'setManaPointsGained', 2)
    self.def:setLvlDataInt('Impg', level, 1, value)
end

AbilityDefinitionStaffoTeleportation = class('AbilityDefinitionStaffoTeleportation', AbilityDefinition)
_G.AbilityDefinitionStaffoTeleportation = AbilityDefinitionStaffoTeleportation

function AbilityDefinitionStaffoTeleportation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImt')
end

function AbilityDefinitionStaffoTeleportation:setUseTeleportClustering(level, value)
    checktype(level, 'integer', 'setUseTeleportClustering', 1)
    checktype(value, 'boolean', 'setUseTeleportClustering', 2)
    self.def:setLvlDataBoolean('Hmt3', level, 3, value)
end

function AbilityDefinitionStaffoTeleportation:setCastingDelay(level, value)
    checktype(level, 'integer', 'setCastingDelay', 1)
    checktype(value, 'float', 'setCastingDelay', 2)
    self.def:setLvlDataUnreal('Hmt2', level, 2, value)
end

function AbilityDefinitionStaffoTeleportation:setNumberofUnitsTeleported(level, value)
    checktype(level, 'integer', 'setNumberofUnitsTeleported', 1)
    checktype(value, 'integer', 'setNumberofUnitsTeleported', 2)
    self.def:setLvlDataInt('Hmt1', level, 1, value)
end

AbilityDefinitionEnsnareCreep = class('AbilityDefinitionEnsnareCreep', AbilityDefinition)
_G.AbilityDefinitionEnsnareCreep = AbilityDefinitionEnsnareCreep

function AbilityDefinitionEnsnareCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACen')
end

function AbilityDefinitionEnsnareCreep:setAirUnitHeight(level, value)
    checktype(level, 'integer', 'setAirUnitHeight', 1)
    checktype(value, 'float', 'setAirUnitHeight', 2)
    self.def:setLvlDataUnreal('Ens2', level, 2, value)
end

function AbilityDefinitionEnsnareCreep:setAirUnitLowerDuration(level, value)
    checktype(level, 'integer', 'setAirUnitLowerDuration', 1)
    checktype(value, 'float', 'setAirUnitLowerDuration', 2)
    self.def:setLvlDataUnreal('Ens1', level, 1, value)
end

function AbilityDefinitionEnsnareCreep:setMeleeAttackRange(level, value)
    checktype(level, 'integer', 'setMeleeAttackRange', 1)
    checktype(value, 'float', 'setMeleeAttackRange', 2)
    self.def:setLvlDataUnreal('Ens3', level, 3, value)
end

AbilityDefinitionMoveSpeedBonus = class('AbilityDefinitionMoveSpeedBonus', AbilityDefinition)
_G.AbilityDefinitionMoveSpeedBonus = AbilityDefinitionMoveSpeedBonus

function AbilityDefinitionMoveSpeedBonus:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIms')
end

function AbilityDefinitionMoveSpeedBonus:setMovementSpeedBonus(level, value)
    checktype(level, 'integer', 'setMovementSpeedBonus', 1)
    checktype(value, 'integer', 'setMovementSpeedBonus', 2)
    self.def:setLvlDataInt('Imvb', level, 1, value)
end

AbilityDefinitionPhoenix = class('AbilityDefinitionPhoenix', AbilityDefinition)
_G.AbilityDefinitionPhoenix = AbilityDefinitionPhoenix

function AbilityDefinitionPhoenix:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aphx')
end

function AbilityDefinitionPhoenix:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionPhoenix:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionPhoenix:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionPhoenix:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionPhoenix:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionNeutralSpell = class('AbilityDefinitionNeutralSpell', AbilityDefinition)
_G.AbilityDefinitionNeutralSpell = AbilityDefinitionNeutralSpell

function AbilityDefinitionNeutralSpell:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AAns')
end

function AbilityDefinitionNeutralSpell:setChargeOwningPlayer(level, value)
    checktype(level, 'integer', 'setChargeOwningPlayer', 1)
    checktype(value, 'boolean', 'setChargeOwningPlayer', 2)
    self.def:setLvlDataBoolean('Ans6', level, 6, value)
end

function AbilityDefinitionNeutralSpell:setGoldCost(level, value)
    checktype(level, 'integer', 'setGoldCost', 1)
    checktype(value, 'integer', 'setGoldCost', 2)
    self.def:setLvlDataInt('Ndt1', level, 1, value)
end

function AbilityDefinitionNeutralSpell:setBaseOrderID(level, value)
    checktype(level, 'integer', 'setBaseOrderID', 1)
    checktype(value, 'string', 'setBaseOrderID', 2)
    self.def:setLvlDataString('Ans5', level, 5, value)
end

function AbilityDefinitionNeutralSpell:setLumberCost(level, value)
    checktype(level, 'integer', 'setLumberCost', 1)
    checktype(value, 'integer', 'setLumberCost', 2)
    self.def:setLvlDataInt('Ndt2', level, 2, value)
end

AbilityDefinitionAImm = class('AbilityDefinitionAImm', AbilityDefinition)
_G.AbilityDefinitionAImm = AbilityDefinitionAImm

function AbilityDefinitionAImm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImm')
end

function AbilityDefinitionAImm:setMaxManaGained(level, value)
    checktype(level, 'integer', 'setMaxManaGained', 1)
    checktype(value, 'integer', 'setMaxManaGained', 2)
    self.def:setLvlDataInt('Iman', level, 1, value)
end

AbilityDefinitionShadowHunterHealingWave = class('AbilityDefinitionShadowHunterHealingWave', AbilityDefinition)
_G.AbilityDefinitionShadowHunterHealingWave = AbilityDefinitionShadowHunterHealingWave

function AbilityDefinitionShadowHunterHealingWave:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOhw')
end

function AbilityDefinitionShadowHunterHealingWave:setDamageperTarget(level, value)
    checktype(level, 'integer', 'setDamageperTarget', 1)
    checktype(value, 'float', 'setDamageperTarget', 2)
    self.def:setLvlDataUnreal('Ocl1', level, 1, value)
end

function AbilityDefinitionShadowHunterHealingWave:setNumberofTargetsHit(level, value)
    checktype(level, 'integer', 'setNumberofTargetsHit', 1)
    checktype(value, 'integer', 'setNumberofTargetsHit', 2)
    self.def:setLvlDataInt('Ocl2', level, 2, value)
end

function AbilityDefinitionShadowHunterHealingWave:setDamageReductionperTarget(level, value)
    checktype(level, 'integer', 'setDamageReductionperTarget', 1)
    checktype(value, 'float', 'setDamageReductionperTarget', 2)
    self.def:setLvlDataUnreal('Ocl3', level, 3, value)
end

AbilityDefinitionShadowHunterHex = class('AbilityDefinitionShadowHunterHex', AbilityDefinition)
_G.AbilityDefinitionShadowHunterHex = AbilityDefinitionShadowHunterHex

function AbilityDefinitionShadowHunterHex:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOhx')
end

function AbilityDefinitionShadowHunterHex:setMorphUnitsGround(level, value)
    checktype(level, 'integer', 'setMorphUnitsGround', 1)
    checktype(value, 'string', 'setMorphUnitsGround', 2)
    self.def:setLvlDataString('Ply2', level, 2, value)
end

function AbilityDefinitionShadowHunterHex:setMorphUnitsWater(level, value)
    checktype(level, 'integer', 'setMorphUnitsWater', 1)
    checktype(value, 'string', 'setMorphUnitsWater', 2)
    self.def:setLvlDataString('Ply5', level, 5, value)
end

function AbilityDefinitionShadowHunterHex:setMorphUnitsAmphibious(level, value)
    checktype(level, 'integer', 'setMorphUnitsAmphibious', 1)
    checktype(value, 'string', 'setMorphUnitsAmphibious', 2)
    self.def:setLvlDataString('Ply4', level, 4, value)
end

function AbilityDefinitionShadowHunterHex:setMorphUnitsAir(level, value)
    checktype(level, 'integer', 'setMorphUnitsAir', 1)
    checktype(value, 'string', 'setMorphUnitsAir', 2)
    self.def:setLvlDataString('Ply3', level, 3, value)
end

function AbilityDefinitionShadowHunterHex:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Ply1', level, 1, value)
end

AbilityDefinitionItemMonsterLure = class('AbilityDefinitionItemMonsterLure', AbilityDefinition)
_G.AbilityDefinitionItemMonsterLure = AbilityDefinitionItemMonsterLure

function AbilityDefinitionItemMonsterLure:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImo')
end

function AbilityDefinitionItemMonsterLure:setLureUnitType(level, value)
    checktype(level, 'integer', 'setLureUnitType', 1)
    checktype(value, 'string', 'setLureUnitType', 2)
    self.def:setLvlDataString('imou', level, 0, value)
end

function AbilityDefinitionItemMonsterLure:setNumberofLures(level, value)
    checktype(level, 'integer', 'setNumberofLures', 1)
    checktype(value, 'integer', 'setNumberofLures', 2)
    self.def:setLvlDataInt('imo1', level, 1, value)
end

function AbilityDefinitionItemMonsterLure:setActivationDelay(level, value)
    checktype(level, 'integer', 'setActivationDelay', 1)
    checktype(value, 'float', 'setActivationDelay', 2)
    self.def:setLvlDataUnreal('imo2', level, 2, value)
end

function AbilityDefinitionItemMonsterLure:setLureIntervalseconds(level, value)
    checktype(level, 'integer', 'setLureIntervalseconds', 1)
    checktype(value, 'float', 'setLureIntervalseconds', 2)
    self.def:setLvlDataUnreal('imo3', level, 3, value)
end

AbilityDefinitionAImi = class('AbilityDefinitionAImi', AbilityDefinition)
_G.AbilityDefinitionAImi = AbilityDefinitionAImi

function AbilityDefinitionAImi:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImi')
end

function AbilityDefinitionAImi:setMaxLifeGained(level, value)
    checktype(level, 'integer', 'setMaxLifeGained', 1)
    checktype(value, 'integer', 'setMaxLifeGained', 2)
    self.def:setLvlDataInt('Ilif', level, 1, value)
end

AbilityDefinitionAIml = class('AbilityDefinitionAIml', AbilityDefinition)
_G.AbilityDefinitionAIml = AbilityDefinitionAIml

function AbilityDefinitionAIml:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIml')
end

function AbilityDefinitionAIml:setMaxLifeGained(level, value)
    checktype(level, 'integer', 'setMaxLifeGained', 1)
    checktype(value, 'integer', 'setMaxLifeGained', 2)
    self.def:setLvlDataInt('Ilif', level, 1, value)
end

AbilityDefinitionPermanentHitpointBonusfromchargeditem = class('AbilityDefinitionPermanentHitpointBonusfromchargeditem', AbilityDefinition)
_G.AbilityDefinitionPermanentHitpointBonusfromchargeditem = AbilityDefinitionPermanentHitpointBonusfromchargeditem

function AbilityDefinitionPermanentHitpointBonusfromchargeditem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AImh')
end

function AbilityDefinitionPermanentHitpointBonusfromchargeditem:setMaxLifeGained(level, value)
    checktype(level, 'integer', 'setMaxLifeGained', 1)
    checktype(value, 'integer', 'setMaxLifeGained', 2)
    self.def:setLvlDataInt('Ilif', level, 1, value)
end

AbilityDefinitionFeedbackArcaneTower = class('AbilityDefinitionFeedbackArcaneTower', AbilityDefinition)
_G.AbilityDefinitionFeedbackArcaneTower = AbilityDefinitionFeedbackArcaneTower

function AbilityDefinitionFeedbackArcaneTower:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afbt')
end

function AbilityDefinitionFeedbackArcaneTower:setSummonedDamage(level, value)
    checktype(level, 'integer', 'setSummonedDamage', 1)
    checktype(value, 'float', 'setSummonedDamage', 2)
    self.def:setLvlDataUnreal('fbk5', level, 5, value)
end

AbilityDefinitionChaosGrunt = class('AbilityDefinitionChaosGrunt', AbilityDefinition)
_G.AbilityDefinitionChaosGrunt = AbilityDefinitionChaosGrunt

function AbilityDefinitionChaosGrunt:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sca1')
end

function AbilityDefinitionChaosGrunt:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionChaosRaider = class('AbilityDefinitionChaosRaider', AbilityDefinition)
_G.AbilityDefinitionChaosRaider = AbilityDefinitionChaosRaider

function AbilityDefinitionChaosRaider:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sca2')
end

function AbilityDefinitionChaosRaider:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionStasisTrap = class('AbilityDefinitionStasisTrap', AbilityDefinition)
_G.AbilityDefinitionStasisTrap = AbilityDefinitionStasisTrap

function AbilityDefinitionStasisTrap:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asta')
end

function AbilityDefinitionStasisTrap:setWardUnitType(level, value)
    checktype(level, 'integer', 'setWardUnitType', 1)
    checktype(value, 'string', 'setWardUnitType', 2)
    self.def:setLvlDataString('Stau', level, 0, value)
end

function AbilityDefinitionStasisTrap:setActivationDelay(level, value)
    checktype(level, 'integer', 'setActivationDelay', 1)
    checktype(value, 'float', 'setActivationDelay', 2)
    self.def:setLvlDataUnreal('Sta1', level, 1, value)
end

function AbilityDefinitionStasisTrap:setDetectionRadius(level, value)
    checktype(level, 'integer', 'setDetectionRadius', 1)
    checktype(value, 'float', 'setDetectionRadius', 2)
    self.def:setLvlDataUnreal('Sta2', level, 2, value)
end

function AbilityDefinitionStasisTrap:setDetonationRadius(level, value)
    checktype(level, 'integer', 'setDetonationRadius', 1)
    checktype(value, 'float', 'setDetonationRadius', 2)
    self.def:setLvlDataUnreal('Sta3', level, 3, value)
end

function AbilityDefinitionStasisTrap:setStunDuration(level, value)
    checktype(level, 'integer', 'setStunDuration', 1)
    checktype(value, 'float', 'setStunDuration', 2)
    self.def:setLvlDataUnreal('Sta4', level, 4, value)
end

AbilityDefinitionPermanentImmolationgraphic = class('AbilityDefinitionPermanentImmolationgraphic', AbilityDefinition)
_G.AbilityDefinitionPermanentImmolationgraphic = AbilityDefinitionPermanentImmolationgraphic

function AbilityDefinitionPermanentImmolationgraphic:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apig')
end

function AbilityDefinitionPermanentImmolationgraphic:setManaDrainedperSecond(level, value)
    checktype(level, 'integer', 'setManaDrainedperSecond', 1)
    checktype(value, 'float', 'setManaDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Eim2', level, 2, value)
end

function AbilityDefinitionPermanentImmolationgraphic:setBufferManaRequired(level, value)
    checktype(level, 'integer', 'setBufferManaRequired', 1)
    checktype(value, 'float', 'setBufferManaRequired', 2)
    self.def:setLvlDataUnreal('Eim3', level, 3, value)
end

function AbilityDefinitionPermanentImmolationgraphic:setDamageperInterval(level, value)
    checktype(level, 'integer', 'setDamageperInterval', 1)
    checktype(value, 'float', 'setDamageperInterval', 2)
    self.def:setLvlDataUnreal('Eim1', level, 1, value)
end

AbilityDefinitionChaosShaman = class('AbilityDefinitionChaosShaman', AbilityDefinition)
_G.AbilityDefinitionChaosShaman = AbilityDefinitionChaosShaman

function AbilityDefinitionChaosShaman:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sca3')
end

function AbilityDefinitionChaosShaman:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionChaosKodo = class('AbilityDefinitionChaosKodo', AbilityDefinition)
_G.AbilityDefinitionChaosKodo = AbilityDefinitionChaosKodo

function AbilityDefinitionChaosKodo:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sca4')
end

function AbilityDefinitionChaosKodo:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionChaosPeon = class('AbilityDefinitionChaosPeon', AbilityDefinition)
_G.AbilityDefinitionChaosPeon = AbilityDefinitionChaosPeon

function AbilityDefinitionChaosPeon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sca5')
end

function AbilityDefinitionChaosPeon:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionFrostDamageBonus = class('AbilityDefinitionFrostDamageBonus', AbilityDefinition)
_G.AbilityDefinitionFrostDamageBonus = AbilityDefinitionFrostDamageBonus

function AbilityDefinitionFrostDamageBonus:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIob')
end

function AbilityDefinitionFrostDamageBonus:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionFrostDamageBonus:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

AbilityDefinitionChaosGrom = class('AbilityDefinitionChaosGrom', AbilityDefinition)
_G.AbilityDefinitionChaosGrom = AbilityDefinitionChaosGrom

function AbilityDefinitionChaosGrom:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sca6')
end

function AbilityDefinitionChaosGrom:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionInnerFire = class('AbilityDefinitionInnerFire', AbilityDefinition)
_G.AbilityDefinitionInnerFire = AbilityDefinitionInnerFire

function AbilityDefinitionInnerFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ainf')
end

function AbilityDefinitionInnerFire:setAutocastRange(level, value)
    checktype(level, 'integer', 'setAutocastRange', 1)
    checktype(value, 'float', 'setAutocastRange', 2)
    self.def:setLvlDataUnreal('Inf3', level, 3, value)
end

function AbilityDefinitionInnerFire:setLifeRegenRate(level, value)
    checktype(level, 'integer', 'setLifeRegenRate', 1)
    checktype(value, 'float', 'setLifeRegenRate', 2)
    self.def:setLvlDataUnreal('Inf4', level, 4, value)
end

function AbilityDefinitionInnerFire:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Inf2', level, 2, value)
end

function AbilityDefinitionInnerFire:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Inf1', level, 1, value)
end

AbilityDefinitionMoonPriestessSearingArrows = class('AbilityDefinitionMoonPriestessSearingArrows', AbilityDefinition)
_G.AbilityDefinitionMoonPriestessSearingArrows = AbilityDefinitionMoonPriestessSearingArrows

function AbilityDefinitionMoonPriestessSearingArrows:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHfa')
end

function AbilityDefinitionMoonPriestessSearingArrows:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Hfa1', level, 1, value)
end

AbilityDefinitionMonsoon = class('AbilityDefinitionMonsoon', AbilityDefinition)
_G.AbilityDefinitionMonsoon = AbilityDefinitionMonsoon

function AbilityDefinitionMonsoon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANmo')
end

function AbilityDefinitionMonsoon:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Esf1', level, 1, value)
end

function AbilityDefinitionMonsoon:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Esf2', level, 2, value)
end

function AbilityDefinitionMonsoon:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Esf3', level, 3, value)
end

AbilityDefinitionInventory = class('AbilityDefinitionInventory', AbilityDefinition)
_G.AbilityDefinitionInventory = AbilityDefinitionInventory

function AbilityDefinitionInventory:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AInv')
end

function AbilityDefinitionInventory:setCanDropItems(level, value)
    checktype(level, 'integer', 'setCanDropItems', 1)
    checktype(value, 'boolean', 'setCanDropItems', 2)
    self.def:setLvlDataBoolean('inv5', level, 5, value)
end

function AbilityDefinitionInventory:setCanUseItems(level, value)
    checktype(level, 'integer', 'setCanUseItems', 1)
    checktype(value, 'boolean', 'setCanUseItems', 2)
    self.def:setLvlDataBoolean('inv3', level, 3, value)
end

function AbilityDefinitionInventory:setDropItemsOnDeath(level, value)
    checktype(level, 'integer', 'setDropItemsOnDeath', 1)
    checktype(value, 'boolean', 'setDropItemsOnDeath', 2)
    self.def:setLvlDataBoolean('inv2', level, 2, value)
end

function AbilityDefinitionInventory:setCanGetItems(level, value)
    checktype(level, 'integer', 'setCanGetItems', 1)
    checktype(value, 'boolean', 'setCanGetItems', 2)
    self.def:setLvlDataBoolean('inv4', level, 4, value)
end

function AbilityDefinitionInventory:setItemCapacity(level, value)
    checktype(level, 'integer', 'setItemCapacity', 1)
    checktype(value, 'integer', 'setItemCapacity', 2)
    self.def:setLvlDataInt('inv1', level, 1, value)
end

AbilityDefinitionnullroarsummoner = class('AbilityDefinitionnullroarsummoner', AbilityDefinition)
_G.AbilityDefinitionnullroarsummoner = AbilityDefinitionnullroarsummoner

function AbilityDefinitionnullroarsummoner:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahnl')
end

function AbilityDefinitionnullroarsummoner:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionnullroarsummoner:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

function AbilityDefinitionnullroarsummoner:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionnullroarsummoner:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

AbilityDefinitionSeaWitchManaShield = class('AbilityDefinitionSeaWitchManaShield', AbilityDefinition)
_G.AbilityDefinitionSeaWitchManaShield = AbilityDefinitionSeaWitchManaShield

function AbilityDefinitionSeaWitchManaShield:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANms')
end

function AbilityDefinitionSeaWitchManaShield:setDamageAbsorbed(level, value)
    checktype(level, 'integer', 'setDamageAbsorbed', 1)
    checktype(value, 'float', 'setDamageAbsorbed', 2)
    self.def:setLvlDataUnreal('Nms2', level, 2, value)
end

function AbilityDefinitionSeaWitchManaShield:setManaperHitPoint(level, value)
    checktype(level, 'integer', 'setManaperHitPoint', 1)
    checktype(value, 'float', 'setManaperHitPoint', 2)
    self.def:setLvlDataUnreal('Nms1', level, 1, value)
end

AbilityDefinitionSpawnSpiderlingOnDeath = class('AbilityDefinitionSpawnSpiderlingOnDeath', AbilityDefinition)
_G.AbilityDefinitionSpawnSpiderlingOnDeath = AbilityDefinitionSpawnSpiderlingOnDeath

function AbilityDefinitionSpawnSpiderlingOnDeath:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Assp')
end

function AbilityDefinitionSpawnSpiderlingOnDeath:setNumberofUnits(level, value)
    checktype(level, 'integer', 'setNumberofUnits', 1)
    checktype(value, 'integer', 'setNumberofUnits', 2)
    self.def:setLvlDataInt('Sod1', level, 1, value)
end

function AbilityDefinitionSpawnSpiderlingOnDeath:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('Sod2', level, 2, value)
end

AbilityDefinitionScrollofRejuvII = class('AbilityDefinitionScrollofRejuvII', AbilityDefinition)
_G.AbilityDefinitionScrollofRejuvII = AbilityDefinitionScrollofRejuvII

function AbilityDefinitionScrollofRejuvII:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIp6')
end

function AbilityDefinitionScrollofRejuvII:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionScrollofRejuvII:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionScrollofRejuvII:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionScrollofRejuvII:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionScrollofRejuvII:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionMindRot = class('AbilityDefinitionMindRot', AbilityDefinition)
_G.AbilityDefinitionMindRot = AbilityDefinitionMindRot

function AbilityDefinitionMindRot:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANmr')
end

function AbilityDefinitionMindRot:setManaDrainedperSecond(level, value)
    checktype(level, 'integer', 'setManaDrainedperSecond', 1)
    checktype(value, 'float', 'setManaDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Nmr1', level, 1, value)
end

AbilityDefinitionFrostNovacreep = class('AbilityDefinitionFrostNovacreep', AbilityDefinition)
_G.AbilityDefinitionFrostNovacreep = AbilityDefinitionFrostNovacreep

function AbilityDefinitionFrostNovacreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACfn')
end

function AbilityDefinitionFrostNovacreep:setAreaofEffectDamage(level, value)
    checktype(level, 'integer', 'setAreaofEffectDamage', 1)
    checktype(value, 'float', 'setAreaofEffectDamage', 2)
    self.def:setLvlDataUnreal('Ufn1', level, 1, value)
end

function AbilityDefinitionFrostNovacreep:setSpecificTargetDamage(level, value)
    checktype(level, 'integer', 'setSpecificTargetDamage', 1)
    checktype(value, 'float', 'setSpecificTargetDamage', 2)
    self.def:setLvlDataUnreal('Ufn2', level, 2, value)
end

AbilityDefinitionScrollofRejuvI = class('AbilityDefinitionScrollofRejuvI', AbilityDefinition)
_G.AbilityDefinitionScrollofRejuvI = AbilityDefinitionScrollofRejuvI

function AbilityDefinitionScrollofRejuvI:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIp5')
end

function AbilityDefinitionScrollofRejuvI:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionScrollofRejuvI:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionScrollofRejuvI:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionScrollofRejuvI:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionScrollofRejuvI:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionPermanentInvisibility = class('AbilityDefinitionPermanentInvisibility', AbilityDefinition)
_G.AbilityDefinitionPermanentInvisibility = AbilityDefinitionPermanentInvisibility

function AbilityDefinitionPermanentInvisibility:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apiv')
end

function AbilityDefinitionPermanentInvisibility:setAutoAcquireAttackTargets(level, value)
    checktype(level, 'integer', 'setAutoAcquireAttackTargets', 1)
    checktype(value, 'boolean', 'setAutoAcquireAttackTargets', 2)
    self.def:setLvlDataBoolean('Gho1', level, 1, value)
end

AbilityDefinitionFeedbackSpiritBeast = class('AbilityDefinitionFeedbackSpiritBeast', AbilityDefinition)
_G.AbilityDefinitionFeedbackSpiritBeast = AbilityDefinitionFeedbackSpiritBeast

function AbilityDefinitionFeedbackSpiritBeast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afbb')
end

function AbilityDefinitionFeedbackSpiritBeast:setSummonedDamage(level, value)
    checktype(level, 'integer', 'setSummonedDamage', 1)
    checktype(value, 'float', 'setSummonedDamage', 2)
    self.def:setLvlDataUnreal('fbk5', level, 5, value)
end

AbilityDefinitionPotionofRejuvIV = class('AbilityDefinitionPotionofRejuvIV', AbilityDefinition)
_G.AbilityDefinitionPotionofRejuvIV = AbilityDefinitionPotionofRejuvIV

function AbilityDefinitionPotionofRejuvIV:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIp4')
end

function AbilityDefinitionPotionofRejuvIV:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionPotionofRejuvIV:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionPotionofRejuvIV:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionPotionofRejuvIV:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionPotionofRejuvIV:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionPotionofRejuvIII = class('AbilityDefinitionPotionofRejuvIII', AbilityDefinition)
_G.AbilityDefinitionPotionofRejuvIII = AbilityDefinitionPotionofRejuvIII

function AbilityDefinitionPotionofRejuvIII:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIp3')
end

function AbilityDefinitionPotionofRejuvIII:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionPotionofRejuvIII:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionPotionofRejuvIII:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionPotionofRejuvIII:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionPotionofRejuvIII:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionFlameStrikeCreep = class('AbilityDefinitionFlameStrikeCreep', AbilityDefinition)
_G.AbilityDefinitionFlameStrikeCreep = AbilityDefinitionFlameStrikeCreep

function AbilityDefinitionFlameStrikeCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACfs')
end

function AbilityDefinitionFlameStrikeCreep:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Hfs5', level, 5, value)
end

function AbilityDefinitionFlameStrikeCreep:setMaximumDamage(level, value)
    checktype(level, 'integer', 'setMaximumDamage', 1)
    checktype(value, 'float', 'setMaximumDamage', 2)
    self.def:setLvlDataUnreal('Hfs6', level, 6, value)
end

function AbilityDefinitionFlameStrikeCreep:setHalfDamageDealt(level, value)
    checktype(level, 'integer', 'setHalfDamageDealt', 1)
    checktype(value, 'float', 'setHalfDamageDealt', 2)
    self.def:setLvlDataUnreal('Hfs3', level, 3, value)
end

function AbilityDefinitionFlameStrikeCreep:setFullDamageDealt(level, value)
    checktype(level, 'integer', 'setFullDamageDealt', 1)
    checktype(value, 'float', 'setFullDamageDealt', 2)
    self.def:setLvlDataUnreal('Hfs1', level, 1, value)
end

function AbilityDefinitionFlameStrikeCreep:setHalfDamageInterval(level, value)
    checktype(level, 'integer', 'setHalfDamageInterval', 1)
    checktype(value, 'float', 'setHalfDamageInterval', 2)
    self.def:setLvlDataUnreal('Hfs4', level, 4, value)
end

function AbilityDefinitionFlameStrikeCreep:setFullDamageInterval(level, value)
    checktype(level, 'integer', 'setFullDamageInterval', 1)
    checktype(value, 'float', 'setFullDamageInterval', 2)
    self.def:setLvlDataUnreal('Hfs2', level, 2, value)
end

AbilityDefinitionWispHarvest = class('AbilityDefinitionWispHarvest', AbilityDefinition)
_G.AbilityDefinitionWispHarvest = AbilityDefinitionWispHarvest

function AbilityDefinitionWispHarvest:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awha')
end

function AbilityDefinitionWispHarvest:setArtAttachmentHeight(level, value)
    checktype(level, 'integer', 'setArtAttachmentHeight', 1)
    checktype(value, 'float', 'setArtAttachmentHeight', 2)
    self.def:setLvlDataUnreal('Wha3', level, 3, value)
end

function AbilityDefinitionWispHarvest:setIntervalsBeforeChangingTrees(level, value)
    checktype(level, 'integer', 'setIntervalsBeforeChangingTrees', 1)
    checktype(value, 'integer', 'setIntervalsBeforeChangingTrees', 2)
    self.def:setLvlDataInt('Wha2', level, 2, value)
end

function AbilityDefinitionWispHarvest:setLumberperInterval(level, value)
    checktype(level, 'integer', 'setLumberperInterval', 1)
    checktype(value, 'float', 'setLumberperInterval', 2)
    self.def:setLvlDataUnreal('Wha1', level, 1, value)
end

AbilityDefinitionPotionofRejuvII = class('AbilityDefinitionPotionofRejuvII', AbilityDefinition)
_G.AbilityDefinitionPotionofRejuvII = AbilityDefinitionPotionofRejuvII

function AbilityDefinitionPotionofRejuvII:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIp2')
end

function AbilityDefinitionPotionofRejuvII:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionPotionofRejuvII:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionPotionofRejuvII:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionPotionofRejuvII:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionPotionofRejuvII:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionHardenedSkin = class('AbilityDefinitionHardenedSkin', AbilityDefinition)
_G.AbilityDefinitionHardenedSkin = AbilityDefinitionHardenedSkin

function AbilityDefinitionHardenedSkin:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Assk')
end

function AbilityDefinitionHardenedSkin:setIncludeRangedDamage(level, value)
    checktype(level, 'integer', 'setIncludeRangedDamage', 1)
    checktype(value, 'boolean', 'setIncludeRangedDamage', 2)
    self.def:setLvlDataBoolean('Ssk4', level, 4, value)
end

function AbilityDefinitionHardenedSkin:setMinimumDamage(level, value)
    checktype(level, 'integer', 'setMinimumDamage', 1)
    checktype(value, 'float', 'setMinimumDamage', 2)
    self.def:setLvlDataUnreal('Ssk2', level, 2, value)
end

function AbilityDefinitionHardenedSkin:setIgnoredDamage(level, value)
    checktype(level, 'integer', 'setIgnoredDamage', 1)
    checktype(value, 'float', 'setIgnoredDamage', 2)
    self.def:setLvlDataUnreal('Ssk3', level, 3, value)
end

function AbilityDefinitionHardenedSkin:setChancetoReduceDamage(level, value)
    checktype(level, 'integer', 'setChancetoReduceDamage', 1)
    checktype(value, 'float', 'setChancetoReduceDamage', 2)
    self.def:setLvlDataUnreal('Ssk1', level, 1, value)
end

function AbilityDefinitionHardenedSkin:setIncludeMeleeDamage(level, value)
    checktype(level, 'integer', 'setIncludeMeleeDamage', 1)
    checktype(value, 'boolean', 'setIncludeMeleeDamage', 2)
    self.def:setLvlDataBoolean('Ssk5', level, 5, value)
end

AbilityDefinitionForceofNaturecreep = class('AbilityDefinitionForceofNaturecreep', AbilityDefinition)
_G.AbilityDefinitionForceofNaturecreep = AbilityDefinitionForceofNaturecreep

function AbilityDefinitionForceofNaturecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACfr')
end

function AbilityDefinitionForceofNaturecreep:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Efnu', level, 0, value)
end

function AbilityDefinitionForceofNaturecreep:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Efn1', level, 1, value)
end

AbilityDefinitionPotionofRejuvI = class('AbilityDefinitionPotionofRejuvI', AbilityDefinition)
_G.AbilityDefinitionPotionofRejuvI = AbilityDefinitionPotionofRejuvI

function AbilityDefinitionPotionofRejuvI:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIp1')
end

function AbilityDefinitionPotionofRejuvI:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionPotionofRejuvI:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionPotionofRejuvI:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionPotionofRejuvI:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionPotionofRejuvI:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionFeedback = class('AbilityDefinitionFeedback', AbilityDefinition)
_G.AbilityDefinitionFeedback = AbilityDefinitionFeedback

function AbilityDefinitionFeedback:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afbk')
end

function AbilityDefinitionFeedback:setSummonedDamage(level, value)
    checktype(level, 'integer', 'setSummonedDamage', 1)
    checktype(value, 'float', 'setSummonedDamage', 2)
    self.def:setLvlDataUnreal('fbk5', level, 5, value)
end

function AbilityDefinitionFeedback:setDamageRatioUnits(level, value)
    checktype(level, 'integer', 'setDamageRatioUnits', 1)
    checktype(value, 'float', 'setDamageRatioUnits', 2)
    self.def:setLvlDataUnreal('fbk2', level, 2, value)
end

function AbilityDefinitionFeedback:setMaxManaDrainedHeros(level, value)
    checktype(level, 'integer', 'setMaxManaDrainedHeros', 1)
    checktype(value, 'float', 'setMaxManaDrainedHeros', 2)
    self.def:setLvlDataUnreal('fbk3', level, 3, value)
end

function AbilityDefinitionFeedback:setMaxManaDrainedUnits(level, value)
    checktype(level, 'integer', 'setMaxManaDrainedUnits', 1)
    checktype(value, 'float', 'setMaxManaDrainedUnits', 2)
    self.def:setLvlDataUnreal('fbk1', level, 1, value)
end

function AbilityDefinitionFeedback:setDamageRatioHeros(level, value)
    checktype(level, 'integer', 'setDamageRatioHeros', 1)
    checktype(value, 'float', 'setDamageRatioHeros', 2)
    self.def:setLvlDataUnreal('fbk4', level, 4, value)
end

AbilityDefinitionStrengthModPlus2 = class('AbilityDefinitionStrengthModPlus2', AbilityDefinition)
_G.AbilityDefinitionStrengthModPlus2 = AbilityDefinitionStrengthModPlus2

function AbilityDefinitionStrengthModPlus2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AInm')
end

function AbilityDefinitionStrengthModPlus2:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionStrengthModPlus2:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionStrengthModPlus2:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionStrengthModPlus2:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionFaerieFirecreep = class('AbilityDefinitionFaerieFirecreep', AbilityDefinition)
_G.AbilityDefinitionFaerieFirecreep = AbilityDefinitionFaerieFirecreep

function AbilityDefinitionFaerieFirecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACff')
end

function AbilityDefinitionFaerieFirecreep:setAlwaysAutocast(level, value)
    checktype(level, 'integer', 'setAlwaysAutocast', 1)
    checktype(value, 'boolean', 'setAlwaysAutocast', 2)
    self.def:setLvlDataBoolean('Fae2', level, 2, value)
end

function AbilityDefinitionFaerieFirecreep:setDefenseReduction(level, value)
    checktype(level, 'integer', 'setDefenseReduction', 1)
    checktype(value, 'integer', 'setDefenseReduction', 2)
    self.def:setLvlDataInt('Fae1', level, 1, value)
end

AbilityDefinitionAarm = class('AbilityDefinitionAarm', AbilityDefinition)
_G.AbilityDefinitionAarm = AbilityDefinitionAarm

function AbilityDefinitionAarm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aarm')
end

function AbilityDefinitionAarm:setPercentage(level, value)
    checktype(level, 'integer', 'setPercentage', 1)
    checktype(value, 'boolean', 'setPercentage', 2)
    self.def:setLvlDataBoolean('Arm2', level, 2, value)
end

function AbilityDefinitionAarm:setAmountRegenerated(level, value)
    checktype(level, 'integer', 'setAmountRegenerated', 1)
    checktype(value, 'float', 'setAmountRegenerated', 2)
    self.def:setLvlDataUnreal('Arm1', level, 1, value)
end

AbilityDefinitionBloodMageFlameStrike = class('AbilityDefinitionBloodMageFlameStrike', AbilityDefinition)
_G.AbilityDefinitionBloodMageFlameStrike = AbilityDefinitionBloodMageFlameStrike

function AbilityDefinitionBloodMageFlameStrike:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHfs')
end

function AbilityDefinitionBloodMageFlameStrike:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Hfs5', level, 5, value)
end

function AbilityDefinitionBloodMageFlameStrike:setMaximumDamage(level, value)
    checktype(level, 'integer', 'setMaximumDamage', 1)
    checktype(value, 'float', 'setMaximumDamage', 2)
    self.def:setLvlDataUnreal('Hfs6', level, 6, value)
end

function AbilityDefinitionBloodMageFlameStrike:setHalfDamageDealt(level, value)
    checktype(level, 'integer', 'setHalfDamageDealt', 1)
    checktype(value, 'float', 'setHalfDamageDealt', 2)
    self.def:setLvlDataUnreal('Hfs3', level, 3, value)
end

function AbilityDefinitionBloodMageFlameStrike:setFullDamageDealt(level, value)
    checktype(level, 'integer', 'setFullDamageDealt', 1)
    checktype(value, 'float', 'setFullDamageDealt', 2)
    self.def:setLvlDataUnreal('Hfs1', level, 1, value)
end

function AbilityDefinitionBloodMageFlameStrike:setHalfDamageInterval(level, value)
    checktype(level, 'integer', 'setHalfDamageInterval', 1)
    checktype(value, 'float', 'setHalfDamageInterval', 2)
    self.def:setLvlDataUnreal('Hfs4', level, 4, value)
end

function AbilityDefinitionBloodMageFlameStrike:setFullDamageInterval(level, value)
    checktype(level, 'integer', 'setFullDamageInterval', 1)
    checktype(value, 'float', 'setFullDamageInterval', 2)
    self.def:setLvlDataUnreal('Hfs2', level, 2, value)
end

AbilityDefinitionBloodlustCreep = class('AbilityDefinitionBloodlustCreep', AbilityDefinition)
_G.AbilityDefinitionBloodlustCreep = AbilityDefinitionBloodlustCreep

function AbilityDefinitionBloodlustCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACbl')
end

function AbilityDefinitionBloodlustCreep:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Blo2', level, 2, value)
end

function AbilityDefinitionBloodlustCreep:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Blo1', level, 1, value)
end

function AbilityDefinitionBloodlustCreep:setScalingFactor(level, value)
    checktype(level, 'integer', 'setScalingFactor', 1)
    checktype(value, 'float', 'setScalingFactor', 2)
    self.def:setLvlDataUnreal('Blo3', level, 3, value)
end

AbilityDefinitionRoarAIrr = class('AbilityDefinitionRoarAIrr', AbilityDefinition)
_G.AbilityDefinitionRoarAIrr = AbilityDefinitionRoarAIrr

function AbilityDefinitionRoarAIrr:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrr')
end

function AbilityDefinitionRoarAIrr:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Roa1', level, 1, value)
end

function AbilityDefinitionRoarAIrr:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Roa2', level, 2, value)
end

function AbilityDefinitionRoarAIrr:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionRoarAIrr:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

function AbilityDefinitionRoarAIrr:setLifeRegenerationRate(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRate', 1)
    checktype(value, 'float', 'setLifeRegenerationRate', 2)
    self.def:setLvlDataUnreal('Roa3', level, 3, value)
end

function AbilityDefinitionRoarAIrr:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionRoarAIrr:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

AbilityDefinitionResurrection = class('AbilityDefinitionResurrection', AbilityDefinition)
_G.AbilityDefinitionResurrection = AbilityDefinitionResurrection

function AbilityDefinitionResurrection:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrs')
end

function AbilityDefinitionResurrection:setRaisedUnitsAreInvulnerable(level, value)
    checktype(level, 'integer', 'setRaisedUnitsAreInvulnerable', 1)
    checktype(value, 'boolean', 'setRaisedUnitsAreInvulnerable', 2)
    self.def:setLvlDataBoolean('Hre2', level, 2, value)
end

function AbilityDefinitionResurrection:setNumberofCorpsesRaised(level, value)
    checktype(level, 'integer', 'setNumberofCorpsesRaised', 1)
    checktype(value, 'integer', 'setNumberofCorpsesRaised', 2)
    self.def:setLvlDataInt('Hre1', level, 1, value)
end

AbilityDefinitionItemRecall = class('AbilityDefinitionItemRecall', AbilityDefinition)
_G.AbilityDefinitionItemRecall = AbilityDefinitionItemRecall

function AbilityDefinitionItemRecall:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrt')
end

function AbilityDefinitionItemRecall:setMaximumNumberofUnits(level, value)
    checktype(level, 'integer', 'setMaximumNumberofUnits', 1)
    checktype(value, 'integer', 'setMaximumNumberofUnits', 2)
    self.def:setLvlDataInt('Irec', level, 1, value)
end

function AbilityDefinitionItemRecall:setUseTeleportClustering(level, value)
    checktype(level, 'integer', 'setUseTeleportClustering', 1)
    checktype(value, 'boolean', 'setUseTeleportClustering', 2)
    self.def:setLvlDataBoolean('Itp2', level, 2, value)
end

AbilityDefinitionAttackBonusAIt6 = class('AbilityDefinitionAttackBonusAIt6', AbilityDefinition)
_G.AbilityDefinitionAttackBonusAIt6 = AbilityDefinitionAttackBonusAIt6

function AbilityDefinitionAttackBonusAIt6:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIt6')
end

function AbilityDefinitionAttackBonusAIt6:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionItemRevealMap = class('AbilityDefinitionItemRevealMap', AbilityDefinition)
_G.AbilityDefinitionItemRevealMap = AbilityDefinitionItemRevealMap

function AbilityDefinitionItemRevealMap:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrv')
end

function AbilityDefinitionItemRevealMap:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionBashcreep = class('AbilityDefinitionBashcreep', AbilityDefinition)
_G.AbilityDefinitionBashcreep = AbilityDefinitionBashcreep

function AbilityDefinitionBashcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACbh')
end

function AbilityDefinitionBashcreep:setChancetoBash(level, value)
    checktype(level, 'integer', 'setChancetoBash', 1)
    checktype(value, 'float', 'setChancetoBash', 2)
    self.def:setLvlDataUnreal('Hbh1', level, 1, value)
end

function AbilityDefinitionBashcreep:setChancetoMiss(level, value)
    checktype(level, 'integer', 'setChancetoMiss', 1)
    checktype(value, 'float', 'setChancetoMiss', 2)
    self.def:setLvlDataUnreal('Hbh4', level, 4, value)
end

function AbilityDefinitionBashcreep:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Hbh3', level, 3, value)
end

function AbilityDefinitionBashcreep:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Hbh5', level, 5, value)
end

function AbilityDefinitionBashcreep:setDamageMultiplier(level, value)
    checktype(level, 'integer', 'setDamageMultiplier', 1)
    checktype(value, 'float', 'setDamageMultiplier', 2)
    self.def:setLvlDataUnreal('Hbh2', level, 2, value)
end

AbilityDefinitionAlchemistChemicalRage = class('AbilityDefinitionAlchemistChemicalRage', AbilityDefinition)
_G.AbilityDefinitionAlchemistChemicalRage = AbilityDefinitionAlchemistChemicalRage

function AbilityDefinitionAlchemistChemicalRage:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANcr')
end

function AbilityDefinitionAlchemistChemicalRage:setAttackSpeedBonusInfoPanelOnly(level, value)
    checktype(level, 'integer', 'setAttackSpeedBonusInfoPanelOnly', 1)
    checktype(value, 'float', 'setAttackSpeedBonusInfoPanelOnly', 2)
    self.def:setLvlDataUnreal('Ncr6', level, 6, value)
end

function AbilityDefinitionAlchemistChemicalRage:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionAlchemistChemicalRage:setMoveSpeedBonusInfoPanelOnly(level, value)
    checktype(level, 'integer', 'setMoveSpeedBonusInfoPanelOnly', 1)
    checktype(value, 'float', 'setMoveSpeedBonusInfoPanelOnly', 2)
    self.def:setLvlDataUnreal('Ncr5', level, 5, value)
end

function AbilityDefinitionAlchemistChemicalRage:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionAlchemistChemicalRage:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionAlchemistChemicalRage:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionAlchemistChemicalRage:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionTinkererClusterRocketsLevel0 = class('AbilityDefinitionTinkererClusterRocketsLevel0', AbilityDefinition)
_G.AbilityDefinitionTinkererClusterRocketsLevel0 = AbilityDefinitionTinkererClusterRocketsLevel0

function AbilityDefinitionTinkererClusterRocketsLevel0:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANcs')
end

function AbilityDefinitionTinkererClusterRocketsLevel0:setEffectDuration(level, value)
    checktype(level, 'integer', 'setEffectDuration', 1)
    checktype(value, 'float', 'setEffectDuration', 2)
    self.def:setLvlDataUnreal('Ncs6', level, 6, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel0:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Ncs2', level, 2, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel0:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ncs4', level, 4, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel0:setMissileCount(level, value)
    checktype(level, 'integer', 'setMissileCount', 1)
    checktype(value, 'integer', 'setMissileCount', 2)
    self.def:setLvlDataInt('Ncs3', level, 3, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel0:setDamageAmount(level, value)
    checktype(level, 'integer', 'setDamageAmount', 1)
    checktype(value, 'float', 'setDamageAmount', 2)
    self.def:setLvlDataUnreal('Ncs1', level, 1, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel0:setBuildingDamageFactor(level, value)
    checktype(level, 'integer', 'setBuildingDamageFactor', 1)
    checktype(value, 'float', 'setBuildingDamageFactor', 2)
    self.def:setLvlDataUnreal('Ncs5', level, 5, value)
end

AbilityDefinitionAttackBonusAIt9 = class('AbilityDefinitionAttackBonusAIt9', AbilityDefinition)
_G.AbilityDefinitionAttackBonusAIt9 = AbilityDefinitionAttackBonusAIt9

function AbilityDefinitionAttackBonusAIt9:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIt9')
end

function AbilityDefinitionAttackBonusAIt9:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionPossession = class('AbilityDefinitionPossession', AbilityDefinition)
_G.AbilityDefinitionPossession = AbilityDefinitionPossession

function AbilityDefinitionPossession:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apos')
end

function AbilityDefinitionPossession:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Pos1', level, 1, value)
end

AbilityDefinitionPotionofLifeRegen = class('AbilityDefinitionPotionofLifeRegen', AbilityDefinition)
_G.AbilityDefinitionPotionofLifeRegen = AbilityDefinitionPotionofLifeRegen

function AbilityDefinitionPotionofLifeRegen:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrl')
end

function AbilityDefinitionPotionofLifeRegen:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionPotionofLifeRegen:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionPotionofLifeRegen:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionPotionofLifeRegen:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionPotionofLifeRegen:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionDarkRangerCharm = class('AbilityDefinitionDarkRangerCharm', AbilityDefinition)
_G.AbilityDefinitionDarkRangerCharm = AbilityDefinitionDarkRangerCharm

function AbilityDefinitionDarkRangerCharm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANch')
end

function AbilityDefinitionDarkRangerCharm:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Nch1', level, 1, value)
end

AbilityDefinitionBreathofFrostCreep = class('AbilityDefinitionBreathofFrostCreep', AbilityDefinition)
_G.AbilityDefinitionBreathofFrostCreep = AbilityDefinitionBreathofFrostCreep

function AbilityDefinitionBreathofFrostCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACbf')
end

function AbilityDefinitionBreathofFrostCreep:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ucs2', level, 2, value)
end

function AbilityDefinitionBreathofFrostCreep:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Nbf5', level, 5, value)
end

function AbilityDefinitionBreathofFrostCreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ucs1', level, 1, value)
end

function AbilityDefinitionBreathofFrostCreep:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionBreathofFrostCreep:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionItemRegenMana = class('AbilityDefinitionItemRegenMana', AbilityDefinition)
_G.AbilityDefinitionItemRegenMana = AbilityDefinitionItemRegenMana

function AbilityDefinitionItemRegenMana:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrm')
end

function AbilityDefinitionItemRegenMana:setManaRegenerationBonusasfractionofnormal(level, value)
    checktype(level, 'integer', 'setManaRegenerationBonusasfractionofnormal', 1)
    checktype(value, 'float', 'setManaRegenerationBonusasfractionofnormal', 2)
    self.def:setLvlDataUnreal('Imrp', level, 1, value)
end

AbilityDefinitionItemRegenManalesser = class('AbilityDefinitionItemRegenManalesser', AbilityDefinition)
_G.AbilityDefinitionItemRegenManalesser = AbilityDefinitionItemRegenManalesser

function AbilityDefinitionItemRegenManalesser:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrn')
end

function AbilityDefinitionItemRegenManalesser:setManaRegenerationBonusasfractionofnormal(level, value)
    checktype(level, 'integer', 'setManaRegenerationBonusasfractionofnormal', 1)
    checktype(value, 'float', 'setManaRegenerationBonusasfractionofnormal', 2)
    self.def:setLvlDataUnreal('Imrp', level, 1, value)
end

AbilityDefinitionAuraBrilliancecreep = class('AbilityDefinitionAuraBrilliancecreep', AbilityDefinition)
_G.AbilityDefinitionAuraBrilliancecreep = AbilityDefinitionAuraBrilliancecreep

function AbilityDefinitionAuraBrilliancecreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACba')
end

function AbilityDefinitionAuraBrilliancecreep:setManaRegenerationIncrease(level, value)
    checktype(level, 'integer', 'setManaRegenerationIncrease', 1)
    checktype(value, 'float', 'setManaRegenerationIncrease', 2)
    self.def:setLvlDataUnreal('Hab1', level, 1, value)
end

function AbilityDefinitionAuraBrilliancecreep:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Hab2', level, 2, value)
end

AbilityDefinitionIllidanChannel = class('AbilityDefinitionIllidanChannel', AbilityDefinition)
_G.AbilityDefinitionIllidanChannel = AbilityDefinitionIllidanChannel

function AbilityDefinitionIllidanChannel:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANcl')
end

function AbilityDefinitionIllidanChannel:setArtDuration(level, value)
    checktype(level, 'integer', 'setArtDuration', 1)
    checktype(value, 'float', 'setArtDuration', 2)
    self.def:setLvlDataUnreal('Ncl4', level, 4, value)
end

function AbilityDefinitionIllidanChannel:setBaseOrderID(level, value)
    checktype(level, 'integer', 'setBaseOrderID', 1)
    checktype(value, 'string', 'setBaseOrderID', 2)
    self.def:setLvlDataString('Ncl6', level, 6, value)
end

function AbilityDefinitionIllidanChannel:setDisableOtherAbilities(level, value)
    checktype(level, 'integer', 'setDisableOtherAbilities', 1)
    checktype(value, 'boolean', 'setDisableOtherAbilities', 2)
    self.def:setLvlDataBoolean('Ncl5', level, 5, value)
end

function AbilityDefinitionIllidanChannel:setFollowThroughTime(level, value)
    checktype(level, 'integer', 'setFollowThroughTime', 1)
    checktype(value, 'float', 'setFollowThroughTime', 2)
    self.def:setLvlDataUnreal('Ncl1', level, 1, value)
end

function AbilityDefinitionIllidanChannel:setTargetType(level, value)
    checktype(level, 'integer', 'setTargetType', 1)
    checktype(value, 'integer', 'setTargetType', 2)
    self.def:setLvlDataInt('Ncl2', level, 2, value)
end

function AbilityDefinitionIllidanChannel:setOptions(level, value)
    checktype(level, 'integer', 'setOptions', 1)
    checktype(value, 'integer', 'setOptions', 2)
    self.def:setLvlDataInt('Ncl3', level, 3, value)
end

AbilityDefinitionBreathofFireCreep = class('AbilityDefinitionBreathofFireCreep', AbilityDefinition)
_G.AbilityDefinitionBreathofFireCreep = AbilityDefinitionBreathofFireCreep

function AbilityDefinitionBreathofFireCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACbc')
end

function AbilityDefinitionBreathofFireCreep:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ucs2', level, 2, value)
end

function AbilityDefinitionBreathofFireCreep:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Nbf5', level, 5, value)
end

function AbilityDefinitionBreathofFireCreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ucs1', level, 1, value)
end

function AbilityDefinitionBreathofFireCreep:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionBreathofFireCreep:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionPitLordCleavingAttack = class('AbilityDefinitionPitLordCleavingAttack', AbilityDefinition)
_G.AbilityDefinitionPitLordCleavingAttack = AbilityDefinitionPitLordCleavingAttack

function AbilityDefinitionPitLordCleavingAttack:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANca')
end

function AbilityDefinitionPitLordCleavingAttack:setDistributedDamageFactor(level, value)
    checktype(level, 'integer', 'setDistributedDamageFactor', 1)
    checktype(value, 'float', 'setDistributedDamageFactor', 2)
    self.def:setLvlDataUnreal('nca1', level, 1, value)
end

AbilityDefinitionSilenceItem = class('AbilityDefinitionSilenceItem', AbilityDefinition)
_G.AbilityDefinitionSilenceItem = AbilityDefinitionSilenceItem

function AbilityDefinitionSilenceItem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIse')
end

function AbilityDefinitionSilenceItem:setAttackSpeedModifier(level, value)
    checktype(level, 'integer', 'setAttackSpeedModifier', 1)
    checktype(value, 'float', 'setAttackSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi4', level, 4, value)
end

function AbilityDefinitionSilenceItem:setMovementSpeedModifier(level, value)
    checktype(level, 'integer', 'setMovementSpeedModifier', 1)
    checktype(value, 'float', 'setMovementSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi3', level, 3, value)
end

function AbilityDefinitionSilenceItem:setChanceToMiss(level, value)
    checktype(level, 'integer', 'setChanceToMiss', 1)
    checktype(value, 'float', 'setChanceToMiss', 2)
    self.def:setLvlDataUnreal('Nsi2', level, 2, value)
end

function AbilityDefinitionSilenceItem:setAttacksPrevented(level, value)
    checktype(level, 'integer', 'setAttacksPrevented', 1)
    checktype(value, 'integer', 'setAttacksPrevented', 2)
    self.def:setLvlDataInt('Nsi1', level, 1, value)
end

AbilityDefinitionSummonHeadhunteritem = class('AbilityDefinitionSummonHeadhunteritem', AbilityDefinition)
_G.AbilityDefinitionSummonHeadhunteritem = AbilityDefinitionSummonHeadhunteritem

function AbilityDefinitionSummonHeadhunteritem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsh')
end

function AbilityDefinitionSummonHeadhunteritem:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Osf1', level, 0, value)
end

function AbilityDefinitionSummonHeadhunteritem:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Osf2', level, 2, value)
end

AbilityDefinitionSightBonus = class('AbilityDefinitionSightBonus', AbilityDefinition)
_G.AbilityDefinitionSightBonus = AbilityDefinitionSightBonus

function AbilityDefinitionSightBonus:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsi')
end

function AbilityDefinitionSightBonus:setSightRangeBonus(level, value)
    checktype(level, 'integer', 'setSightRangeBonus', 1)
    checktype(value, 'integer', 'setSightRangeBonus', 2)
    self.def:setLvlDataInt('Isib', level, 1, value)
end

AbilityDefinitionBlizzardcreep = class('AbilityDefinitionBlizzardcreep', AbilityDefinition)
_G.AbilityDefinitionBlizzardcreep = AbilityDefinitionBlizzardcreep

function AbilityDefinitionBlizzardcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACbz')
end

function AbilityDefinitionBlizzardcreep:setMaximumDamageperWave(level, value)
    checktype(level, 'integer', 'setMaximumDamageperWave', 1)
    checktype(value, 'float', 'setMaximumDamageperWave', 2)
    self.def:setLvlDataUnreal('Hbz6', level, 6, value)
end

function AbilityDefinitionBlizzardcreep:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Hbz5', level, 5, value)
end

function AbilityDefinitionBlizzardcreep:setNumberofWaves(level, value)
    checktype(level, 'integer', 'setNumberofWaves', 1)
    checktype(value, 'integer', 'setNumberofWaves', 2)
    self.def:setLvlDataInt('Hbz1', level, 1, value)
end

function AbilityDefinitionBlizzardcreep:setNumberofShards(level, value)
    checktype(level, 'integer', 'setNumberofShards', 1)
    checktype(value, 'integer', 'setNumberofShards', 2)
    self.def:setLvlDataInt('Hbz3', level, 3, value)
end

function AbilityDefinitionBlizzardcreep:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Hbz4', level, 4, value)
end

function AbilityDefinitionBlizzardcreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Hbz2', level, 2, value)
end

AbilityDefinitionCloudofFog = class('AbilityDefinitionCloudofFog', AbilityDefinition)
_G.AbilityDefinitionCloudofFog = AbilityDefinitionCloudofFog

function AbilityDefinitionCloudofFog:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aclf')
end

function AbilityDefinitionCloudofFog:setAttackSpeedModifier(level, value)
    checktype(level, 'integer', 'setAttackSpeedModifier', 1)
    checktype(value, 'float', 'setAttackSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi4', level, 4, value)
end

function AbilityDefinitionCloudofFog:setMovementSpeedModifier(level, value)
    checktype(level, 'integer', 'setMovementSpeedModifier', 1)
    checktype(value, 'float', 'setMovementSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi3', level, 3, value)
end

function AbilityDefinitionCloudofFog:setChanceToMiss(level, value)
    checktype(level, 'integer', 'setChanceToMiss', 1)
    checktype(value, 'float', 'setChanceToMiss', 2)
    self.def:setLvlDataUnreal('Nsi2', level, 2, value)
end

function AbilityDefinitionCloudofFog:setAttacksPrevented(level, value)
    checktype(level, 'integer', 'setAttacksPrevented', 1)
    checktype(value, 'integer', 'setAttacksPrevented', 2)
    self.def:setLvlDataInt('Nsi1', level, 1, value)
end

AbilityDefinitionAntimagicShieldMatrix = class('AbilityDefinitionAntimagicShieldMatrix', AbilityDefinition)
_G.AbilityDefinitionAntimagicShieldMatrix = AbilityDefinitionAntimagicShieldMatrix

function AbilityDefinitionAntimagicShieldMatrix:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aam2')
end

function AbilityDefinitionAntimagicShieldMatrix:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Ams4', level, 4, value)
end

AbilityDefinitionLoad = class('AbilityDefinitionLoad', AbilityDefinition)
_G.AbilityDefinitionLoad = AbilityDefinitionLoad

function AbilityDefinitionLoad:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aloa')
end

function AbilityDefinitionLoad:setAllowedUnitType(level, value)
    checktype(level, 'integer', 'setAllowedUnitType', 1)
    checktype(value, 'string', 'setAllowedUnitType', 2)
    self.def:setLvlDataString('Loa1', level, 0, value)
end

AbilityDefinitionBladeMasterMirrorImage = class('AbilityDefinitionBladeMasterMirrorImage', AbilityDefinition)
_G.AbilityDefinitionBladeMasterMirrorImage = AbilityDefinitionBladeMasterMirrorImage

function AbilityDefinitionBladeMasterMirrorImage:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOmi')
end

function AbilityDefinitionBladeMasterMirrorImage:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Omi2', level, 2, value)
end

function AbilityDefinitionBladeMasterMirrorImage:setNumberofImages(level, value)
    checktype(level, 'integer', 'setNumberofImages', 1)
    checktype(value, 'integer', 'setNumberofImages', 2)
    self.def:setLvlDataInt('Omi1', level, 1, value)
end

function AbilityDefinitionBladeMasterMirrorImage:setDamageTaken(level, value)
    checktype(level, 'integer', 'setDamageTaken', 1)
    checktype(value, 'float', 'setDamageTaken', 2)
    self.def:setLvlDataUnreal('Omi3', level, 3, value)
end

function AbilityDefinitionBladeMasterMirrorImage:setAnimationDelay(level, value)
    checktype(level, 'integer', 'setAnimationDelay', 1)
    checktype(value, 'float', 'setAnimationDelay', 2)
    self.def:setLvlDataUnreal('Omi4', level, 4, value)
end

AbilityDefinitionWardenBlink = class('AbilityDefinitionWardenBlink', AbilityDefinition)
_G.AbilityDefinitionWardenBlink = AbilityDefinitionWardenBlink

function AbilityDefinitionWardenBlink:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEbl')
end

function AbilityDefinitionWardenBlink:setMaximumRange(level, value)
    checktype(level, 'integer', 'setMaximumRange', 1)
    checktype(value, 'float', 'setMaximumRange', 2)
    self.def:setLvlDataUnreal('Ebl1', level, 1, value)
end

function AbilityDefinitionWardenBlink:setMinimumRange(level, value)
    checktype(level, 'integer', 'setMinimumRange', 1)
    checktype(value, 'float', 'setMinimumRange', 2)
    self.def:setLvlDataUnreal('Ebl2', level, 2, value)
end

AbilityDefinitionPoisonAttack = class('AbilityDefinitionPoisonAttack', AbilityDefinition)
_G.AbilityDefinitionPoisonAttack = AbilityDefinitionPoisonAttack

function AbilityDefinitionPoisonAttack:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apoi')
end

function AbilityDefinitionPoisonAttack:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi2', level, 2, value)
end

function AbilityDefinitionPoisonAttack:setStackingType(level, value)
    checktype(level, 'integer', 'setStackingType', 1)
    checktype(value, 'integer', 'setStackingType', 2)
    self.def:setLvlDataInt('Poi4', level, 4, value)
end

function AbilityDefinitionPoisonAttack:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Poi1', level, 1, value)
end

function AbilityDefinitionPoisonAttack:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi3', level, 3, value)
end

AbilityDefinitionOrbofSpells = class('AbilityDefinitionOrbofSpells', AbilityDefinition)
_G.AbilityDefinitionOrbofSpells = AbilityDefinitionOrbofSpells

function AbilityDefinitionOrbofSpells:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsb')
end

function AbilityDefinitionOrbofSpells:setChanceToHitUnits(level, value)
    checktype(level, 'integer', 'setChanceToHitUnits', 1)
    checktype(value, 'float', 'setChanceToHitUnits', 2)
    self.def:setLvlDataUnreal('Iob2', level, 2, value)
end

function AbilityDefinitionOrbofSpells:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionOrbofSpells:setChanceToHitSummons(level, value)
    checktype(level, 'integer', 'setChanceToHitSummons', 1)
    checktype(value, 'float', 'setChanceToHitSummons', 2)
    self.def:setLvlDataUnreal('Iob4', level, 4, value)
end

function AbilityDefinitionOrbofSpells:setChanceToHitHeros(level, value)
    checktype(level, 'integer', 'setChanceToHitHeros', 1)
    checktype(value, 'float', 'setChanceToHitHeros', 2)
    self.def:setLvlDataUnreal('Iob3', level, 3, value)
end

function AbilityDefinitionOrbofSpells:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

function AbilityDefinitionOrbofSpells:setEffectAbility(level, value)
    checktype(level, 'integer', 'setEffectAbility', 1)
    checktype(value, 'string', 'setEffectAbility', 2)
    self.def:setLvlDataString('Iobu', level, 0, value)
end

AbilityDefinitionItemSpeedAoe = class('AbilityDefinitionItemSpeedAoe', AbilityDefinition)
_G.AbilityDefinitionItemSpeedAoe = AbilityDefinitionItemSpeedAoe

function AbilityDefinitionItemSpeedAoe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsa')
end

function AbilityDefinitionItemSpeedAoe:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Ispi', level, 1, value)
end

AbilityDefinitionUnholyFrenzy = class('AbilityDefinitionUnholyFrenzy', AbilityDefinition)
_G.AbilityDefinitionUnholyFrenzy = AbilityDefinitionUnholyFrenzy

function AbilityDefinitionUnholyFrenzy:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Auhf')
end

function AbilityDefinitionUnholyFrenzy:setAttackSpeedBonus(level, value)
    checktype(level, 'integer', 'setAttackSpeedBonus', 1)
    checktype(value, 'float', 'setAttackSpeedBonus', 2)
    self.def:setLvlDataUnreal('Uhf1', level, 1, value)
end

function AbilityDefinitionUnholyFrenzy:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Uhf2', level, 2, value)
end

AbilityDefinitionAntimagicShieldcreep = class('AbilityDefinitionAntimagicShieldcreep', AbilityDefinition)
_G.AbilityDefinitionAntimagicShieldcreep = AbilityDefinitionAntimagicShieldcreep

function AbilityDefinitionAntimagicShieldcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACam')
end

function AbilityDefinitionAntimagicShieldcreep:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Ams2', level, 2, value)
end

function AbilityDefinitionAntimagicShieldcreep:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Ams4', level, 4, value)
end

function AbilityDefinitionAntimagicShieldcreep:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Ams1', level, 1, value)
end

function AbilityDefinitionAntimagicShieldcreep:setShieldLife(level, value)
    checktype(level, 'integer', 'setShieldLife', 1)
    checktype(value, 'integer', 'setShieldLife', 2)
    self.def:setLvlDataInt('Ams3', level, 3, value)
end

AbilityDefinitionSpawnSpiderOnDeath = class('AbilityDefinitionSpawnSpiderOnDeath', AbilityDefinition)
_G.AbilityDefinitionSpawnSpiderOnDeath = AbilityDefinitionSpawnSpiderOnDeath

function AbilityDefinitionSpawnSpiderOnDeath:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspd')
end

function AbilityDefinitionSpawnSpiderOnDeath:setNumberofUnits(level, value)
    checktype(level, 'integer', 'setNumberofUnits', 1)
    checktype(value, 'integer', 'setNumberofUnits', 2)
    self.def:setLvlDataInt('Sod1', level, 1, value)
end

function AbilityDefinitionSpawnSpiderOnDeath:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('Sod2', level, 2, value)
end

AbilityDefinitionDarkRangerDrain = class('AbilityDefinitionDarkRangerDrain', AbilityDefinition)
_G.AbilityDefinitionDarkRangerDrain = AbilityDefinitionDarkRangerDrain

function AbilityDefinitionDarkRangerDrain:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANdr')
end

function AbilityDefinitionDarkRangerDrain:setBonusLifeDecay(level, value)
    checktype(level, 'integer', 'setBonusLifeDecay', 1)
    checktype(value, 'float', 'setBonusLifeDecay', 2)
    self.def:setLvlDataUnreal('Ndr7', level, 7, value)
end

function AbilityDefinitionDarkRangerDrain:setDrainIntervalseconds(level, value)
    checktype(level, 'integer', 'setDrainIntervalseconds', 1)
    checktype(value, 'float', 'setDrainIntervalseconds', 2)
    self.def:setLvlDataUnreal('Ndr3', level, 3, value)
end

function AbilityDefinitionDarkRangerDrain:setHitPointsDrained(level, value)
    checktype(level, 'integer', 'setHitPointsDrained', 1)
    checktype(value, 'float', 'setHitPointsDrained', 2)
    self.def:setLvlDataUnreal('Ndr1', level, 1, value)
end

function AbilityDefinitionDarkRangerDrain:setBonusLifeFactor(level, value)
    checktype(level, 'integer', 'setBonusLifeFactor', 1)
    checktype(value, 'float', 'setBonusLifeFactor', 2)
    self.def:setLvlDataUnreal('Ndr6', level, 6, value)
end

function AbilityDefinitionDarkRangerDrain:setManaPointsDrained(level, value)
    checktype(level, 'integer', 'setManaPointsDrained', 1)
    checktype(value, 'float', 'setManaPointsDrained', 2)
    self.def:setLvlDataUnreal('Ndr2', level, 2, value)
end

function AbilityDefinitionDarkRangerDrain:setManaTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setManaTransferredPerSecond', 1)
    checktype(value, 'float', 'setManaTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr5', level, 5, value)
end

function AbilityDefinitionDarkRangerDrain:setBonusManaDecay(level, value)
    checktype(level, 'integer', 'setBonusManaDecay', 1)
    checktype(value, 'float', 'setBonusManaDecay', 2)
    self.def:setLvlDataUnreal('Ndr9', level, 9, value)
end

function AbilityDefinitionDarkRangerDrain:setBonusManaFactor(level, value)
    checktype(level, 'integer', 'setBonusManaFactor', 1)
    checktype(value, 'float', 'setBonusManaFactor', 2)
    self.def:setLvlDataUnreal('Ndr8', level, 8, value)
end

function AbilityDefinitionDarkRangerDrain:setLifeTransferredPerSecond(level, value)
    checktype(level, 'integer', 'setLifeTransferredPerSecond', 1)
    checktype(value, 'float', 'setLifeTransferredPerSecond', 2)
    self.def:setLvlDataUnreal('Ndr4', level, 4, value)
end

AbilityDefinitionFlare = class('AbilityDefinitionFlare', AbilityDefinition)
_G.AbilityDefinitionFlare = AbilityDefinitionFlare

function AbilityDefinitionFlare:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afla')
end

function AbilityDefinitionFlare:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Fla1', level, 1, value)
end

function AbilityDefinitionFlare:setFlareCount(level, value)
    checktype(level, 'integer', 'setFlareCount', 1)
    checktype(value, 'integer', 'setFlareCount', 2)
    self.def:setLvlDataInt('Fla3', level, 3, value)
end

function AbilityDefinitionFlare:setEffectDelay(level, value)
    checktype(level, 'integer', 'setEffectDelay', 1)
    checktype(value, 'float', 'setEffectDelay', 2)
    self.def:setLvlDataUnreal('Fla2', level, 2, value)
end

AbilityDefinitionStrengthBonusPlus6 = class('AbilityDefinitionStrengthBonusPlus6', AbilityDefinition)
_G.AbilityDefinitionStrengthBonusPlus6 = AbilityDefinitionStrengthBonusPlus6

function AbilityDefinitionStrengthBonusPlus6:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIs6')
end

function AbilityDefinitionStrengthBonusPlus6:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionStrengthBonusPlus6:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionStrengthBonusPlus6:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionStrengthBonusPlus6:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionPitLordDoom = class('AbilityDefinitionPitLordDoom', AbilityDefinition)
_G.AbilityDefinitionPitLordDoom = AbilityDefinitionPitLordDoom

function AbilityDefinitionPitLordDoom:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANdo')
end

function AbilityDefinitionPitLordDoom:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Ndo1', level, 1, value)
end

function AbilityDefinitionPitLordDoom:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Ndo2', level, 2, value)
end

function AbilityDefinitionPitLordDoom:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Ndou', level, 0, value)
end

function AbilityDefinitionPitLordDoom:setSummonedUnitDurationseconds(level, value)
    checktype(level, 'integer', 'setSummonedUnitDurationseconds', 1)
    checktype(value, 'float', 'setSummonedUnitDurationseconds', 2)
    self.def:setLvlDataUnreal('Ndo3', level, 3, value)
end

AbilityDefinitionSpellBook = class('AbilityDefinitionSpellBook', AbilityDefinition)
_G.AbilityDefinitionSpellBook = AbilityDefinitionSpellBook

function AbilityDefinitionSpellBook:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspb')
end

function AbilityDefinitionSpellBook:setMaximumSpells(level, value)
    checktype(level, 'integer', 'setMaximumSpells', 1)
    checktype(value, 'integer', 'setMaximumSpells', 2)
    self.def:setLvlDataInt('spb4', level, 4, value)
end

function AbilityDefinitionSpellBook:setSharedSpellCooldown(level, value)
    checktype(level, 'integer', 'setSharedSpellCooldown', 1)
    checktype(value, 'boolean', 'setSharedSpellCooldown', 2)
    self.def:setLvlDataBoolean('spb2', level, 2, value)
end

function AbilityDefinitionSpellBook:setSpellList(level, value)
    checktype(level, 'integer', 'setSpellList', 1)
    checktype(value, 'string', 'setSpellList', 2)
    self.def:setLvlDataString('spb1', level, 1, value)
end

function AbilityDefinitionSpellBook:setMinimumSpells(level, value)
    checktype(level, 'integer', 'setMinimumSpells', 1)
    checktype(value, 'integer', 'setMinimumSpells', 2)
    self.def:setLvlDataInt('spb3', level, 3, value)
end

function AbilityDefinitionSpellBook:setBaseOrderID(level, value)
    checktype(level, 'integer', 'setBaseOrderID', 1)
    checktype(value, 'string', 'setBaseOrderID', 2)
    self.def:setLvlDataString('spb5', level, 5, value)
end

AbilityDefinitionStrengthBonusPlus3 = class('AbilityDefinitionStrengthBonusPlus3', AbilityDefinition)
_G.AbilityDefinitionStrengthBonusPlus3 = AbilityDefinitionStrengthBonusPlus3

function AbilityDefinitionStrengthBonusPlus3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIs3')
end

function AbilityDefinitionStrengthBonusPlus3:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionStrengthBonusPlus3:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionStrengthBonusPlus3:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionStrengthBonusPlus3:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionDarkPortal = class('AbilityDefinitionDarkPortal', AbilityDefinition)
_G.AbilityDefinitionDarkPortal = AbilityDefinitionDarkPortal

function AbilityDefinitionDarkPortal:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANdp')
end

function AbilityDefinitionDarkPortal:setSpawnedUnits(level, value)
    checktype(level, 'integer', 'setSpawnedUnits', 1)
    checktype(value, 'string', 'setSpawnedUnits', 2)
    self.def:setLvlDataString('Ndp1', level, 1, value)
end

function AbilityDefinitionDarkPortal:setMaximumNumberofUnits(level, value)
    checktype(level, 'integer', 'setMaximumNumberofUnits', 1)
    checktype(value, 'integer', 'setMaximumNumberofUnits', 2)
    self.def:setLvlDataInt('Ndp3', level, 3, value)
end

function AbilityDefinitionDarkPortal:setMinimumNumberofUnits(level, value)
    checktype(level, 'integer', 'setMinimumNumberofUnits', 1)
    checktype(value, 'integer', 'setMinimumNumberofUnits', 2)
    self.def:setLvlDataInt('Ndp2', level, 2, value)
end

AbilityDefinitionMoonPriestessTrueshotAura = class('AbilityDefinitionMoonPriestessTrueshotAura', AbilityDefinition)
_G.AbilityDefinitionMoonPriestessTrueshotAura = AbilityDefinitionMoonPriestessTrueshotAura

function AbilityDefinitionMoonPriestessTrueshotAura:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEar')
end

function AbilityDefinitionMoonPriestessTrueshotAura:setFlatBonus(level, value)
    checktype(level, 'integer', 'setFlatBonus', 1)
    checktype(value, 'boolean', 'setFlatBonus', 2)
    self.def:setLvlDataBoolean('Ear4', level, 4, value)
end

function AbilityDefinitionMoonPriestessTrueshotAura:setRangedBonus(level, value)
    checktype(level, 'integer', 'setRangedBonus', 1)
    checktype(value, 'boolean', 'setRangedBonus', 2)
    self.def:setLvlDataBoolean('Ear3', level, 3, value)
end

function AbilityDefinitionMoonPriestessTrueshotAura:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Ear1', level, 1, value)
end

function AbilityDefinitionMoonPriestessTrueshotAura:setMeleeBonus(level, value)
    checktype(level, 'integer', 'setMeleeBonus', 1)
    checktype(value, 'boolean', 'setMeleeBonus', 2)
    self.def:setLvlDataBoolean('Ear2', level, 2, value)
end

AbilityDefinitionStrengthBonusPlus4 = class('AbilityDefinitionStrengthBonusPlus4', AbilityDefinition)
_G.AbilityDefinitionStrengthBonusPlus4 = AbilityDefinitionStrengthBonusPlus4

function AbilityDefinitionStrengthBonusPlus4:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIs4')
end

function AbilityDefinitionStrengthBonusPlus4:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionStrengthBonusPlus4:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionStrengthBonusPlus4:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionStrengthBonusPlus4:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionSpiderAttack = class('AbilityDefinitionSpiderAttack', AbilityDefinition)
_G.AbilityDefinitionSpiderAttack = AbilityDefinitionSpiderAttack

function AbilityDefinitionSpiderAttack:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspa')
end

function AbilityDefinitionSpiderAttack:setSpiderCapacity(level, value)
    checktype(level, 'integer', 'setSpiderCapacity', 1)
    checktype(value, 'integer', 'setSpiderCapacity', 2)
    self.def:setLvlDataInt('Spa1', level, 1, value)
end

AbilityDefinitionSpiritLink = class('AbilityDefinitionSpiritLink', AbilityDefinition)
_G.AbilityDefinitionSpiritLink = AbilityDefinitionSpiritLink

function AbilityDefinitionSpiritLink:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspl')
end

function AbilityDefinitionSpiritLink:setMaximumNumberofTargets(level, value)
    checktype(level, 'integer', 'setMaximumNumberofTargets', 1)
    checktype(value, 'integer', 'setMaximumNumberofTargets', 2)
    self.def:setLvlDataInt('spl2', level, 2, value)
end

function AbilityDefinitionSpiritLink:setDistributedDamageFactor(level, value)
    checktype(level, 'integer', 'setDistributedDamageFactor', 1)
    checktype(value, 'float', 'setDistributedDamageFactor', 2)
    self.def:setLvlDataUnreal('spl1', level, 1, value)
end

AbilityDefinitionAuraWarDrumsKodobeast = class('AbilityDefinitionAuraWarDrumsKodobeast', AbilityDefinition)
_G.AbilityDefinitionAuraWarDrumsKodobeast = AbilityDefinitionAuraWarDrumsKodobeast

function AbilityDefinitionAuraWarDrumsKodobeast:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aakb')
end

function AbilityDefinitionAuraWarDrumsKodobeast:setFlatBonus(level, value)
    checktype(level, 'integer', 'setFlatBonus', 1)
    checktype(value, 'boolean', 'setFlatBonus', 2)
    self.def:setLvlDataBoolean('Ear4', level, 4, value)
end

function AbilityDefinitionAuraWarDrumsKodobeast:setRangedBonus(level, value)
    checktype(level, 'integer', 'setRangedBonus', 1)
    checktype(value, 'boolean', 'setRangedBonus', 2)
    self.def:setLvlDataBoolean('Ear3', level, 3, value)
end

function AbilityDefinitionAuraWarDrumsKodobeast:setAttackDamageIncrease(level, value)
    checktype(level, 'integer', 'setAttackDamageIncrease', 1)
    checktype(value, 'float', 'setAttackDamageIncrease', 2)
    self.def:setLvlDataUnreal('Akb1', level, 1, value)
end

function AbilityDefinitionAuraWarDrumsKodobeast:setMeleeBonus(level, value)
    checktype(level, 'integer', 'setMeleeBonus', 1)
    checktype(value, 'boolean', 'setMeleeBonus', 2)
    self.def:setLvlDataBoolean('Ear2', level, 2, value)
end

AbilityDefinitionArchMageMassTeleport = class('AbilityDefinitionArchMageMassTeleport', AbilityDefinition)
_G.AbilityDefinitionArchMageMassTeleport = AbilityDefinitionArchMageMassTeleport

function AbilityDefinitionArchMageMassTeleport:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHmt')
end

function AbilityDefinitionArchMageMassTeleport:setUseTeleportClustering(level, value)
    checktype(level, 'integer', 'setUseTeleportClustering', 1)
    checktype(value, 'boolean', 'setUseTeleportClustering', 2)
    self.def:setLvlDataBoolean('Hmt3', level, 3, value)
end

function AbilityDefinitionArchMageMassTeleport:setCastingDelay(level, value)
    checktype(level, 'integer', 'setCastingDelay', 1)
    checktype(value, 'float', 'setCastingDelay', 2)
    self.def:setLvlDataUnreal('Hmt2', level, 2, value)
end

function AbilityDefinitionArchMageMassTeleport:setNumberofUnitsTeleported(level, value)
    checktype(level, 'integer', 'setNumberofUnitsTeleported', 1)
    checktype(value, 'integer', 'setNumberofUnitsTeleported', 2)
    self.def:setLvlDataInt('Hmt1', level, 1, value)
end

AbilityDefinitionGoldMine = class('AbilityDefinitionGoldMine', AbilityDefinition)
_G.AbilityDefinitionGoldMine = AbilityDefinitionGoldMine

function AbilityDefinitionGoldMine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Agld')
end

function AbilityDefinitionGoldMine:setMiningCapacity(level, value)
    checktype(level, 'integer', 'setMiningCapacity', 1)
    checktype(value, 'integer', 'setMiningCapacity', 2)
    self.def:setLvlDataInt('Gld3', level, 3, value)
end

function AbilityDefinitionGoldMine:setMaxGold(level, value)
    checktype(level, 'integer', 'setMaxGold', 1)
    checktype(value, 'integer', 'setMaxGold', 2)
    self.def:setLvlDataInt('Gld1', level, 1, value)
end

function AbilityDefinitionGoldMine:setMiningDuration(level, value)
    checktype(level, 'integer', 'setMiningDuration', 1)
    checktype(value, 'float', 'setMiningDuration', 2)
    self.def:setLvlDataUnreal('Gld2', level, 2, value)
end

AbilityDefinitionAuraCommandCreep = class('AbilityDefinitionAuraCommandCreep', AbilityDefinition)
_G.AbilityDefinitionAuraCommandCreep = AbilityDefinitionAuraCommandCreep

function AbilityDefinitionAuraCommandCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACac')
end

function AbilityDefinitionAuraCommandCreep:setRangedBonus(level, value)
    checktype(level, 'integer', 'setRangedBonus', 1)
    checktype(value, 'boolean', 'setRangedBonus', 2)
    self.def:setLvlDataBoolean('Ear3', level, 3, value)
end

function AbilityDefinitionAuraCommandCreep:setFlatBonus(level, value)
    checktype(level, 'integer', 'setFlatBonus', 1)
    checktype(value, 'boolean', 'setFlatBonus', 2)
    self.def:setLvlDataBoolean('Ear4', level, 4, value)
end

function AbilityDefinitionAuraCommandCreep:setAttackDamageIncrease(level, value)
    checktype(level, 'integer', 'setAttackDamageIncrease', 1)
    checktype(value, 'float', 'setAttackDamageIncrease', 2)
    self.def:setLvlDataUnreal('Cac1', level, 1, value)
end

function AbilityDefinitionAuraCommandCreep:setMeleeBonus(level, value)
    checktype(level, 'integer', 'setMeleeBonus', 1)
    checktype(value, 'boolean', 'setMeleeBonus', 2)
    self.def:setLvlDataBoolean('Ear2', level, 2, value)
end

AbilityDefinitionBrewmasterDrunkenHaze = class('AbilityDefinitionBrewmasterDrunkenHaze', AbilityDefinition)
_G.AbilityDefinitionBrewmasterDrunkenHaze = AbilityDefinitionBrewmasterDrunkenHaze

function AbilityDefinitionBrewmasterDrunkenHaze:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANdh')
end

function AbilityDefinitionBrewmasterDrunkenHaze:setAttackSpeedModifier(level, value)
    checktype(level, 'integer', 'setAttackSpeedModifier', 1)
    checktype(value, 'float', 'setAttackSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi4', level, 4, value)
end

function AbilityDefinitionBrewmasterDrunkenHaze:setMovementSpeedModifier(level, value)
    checktype(level, 'integer', 'setMovementSpeedModifier', 1)
    checktype(value, 'float', 'setMovementSpeedModifier', 2)
    self.def:setLvlDataUnreal('Nsi3', level, 3, value)
end

function AbilityDefinitionBrewmasterDrunkenHaze:setChanceToMiss(level, value)
    checktype(level, 'integer', 'setChanceToMiss', 1)
    checktype(value, 'float', 'setChanceToMiss', 2)
    self.def:setLvlDataUnreal('Nsi2', level, 2, value)
end

function AbilityDefinitionBrewmasterDrunkenHaze:setAttacksPrevented(level, value)
    checktype(level, 'integer', 'setAttacksPrevented', 1)
    checktype(value, 'integer', 'setAttacksPrevented', 2)
    self.def:setLvlDataInt('Nsi1', level, 1, value)
end

AbilityDefinitionAnimateDeadcreep = class('AbilityDefinitionAnimateDeadcreep', AbilityDefinition)
_G.AbilityDefinitionAnimateDeadcreep = AbilityDefinitionAnimateDeadcreep

function AbilityDefinitionAnimateDeadcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACad')
end

function AbilityDefinitionAnimateDeadcreep:setRaisedUnitsAreInvulnerable(level, value)
    checktype(level, 'integer', 'setRaisedUnitsAreInvulnerable', 1)
    checktype(value, 'boolean', 'setRaisedUnitsAreInvulnerable', 2)
    self.def:setLvlDataBoolean('Hre2', level, 2, value)
end

function AbilityDefinitionAnimateDeadcreep:setNumberofCorpsesRaised(level, value)
    checktype(level, 'integer', 'setNumberofCorpsesRaised', 1)
    checktype(value, 'integer', 'setNumberofCorpsesRaised', 2)
    self.def:setLvlDataInt('Cad1', level, 1, value)
end

function AbilityDefinitionAnimateDeadcreep:setInheritUpgrades(level, value)
    checktype(level, 'integer', 'setInheritUpgrades', 1)
    checktype(value, 'boolean', 'setInheritUpgrades', 2)
    self.def:setLvlDataBoolean('Uan3', level, 3, value)
end

AbilityDefinitionStrengthBonusPlus1 = class('AbilityDefinitionStrengthBonusPlus1', AbilityDefinition)
_G.AbilityDefinitionStrengthBonusPlus1 = AbilityDefinitionStrengthBonusPlus1

function AbilityDefinitionStrengthBonusPlus1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIs1')
end

function AbilityDefinitionStrengthBonusPlus1:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionStrengthBonusPlus1:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionStrengthBonusPlus1:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionStrengthBonusPlus1:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionAttackSpeedIncreaseGreater = class('AbilityDefinitionAttackSpeedIncreaseGreater', AbilityDefinition)
_G.AbilityDefinitionAttackSpeedIncreaseGreater = AbilityDefinitionAttackSpeedIncreaseGreater

function AbilityDefinitionAttackSpeedIncreaseGreater:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIs2')
end

function AbilityDefinitionAttackSpeedIncreaseGreater:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Isx1', level, 1, value)
end

AbilityDefinitionItemRestore = class('AbilityDefinitionItemRestore', AbilityDefinition)
_G.AbilityDefinitionItemRestore = AbilityDefinitionItemRestore

function AbilityDefinitionItemRestore:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIre')
end

function AbilityDefinitionItemRestore:setManaPointsRestored(level, value)
    checktype(level, 'integer', 'setManaPointsRestored', 1)
    checktype(value, 'integer', 'setManaPointsRestored', 2)
    self.def:setLvlDataInt('Imps', level, 2, value)
end

function AbilityDefinitionItemRestore:setHitPointsRestored(level, value)
    checktype(level, 'integer', 'setHitPointsRestored', 1)
    checktype(value, 'integer', 'setHitPointsRestored', 2)
    self.def:setLvlDataInt('Ihps', level, 1, value)
end

AbilityDefinitionBrewmasterDrunkenBrawler = class('AbilityDefinitionBrewmasterDrunkenBrawler', AbilityDefinition)
_G.AbilityDefinitionBrewmasterDrunkenBrawler = AbilityDefinitionBrewmasterDrunkenBrawler

function AbilityDefinitionBrewmasterDrunkenBrawler:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANdb')
end

function AbilityDefinitionBrewmasterDrunkenBrawler:setDamageMultiplier(level, value)
    checktype(level, 'integer', 'setDamageMultiplier', 1)
    checktype(value, 'float', 'setDamageMultiplier', 2)
    self.def:setLvlDataUnreal('Ocr2', level, 2, value)
end

function AbilityDefinitionBrewmasterDrunkenBrawler:setChancetoCriticalStrike(level, value)
    checktype(level, 'integer', 'setChancetoCriticalStrike', 1)
    checktype(value, 'float', 'setChancetoCriticalStrike', 2)
    self.def:setLvlDataUnreal('Ocr1', level, 1, value)
end

function AbilityDefinitionBrewmasterDrunkenBrawler:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Ocr3', level, 3, value)
end

function AbilityDefinitionBrewmasterDrunkenBrawler:setChancetoEvade(level, value)
    checktype(level, 'integer', 'setChancetoEvade', 1)
    checktype(value, 'float', 'setChancetoEvade', 2)
    self.def:setLvlDataUnreal('Ocr4', level, 4, value)
end

function AbilityDefinitionBrewmasterDrunkenBrawler:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Ocr5', level, 5, value)
end

AbilityDefinitionRaiseDeadItem = class('AbilityDefinitionRaiseDeadItem', AbilityDefinition)
_G.AbilityDefinitionRaiseDeadItem = AbilityDefinitionRaiseDeadItem

function AbilityDefinitionRaiseDeadItem:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrd')
end

function AbilityDefinitionRaiseDeadItem:setUnitsSummonedTypeOne(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeOne', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeOne', 2)
    self.def:setLvlDataInt('Rai1', level, 1, value)
end

function AbilityDefinitionRaiseDeadItem:setUnitTypeForLimitCheck(level, value)
    checktype(level, 'integer', 'setUnitTypeForLimitCheck', 1)
    checktype(value, 'string', 'setUnitTypeForLimitCheck', 2)
    self.def:setLvlDataString('Raiu', level, 0, value)
end

function AbilityDefinitionRaiseDeadItem:setUnitsSummonedTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeTwo', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeTwo', 2)
    self.def:setLvlDataInt('Rai2', level, 2, value)
end

function AbilityDefinitionRaiseDeadItem:setUnitTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitTypeTwo', 1)
    checktype(value, 'string', 'setUnitTypeTwo', 2)
    self.def:setLvlDataString('Rai4', level, 4, value)
end

function AbilityDefinitionRaiseDeadItem:setUnitTypeOne(level, value)
    checktype(level, 'integer', 'setUnitTypeOne', 1)
    checktype(value, 'string', 'setUnitTypeOne', 2)
    self.def:setLvlDataString('Rai3', level, 3, value)
end

AbilityDefinitionSpawnHydraHatchling = class('AbilityDefinitionSpawnHydraHatchling', AbilityDefinition)
_G.AbilityDefinitionSpawnHydraHatchling = AbilityDefinitionSpawnHydraHatchling

function AbilityDefinitionSpawnHydraHatchling:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspt')
end

function AbilityDefinitionSpawnHydraHatchling:setNumberofUnits(level, value)
    checktype(level, 'integer', 'setNumberofUnits', 1)
    checktype(value, 'integer', 'setNumberofUnits', 2)
    self.def:setLvlDataInt('Sod1', level, 1, value)
end

function AbilityDefinitionSpawnHydraHatchling:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('Sod2', level, 2, value)
end

AbilityDefinitionItemReincarnation = class('AbilityDefinitionItemReincarnation', AbilityDefinition)
_G.AbilityDefinitionItemReincarnation = AbilityDefinitionItemReincarnation

function AbilityDefinitionItemReincarnation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIrc')
end

function AbilityDefinitionItemReincarnation:setRestoredLife(level, value)
    checktype(level, 'integer', 'setRestoredLife', 1)
    checktype(value, 'integer', 'setRestoredLife', 2)
    self.def:setLvlDataInt('irc2', level, 2, value)
end

function AbilityDefinitionItemReincarnation:setDelayAfterDeathseconds(level, value)
    checktype(level, 'integer', 'setDelayAfterDeathseconds', 1)
    checktype(value, 'integer', 'setDelayAfterDeathseconds', 2)
    self.def:setLvlDataInt('Ircd', level, 1, value)
end

function AbilityDefinitionItemReincarnation:setRestoredManaforcurrent(level, value)
    checktype(level, 'integer', 'setRestoredManaforcurrent', 1)
    checktype(value, 'integer', 'setRestoredManaforcurrent', 2)
    self.def:setLvlDataInt('irc3', level, 3, value)
end

AbilityDefinitionTinkererDemolishLevel0 = class('AbilityDefinitionTinkererDemolishLevel0', AbilityDefinition)
_G.AbilityDefinitionTinkererDemolishLevel0 = AbilityDefinitionTinkererDemolishLevel0

function AbilityDefinitionTinkererDemolishLevel0:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANde')
end

function AbilityDefinitionTinkererDemolishLevel0:setDamageMultiplierBuildings(level, value)
    checktype(level, 'integer', 'setDamageMultiplierBuildings', 1)
    checktype(value, 'float', 'setDamageMultiplierBuildings', 2)
    self.def:setLvlDataUnreal('Nde2', level, 2, value)
end

function AbilityDefinitionTinkererDemolishLevel0:setDamageMultiplierUnits(level, value)
    checktype(level, 'integer', 'setDamageMultiplierUnits', 1)
    checktype(value, 'float', 'setDamageMultiplierUnits', 2)
    self.def:setLvlDataUnreal('Nde3', level, 3, value)
end

function AbilityDefinitionTinkererDemolishLevel0:setDamageMultiplierHeroes(level, value)
    checktype(level, 'integer', 'setDamageMultiplierHeroes', 1)
    checktype(value, 'float', 'setDamageMultiplierHeroes', 2)
    self.def:setLvlDataUnreal('Nde4', level, 4, value)
end

function AbilityDefinitionTinkererDemolishLevel0:setChancetoDemolish(level, value)
    checktype(level, 'integer', 'setChancetoDemolish', 1)
    checktype(value, 'float', 'setChancetoDemolish', 2)
    self.def:setLvlDataUnreal('Nde1', level, 1, value)
end

AbilityDefinitionRuneofSpiritLink = class('AbilityDefinitionRuneofSpiritLink', AbilityDefinition)
_G.AbilityDefinitionRuneofSpiritLink = AbilityDefinitionRuneofSpiritLink

function AbilityDefinitionRuneofSpiritLink:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspp')
end

function AbilityDefinitionRuneofSpiritLink:setDistributedDamageFactor(level, value)
    checktype(level, 'integer', 'setDistributedDamageFactor', 1)
    checktype(value, 'float', 'setDistributedDamageFactor', 2)
    self.def:setLvlDataUnreal('spl1', level, 1, value)
end

AbilityDefinitionSlowPoison = class('AbilityDefinitionSlowPoison', AbilityDefinition)
_G.AbilityDefinitionSlowPoison = AbilityDefinitionSlowPoison

function AbilityDefinitionSlowPoison:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspo')
end

function AbilityDefinitionSlowPoison:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Spo1', level, 1, value)
end

function AbilityDefinitionSlowPoison:setStackingType(level, value)
    checktype(level, 'integer', 'setStackingType', 1)
    checktype(value, 'integer', 'setStackingType', 2)
    self.def:setLvlDataInt('Spo4', level, 4, value)
end

function AbilityDefinitionSlowPoison:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Spo3', level, 3, value)
end

function AbilityDefinitionSlowPoison:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Spo2', level, 2, value)
end

AbilityDefinitionMalganisDarkConversion = class('AbilityDefinitionMalganisDarkConversion', AbilityDefinition)
_G.AbilityDefinitionMalganisDarkConversion = AbilityDefinitionMalganisDarkConversion

function AbilityDefinitionMalganisDarkConversion:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANdc')
end

function AbilityDefinitionMalganisDarkConversion:setConversionUnit(level, value)
    checktype(level, 'integer', 'setConversionUnit', 1)
    checktype(value, 'string', 'setConversionUnit', 2)
    self.def:setLvlDataString('Ndc2', level, 0, value)
end

function AbilityDefinitionMalganisDarkConversion:setRacetoConvert(level, value)
    checktype(level, 'integer', 'setRacetoConvert', 1)
    checktype(value, 'string', 'setRacetoConvert', 2)
    self.def:setLvlDataString('Ndc1', level, 1, value)
end

AbilityDefinitionAuraDevotionCreep = class('AbilityDefinitionAuraDevotionCreep', AbilityDefinition)
_G.AbilityDefinitionAuraDevotionCreep = AbilityDefinitionAuraDevotionCreep

function AbilityDefinitionAuraDevotionCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACav')
end

function AbilityDefinitionAuraDevotionCreep:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Had2', level, 2, value)
end

function AbilityDefinitionAuraDevotionCreep:setArmorBonus(level, value)
    checktype(level, 'integer', 'setArmorBonus', 1)
    checktype(value, 'float', 'setArmorBonus', 2)
    self.def:setLvlDataUnreal('Had1', level, 1, value)
end

AbilityDefinitionAuraTrueshotCreep = class('AbilityDefinitionAuraTrueshotCreep', AbilityDefinition)
_G.AbilityDefinitionAuraTrueshotCreep = AbilityDefinitionAuraTrueshotCreep

function AbilityDefinitionAuraTrueshotCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACat')
end

function AbilityDefinitionAuraTrueshotCreep:setFlatBonus(level, value)
    checktype(level, 'integer', 'setFlatBonus', 1)
    checktype(value, 'boolean', 'setFlatBonus', 2)
    self.def:setLvlDataBoolean('Ear4', level, 4, value)
end

function AbilityDefinitionAuraTrueshotCreep:setRangedBonus(level, value)
    checktype(level, 'integer', 'setRangedBonus', 1)
    checktype(value, 'boolean', 'setRangedBonus', 2)
    self.def:setLvlDataBoolean('Ear3', level, 3, value)
end

function AbilityDefinitionAuraTrueshotCreep:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Ear1', level, 1, value)
end

function AbilityDefinitionAuraTrueshotCreep:setMeleeBonus(level, value)
    checktype(level, 'integer', 'setMeleeBonus', 1)
    checktype(value, 'boolean', 'setMeleeBonus', 2)
    self.def:setLvlDataBoolean('Ear2', level, 2, value)
end

AbilityDefinitionItemRestoreAoe = class('AbilityDefinitionItemRestoreAoe', AbilityDefinition)
_G.AbilityDefinitionItemRestoreAoe = AbilityDefinitionItemRestoreAoe

function AbilityDefinitionItemRestoreAoe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIra')
end

function AbilityDefinitionItemRestoreAoe:setManaPointsRestored(level, value)
    checktype(level, 'integer', 'setManaPointsRestored', 1)
    checktype(value, 'integer', 'setManaPointsRestored', 2)
    self.def:setLvlDataInt('Imps', level, 2, value)
end

function AbilityDefinitionItemRestoreAoe:setHitPointsRestored(level, value)
    checktype(level, 'integer', 'setHitPointsRestored', 1)
    checktype(value, 'integer', 'setHitPointsRestored', 2)
    self.def:setLvlDataInt('Ihps', level, 1, value)
end

AbilityDefinitionKeeperoftheGroveThornsAura = class('AbilityDefinitionKeeperoftheGroveThornsAura', AbilityDefinition)
_G.AbilityDefinitionKeeperoftheGroveThornsAura = AbilityDefinitionKeeperoftheGroveThornsAura

function AbilityDefinitionKeeperoftheGroveThornsAura:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEah')
end

function AbilityDefinitionKeeperoftheGroveThornsAura:setDamageisPercentReceived(level, value)
    checktype(level, 'integer', 'setDamageisPercentReceived', 1)
    checktype(value, 'boolean', 'setDamageisPercentReceived', 2)
    self.def:setLvlDataBoolean('Eah2', level, 2, value)
end

function AbilityDefinitionKeeperoftheGroveThornsAura:setDamageDealttoAttackers(level, value)
    checktype(level, 'integer', 'setDamageDealttoAttackers', 1)
    checktype(value, 'float', 'setDamageDealttoAttackers', 2)
    self.def:setLvlDataUnreal('Eah1', level, 1, value)
end

AbilityDefinitionSpawnHydra = class('AbilityDefinitionSpawnHydra', AbilityDefinition)
_G.AbilityDefinitionSpawnHydra = AbilityDefinitionSpawnHydra

function AbilityDefinitionSpawnHydra:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspy')
end

function AbilityDefinitionSpawnHydra:setNumberofUnits(level, value)
    checktype(level, 'integer', 'setNumberofUnits', 1)
    checktype(value, 'integer', 'setNumberofUnits', 2)
    self.def:setLvlDataInt('Sod1', level, 1, value)
end

function AbilityDefinitionSpawnHydra:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('Sod2', level, 2, value)
end

AbilityDefinitionAspx = class('AbilityDefinitionAspx', AbilityDefinition)
_G.AbilityDefinitionAspx = AbilityDefinitionAspx

function AbilityDefinitionAspx:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aspx')
end

function AbilityDefinitionAspx:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionAspx:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionAspx:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionAspx:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionAspx:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionTinkererClusterRocketsLevel2 = class('AbilityDefinitionTinkererClusterRocketsLevel2', AbilityDefinition)
_G.AbilityDefinitionTinkererClusterRocketsLevel2 = AbilityDefinitionTinkererClusterRocketsLevel2

function AbilityDefinitionTinkererClusterRocketsLevel2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANc2')
end

function AbilityDefinitionTinkererClusterRocketsLevel2:setEffectDuration(level, value)
    checktype(level, 'integer', 'setEffectDuration', 1)
    checktype(value, 'float', 'setEffectDuration', 2)
    self.def:setLvlDataUnreal('Ncs6', level, 6, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel2:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Ncs2', level, 2, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel2:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ncs4', level, 4, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel2:setMissileCount(level, value)
    checktype(level, 'integer', 'setMissileCount', 1)
    checktype(value, 'integer', 'setMissileCount', 2)
    self.def:setLvlDataInt('Ncs3', level, 3, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel2:setDamageAmount(level, value)
    checktype(level, 'integer', 'setDamageAmount', 1)
    checktype(value, 'float', 'setDamageAmount', 2)
    self.def:setLvlDataUnreal('Ncs1', level, 1, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel2:setBuildingDamageFactor(level, value)
    checktype(level, 'integer', 'setBuildingDamageFactor', 1)
    checktype(value, 'float', 'setBuildingDamageFactor', 2)
    self.def:setLvlDataUnreal('Ncs5', level, 5, value)
end

AbilityDefinitionDreadlordVampiricAura = class('AbilityDefinitionDreadlordVampiricAura', AbilityDefinition)
_G.AbilityDefinitionDreadlordVampiricAura = AbilityDefinitionDreadlordVampiricAura

function AbilityDefinitionDreadlordVampiricAura:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUav')
end

function AbilityDefinitionDreadlordVampiricAura:setAttackDamageStolen(level, value)
    checktype(level, 'integer', 'setAttackDamageStolen', 1)
    checktype(value, 'float', 'setAttackDamageStolen', 2)
    self.def:setLvlDataUnreal('Uav1', level, 1, value)
end

AbilityDefinitionTinkererClusterRocketsLevel3 = class('AbilityDefinitionTinkererClusterRocketsLevel3', AbilityDefinition)
_G.AbilityDefinitionTinkererClusterRocketsLevel3 = AbilityDefinitionTinkererClusterRocketsLevel3

function AbilityDefinitionTinkererClusterRocketsLevel3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANc3')
end

function AbilityDefinitionTinkererClusterRocketsLevel3:setEffectDuration(level, value)
    checktype(level, 'integer', 'setEffectDuration', 1)
    checktype(value, 'float', 'setEffectDuration', 2)
    self.def:setLvlDataUnreal('Ncs6', level, 6, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel3:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Ncs2', level, 2, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel3:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ncs4', level, 4, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel3:setMissileCount(level, value)
    checktype(level, 'integer', 'setMissileCount', 1)
    checktype(value, 'integer', 'setMissileCount', 2)
    self.def:setLvlDataInt('Ncs3', level, 3, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel3:setDamageAmount(level, value)
    checktype(level, 'integer', 'setDamageAmount', 1)
    checktype(value, 'float', 'setDamageAmount', 2)
    self.def:setLvlDataUnreal('Ncs1', level, 1, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel3:setBuildingDamageFactor(level, value)
    checktype(level, 'integer', 'setBuildingDamageFactor', 1)
    checktype(value, 'float', 'setBuildingDamageFactor', 2)
    self.def:setLvlDataUnreal('Ncs5', level, 5, value)
end

AbilityDefinitionDeathKnightUnholyAura = class('AbilityDefinitionDeathKnightUnholyAura', AbilityDefinition)
_G.AbilityDefinitionDeathKnightUnholyAura = AbilityDefinitionDeathKnightUnholyAura

function AbilityDefinitionDeathKnightUnholyAura:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUau')
end

function AbilityDefinitionDeathKnightUnholyAura:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Uau3', level, 3, value)
end

function AbilityDefinitionDeathKnightUnholyAura:setLifeRegenerationIncrease(level, value)
    checktype(level, 'integer', 'setLifeRegenerationIncrease', 1)
    checktype(value, 'float', 'setLifeRegenerationIncrease', 2)
    self.def:setLvlDataUnreal('Uau2', level, 2, value)
end

function AbilityDefinitionDeathKnightUnholyAura:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Uau1', level, 1, value)
end

AbilityDefinitionItemPotionVampirism = class('AbilityDefinitionItemPotionVampirism', AbilityDefinition)
_G.AbilityDefinitionItemPotionVampirism = AbilityDefinitionItemPotionVampirism

function AbilityDefinitionItemPotionVampirism:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIpv')
end

function AbilityDefinitionItemPotionVampirism:setAmountIsRawValue(level, value)
    checktype(level, 'integer', 'setAmountIsRawValue', 1)
    checktype(value, 'boolean', 'setAmountIsRawValue', 2)
    self.def:setLvlDataBoolean('ipv3', level, 3, value)
end

function AbilityDefinitionItemPotionVampirism:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('ipv1', level, 1, value)
end

function AbilityDefinitionItemPotionVampirism:setLifeStealAmount(level, value)
    checktype(level, 'integer', 'setLifeStealAmount', 1)
    checktype(value, 'float', 'setLifeStealAmount', 2)
    self.def:setLvlDataUnreal('ipv2', level, 2, value)
end

AbilityDefinitionOrbofVenomPoisonAttack = class('AbilityDefinitionOrbofVenomPoisonAttack', AbilityDefinition)
_G.AbilityDefinitionOrbofVenomPoisonAttack = AbilityDefinitionOrbofVenomPoisonAttack

function AbilityDefinitionOrbofVenomPoisonAttack:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apo2')
end

function AbilityDefinitionOrbofVenomPoisonAttack:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi2', level, 2, value)
end

function AbilityDefinitionOrbofVenomPoisonAttack:setStackingType(level, value)
    checktype(level, 'integer', 'setStackingType', 1)
    checktype(value, 'integer', 'setStackingType', 2)
    self.def:setLvlDataInt('Poi4', level, 4, value)
end

function AbilityDefinitionOrbofVenomPoisonAttack:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Poi1', level, 1, value)
end

function AbilityDefinitionOrbofVenomPoisonAttack:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi3', level, 3, value)
end

AbilityDefinitionCoupleInstantArcher = class('AbilityDefinitionCoupleInstantArcher', AbilityDefinition)
_G.AbilityDefinitionCoupleInstantArcher = AbilityDefinitionCoupleInstantArcher

function AbilityDefinitionCoupleInstantArcher:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aco2')
end

function AbilityDefinitionCoupleInstantArcher:setMoveToPartner(level, value)
    checktype(level, 'integer', 'setMoveToPartner', 1)
    checktype(value, 'boolean', 'setMoveToPartner', 2)
    self.def:setLvlDataBoolean('coa2', level, 2, value)
end

function AbilityDefinitionCoupleInstantArcher:setResultingUnitType(level, value)
    checktype(level, 'integer', 'setResultingUnitType', 1)
    checktype(value, 'string', 'setResultingUnitType', 2)
    self.def:setLvlDataString('coau', level, 0, value)
end

function AbilityDefinitionCoupleInstantArcher:setPartnerUnitType(level, value)
    checktype(level, 'integer', 'setPartnerUnitType', 1)
    checktype(value, 'string', 'setPartnerUnitType', 2)
    self.def:setLvlDataString('coa1', level, 1, value)
end

AbilityDefinitionPotionofManaRegengreater = class('AbilityDefinitionPotionofManaRegengreater', AbilityDefinition)
_G.AbilityDefinitionPotionofManaRegengreater = AbilityDefinitionPotionofManaRegengreater

function AbilityDefinitionPotionofManaRegengreater:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIpr')
end

function AbilityDefinitionPotionofManaRegengreater:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionPotionofManaRegengreater:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionPotionofManaRegengreater:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionPotionofManaRegengreater:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionPotionofManaRegengreater:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionTinkererClusterRocketsLevel1 = class('AbilityDefinitionTinkererClusterRocketsLevel1', AbilityDefinition)
_G.AbilityDefinitionTinkererClusterRocketsLevel1 = AbilityDefinitionTinkererClusterRocketsLevel1

function AbilityDefinitionTinkererClusterRocketsLevel1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANc1')
end

function AbilityDefinitionTinkererClusterRocketsLevel1:setEffectDuration(level, value)
    checktype(level, 'integer', 'setEffectDuration', 1)
    checktype(value, 'float', 'setEffectDuration', 2)
    self.def:setLvlDataUnreal('Ncs6', level, 6, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel1:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Ncs2', level, 2, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel1:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ncs4', level, 4, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel1:setMissileCount(level, value)
    checktype(level, 'integer', 'setMissileCount', 1)
    checktype(value, 'integer', 'setMissileCount', 2)
    self.def:setLvlDataInt('Ncs3', level, 3, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel1:setDamageAmount(level, value)
    checktype(level, 'integer', 'setDamageAmount', 1)
    checktype(value, 'float', 'setDamageAmount', 2)
    self.def:setLvlDataUnreal('Ncs1', level, 1, value)
end

function AbilityDefinitionTinkererClusterRocketsLevel1:setBuildingDamageFactor(level, value)
    checktype(level, 'integer', 'setBuildingDamageFactor', 1)
    checktype(value, 'float', 'setBuildingDamageFactor', 2)
    self.def:setLvlDataUnreal('Ncs5', level, 5, value)
end

AbilityDefinitionCoupleInstantHippogryph = class('AbilityDefinitionCoupleInstantHippogryph', AbilityDefinition)
_G.AbilityDefinitionCoupleInstantHippogryph = AbilityDefinitionCoupleInstantHippogryph

function AbilityDefinitionCoupleInstantHippogryph:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aco3')
end

function AbilityDefinitionCoupleInstantHippogryph:setMoveToPartner(level, value)
    checktype(level, 'integer', 'setMoveToPartner', 1)
    checktype(value, 'boolean', 'setMoveToPartner', 2)
    self.def:setLvlDataBoolean('coa2', level, 2, value)
end

function AbilityDefinitionCoupleInstantHippogryph:setResultingUnitType(level, value)
    checktype(level, 'integer', 'setResultingUnitType', 1)
    checktype(value, 'string', 'setResultingUnitType', 2)
    self.def:setLvlDataString('coau', level, 0, value)
end

function AbilityDefinitionCoupleInstantHippogryph:setPartnerUnitType(level, value)
    checktype(level, 'integer', 'setPartnerUnitType', 1)
    checktype(value, 'string', 'setPartnerUnitType', 2)
    self.def:setLvlDataString('coa1', level, 1, value)
end

AbilityDefinitionSpawnOnDeathskeleton = class('AbilityDefinitionSpawnOnDeathskeleton', AbilityDefinition)
_G.AbilityDefinitionSpawnOnDeathskeleton = AbilityDefinitionSpawnOnDeathskeleton

function AbilityDefinitionSpawnOnDeathskeleton:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asod')
end

function AbilityDefinitionSpawnOnDeathskeleton:setNumberofUnits(level, value)
    checktype(level, 'integer', 'setNumberofUnits', 1)
    checktype(value, 'integer', 'setNumberofUnits', 2)
    self.def:setLvlDataInt('Sod1', level, 1, value)
end

function AbilityDefinitionSpawnOnDeathskeleton:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('Sod2', level, 2, value)
end

AbilityDefinitionPotionofManaRegenlesser = class('AbilityDefinitionPotionofManaRegenlesser', AbilityDefinition)
_G.AbilityDefinitionPotionofManaRegenlesser = AbilityDefinitionPotionofManaRegenlesser

function AbilityDefinitionPotionofManaRegenlesser:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIpl')
end

function AbilityDefinitionPotionofManaRegenlesser:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionPotionofManaRegenlesser:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionPotionofManaRegenlesser:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionPotionofManaRegenlesser:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionPotionofManaRegenlesser:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionDeathKnightAnimateDead = class('AbilityDefinitionDeathKnightAnimateDead', AbilityDefinition)
_G.AbilityDefinitionDeathKnightAnimateDead = AbilityDefinitionDeathKnightAnimateDead

function AbilityDefinitionDeathKnightAnimateDead:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUan')
end

function AbilityDefinitionDeathKnightAnimateDead:setRaisedUnitsAreInvulnerable(level, value)
    checktype(level, 'integer', 'setRaisedUnitsAreInvulnerable', 1)
    checktype(value, 'boolean', 'setRaisedUnitsAreInvulnerable', 2)
    self.def:setLvlDataBoolean('Hre2', level, 2, value)
end

function AbilityDefinitionDeathKnightAnimateDead:setInheritUpgrades(level, value)
    checktype(level, 'integer', 'setInheritUpgrades', 1)
    checktype(value, 'boolean', 'setInheritUpgrades', 2)
    self.def:setLvlDataBoolean('Uan3', level, 3, value)
end

function AbilityDefinitionDeathKnightAnimateDead:setNumberofCorpsesRaised(level, value)
    checktype(level, 'integer', 'setNumberofCorpsesRaised', 1)
    checktype(value, 'integer', 'setNumberofCorpsesRaised', 2)
    self.def:setLvlDataInt('Uan1', level, 1, value)
end

AbilityDefinitionItemPlaceMine = class('AbilityDefinitionItemPlaceMine', AbilityDefinition)
_G.AbilityDefinitionItemPlaceMine = AbilityDefinitionItemPlaceMine

function AbilityDefinitionItemPlaceMine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIpm')
end

function AbilityDefinitionItemPlaceMine:setUnitType(level, value)
    checktype(level, 'integer', 'setUnitType', 1)
    checktype(value, 'string', 'setUnitType', 2)
    self.def:setLvlDataString('ipmu', level, 0, value)
end

AbilityDefinitionBloodMagePhoenix = class('AbilityDefinitionBloodMagePhoenix', AbilityDefinition)
_G.AbilityDefinitionBloodMagePhoenix = AbilityDefinitionBloodMagePhoenix

function AbilityDefinitionBloodMagePhoenix:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHpx')
end

function AbilityDefinitionBloodMagePhoenix:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionBloodMagePhoenix:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionAlchemistAcidBomb = class('AbilityDefinitionAlchemistAcidBomb', AbilityDefinition)
_G.AbilityDefinitionAlchemistAcidBomb = AbilityDefinitionAlchemistAcidBomb

function AbilityDefinitionAlchemistAcidBomb:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANab')
end

function AbilityDefinitionAlchemistAcidBomb:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Nab6', level, 6, value)
end

function AbilityDefinitionAlchemistAcidBomb:setPrimaryDamage(level, value)
    checktype(level, 'integer', 'setPrimaryDamage', 1)
    checktype(value, 'float', 'setPrimaryDamage', 2)
    self.def:setLvlDataUnreal('Nab4', level, 4, value)
end

function AbilityDefinitionAlchemistAcidBomb:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Nab1', level, 1, value)
end

function AbilityDefinitionAlchemistAcidBomb:setArmorPenalty(level, value)
    checktype(level, 'integer', 'setArmorPenalty', 1)
    checktype(value, 'integer', 'setArmorPenalty', 2)
    self.def:setLvlDataInt('Nab3', level, 3, value)
end

function AbilityDefinitionAlchemistAcidBomb:setSecondaryDamage(level, value)
    checktype(level, 'integer', 'setSecondaryDamage', 1)
    checktype(value, 'float', 'setSecondaryDamage', 2)
    self.def:setLvlDataUnreal('Nab5', level, 5, value)
end

function AbilityDefinitionAlchemistAcidBomb:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Nab2', level, 2, value)
end

AbilityDefinitionPermanentImmolationflying = class('AbilityDefinitionPermanentImmolationflying', AbilityDefinition)
_G.AbilityDefinitionPermanentImmolationflying = AbilityDefinitionPermanentImmolationflying

function AbilityDefinitionPermanentImmolationflying:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apmf')
end

function AbilityDefinitionPermanentImmolationflying:setManaDrainedperSecond(level, value)
    checktype(level, 'integer', 'setManaDrainedperSecond', 1)
    checktype(value, 'float', 'setManaDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Eim2', level, 2, value)
end

function AbilityDefinitionPermanentImmolationflying:setBufferManaRequired(level, value)
    checktype(level, 'integer', 'setBufferManaRequired', 1)
    checktype(value, 'float', 'setBufferManaRequired', 2)
    self.def:setLvlDataUnreal('Eim3', level, 3, value)
end

function AbilityDefinitionPermanentImmolationflying:setDamageperInterval(level, value)
    checktype(level, 'integer', 'setDamageperInterval', 1)
    checktype(value, 'float', 'setDamageperInterval', 2)
    self.def:setLvlDataUnreal('Eim1', level, 1, value)
end

AbilityDefinitionTornadoSpin = class('AbilityDefinitionTornadoSpin', AbilityDefinition)
_G.AbilityDefinitionTornadoSpin = AbilityDefinitionTornadoSpin

function AbilityDefinitionTornadoSpin:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Atsp')
end

function AbilityDefinitionTornadoSpin:setMinimumHitIntervalseconds(level, value)
    checktype(level, 'integer', 'setMinimumHitIntervalseconds', 1)
    checktype(value, 'float', 'setMinimumHitIntervalseconds', 2)
    self.def:setLvlDataUnreal('Tsp2', level, 2, value)
end

function AbilityDefinitionTornadoSpin:setAirTimeseconds(level, value)
    checktype(level, 'integer', 'setAirTimeseconds', 1)
    checktype(value, 'float', 'setAirTimeseconds', 2)
    self.def:setLvlDataUnreal('Tsp1', level, 1, value)
end

AbilityDefinitionAntimagicShield = class('AbilityDefinitionAntimagicShield', AbilityDefinition)
_G.AbilityDefinitionAntimagicShield = AbilityDefinitionAntimagicShield

function AbilityDefinitionAntimagicShield:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aams')
end

function AbilityDefinitionAntimagicShield:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Ams2', level, 2, value)
end

function AbilityDefinitionAntimagicShield:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Ams4', level, 4, value)
end

function AbilityDefinitionAntimagicShield:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Ams1', level, 1, value)
end

function AbilityDefinitionAntimagicShield:setShieldLife(level, value)
    checktype(level, 'integer', 'setShieldLife', 1)
    checktype(value, 'integer', 'setShieldLife', 2)
    self.def:setLvlDataInt('Ams3', level, 3, value)
end

AbilityDefinitionOrbofDarknessBlackArrow = class('AbilityDefinitionOrbofDarknessBlackArrow', AbilityDefinition)
_G.AbilityDefinitionOrbofDarknessBlackArrow = AbilityDefinitionOrbofDarknessBlackArrow

function AbilityDefinitionOrbofDarknessBlackArrow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANbs')
end

function AbilityDefinitionOrbofDarknessBlackArrow:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Nba2', level, 2, value)
end

function AbilityDefinitionOrbofDarknessBlackArrow:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Nba1', level, 1, value)
end

function AbilityDefinitionOrbofDarknessBlackArrow:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Nbau', level, 0, value)
end

function AbilityDefinitionOrbofDarknessBlackArrow:setSummonedUnitDurationseconds(level, value)
    checktype(level, 'integer', 'setSummonedUnitDurationseconds', 1)
    checktype(value, 'float', 'setSummonedUnitDurationseconds', 2)
    self.def:setLvlDataUnreal('Nba3', level, 3, value)
end

AbilityDefinitionTinkererDemolishLevel3 = class('AbilityDefinitionTinkererDemolishLevel3', AbilityDefinition)
_G.AbilityDefinitionTinkererDemolishLevel3 = AbilityDefinitionTinkererDemolishLevel3

function AbilityDefinitionTinkererDemolishLevel3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANd3')
end

function AbilityDefinitionTinkererDemolishLevel3:setDamageMultiplierBuildings(level, value)
    checktype(level, 'integer', 'setDamageMultiplierBuildings', 1)
    checktype(value, 'float', 'setDamageMultiplierBuildings', 2)
    self.def:setLvlDataUnreal('Nde2', level, 2, value)
end

function AbilityDefinitionTinkererDemolishLevel3:setDamageMultiplierUnits(level, value)
    checktype(level, 'integer', 'setDamageMultiplierUnits', 1)
    checktype(value, 'float', 'setDamageMultiplierUnits', 2)
    self.def:setLvlDataUnreal('Nde3', level, 3, value)
end

function AbilityDefinitionTinkererDemolishLevel3:setDamageMultiplierHeroes(level, value)
    checktype(level, 'integer', 'setDamageMultiplierHeroes', 1)
    checktype(value, 'float', 'setDamageMultiplierHeroes', 2)
    self.def:setLvlDataUnreal('Nde4', level, 4, value)
end

function AbilityDefinitionTinkererDemolishLevel3:setChancetoDemolish(level, value)
    checktype(level, 'integer', 'setChancetoDemolish', 1)
    checktype(value, 'float', 'setChancetoDemolish', 2)
    self.def:setLvlDataUnreal('Nde1', level, 1, value)
end

AbilityDefinitionSlowAIos = class('AbilityDefinitionSlowAIos', AbilityDefinition)
_G.AbilityDefinitionSlowAIos = AbilityDefinitionSlowAIos

function AbilityDefinitionSlowAIos:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIos')
end

function AbilityDefinitionSlowAIos:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo1', level, 1, value)
end

function AbilityDefinitionSlowAIos:setAlwaysAutocast(level, value)
    checktype(level, 'integer', 'setAlwaysAutocast', 1)
    checktype(value, 'boolean', 'setAlwaysAutocast', 2)
    self.def:setLvlDataBoolean('Slo3', level, 3, value)
end

function AbilityDefinitionSlowAIos:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo2', level, 2, value)
end

AbilityDefinitionBattleRoar = class('AbilityDefinitionBattleRoar', AbilityDefinition)
_G.AbilityDefinitionBattleRoar = AbilityDefinitionBattleRoar

function AbilityDefinitionBattleRoar:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANbr')
end

function AbilityDefinitionBattleRoar:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Nbr1', level, 1, value)
end

function AbilityDefinitionBattleRoar:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Roa2', level, 2, value)
end

function AbilityDefinitionBattleRoar:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionBattleRoar:setLifeRegenerationRate(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRate', 1)
    checktype(value, 'float', 'setLifeRegenerationRate', 2)
    self.def:setLvlDataUnreal('Roa3', level, 3, value)
end

function AbilityDefinitionBattleRoar:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

function AbilityDefinitionBattleRoar:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionBattleRoar:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

AbilityDefinitionTinkererDemolishLevel1 = class('AbilityDefinitionTinkererDemolishLevel1', AbilityDefinition)
_G.AbilityDefinitionTinkererDemolishLevel1 = AbilityDefinitionTinkererDemolishLevel1

function AbilityDefinitionTinkererDemolishLevel1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANd1')
end

function AbilityDefinitionTinkererDemolishLevel1:setDamageMultiplierBuildings(level, value)
    checktype(level, 'integer', 'setDamageMultiplierBuildings', 1)
    checktype(value, 'float', 'setDamageMultiplierBuildings', 2)
    self.def:setLvlDataUnreal('Nde2', level, 2, value)
end

function AbilityDefinitionTinkererDemolishLevel1:setDamageMultiplierUnits(level, value)
    checktype(level, 'integer', 'setDamageMultiplierUnits', 1)
    checktype(value, 'float', 'setDamageMultiplierUnits', 2)
    self.def:setLvlDataUnreal('Nde3', level, 3, value)
end

function AbilityDefinitionTinkererDemolishLevel1:setDamageMultiplierHeroes(level, value)
    checktype(level, 'integer', 'setDamageMultiplierHeroes', 1)
    checktype(value, 'float', 'setDamageMultiplierHeroes', 2)
    self.def:setLvlDataUnreal('Nde4', level, 4, value)
end

function AbilityDefinitionTinkererDemolishLevel1:setChancetoDemolish(level, value)
    checktype(level, 'integer', 'setChancetoDemolish', 1)
    checktype(value, 'float', 'setChancetoDemolish', 2)
    self.def:setLvlDataUnreal('Nde1', level, 1, value)
end

AbilityDefinitionTinkererDemolishLevel2 = class('AbilityDefinitionTinkererDemolishLevel2', AbilityDefinition)
_G.AbilityDefinitionTinkererDemolishLevel2 = AbilityDefinitionTinkererDemolishLevel2

function AbilityDefinitionTinkererDemolishLevel2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANd2')
end

function AbilityDefinitionTinkererDemolishLevel2:setDamageMultiplierBuildings(level, value)
    checktype(level, 'integer', 'setDamageMultiplierBuildings', 1)
    checktype(value, 'float', 'setDamageMultiplierBuildings', 2)
    self.def:setLvlDataUnreal('Nde2', level, 2, value)
end

function AbilityDefinitionTinkererDemolishLevel2:setDamageMultiplierUnits(level, value)
    checktype(level, 'integer', 'setDamageMultiplierUnits', 1)
    checktype(value, 'float', 'setDamageMultiplierUnits', 2)
    self.def:setLvlDataUnreal('Nde3', level, 3, value)
end

function AbilityDefinitionTinkererDemolishLevel2:setDamageMultiplierHeroes(level, value)
    checktype(level, 'integer', 'setDamageMultiplierHeroes', 1)
    checktype(value, 'float', 'setDamageMultiplierHeroes', 2)
    self.def:setLvlDataUnreal('Nde4', level, 4, value)
end

function AbilityDefinitionTinkererDemolishLevel2:setChancetoDemolish(level, value)
    checktype(level, 'integer', 'setChancetoDemolish', 1)
    checktype(value, 'float', 'setChancetoDemolish', 2)
    self.def:setLvlDataUnreal('Nde1', level, 1, value)
end

AbilityDefinitionAttributeModifierSkill = class('AbilityDefinitionAttributeModifierSkill', AbilityDefinition)
_G.AbilityDefinitionAttributeModifierSkill = AbilityDefinitionAttributeModifierSkill

function AbilityDefinitionAttributeModifierSkill:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aamk')
end

function AbilityDefinitionAttributeModifierSkill:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAttributeModifierSkill:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAttributeModifierSkill:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAttributeModifierSkill:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionDispelMagic = class('AbilityDefinitionDispelMagic', AbilityDefinition)
_G.AbilityDefinitionDispelMagic = AbilityDefinitionDispelMagic

function AbilityDefinitionDispelMagic:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adis')
end

function AbilityDefinitionDispelMagic:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'float', 'setManaLoss', 2)
    self.def:setLvlDataUnreal('Adm1', level, 1, value)
end

function AbilityDefinitionDispelMagic:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Adm2', level, 2, value)
end

AbilityDefinitionBashBeastmasterBear = class('AbilityDefinitionBashBeastmasterBear', AbilityDefinition)
_G.AbilityDefinitionBashBeastmasterBear = AbilityDefinitionBashBeastmasterBear

function AbilityDefinitionBashBeastmasterBear:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANbh')
end

function AbilityDefinitionBashBeastmasterBear:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Hbh5', level, 5, value)
end

AbilityDefinitionBrewmasterBreathofFire = class('AbilityDefinitionBrewmasterBreathofFire', AbilityDefinition)
_G.AbilityDefinitionBrewmasterBreathofFire = AbilityDefinitionBrewmasterBreathofFire

function AbilityDefinitionBrewmasterBreathofFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANbf')
end

function AbilityDefinitionBrewmasterBreathofFire:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ucs2', level, 2, value)
end

function AbilityDefinitionBrewmasterBreathofFire:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Nbf5', level, 5, value)
end

function AbilityDefinitionBrewmasterBreathofFire:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ucs1', level, 1, value)
end

function AbilityDefinitionBrewmasterBreathofFire:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionBrewmasterBreathofFire:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionPolymorph = class('AbilityDefinitionPolymorph', AbilityDefinition)
_G.AbilityDefinitionPolymorph = AbilityDefinitionPolymorph

function AbilityDefinitionPolymorph:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aply')
end

function AbilityDefinitionPolymorph:setMorphUnitsGround(level, value)
    checktype(level, 'integer', 'setMorphUnitsGround', 1)
    checktype(value, 'string', 'setMorphUnitsGround', 2)
    self.def:setLvlDataString('Ply2', level, 2, value)
end

function AbilityDefinitionPolymorph:setMorphUnitsWater(level, value)
    checktype(level, 'integer', 'setMorphUnitsWater', 1)
    checktype(value, 'string', 'setMorphUnitsWater', 2)
    self.def:setLvlDataString('Ply5', level, 5, value)
end

function AbilityDefinitionPolymorph:setMorphUnitsAmphibious(level, value)
    checktype(level, 'integer', 'setMorphUnitsAmphibious', 1)
    checktype(value, 'string', 'setMorphUnitsAmphibious', 2)
    self.def:setLvlDataString('Ply4', level, 4, value)
end

function AbilityDefinitionPolymorph:setMorphUnitsAir(level, value)
    checktype(level, 'integer', 'setMorphUnitsAir', 1)
    checktype(value, 'string', 'setMorphUnitsAir', 2)
    self.def:setLvlDataString('Ply3', level, 3, value)
end

function AbilityDefinitionPolymorph:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Ply1', level, 1, value)
end

AbilityDefinitionPurgeorb = class('AbilityDefinitionPurgeorb', AbilityDefinition)
_G.AbilityDefinitionPurgeorb = AbilityDefinitionPurgeorb

function AbilityDefinitionPurgeorb:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIpg')
end

function AbilityDefinitionPurgeorb:setHeroPauseDuration(level, value)
    checktype(level, 'integer', 'setHeroPauseDuration', 1)
    checktype(value, 'float', 'setHeroPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg5', level, 5, value)
end

function AbilityDefinitionPurgeorb:setUnitPauseDuration(level, value)
    checktype(level, 'integer', 'setUnitPauseDuration', 1)
    checktype(value, 'float', 'setUnitPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg4', level, 4, value)
end

function AbilityDefinitionPurgeorb:setMovementUpdateFrequency(level, value)
    checktype(level, 'integer', 'setMovementUpdateFrequency', 1)
    checktype(value, 'integer', 'setMovementUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg1', level, 1, value)
end

function AbilityDefinitionPurgeorb:setAttackUpdateFrequency(level, value)
    checktype(level, 'integer', 'setAttackUpdateFrequency', 1)
    checktype(value, 'integer', 'setAttackUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg2', level, 2, value)
end

function AbilityDefinitionPurgeorb:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Prg6', level, 6, value)
end

function AbilityDefinitionPurgeorb:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Prg3', level, 3, value)
end

AbilityDefinitionDarkRangerBlackArrow = class('AbilityDefinitionDarkRangerBlackArrow', AbilityDefinition)
_G.AbilityDefinitionDarkRangerBlackArrow = AbilityDefinitionDarkRangerBlackArrow

function AbilityDefinitionDarkRangerBlackArrow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANba')
end

function AbilityDefinitionDarkRangerBlackArrow:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Nba2', level, 2, value)
end

function AbilityDefinitionDarkRangerBlackArrow:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Nba1', level, 1, value)
end

function AbilityDefinitionDarkRangerBlackArrow:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Nbau', level, 0, value)
end

function AbilityDefinitionDarkRangerBlackArrow:setSummonedUnitDurationseconds(level, value)
    checktype(level, 'integer', 'setSummonedUnitDurationseconds', 1)
    checktype(value, 'float', 'setSummonedUnitDurationseconds', 2)
    self.def:setLvlDataUnreal('Nba3', level, 3, value)
end

AbilityDefinitionCargoHoldEntangledGoldMine = class('AbilityDefinitionCargoHoldEntangledGoldMine', AbilityDefinition)
_G.AbilityDefinitionCargoHoldEntangledGoldMine = AbilityDefinitionCargoHoldEntangledGoldMine

function AbilityDefinitionCargoHoldEntangledGoldMine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aenc')
end

function AbilityDefinitionCargoHoldEntangledGoldMine:setCargoCapacity(level, value)
    checktype(level, 'integer', 'setCargoCapacity', 1)
    checktype(value, 'integer', 'setCargoCapacity', 2)
    self.def:setLvlDataInt('Car1', level, 1, value)
end

AbilityDefinitionAerialShackles = class('AbilityDefinitionAerialShackles', AbilityDefinition)
_G.AbilityDefinitionAerialShackles = AbilityDefinitionAerialShackles

function AbilityDefinitionAerialShackles:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amls')
end

function AbilityDefinitionAerialShackles:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('mls1', level, 1, value)
end

AbilityDefinitionOrbofVenom = class('AbilityDefinitionOrbofVenom', AbilityDefinition)
_G.AbilityDefinitionOrbofVenom = AbilityDefinitionOrbofVenom

function AbilityDefinitionOrbofVenom:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIpb')
end

function AbilityDefinitionOrbofVenom:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionOrbofVenom:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

function AbilityDefinitionOrbofVenom:setDamageBonusDice(level, value)
    checktype(level, 'integer', 'setDamageBonusDice', 1)
    checktype(value, 'integer', 'setDamageBonusDice', 2)
    self.def:setLvlDataInt('Idic', level, 1, value)
end

AbilityDefinitionDetectShade = class('AbilityDefinitionDetectShade', AbilityDefinition)
_G.AbilityDefinitionDetectShade = AbilityDefinitionDetectShade

function AbilityDefinitionDetectShade:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Atru')
end

function AbilityDefinitionDetectShade:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionAlliedBuilding = class('AbilityDefinitionAlliedBuilding', AbilityDefinition)
_G.AbilityDefinitionAlliedBuilding = AbilityDefinitionAlliedBuilding

function AbilityDefinitionAlliedBuilding:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aall')
end

function AbilityDefinitionAlliedBuilding:setShowUnitIndicator(level, value)
    checktype(level, 'integer', 'setShowUnitIndicator', 1)
    checktype(value, 'boolean', 'setShowUnitIndicator', 2)
    self.def:setLvlDataBoolean('Neu4', level, 4, value)
end

function AbilityDefinitionAlliedBuilding:setActivationRadius(level, value)
    checktype(level, 'integer', 'setActivationRadius', 1)
    checktype(value, 'float', 'setActivationRadius', 2)
    self.def:setLvlDataUnreal('Neu1', level, 1, value)
end

function AbilityDefinitionAlliedBuilding:setShowSelectUnitButton(level, value)
    checktype(level, 'integer', 'setShowSelectUnitButton', 1)
    checktype(value, 'boolean', 'setShowSelectUnitButton', 2)
    self.def:setLvlDataBoolean('Neu3', level, 3, value)
end

function AbilityDefinitionAlliedBuilding:setInteractionType(level, value)
    checktype(level, 'integer', 'setInteractionType', 1)
    checktype(value, 'integer', 'setInteractionType', 2)
    self.def:setLvlDataInt('Neu2', level, 2, value)
end

AbilityDefinitionControlMagic = class('AbilityDefinitionControlMagic', AbilityDefinition)
_G.AbilityDefinitionControlMagic = AbilityDefinitionControlMagic

function AbilityDefinitionControlMagic:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acmg')
end

function AbilityDefinitionControlMagic:setChargeforCurrentLife(level, value)
    checktype(level, 'integer', 'setChargeforCurrentLife', 1)
    checktype(value, 'float', 'setChargeforCurrentLife', 2)
    self.def:setLvlDataUnreal('Cmg3', level, 3, value)
end

function AbilityDefinitionControlMagic:setManaperSummonedHitpoint(level, value)
    checktype(level, 'integer', 'setManaperSummonedHitpoint', 1)
    checktype(value, 'float', 'setManaperSummonedHitpoint', 2)
    self.def:setLvlDataUnreal('Cmg2', level, 2, value)
end

function AbilityDefinitionControlMagic:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Nch1', level, 1, value)
end

AbilityDefinitionDreadlordCarrionSwarm = class('AbilityDefinitionDreadlordCarrionSwarm', AbilityDefinition)
_G.AbilityDefinitionDreadlordCarrionSwarm = AbilityDefinitionDreadlordCarrionSwarm

function AbilityDefinitionDreadlordCarrionSwarm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUcs')
end

function AbilityDefinitionDreadlordCarrionSwarm:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ucs2', level, 2, value)
end

function AbilityDefinitionDreadlordCarrionSwarm:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ucs1', level, 1, value)
end

function AbilityDefinitionDreadlordCarrionSwarm:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionDreadlordCarrionSwarm:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionAllPlus1 = class('AbilityDefinitionAllPlus1', AbilityDefinition)
_G.AbilityDefinitionAllPlus1 = AbilityDefinitionAllPlus1

function AbilityDefinitionAllPlus1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIx1')
end

function AbilityDefinitionAllPlus1:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAllPlus1:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAllPlus1:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAllPlus1:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionAllPlus2 = class('AbilityDefinitionAllPlus2', AbilityDefinition)
_G.AbilityDefinitionAllPlus2 = AbilityDefinitionAllPlus2

function AbilityDefinitionAllPlus2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIx2')
end

function AbilityDefinitionAllPlus2:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAllPlus2:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAllPlus2:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAllPlus2:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionAllPlus3 = class('AbilityDefinitionAllPlus3', AbilityDefinition)
_G.AbilityDefinitionAllPlus3 = AbilityDefinitionAllPlus3

function AbilityDefinitionAllPlus3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIx3')
end

function AbilityDefinitionAllPlus3:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionAllPlus3:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionAllPlus3:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionAllPlus3:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionCrownofKingsAllPlus5 = class('AbilityDefinitionCrownofKingsAllPlus5', AbilityDefinition)
_G.AbilityDefinitionCrownofKingsAllPlus5 = AbilityDefinitionCrownofKingsAllPlus5

function AbilityDefinitionCrownofKingsAllPlus5:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIx5')
end

function AbilityDefinitionCrownofKingsAllPlus5:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionCrownofKingsAllPlus5:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionCrownofKingsAllPlus5:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionCrownofKingsAllPlus5:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionCorrosiveBreath = class('AbilityDefinitionCorrosiveBreath', AbilityDefinition)
_G.AbilityDefinitionCorrosiveBreath = AbilityDefinitionCorrosiveBreath

function AbilityDefinitionCorrosiveBreath:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acor')
end

function AbilityDefinitionCorrosiveBreath:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Cor1', level, 1, value)
end

AbilityDefinitionRootAncients = class('AbilityDefinitionRootAncients', AbilityDefinition)
_G.AbilityDefinitionRootAncients = AbilityDefinitionRootAncients

function AbilityDefinitionRootAncients:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aro1')
end

function AbilityDefinitionRootAncients:setUprootedDefenseType(level, value)
    checktype(level, 'integer', 'setUprootedDefenseType', 1)
    checktype(value, 'string', 'setUprootedDefenseType', 2)
    self.def:setLvlDataString('Roo4', level, 4, value)
end

function AbilityDefinitionRootAncients:setRootedTurning(level, value)
    checktype(level, 'integer', 'setRootedTurning', 1)
    checktype(value, 'boolean', 'setRootedTurning', 2)
    self.def:setLvlDataBoolean('Roo3', level, 3, value)
end

function AbilityDefinitionRootAncients:setUprootedWeapons(level, value)
    checktype(level, 'integer', 'setUprootedWeapons', 1)
    checktype(value, 'string', 'setUprootedWeapons', 2)
    self.def:setLvlDataString('Roo2', level, 2, value)
end

function AbilityDefinitionRootAncients:setRootedWeapons(level, value)
    checktype(level, 'integer', 'setRootedWeapons', 1)
    checktype(value, 'string', 'setRootedWeapons', 2)
    self.def:setLvlDataString('Roo1', level, 1, value)
end

AbilityDefinitionRootAncientProtector = class('AbilityDefinitionRootAncientProtector', AbilityDefinition)
_G.AbilityDefinitionRootAncientProtector = AbilityDefinitionRootAncientProtector

function AbilityDefinitionRootAncientProtector:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aro2')
end

function AbilityDefinitionRootAncientProtector:setUprootedDefenseType(level, value)
    checktype(level, 'integer', 'setUprootedDefenseType', 1)
    checktype(value, 'string', 'setUprootedDefenseType', 2)
    self.def:setLvlDataString('Roo4', level, 4, value)
end

function AbilityDefinitionRootAncientProtector:setRootedTurning(level, value)
    checktype(level, 'integer', 'setRootedTurning', 1)
    checktype(value, 'boolean', 'setRootedTurning', 2)
    self.def:setLvlDataBoolean('Roo3', level, 3, value)
end

function AbilityDefinitionRootAncientProtector:setUprootedWeapons(level, value)
    checktype(level, 'integer', 'setUprootedWeapons', 1)
    checktype(value, 'string', 'setUprootedWeapons', 2)
    self.def:setLvlDataString('Roo2', level, 2, value)
end

function AbilityDefinitionRootAncientProtector:setRootedWeapons(level, value)
    checktype(level, 'integer', 'setRootedWeapons', 1)
    checktype(value, 'string', 'setRootedWeapons', 2)
    self.def:setLvlDataString('Roo1', level, 1, value)
end

AbilityDefinitionFactory = class('AbilityDefinitionFactory', AbilityDefinition)
_G.AbilityDefinitionFactory = AbilityDefinitionFactory

function AbilityDefinitionFactory:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANfy')
end

function AbilityDefinitionFactory:setSpawnUnitID(level, value)
    checktype(level, 'integer', 'setSpawnUnitID', 1)
    checktype(value, 'string', 'setSpawnUnitID', 2)
    self.def:setLvlDataString('Nfyu', level, 0, value)
end

function AbilityDefinitionFactory:setLeashRange(level, value)
    checktype(level, 'integer', 'setLeashRange', 1)
    checktype(value, 'float', 'setLeashRange', 2)
    self.def:setLvlDataUnreal('Nfy2', level, 2, value)
end

function AbilityDefinitionFactory:setSpawnInterval(level, value)
    checktype(level, 'integer', 'setSpawnInterval', 1)
    checktype(value, 'float', 'setSpawnInterval', 2)
    self.def:setLvlDataUnreal('Nfy1', level, 1, value)
end

AbilityDefinitionKeeperoftheGroveForceofNature = class('AbilityDefinitionKeeperoftheGroveForceofNature', AbilityDefinition)
_G.AbilityDefinitionKeeperoftheGroveForceofNature = AbilityDefinitionKeeperoftheGroveForceofNature

function AbilityDefinitionKeeperoftheGroveForceofNature:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEfn')
end

function AbilityDefinitionKeeperoftheGroveForceofNature:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Efnu', level, 0, value)
end

function AbilityDefinitionKeeperoftheGroveForceofNature:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Efn1', level, 1, value)
end

AbilityDefinitionLichDeathandDecay = class('AbilityDefinitionLichDeathandDecay', AbilityDefinition)
_G.AbilityDefinitionLichDeathandDecay = AbilityDefinitionLichDeathandDecay

function AbilityDefinitionLichDeathandDecay:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUdd')
end

function AbilityDefinitionLichDeathandDecay:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Udd2', level, 2, value)
end

function AbilityDefinitionLichDeathandDecay:setMaxLifeDrainedperSecond(level, value)
    checktype(level, 'integer', 'setMaxLifeDrainedperSecond', 1)
    checktype(value, 'float', 'setMaxLifeDrainedperSecond', 2)
    self.def:setLvlDataUnreal('Udd1', level, 1, value)
end

AbilityDefinitionItemWeb = class('AbilityDefinitionItemWeb', AbilityDefinition)
_G.AbilityDefinitionItemWeb = AbilityDefinitionItemWeb

function AbilityDefinitionItemWeb:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIwb')
end

function AbilityDefinitionItemWeb:setAirUnitHeight(level, value)
    checktype(level, 'integer', 'setAirUnitHeight', 1)
    checktype(value, 'float', 'setAirUnitHeight', 2)
    self.def:setLvlDataUnreal('Ens2', level, 2, value)
end

function AbilityDefinitionItemWeb:setAirUnitLowerDuration(level, value)
    checktype(level, 'integer', 'setAirUnitLowerDuration', 1)
    checktype(value, 'float', 'setAirUnitLowerDuration', 2)
    self.def:setLvlDataUnreal('Ens1', level, 1, value)
end

function AbilityDefinitionItemWeb:setMeleeAttackRange(level, value)
    checktype(level, 'integer', 'setMeleeAttackRange', 1)
    checktype(value, 'float', 'setMeleeAttackRange', 2)
    self.def:setLvlDataUnreal('Ens3', level, 3, value)
end

AbilityDefinitionWardenFanofKnives = class('AbilityDefinitionWardenFanofKnives', AbilityDefinition)
_G.AbilityDefinitionWardenFanofKnives = AbilityDefinitionWardenFanofKnives

function AbilityDefinitionWardenFanofKnives:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEfk')
end

function AbilityDefinitionWardenFanofKnives:setMaximumSpeedAdjustment(level, value)
    checktype(level, 'integer', 'setMaximumSpeedAdjustment', 1)
    checktype(value, 'float', 'setMaximumSpeedAdjustment', 2)
    self.def:setLvlDataUnreal('Efk4', level, 4, value)
end

function AbilityDefinitionWardenFanofKnives:setMaximumNumberofTargets(level, value)
    checktype(level, 'integer', 'setMaximumNumberofTargets', 1)
    checktype(value, 'integer', 'setMaximumNumberofTargets', 2)
    self.def:setLvlDataInt('Efk3', level, 3, value)
end

function AbilityDefinitionWardenFanofKnives:setDamagePerTarget(level, value)
    checktype(level, 'integer', 'setDamagePerTarget', 1)
    checktype(value, 'float', 'setDamagePerTarget', 2)
    self.def:setLvlDataUnreal('Efk1', level, 1, value)
end

function AbilityDefinitionWardenFanofKnives:setMaximumTotalDamage(level, value)
    checktype(level, 'integer', 'setMaximumTotalDamage', 1)
    checktype(value, 'float', 'setMaximumTotalDamage', 2)
    self.def:setLvlDataUnreal('Efk2', level, 2, value)
end

AbilityDefinitionBattlestationsChaos = class('AbilityDefinitionBattlestationsChaos', AbilityDefinition)
_G.AbilityDefinitionBattlestationsChaos = AbilityDefinitionBattlestationsChaos

function AbilityDefinitionBattlestationsChaos:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sbtl')
end

function AbilityDefinitionBattlestationsChaos:setSummonBusyUnits(level, value)
    checktype(level, 'integer', 'setSummonBusyUnits', 1)
    checktype(value, 'boolean', 'setSummonBusyUnits', 2)
    self.def:setLvlDataBoolean('Btl2', level, 2, value)
end

function AbilityDefinitionBattlestationsChaos:setAllowedUnitType(level, value)
    checktype(level, 'integer', 'setAllowedUnitType', 1)
    checktype(value, 'string', 'setAllowedUnitType', 2)
    self.def:setLvlDataString('Btl1', level, 0, value)
end

AbilityDefinitionCorporealForm = class('AbilityDefinitionCorporealForm', AbilityDefinition)
_G.AbilityDefinitionCorporealForm = AbilityDefinitionCorporealForm

function AbilityDefinitionCorporealForm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acpf')
end

function AbilityDefinitionCorporealForm:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionCorporealForm:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionCorporealForm:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionCorporealForm:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionCorporealForm:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionDeathKnightDeathCoil = class('AbilityDefinitionDeathKnightDeathCoil', AbilityDefinition)
_G.AbilityDefinitionDeathKnightDeathCoil = AbilityDefinitionDeathKnightDeathCoil

function AbilityDefinitionDeathKnightDeathCoil:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUdc')
end

function AbilityDefinitionDeathKnightDeathCoil:setAmountHealedDamaged(level, value)
    checktype(level, 'integer', 'setAmountHealedDamaged', 1)
    checktype(value, 'float', 'setAmountHealedDamaged', 2)
    self.def:setLvlDataUnreal('Udc1', level, 1, value)
end

AbilityDefinitionPhaseShift = class('AbilityDefinitionPhaseShift', AbilityDefinition)
_G.AbilityDefinitionPhaseShift = AbilityDefinitionPhaseShift

function AbilityDefinitionPhaseShift:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apsh')
end

function AbilityDefinitionPhaseShift:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Hbn2', level, 2, value)
end

function AbilityDefinitionPhaseShift:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Hbn1', level, 1, value)
end

AbilityDefinitionSleepAlways = class('AbilityDefinitionSleepAlways', AbilityDefinition)
_G.AbilityDefinitionSleepAlways = AbilityDefinitionSleepAlways

function AbilityDefinitionSleepAlways:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asla')
end

function AbilityDefinitionSleepAlways:setSleepOnce(level, value)
    checktype(level, 'integer', 'setSleepOnce', 1)
    checktype(value, 'boolean', 'setSleepOnce', 2)
    self.def:setLvlDataBoolean('sla1', level, 1, value)
end

function AbilityDefinitionSleepAlways:setAllowOnAnyPlayerSlot(level, value)
    checktype(level, 'integer', 'setAllowOnAnyPlayerSlot', 1)
    checktype(value, 'boolean', 'setAllowOnAnyPlayerSlot', 2)
    self.def:setLvlDataBoolean('sla2', level, 2, value)
end

AbilityDefinitionFigurineUrsaWarrior = class('AbilityDefinitionFigurineUrsaWarrior', AbilityDefinition)
_G.AbilityDefinitionFigurineUrsaWarrior = AbilityDefinitionFigurineUrsaWarrior

function AbilityDefinitionFigurineUrsaWarrior:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIuw')
end

function AbilityDefinitionFigurineUrsaWarrior:setSummonUnitType(level, value)
    checktype(level, 'integer', 'setSummonUnitType', 1)
    checktype(value, 'string', 'setSummonUnitType', 2)
    self.def:setLvlDataString('Ist2', level, 4, value)
end

function AbilityDefinitionFigurineUrsaWarrior:setSummonAmount(level, value)
    checktype(level, 'integer', 'setSummonAmount', 1)
    checktype(value, 'integer', 'setSummonAmount', 2)
    self.def:setLvlDataInt('Isn2', level, 2, value)
end

function AbilityDefinitionFigurineUrsaWarrior:setSummonUnitType1(level, value)
    checktype(level, 'integer', 'setSummonUnitType1', 1)
    checktype(value, 'string', 'setSummonUnitType1', 2)
    self.def:setLvlDataString('Ist1', level, 3, value)
end

function AbilityDefinitionFigurineUrsaWarrior:setSummonAmount1(level, value)
    checktype(level, 'integer', 'setSummonAmount1', 1)
    checktype(value, 'integer', 'setSummonAmount1', 2)
    self.def:setLvlDataInt('Isn1', level, 1, value)
end

AbilityDefinitionElunesGrace = class('AbilityDefinitionElunesGrace', AbilityDefinition)
_G.AbilityDefinitionElunesGrace = AbilityDefinitionElunesGrace

function AbilityDefinitionElunesGrace:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aegr')
end

function AbilityDefinitionElunesGrace:setChancetoDeflect(level, value)
    checktype(level, 'integer', 'setChancetoDeflect', 1)
    checktype(value, 'float', 'setChancetoDeflect', 2)
    self.def:setLvlDataUnreal('Def6', level, 6, value)
end

function AbilityDefinitionElunesGrace:setDeflectDamageTakenSpells(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenSpells', 1)
    checktype(value, 'float', 'setDeflectDamageTakenSpells', 2)
    self.def:setLvlDataUnreal('Def8', level, 8, value)
end

function AbilityDefinitionElunesGrace:setDeflectDamageTakenPiercing(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenPiercing', 1)
    checktype(value, 'float', 'setDeflectDamageTakenPiercing', 2)
    self.def:setLvlDataUnreal('Def7', level, 7, value)
end

function AbilityDefinitionElunesGrace:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Def5', level, 5, value)
end

function AbilityDefinitionElunesGrace:setDamageTaken(level, value)
    checktype(level, 'integer', 'setDamageTaken', 1)
    checktype(value, 'float', 'setDamageTaken', 2)
    self.def:setLvlDataUnreal('Def1', level, 1, value)
end

function AbilityDefinitionElunesGrace:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Def2', level, 2, value)
end

AbilityDefinitionReturnLumber = class('AbilityDefinitionReturnLumber', AbilityDefinition)
_G.AbilityDefinitionReturnLumber = AbilityDefinitionReturnLumber

function AbilityDefinitionReturnLumber:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arlm')
end

function AbilityDefinitionReturnLumber:setAcceptsGold(level, value)
    checktype(level, 'integer', 'setAcceptsGold', 1)
    checktype(value, 'boolean', 'setAcceptsGold', 2)
    self.def:setLvlDataBoolean('Rtn1', level, 1, value)
end

function AbilityDefinitionReturnLumber:setAcceptsLumber(level, value)
    checktype(level, 'integer', 'setAcceptsLumber', 1)
    checktype(value, 'boolean', 'setAcceptsLumber', 2)
    self.def:setLvlDataBoolean('Rtn2', level, 2, value)
end

AbilityDefinitionRegenLifeArll = class('AbilityDefinitionRegenLifeArll', AbilityDefinition)
_G.AbilityDefinitionRegenLifeArll = AbilityDefinitionRegenLifeArll

function AbilityDefinitionRegenLifeArll:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arll')
end

function AbilityDefinitionRegenLifeArll:setHitPointsRegeneratedPerSecond(level, value)
    checktype(level, 'integer', 'setHitPointsRegeneratedPerSecond', 1)
    checktype(value, 'integer', 'setHitPointsRegeneratedPerSecond', 2)
    self.def:setLvlDataInt('Ihpr', level, 1, value)
end

AbilityDefinitionDemonHunterEvasion = class('AbilityDefinitionDemonHunterEvasion', AbilityDefinition)
_G.AbilityDefinitionDemonHunterEvasion = AbilityDefinitionDemonHunterEvasion

function AbilityDefinitionDemonHunterEvasion:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEev')
end

function AbilityDefinitionDemonHunterEvasion:setChancetoEvade(level, value)
    checktype(level, 'integer', 'setChancetoEvade', 1)
    checktype(value, 'float', 'setChancetoEvade', 2)
    self.def:setLvlDataUnreal('Eev1', level, 1, value)
end

AbilityDefinitionPitLordHowlofTerror = class('AbilityDefinitionPitLordHowlofTerror', AbilityDefinition)
_G.AbilityDefinitionPitLordHowlofTerror = AbilityDefinitionPitLordHowlofTerror

function AbilityDefinitionPitLordHowlofTerror:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANht')
end

function AbilityDefinitionPitLordHowlofTerror:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Roa1', level, 1, value)
end

function AbilityDefinitionPitLordHowlofTerror:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Roa2', level, 2, value)
end

function AbilityDefinitionPitLordHowlofTerror:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionPitLordHowlofTerror:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

function AbilityDefinitionPitLordHowlofTerror:setLifeRegenerationRate(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRate', 1)
    checktype(value, 'float', 'setLifeRegenerationRate', 2)
    self.def:setLvlDataUnreal('Roa3', level, 3, value)
end

function AbilityDefinitionPitLordHowlofTerror:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionPitLordHowlofTerror:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

AbilityDefinitionAlchemistHealingSpray = class('AbilityDefinitionAlchemistHealingSpray', AbilityDefinition)
_G.AbilityDefinitionAlchemistHealingSpray = AbilityDefinitionAlchemistHealingSpray

function AbilityDefinitionAlchemistHealingSpray:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANhs')
end

function AbilityDefinitionAlchemistHealingSpray:setDamageInterval(level, value)
    checktype(level, 'integer', 'setDamageInterval', 1)
    checktype(value, 'float', 'setDamageInterval', 2)
    self.def:setLvlDataUnreal('Ncs2', level, 2, value)
end

function AbilityDefinitionAlchemistHealingSpray:setMaxDamage(level, value)
    checktype(level, 'integer', 'setMaxDamage', 1)
    checktype(value, 'float', 'setMaxDamage', 2)
    self.def:setLvlDataUnreal('Ncs4', level, 4, value)
end

function AbilityDefinitionAlchemistHealingSpray:setMissileCount(level, value)
    checktype(level, 'integer', 'setMissileCount', 1)
    checktype(value, 'integer', 'setMissileCount', 2)
    self.def:setLvlDataInt('Ncs3', level, 3, value)
end

function AbilityDefinitionAlchemistHealingSpray:setWaveCount(level, value)
    checktype(level, 'integer', 'setWaveCount', 1)
    checktype(value, 'integer', 'setWaveCount', 2)
    self.def:setLvlDataInt('Nhs6', level, 6, value)
end

function AbilityDefinitionAlchemistHealingSpray:setDamageAmount(level, value)
    checktype(level, 'integer', 'setDamageAmount', 1)
    checktype(value, 'float', 'setDamageAmount', 2)
    self.def:setLvlDataUnreal('Ncs1', level, 1, value)
end

function AbilityDefinitionAlchemistHealingSpray:setBuildingDamageFactor(level, value)
    checktype(level, 'integer', 'setBuildingDamageFactor', 1)
    checktype(value, 'float', 'setBuildingDamageFactor', 2)
    self.def:setLvlDataUnreal('Ncs5', level, 5, value)
end

AbilityDefinitionEntangledGoldMine = class('AbilityDefinitionEntangledGoldMine', AbilityDefinition)
_G.AbilityDefinitionEntangledGoldMine = AbilityDefinitionEntangledGoldMine

function AbilityDefinitionEntangledGoldMine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aegm')
end

function AbilityDefinitionEntangledGoldMine:setIntervalDuration(level, value)
    checktype(level, 'integer', 'setIntervalDuration', 1)
    checktype(value, 'float', 'setIntervalDuration', 2)
    self.def:setLvlDataUnreal('Egm2', level, 2, value)
end

function AbilityDefinitionEntangledGoldMine:setGoldperInterval(level, value)
    checktype(level, 'integer', 'setGoldperInterval', 1)
    checktype(value, 'integer', 'setGoldperInterval', 2)
    self.def:setLvlDataInt('Egm1', level, 1, value)
end

AbilityDefinitionKeeperoftheGroveEntanglingRoots = class('AbilityDefinitionKeeperoftheGroveEntanglingRoots', AbilityDefinition)
_G.AbilityDefinitionKeeperoftheGroveEntanglingRoots = AbilityDefinitionKeeperoftheGroveEntanglingRoots

function AbilityDefinitionKeeperoftheGroveEntanglingRoots:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AEer')
end

function AbilityDefinitionKeeperoftheGroveEntanglingRoots:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Eer1', level, 1, value)
end

AbilityDefinitionLightningShield = class('AbilityDefinitionLightningShield', AbilityDefinition)
_G.AbilityDefinitionLightningShield = AbilityDefinitionLightningShield

function AbilityDefinitionLightningShield:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Alsh')
end

function AbilityDefinitionLightningShield:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Lsh1', level, 1, value)
end

AbilityDefinitionVampiricattackAIva = class('AbilityDefinitionVampiricattackAIva', AbilityDefinition)
_G.AbilityDefinitionVampiricattackAIva = AbilityDefinitionVampiricattackAIva

function AbilityDefinitionVampiricattackAIva:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIva')
end

function AbilityDefinitionVampiricattackAIva:setLifeStolenPerAttack(level, value)
    checktype(level, 'integer', 'setLifeStolenPerAttack', 1)
    checktype(value, 'float', 'setLifeStolenPerAttack', 2)
    self.def:setLvlDataUnreal('Ivam', level, 1, value)
end

AbilityDefinitionCoupleHippogryph = class('AbilityDefinitionCoupleHippogryph', AbilityDefinition)
_G.AbilityDefinitionCoupleHippogryph = AbilityDefinitionCoupleHippogryph

function AbilityDefinitionCoupleHippogryph:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acoh')
end

function AbilityDefinitionCoupleHippogryph:setResultingUnitType(level, value)
    checktype(level, 'integer', 'setResultingUnitType', 1)
    checktype(value, 'string', 'setResultingUnitType', 2)
    self.def:setLvlDataString('coau', level, 0, value)
end

function AbilityDefinitionCoupleHippogryph:setPartnerUnitType(level, value)
    checktype(level, 'integer', 'setPartnerUnitType', 1)
    checktype(value, 'string', 'setPartnerUnitType', 2)
    self.def:setLvlDataString('coa1', level, 1, value)
end

AbilityDefinitionPaladinResurrection = class('AbilityDefinitionPaladinResurrection', AbilityDefinition)
_G.AbilityDefinitionPaladinResurrection = AbilityDefinitionPaladinResurrection

function AbilityDefinitionPaladinResurrection:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHre')
end

function AbilityDefinitionPaladinResurrection:setRaisedUnitsAreInvulnerable(level, value)
    checktype(level, 'integer', 'setRaisedUnitsAreInvulnerable', 1)
    checktype(value, 'boolean', 'setRaisedUnitsAreInvulnerable', 2)
    self.def:setLvlDataBoolean('Hre2', level, 2, value)
end

function AbilityDefinitionPaladinResurrection:setNumberofCorpsesRaised(level, value)
    checktype(level, 'integer', 'setNumberofCorpsesRaised', 1)
    checktype(value, 'integer', 'setNumberofCorpsesRaised', 2)
    self.def:setLvlDataInt('Hre1', level, 1, value)
end

AbilityDefinitionCryptLordCarrionScarabs = class('AbilityDefinitionCryptLordCarrionScarabs', AbilityDefinition)
_G.AbilityDefinitionCryptLordCarrionScarabs = AbilityDefinitionCryptLordCarrionScarabs

function AbilityDefinitionCryptLordCarrionScarabs:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUcb')
end

function AbilityDefinitionCryptLordCarrionScarabs:setUnitsSummonedTypeOne(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeOne', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeOne', 2)
    self.def:setLvlDataInt('Rai1', level, 1, value)
end

function AbilityDefinitionCryptLordCarrionScarabs:setUnitsSummonedTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeTwo', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeTwo', 2)
    self.def:setLvlDataInt('Rai2', level, 2, value)
end

function AbilityDefinitionCryptLordCarrionScarabs:setKillOnCasterDeath(level, value)
    checktype(level, 'integer', 'setKillOnCasterDeath', 1)
    checktype(value, 'boolean', 'setKillOnCasterDeath', 2)
    self.def:setLvlDataBoolean('Ucb6', level, 6, value)
end

function AbilityDefinitionCryptLordCarrionScarabs:setMaxUnitsSummoned(level, value)
    checktype(level, 'integer', 'setMaxUnitsSummoned', 1)
    checktype(value, 'integer', 'setMaxUnitsSummoned', 2)
    self.def:setLvlDataInt('Ucb5', level, 5, value)
end

function AbilityDefinitionCryptLordCarrionScarabs:setUnitTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitTypeTwo', 1)
    checktype(value, 'string', 'setUnitTypeTwo', 2)
    self.def:setLvlDataString('Rai4', level, 4, value)
end

function AbilityDefinitionCryptLordCarrionScarabs:setUnitTypeOne(level, value)
    checktype(level, 'integer', 'setUnitTypeOne', 1)
    checktype(value, 'string', 'setUnitTypeOne', 2)
    self.def:setLvlDataString('Rai3', level, 3, value)
end

AbilityDefinitionBerserkerUpgrade = class('AbilityDefinitionBerserkerUpgrade', AbilityDefinition)
_G.AbilityDefinitionBerserkerUpgrade = AbilityDefinitionBerserkerUpgrade

function AbilityDefinitionBerserkerUpgrade:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sbsk')
end

function AbilityDefinitionBerserkerUpgrade:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionRuneofGreaterResurrection = class('AbilityDefinitionRuneofGreaterResurrection', AbilityDefinition)
_G.AbilityDefinitionRuneofGreaterResurrection = AbilityDefinitionRuneofGreaterResurrection

function AbilityDefinitionRuneofGreaterResurrection:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'APrr')
end

function AbilityDefinitionRuneofGreaterResurrection:setRaisedUnitsAreInvulnerable(level, value)
    checktype(level, 'integer', 'setRaisedUnitsAreInvulnerable', 1)
    checktype(value, 'boolean', 'setRaisedUnitsAreInvulnerable', 2)
    self.def:setLvlDataBoolean('Hre2', level, 2, value)
end

AbilityDefinitionManaFlare = class('AbilityDefinitionManaFlare', AbilityDefinition)
_G.AbilityDefinitionManaFlare = AbilityDefinitionManaFlare

function AbilityDefinitionManaFlare:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amfl')
end

function AbilityDefinitionManaFlare:setHeroMaximumDamage(level, value)
    checktype(level, 'integer', 'setHeroMaximumDamage', 1)
    checktype(value, 'float', 'setHeroMaximumDamage', 2)
    self.def:setLvlDataUnreal('mfl4', level, 4, value)
end

function AbilityDefinitionManaFlare:setHeroDamagePerManaPoint(level, value)
    checktype(level, 'integer', 'setHeroDamagePerManaPoint', 1)
    checktype(value, 'float', 'setHeroDamagePerManaPoint', 2)
    self.def:setLvlDataUnreal('mfl2', level, 2, value)
end

function AbilityDefinitionManaFlare:setCasterOnlySplash(level, value)
    checktype(level, 'integer', 'setCasterOnlySplash', 1)
    checktype(value, 'boolean', 'setCasterOnlySplash', 2)
    self.def:setLvlDataBoolean('mfl6', level, 6, value)
end

function AbilityDefinitionManaFlare:setDamageCooldown(level, value)
    checktype(level, 'integer', 'setDamageCooldown', 1)
    checktype(value, 'float', 'setDamageCooldown', 2)
    self.def:setLvlDataUnreal('mfl5', level, 5, value)
end

function AbilityDefinitionManaFlare:setUnitDamagePerManaPoint(level, value)
    checktype(level, 'integer', 'setUnitDamagePerManaPoint', 1)
    checktype(value, 'float', 'setUnitDamagePerManaPoint', 2)
    self.def:setLvlDataUnreal('mfl1', level, 1, value)
end

function AbilityDefinitionManaFlare:setUnitMaximumDamage(level, value)
    checktype(level, 'integer', 'setUnitMaximumDamage', 1)
    checktype(value, 'float', 'setUnitMaximumDamage', 2)
    self.def:setLvlDataUnreal('mfl3', level, 3, value)
end

AbilityDefinitionTaurenChieftainReincarnation = class('AbilityDefinitionTaurenChieftainReincarnation', AbilityDefinition)
_G.AbilityDefinitionTaurenChieftainReincarnation = AbilityDefinitionTaurenChieftainReincarnation

function AbilityDefinitionTaurenChieftainReincarnation:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOre')
end

function AbilityDefinitionTaurenChieftainReincarnation:setReincarnationDelay(level, value)
    checktype(level, 'integer', 'setReincarnationDelay', 1)
    checktype(value, 'float', 'setReincarnationDelay', 2)
    self.def:setLvlDataUnreal('Ore1', level, 1, value)
end

AbilityDefinitionCoupleArcher = class('AbilityDefinitionCoupleArcher', AbilityDefinition)
_G.AbilityDefinitionCoupleArcher = AbilityDefinitionCoupleArcher

function AbilityDefinitionCoupleArcher:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acoa')
end

function AbilityDefinitionCoupleArcher:setResultingUnitType(level, value)
    checktype(level, 'integer', 'setResultingUnitType', 1)
    checktype(value, 'string', 'setResultingUnitType', 2)
    self.def:setLvlDataString('coau', level, 0, value)
end

function AbilityDefinitionCoupleArcher:setPartnerUnitType(level, value)
    checktype(level, 'integer', 'setPartnerUnitType', 1)
    checktype(value, 'string', 'setPartnerUnitType', 2)
    self.def:setLvlDataString('coa1', level, 1, value)
end

AbilityDefinitionBallsofFire = class('AbilityDefinitionBallsofFire', AbilityDefinition)
_G.AbilityDefinitionBallsofFire = AbilityDefinitionBallsofFire

function AbilityDefinitionBallsofFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abof')
end

function AbilityDefinitionBallsofFire:setBuildingReduction(level, value)
    checktype(level, 'integer', 'setBuildingReduction', 1)
    checktype(value, 'float', 'setBuildingReduction', 2)
    self.def:setLvlDataUnreal('Hfs5', level, 5, value)
end

function AbilityDefinitionBallsofFire:setMaximumDamage(level, value)
    checktype(level, 'integer', 'setMaximumDamage', 1)
    checktype(value, 'float', 'setMaximumDamage', 2)
    self.def:setLvlDataUnreal('Hfs6', level, 6, value)
end

function AbilityDefinitionBallsofFire:setHalfDamageDealt(level, value)
    checktype(level, 'integer', 'setHalfDamageDealt', 1)
    checktype(value, 'float', 'setHalfDamageDealt', 2)
    self.def:setLvlDataUnreal('Hfs3', level, 3, value)
end

function AbilityDefinitionBallsofFire:setFullDamageDealt(level, value)
    checktype(level, 'integer', 'setFullDamageDealt', 1)
    checktype(value, 'float', 'setFullDamageDealt', 2)
    self.def:setLvlDataUnreal('Hfs1', level, 1, value)
end

function AbilityDefinitionBallsofFire:setHalfDamageInterval(level, value)
    checktype(level, 'integer', 'setHalfDamageInterval', 1)
    checktype(value, 'float', 'setHalfDamageInterval', 2)
    self.def:setLvlDataUnreal('Hfs4', level, 4, value)
end

function AbilityDefinitionBallsofFire:setFullDamageInterval(level, value)
    checktype(level, 'integer', 'setFullDamageInterval', 1)
    checktype(value, 'float', 'setFullDamageInterval', 2)
    self.def:setLvlDataUnreal('Hfs2', level, 2, value)
end

AbilityDefinitionPurge = class('AbilityDefinitionPurge', AbilityDefinition)
_G.AbilityDefinitionPurge = AbilityDefinitionPurge

function AbilityDefinitionPurge:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aprg')
end

function AbilityDefinitionPurge:setHeroPauseDuration(level, value)
    checktype(level, 'integer', 'setHeroPauseDuration', 1)
    checktype(value, 'float', 'setHeroPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg5', level, 5, value)
end

function AbilityDefinitionPurge:setUnitPauseDuration(level, value)
    checktype(level, 'integer', 'setUnitPauseDuration', 1)
    checktype(value, 'float', 'setUnitPauseDuration', 2)
    self.def:setLvlDataUnreal('Prg4', level, 4, value)
end

function AbilityDefinitionPurge:setMovementUpdateFrequency(level, value)
    checktype(level, 'integer', 'setMovementUpdateFrequency', 1)
    checktype(value, 'integer', 'setMovementUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg1', level, 1, value)
end

function AbilityDefinitionPurge:setAttackUpdateFrequency(level, value)
    checktype(level, 'integer', 'setAttackUpdateFrequency', 1)
    checktype(value, 'integer', 'setAttackUpdateFrequency', 2)
    self.def:setLvlDataInt('Prg2', level, 2, value)
end

function AbilityDefinitionPurge:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Prg6', level, 6, value)
end

function AbilityDefinitionPurge:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Prg3', level, 3, value)
end

AbilityDefinitionSlow = class('AbilityDefinitionSlow', AbilityDefinition)
_G.AbilityDefinitionSlow = AbilityDefinitionSlow

function AbilityDefinitionSlow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aslo')
end

function AbilityDefinitionSlow:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo1', level, 1, value)
end

function AbilityDefinitionSlow:setAlwaysAutocast(level, value)
    checktype(level, 'integer', 'setAlwaysAutocast', 1)
    checktype(value, 'boolean', 'setAlwaysAutocast', 2)
    self.def:setLvlDataBoolean('Slo3', level, 3, value)
end

function AbilityDefinitionSlow:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo2', level, 2, value)
end

AbilityDefinitionRuneofLesserResurrection = class('AbilityDefinitionRuneofLesserResurrection', AbilityDefinition)
_G.AbilityDefinitionRuneofLesserResurrection = AbilityDefinitionRuneofLesserResurrection

function AbilityDefinitionRuneofLesserResurrection:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'APrl')
end

function AbilityDefinitionRuneofLesserResurrection:setRaisedUnitsAreInvulnerable(level, value)
    checktype(level, 'integer', 'setRaisedUnitsAreInvulnerable', 1)
    checktype(value, 'boolean', 'setRaisedUnitsAreInvulnerable', 2)
    self.def:setLvlDataBoolean('Hre2', level, 2, value)
end

AbilityDefinitionItemTownPortal = class('AbilityDefinitionItemTownPortal', AbilityDefinition)
_G.AbilityDefinitionItemTownPortal = AbilityDefinitionItemTownPortal

function AbilityDefinitionItemTownPortal:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItp')
end

function AbilityDefinitionItemTownPortal:setMaximumNumberofUnits(level, value)
    checktype(level, 'integer', 'setMaximumNumberofUnits', 1)
    checktype(value, 'integer', 'setMaximumNumberofUnits', 2)
    self.def:setLvlDataInt('Itpm', level, 1, value)
end

function AbilityDefinitionItemTownPortal:setUseTeleportClustering(level, value)
    checktype(level, 'integer', 'setUseTeleportClustering', 1)
    checktype(value, 'boolean', 'setUseTeleportClustering', 2)
    self.def:setLvlDataBoolean('Itp2', level, 2, value)
end

AbilityDefinitionTinkererRoboGoblinLevel1 = class('AbilityDefinitionTinkererRoboGoblinLevel1', AbilityDefinition)
_G.AbilityDefinitionTinkererRoboGoblinLevel1 = AbilityDefinitionTinkererRoboGoblinLevel1

function AbilityDefinitionTinkererRoboGoblinLevel1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANg1')
end

function AbilityDefinitionTinkererRoboGoblinLevel1:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Nrg5', level, 5, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel1:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel1:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel1:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel1:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel1:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Nrg6', level, 6, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel1:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionMilitia = class('AbilityDefinitionMilitia', AbilityDefinition)
_G.AbilityDefinitionMilitia = AbilityDefinitionMilitia

function AbilityDefinitionMilitia:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amil')
end

function AbilityDefinitionMilitia:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Mil2', level, 2, value)
end

function AbilityDefinitionMilitia:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Mil1', level, 1, value)
end

AbilityDefinitionVengeance = class('AbilityDefinitionVengeance', AbilityDefinition)
_G.AbilityDefinitionVengeance = AbilityDefinitionVengeance

function AbilityDefinitionVengeance:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Avng')
end

function AbilityDefinitionVengeance:setUnitsSummonedTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeTwo', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeTwo', 2)
    self.def:setLvlDataInt('Rai2', level, 2, value)
end

function AbilityDefinitionVengeance:setKillOnCasterDeath(level, value)
    checktype(level, 'integer', 'setKillOnCasterDeath', 1)
    checktype(value, 'boolean', 'setKillOnCasterDeath', 2)
    self.def:setLvlDataBoolean('Ucb6', level, 6, value)
end

function AbilityDefinitionVengeance:setMaxUnitsSummoned(level, value)
    checktype(level, 'integer', 'setMaxUnitsSummoned', 1)
    checktype(value, 'integer', 'setMaxUnitsSummoned', 2)
    self.def:setLvlDataInt('Ucb5', level, 5, value)
end

function AbilityDefinitionVengeance:setUnitTypeOne(level, value)
    checktype(level, 'integer', 'setUnitTypeOne', 1)
    checktype(value, 'string', 'setUnitTypeOne', 2)
    self.def:setLvlDataString('Rai3', level, 3, value)
end

function AbilityDefinitionVengeance:setUnitsSummonedTypeOne(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeOne', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeOne', 2)
    self.def:setLvlDataInt('Rai1', level, 1, value)
end

function AbilityDefinitionVengeance:setUnitTypeForLimitCheck(level, value)
    checktype(level, 'integer', 'setUnitTypeForLimitCheck', 1)
    checktype(value, 'string', 'setUnitTypeForLimitCheck', 2)
    self.def:setLvlDataString('Raiu', level, 0, value)
end

function AbilityDefinitionVengeance:setUnitTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitTypeTwo', 1)
    checktype(value, 'string', 'setUnitTypeTwo', 2)
    self.def:setLvlDataString('Rai4', level, 4, value)
end

AbilityDefinitionIntelligenceModPlus2 = class('AbilityDefinitionIntelligenceModPlus2', AbilityDefinition)
_G.AbilityDefinitionIntelligenceModPlus2 = AbilityDefinitionIntelligenceModPlus2

function AbilityDefinitionIntelligenceModPlus2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItm')
end

function AbilityDefinitionIntelligenceModPlus2:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionIntelligenceModPlus2:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionIntelligenceModPlus2:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionIntelligenceModPlus2:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionAttackBonusPlus8 = class('AbilityDefinitionAttackBonusPlus8', AbilityDefinition)
_G.AbilityDefinitionAttackBonusPlus8 = AbilityDefinitionAttackBonusPlus8

function AbilityDefinitionAttackBonusPlus8:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItl')
end

function AbilityDefinitionAttackBonusPlus8:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionAttackBonusPlus10 = class('AbilityDefinitionAttackBonusPlus10', AbilityDefinition)
_G.AbilityDefinitionAttackBonusPlus10 = AbilityDefinitionAttackBonusPlus10

function AbilityDefinitionAttackBonusPlus10:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItn')
end

function AbilityDefinitionAttackBonusPlus10:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionTinkererRoboGoblinLevel3 = class('AbilityDefinitionTinkererRoboGoblinLevel3', AbilityDefinition)
_G.AbilityDefinitionTinkererRoboGoblinLevel3 = AbilityDefinitionTinkererRoboGoblinLevel3

function AbilityDefinitionTinkererRoboGoblinLevel3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANg3')
end

function AbilityDefinitionTinkererRoboGoblinLevel3:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Nrg5', level, 5, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel3:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel3:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel3:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel3:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel3:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Nrg6', level, 6, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel3:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionDeathDamageAOEsapper = class('AbilityDefinitionDeathDamageAOEsapper', AbilityDefinition)
_G.AbilityDefinitionDeathDamageAOEsapper = AbilityDefinitionDeathDamageAOEsapper

function AbilityDefinitionDeathDamageAOEsapper:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adda')
end

function AbilityDefinitionDeathDamageAOEsapper:setPartialDamageAmount(level, value)
    checktype(level, 'integer', 'setPartialDamageAmount', 1)
    checktype(value, 'float', 'setPartialDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda4', level, 4, value)
end

function AbilityDefinitionDeathDamageAOEsapper:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda1', level, 1, value)
end

function AbilityDefinitionDeathDamageAOEsapper:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda2', level, 2, value)
end

function AbilityDefinitionDeathDamageAOEsapper:setPartialDamageRadius(level, value)
    checktype(level, 'integer', 'setPartialDamageRadius', 1)
    checktype(value, 'float', 'setPartialDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda3', level, 3, value)
end

AbilityDefinitionAroo = class('AbilityDefinitionAroo', AbilityDefinition)
_G.AbilityDefinitionAroo = AbilityDefinitionAroo

function AbilityDefinitionAroo:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aroo')
end

function AbilityDefinitionAroo:setUprootedDefenseType(level, value)
    checktype(level, 'integer', 'setUprootedDefenseType', 1)
    checktype(value, 'string', 'setUprootedDefenseType', 2)
    self.def:setLvlDataString('Roo4', level, 4, value)
end

function AbilityDefinitionAroo:setRootedTurning(level, value)
    checktype(level, 'integer', 'setRootedTurning', 1)
    checktype(value, 'boolean', 'setRootedTurning', 2)
    self.def:setLvlDataBoolean('Roo3', level, 3, value)
end

function AbilityDefinitionAroo:setUprootedWeapons(level, value)
    checktype(level, 'integer', 'setUprootedWeapons', 1)
    checktype(value, 'string', 'setUprootedWeapons', 2)
    self.def:setLvlDataString('Roo2', level, 2, value)
end

function AbilityDefinitionAroo:setRootedWeapons(level, value)
    checktype(level, 'integer', 'setRootedWeapons', 1)
    checktype(value, 'string', 'setRootedWeapons', 2)
    self.def:setLvlDataString('Roo1', level, 1, value)
end

AbilityDefinitionTinkererRoboGoblinLevel2 = class('AbilityDefinitionTinkererRoboGoblinLevel2', AbilityDefinition)
_G.AbilityDefinitionTinkererRoboGoblinLevel2 = AbilityDefinitionTinkererRoboGoblinLevel2

function AbilityDefinitionTinkererRoboGoblinLevel2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANg2')
end

function AbilityDefinitionTinkererRoboGoblinLevel2:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Nrg5', level, 5, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel2:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel2:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel2:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel2:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel2:setDefenseBonus(level, value)
    checktype(level, 'integer', 'setDefenseBonus', 1)
    checktype(value, 'integer', 'setDefenseBonus', 2)
    self.def:setLvlDataInt('Nrg6', level, 6, value)
end

function AbilityDefinitionTinkererRoboGoblinLevel2:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionLichFrostArmor = class('AbilityDefinitionLichFrostArmor', AbilityDefinition)
_G.AbilityDefinitionLichFrostArmor = AbilityDefinitionLichFrostArmor

function AbilityDefinitionLichFrostArmor:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUfa')
end

function AbilityDefinitionLichFrostArmor:setArmorDuration(level, value)
    checktype(level, 'integer', 'setArmorDuration', 1)
    checktype(value, 'float', 'setArmorDuration', 2)
    self.def:setLvlDataUnreal('Ufa1', level, 1, value)
end

function AbilityDefinitionLichFrostArmor:setArmorBonus(level, value)
    checktype(level, 'integer', 'setArmorBonus', 1)
    checktype(value, 'float', 'setArmorBonus', 2)
    self.def:setLvlDataUnreal('Ufa2', level, 2, value)
end

AbilityDefinitionTankUpgrade = class('AbilityDefinitionTankUpgrade', AbilityDefinition)
_G.AbilityDefinitionTankUpgrade = AbilityDefinitionTankUpgrade

function AbilityDefinitionTankUpgrade:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Srtt')
end

function AbilityDefinitionTankUpgrade:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionCripple = class('AbilityDefinitionCripple', AbilityDefinition)
_G.AbilityDefinitionCripple = AbilityDefinitionCripple

function AbilityDefinitionCripple:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acri')
end

function AbilityDefinitionCripple:setDamageReduction(level, value)
    checktype(level, 'integer', 'setDamageReduction', 1)
    checktype(value, 'float', 'setDamageReduction', 2)
    self.def:setLvlDataUnreal('Cri3', level, 3, value)
end

function AbilityDefinitionCripple:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Cri2', level, 2, value)
end

function AbilityDefinitionCripple:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Cri1', level, 1, value)
end

AbilityDefinitionFlakCannon = class('AbilityDefinitionFlakCannon', AbilityDefinition)
_G.AbilityDefinitionFlakCannon = AbilityDefinitionFlakCannon

function AbilityDefinitionFlakCannon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aflk')
end

function AbilityDefinitionFlakCannon:setSmallDamageRadius(level, value)
    checktype(level, 'integer', 'setSmallDamageRadius', 1)
    checktype(value, 'float', 'setSmallDamageRadius', 2)
    self.def:setLvlDataUnreal('flk2', level, 2, value)
end

function AbilityDefinitionFlakCannon:setSmallDamageAmount(level, value)
    checktype(level, 'integer', 'setSmallDamageAmount', 1)
    checktype(value, 'float', 'setSmallDamageAmount', 2)
    self.def:setLvlDataUnreal('flk5', level, 5, value)
end

function AbilityDefinitionFlakCannon:setMediumDamageAmount(level, value)
    checktype(level, 'integer', 'setMediumDamageAmount', 1)
    checktype(value, 'float', 'setMediumDamageAmount', 2)
    self.def:setLvlDataUnreal('flk4', level, 4, value)
end

function AbilityDefinitionFlakCannon:setMediumDamageRadius(level, value)
    checktype(level, 'integer', 'setMediumDamageRadius', 1)
    checktype(value, 'float', 'setMediumDamageRadius', 2)
    self.def:setLvlDataUnreal('flk1', level, 1, value)
end

function AbilityDefinitionFlakCannon:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('flk3', level, 3, value)
end

AbilityDefinitionPossessionChanneling = class('AbilityDefinitionPossessionChanneling', AbilityDefinition)
_G.AbilityDefinitionPossessionChanneling = AbilityDefinitionPossessionChanneling

function AbilityDefinitionPossessionChanneling:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aps2')
end

function AbilityDefinitionPossessionChanneling:setTargetIsMagicImmune(level, value)
    checktype(level, 'integer', 'setTargetIsMagicImmune', 1)
    checktype(value, 'boolean', 'setTargetIsMagicImmune', 2)
    self.def:setLvlDataBoolean('Pos4', level, 4, value)
end

function AbilityDefinitionPossessionChanneling:setMaximumCreepLevel(level, value)
    checktype(level, 'integer', 'setMaximumCreepLevel', 1)
    checktype(value, 'integer', 'setMaximumCreepLevel', 2)
    self.def:setLvlDataInt('Pos1', level, 1, value)
end

function AbilityDefinitionPossessionChanneling:setDamageAmplification(level, value)
    checktype(level, 'integer', 'setDamageAmplification', 1)
    checktype(value, 'float', 'setDamageAmplification', 2)
    self.def:setLvlDataUnreal('Pos2', level, 2, value)
end

function AbilityDefinitionPossessionChanneling:setTargetIsInvulnerable(level, value)
    checktype(level, 'integer', 'setTargetIsInvulnerable', 1)
    checktype(value, 'boolean', 'setTargetIsInvulnerable', 2)
    self.def:setLvlDataBoolean('Pos3', level, 3, value)
end

AbilityDefinitionRocketAttack = class('AbilityDefinitionRocketAttack', AbilityDefinition)
_G.AbilityDefinitionRocketAttack = AbilityDefinitionRocketAttack

function AbilityDefinitionRocketAttack:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aroc')
end

function AbilityDefinitionRocketAttack:setMaximumNumberofTargets(level, value)
    checktype(level, 'integer', 'setMaximumNumberofTargets', 1)
    checktype(value, 'integer', 'setMaximumNumberofTargets', 2)
    self.def:setLvlDataInt('Efk3', level, 3, value)
end

function AbilityDefinitionRocketAttack:setDamagePerTarget(level, value)
    checktype(level, 'integer', 'setDamagePerTarget', 1)
    checktype(value, 'float', 'setDamagePerTarget', 2)
    self.def:setLvlDataUnreal('Efk1', level, 1, value)
end

function AbilityDefinitionRocketAttack:setMaximumTotalDamage(level, value)
    checktype(level, 'integer', 'setMaximumTotalDamage', 1)
    checktype(value, 'float', 'setMaximumTotalDamage', 2)
    self.def:setLvlDataUnreal('Efk2', level, 2, value)
end

AbilityDefinitionBrewmasterStormEarthandFire = class('AbilityDefinitionBrewmasterStormEarthandFire', AbilityDefinition)
_G.AbilityDefinitionBrewmasterStormEarthandFire = AbilityDefinitionBrewmasterStormEarthandFire

function AbilityDefinitionBrewmasterStormEarthandFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANef')
end

function AbilityDefinitionBrewmasterStormEarthandFire:setSummonedUnitTypes(level, value)
    checktype(level, 'integer', 'setSummonedUnitTypes', 1)
    checktype(value, 'string', 'setSummonedUnitTypes', 2)
    self.def:setLvlDataString('Nef1', level, 1, value)
end

AbilityDefinitionTinkererEngineeringUpgrade = class('AbilityDefinitionTinkererEngineeringUpgrade', AbilityDefinition)
_G.AbilityDefinitionTinkererEngineeringUpgrade = AbilityDefinitionTinkererEngineeringUpgrade

function AbilityDefinitionTinkererEngineeringUpgrade:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANeg')
end

function AbilityDefinitionTinkererEngineeringUpgrade:setAbilityUpgrade(level, value)
    checktype(level, 'integer', 'setAbilityUpgrade', 1)
    checktype(value, 'string', 'setAbilityUpgrade', 2)
    self.def:setLvlDataString('Neg5', level, 5, value)
end

function AbilityDefinitionTinkererEngineeringUpgrade:setAbilityUpgrade1(level, value)
    checktype(level, 'integer', 'setAbilityUpgrade1', 1)
    checktype(value, 'string', 'setAbilityUpgrade1', 2)
    self.def:setLvlDataString('Neg4', level, 4, value)
end

function AbilityDefinitionTinkererEngineeringUpgrade:setAbilityUpgrade2(level, value)
    checktype(level, 'integer', 'setAbilityUpgrade2', 1)
    checktype(value, 'string', 'setAbilityUpgrade2', 2)
    self.def:setLvlDataString('Neg6', level, 6, value)
end

function AbilityDefinitionTinkererEngineeringUpgrade:setMoveSpeedBonus(level, value)
    checktype(level, 'integer', 'setMoveSpeedBonus', 1)
    checktype(value, 'float', 'setMoveSpeedBonus', 2)
    self.def:setLvlDataUnreal('Neg1', level, 1, value)
end

function AbilityDefinitionTinkererEngineeringUpgrade:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Neg2', level, 2, value)
end

function AbilityDefinitionTinkererEngineeringUpgrade:setAbilityUpgrade3(level, value)
    checktype(level, 'integer', 'setAbilityUpgrade3', 1)
    checktype(value, 'string', 'setAbilityUpgrade3', 2)
    self.def:setLvlDataString('Neg3', level, 3, value)
end

AbilityDefinitionMine = class('AbilityDefinitionMine', AbilityDefinition)
_G.AbilityDefinitionMine = AbilityDefinitionMine

function AbilityDefinitionMine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amin')
end

function AbilityDefinitionMine:setActivationDelay(level, value)
    checktype(level, 'integer', 'setActivationDelay', 1)
    checktype(value, 'float', 'setActivationDelay', 2)
    self.def:setLvlDataUnreal('Min1', level, 1, value)
end

function AbilityDefinitionMine:setInvisibilityTransitionTime(level, value)
    checktype(level, 'integer', 'setInvisibilityTransitionTime', 1)
    checktype(value, 'float', 'setInvisibilityTransitionTime', 2)
    self.def:setLvlDataUnreal('Min2', level, 2, value)
end

AbilityDefinitionMagicImmunity = class('AbilityDefinitionMagicImmunity', AbilityDefinition)
_G.AbilityDefinitionMagicImmunity = AbilityDefinitionMagicImmunity

function AbilityDefinitionMagicImmunity:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amim')
end

function AbilityDefinitionMagicImmunity:setMagicDamageFactor(level, value)
    checktype(level, 'integer', 'setMagicDamageFactor', 1)
    checktype(value, 'float', 'setMagicDamageFactor', 2)
    self.def:setLvlDataUnreal('mim1', level, 1, value)
end

AbilityDefinitionLichFrostNova = class('AbilityDefinitionLichFrostNova', AbilityDefinition)
_G.AbilityDefinitionLichFrostNova = AbilityDefinitionLichFrostNova

function AbilityDefinitionLichFrostNova:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUfn')
end

function AbilityDefinitionLichFrostNova:setAreaofEffectDamage(level, value)
    checktype(level, 'integer', 'setAreaofEffectDamage', 1)
    checktype(value, 'float', 'setAreaofEffectDamage', 2)
    self.def:setLvlDataUnreal('Ufn1', level, 1, value)
end

function AbilityDefinitionLichFrostNova:setSpecificTargetDamage(level, value)
    checktype(level, 'integer', 'setSpecificTargetDamage', 1)
    checktype(value, 'float', 'setSpecificTargetDamage', 2)
    self.def:setLvlDataUnreal('Ufn2', level, 2, value)
end

AbilityDefinitionRoar = class('AbilityDefinitionRoar', AbilityDefinition)
_G.AbilityDefinitionRoar = AbilityDefinitionRoar

function AbilityDefinitionRoar:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aroa')
end

function AbilityDefinitionRoar:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Roa1', level, 1, value)
end

function AbilityDefinitionRoar:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Roa2', level, 2, value)
end

function AbilityDefinitionRoar:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionRoar:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

function AbilityDefinitionRoar:setLifeRegenerationRate(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRate', 1)
    checktype(value, 'float', 'setLifeRegenerationRate', 2)
    self.def:setLvlDataUnreal('Roa3', level, 3, value)
end

function AbilityDefinitionRoar:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionRoar:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

AbilityDefinitionRunedBracers = class('AbilityDefinitionRunedBracers', AbilityDefinition)
_G.AbilityDefinitionRunedBracers = AbilityDefinitionRunedBracers

function AbilityDefinitionRunedBracers:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsr')
end

function AbilityDefinitionRunedBracers:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('isr1', level, 1, value)
end

function AbilityDefinitionRunedBracers:setDamageReduction(level, value)
    checktype(level, 'integer', 'setDamageReduction', 1)
    checktype(value, 'float', 'setDamageReduction', 2)
    self.def:setLvlDataUnreal('isr2', level, 2, value)
end

AbilityDefinitionLichDarkRitual = class('AbilityDefinitionLichDarkRitual', AbilityDefinition)
_G.AbilityDefinitionLichDarkRitual = AbilityDefinitionLichDarkRitual

function AbilityDefinitionLichDarkRitual:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUdr')
end

function AbilityDefinitionLichDarkRitual:setLeaveTargetAlive(level, value)
    checktype(level, 'integer', 'setLeaveTargetAlive', 1)
    checktype(value, 'boolean', 'setLeaveTargetAlive', 2)
    self.def:setLvlDataBoolean('Udp5', level, 5, value)
end

function AbilityDefinitionLichDarkRitual:setLifeConvertedtoMana(level, value)
    checktype(level, 'integer', 'setLifeConvertedtoMana', 1)
    checktype(value, 'float', 'setLifeConvertedtoMana', 2)
    self.def:setLvlDataUnreal('Udp1', level, 1, value)
end

function AbilityDefinitionLichDarkRitual:setLifeConvertedtoLife(level, value)
    checktype(level, 'integer', 'setLifeConvertedtoLife', 1)
    checktype(value, 'float', 'setLifeConvertedtoLife', 2)
    self.def:setLvlDataUnreal('Udp2', level, 2, value)
end

function AbilityDefinitionLichDarkRitual:setLifeConversionAsPercent(level, value)
    checktype(level, 'integer', 'setLifeConversionAsPercent', 1)
    checktype(value, 'boolean', 'setLifeConversionAsPercent', 2)
    self.def:setLvlDataBoolean('Udp4', level, 4, value)
end

function AbilityDefinitionLichDarkRitual:setManaConversionAsPercent(level, value)
    checktype(level, 'integer', 'setManaConversionAsPercent', 1)
    checktype(value, 'boolean', 'setManaConversionAsPercent', 2)
    self.def:setLvlDataBoolean('Udp3', level, 3, value)
end

AbilityDefinitionTichondriusDarkSummoning = class('AbilityDefinitionTichondriusDarkSummoning', AbilityDefinition)
_G.AbilityDefinitionTichondriusDarkSummoning = AbilityDefinitionTichondriusDarkSummoning

function AbilityDefinitionTichondriusDarkSummoning:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUds')
end

function AbilityDefinitionTichondriusDarkSummoning:setMaximumUnits(level, value)
    checktype(level, 'integer', 'setMaximumUnits', 1)
    checktype(value, 'integer', 'setMaximumUnits', 2)
    self.def:setLvlDataInt('Uds1', level, 1, value)
end

function AbilityDefinitionTichondriusDarkSummoning:setUseTeleportClustering(level, value)
    checktype(level, 'integer', 'setUseTeleportClustering', 1)
    checktype(value, 'boolean', 'setUseTeleportClustering', 2)
    self.def:setLvlDataBoolean('Hmt3', level, 3, value)
end

function AbilityDefinitionTichondriusDarkSummoning:setCastingDelayseconds(level, value)
    checktype(level, 'integer', 'setCastingDelayseconds', 1)
    checktype(value, 'float', 'setCastingDelayseconds', 2)
    self.def:setLvlDataUnreal('Uds2', level, 2, value)
end

AbilityDefinitionItemSpeed = class('AbilityDefinitionItemSpeed', AbilityDefinition)
_G.AbilityDefinitionItemSpeed = AbilityDefinitionItemSpeed

function AbilityDefinitionItemSpeed:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsp')
end

function AbilityDefinitionItemSpeed:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Ispi', level, 1, value)
end

AbilityDefinitionBloodlust = class('AbilityDefinitionBloodlust', AbilityDefinition)
_G.AbilityDefinitionBloodlust = AbilityDefinitionBloodlust

function AbilityDefinitionBloodlust:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ablo')
end

function AbilityDefinitionBloodlust:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Blo2', level, 2, value)
end

function AbilityDefinitionBloodlust:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Blo1', level, 1, value)
end

function AbilityDefinitionBloodlust:setScalingFactor(level, value)
    checktype(level, 'integer', 'setScalingFactor', 1)
    checktype(value, 'float', 'setScalingFactor', 2)
    self.def:setLvlDataUnreal('Blo3', level, 3, value)
end

AbilityDefinitionDeathKnightDeathPact = class('AbilityDefinitionDeathKnightDeathPact', AbilityDefinition)
_G.AbilityDefinitionDeathKnightDeathPact = AbilityDefinitionDeathKnightDeathPact

function AbilityDefinitionDeathKnightDeathPact:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AUdp')
end

function AbilityDefinitionDeathKnightDeathPact:setLeaveTargetAlive(level, value)
    checktype(level, 'integer', 'setLeaveTargetAlive', 1)
    checktype(value, 'boolean', 'setLeaveTargetAlive', 2)
    self.def:setLvlDataBoolean('Udp5', level, 5, value)
end

function AbilityDefinitionDeathKnightDeathPact:setLifeConvertedtoMana(level, value)
    checktype(level, 'integer', 'setLifeConvertedtoMana', 1)
    checktype(value, 'float', 'setLifeConvertedtoMana', 2)
    self.def:setLvlDataUnreal('Udp1', level, 1, value)
end

function AbilityDefinitionDeathKnightDeathPact:setLifeConvertedtoLife(level, value)
    checktype(level, 'integer', 'setLifeConvertedtoLife', 1)
    checktype(value, 'float', 'setLifeConvertedtoLife', 2)
    self.def:setLvlDataUnreal('Udp2', level, 2, value)
end

function AbilityDefinitionDeathKnightDeathPact:setLifeConversionAsPercent(level, value)
    checktype(level, 'integer', 'setLifeConversionAsPercent', 1)
    checktype(value, 'boolean', 'setLifeConversionAsPercent', 2)
    self.def:setLvlDataBoolean('Udp4', level, 4, value)
end

function AbilityDefinitionDeathKnightDeathPact:setManaConversionAsPercent(level, value)
    checktype(level, 'integer', 'setManaConversionAsPercent', 1)
    checktype(value, 'boolean', 'setManaConversionAsPercent', 2)
    self.def:setLvlDataBoolean('Udp3', level, 3, value)
end

AbilityDefinitionBlightPlacement = class('AbilityDefinitionBlightPlacement', AbilityDefinition)
_G.AbilityDefinitionBlightPlacement = AbilityDefinitionBlightPlacement

function AbilityDefinitionBlightPlacement:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ablp')
end

function AbilityDefinitionBlightPlacement:setCreatesBlight(level, value)
    checktype(level, 'integer', 'setCreatesBlight', 1)
    checktype(value, 'boolean', 'setCreatesBlight', 2)
    self.def:setLvlDataBoolean('Bli2', level, 2, value)
end

function AbilityDefinitionBlightPlacement:setExpansionAmount(level, value)
    checktype(level, 'integer', 'setExpansionAmount', 1)
    checktype(value, 'float', 'setExpansionAmount', 2)
    self.def:setLvlDataUnreal('Bli1', level, 1, value)
end

AbilityDefinitionSeaWitchForkedLightning = class('AbilityDefinitionSeaWitchForkedLightning', AbilityDefinition)
_G.AbilityDefinitionSeaWitchForkedLightning = AbilityDefinitionSeaWitchForkedLightning

function AbilityDefinitionSeaWitchForkedLightning:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANfl')
end

function AbilityDefinitionSeaWitchForkedLightning:setNumberofTargetsHit(level, value)
    checktype(level, 'integer', 'setNumberofTargetsHit', 1)
    checktype(value, 'integer', 'setNumberofTargetsHit', 2)
    self.def:setLvlDataInt('Ocl2', level, 2, value)
end

function AbilityDefinitionSeaWitchForkedLightning:setDamageperTarget(level, value)
    checktype(level, 'integer', 'setDamageperTarget', 1)
    checktype(value, 'float', 'setDamageperTarget', 2)
    self.def:setLvlDataUnreal('Ocl1', level, 1, value)
end

function AbilityDefinitionSeaWitchForkedLightning:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionSeaWitchForkedLightning:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionLightning = class('AbilityDefinitionLightning', AbilityDefinition)
_G.AbilityDefinitionLightning = AbilityDefinitionLightning

function AbilityDefinitionLightning:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACfl')
end

function AbilityDefinitionLightning:setNumberofTargetsHit(level, value)
    checktype(level, 'integer', 'setNumberofTargetsHit', 1)
    checktype(value, 'integer', 'setNumberofTargetsHit', 2)
    self.def:setLvlDataInt('Ocl2', level, 2, value)
end

function AbilityDefinitionLightning:setDamageperTarget(level, value)
    checktype(level, 'integer', 'setDamageperTarget', 1)
    checktype(value, 'float', 'setDamageperTarget', 2)
    self.def:setLvlDataUnreal('Ocl1', level, 1, value)
end

function AbilityDefinitionLightning:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Ucs4', level, 4, value)
end

function AbilityDefinitionLightning:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Ucs3', level, 3, value)
end

AbilityDefinitionStrengthMod = class('AbilityDefinitionStrengthMod', AbilityDefinition)
_G.AbilityDefinitionStrengthMod = AbilityDefinitionStrengthMod

function AbilityDefinitionStrengthMod:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsm')
end

function AbilityDefinitionStrengthMod:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionStrengthMod:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionStrengthMod:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionStrengthMod:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionScrollofLifeRegen = class('AbilityDefinitionScrollofLifeRegen', AbilityDefinition)
_G.AbilityDefinitionScrollofLifeRegen = AbilityDefinitionScrollofLifeRegen

function AbilityDefinitionScrollofLifeRegen:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsl')
end

function AbilityDefinitionScrollofLifeRegen:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('irl4', level, 4, value)
end

function AbilityDefinitionScrollofLifeRegen:setDispelOnAttack(level, value)
    checktype(level, 'integer', 'setDispelOnAttack', 1)
    checktype(value, 'boolean', 'setDispelOnAttack', 2)
    self.def:setLvlDataBoolean('irl5', level, 5, value)
end

function AbilityDefinitionScrollofLifeRegen:setManaRegenerated(level, value)
    checktype(level, 'integer', 'setManaRegenerated', 1)
    checktype(value, 'float', 'setManaRegenerated', 2)
    self.def:setLvlDataUnreal('irl2', level, 2, value)
end

function AbilityDefinitionScrollofLifeRegen:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('irl3', level, 3, value)
end

function AbilityDefinitionScrollofLifeRegen:setLifeRegenerated(level, value)
    checktype(level, 'integer', 'setLifeRegenerated', 1)
    checktype(value, 'float', 'setLifeRegenerated', 2)
    self.def:setLvlDataUnreal('irl1', level, 1, value)
end

AbilityDefinitionHealCreepNormalAnhe = class('AbilityDefinitionHealCreepNormalAnhe', AbilityDefinition)
_G.AbilityDefinitionHealCreepNormalAnhe = AbilityDefinitionHealCreepNormalAnhe

function AbilityDefinitionHealCreepNormalAnhe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Anhe')
end

function AbilityDefinitionHealCreepNormalAnhe:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Hea1', level, 1, value)
end

AbilityDefinitionAttackSpeedIncrease = class('AbilityDefinitionAttackSpeedIncrease', AbilityDefinition)
_G.AbilityDefinitionAttackSpeedIncrease = AbilityDefinitionAttackSpeedIncrease

function AbilityDefinitionAttackSpeedIncrease:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsx')
end

function AbilityDefinitionAttackSpeedIncrease:setAttackSpeedIncrease(level, value)
    checktype(level, 'integer', 'setAttackSpeedIncrease', 1)
    checktype(value, 'float', 'setAttackSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Isx1', level, 1, value)
end

AbilityDefinitionDefend = class('AbilityDefinitionDefend', AbilityDefinition)
_G.AbilityDefinitionDefend = AbilityDefinitionDefend

function AbilityDefinitionDefend:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adef')
end

function AbilityDefinitionDefend:setDamageTaken(level, value)
    checktype(level, 'integer', 'setDamageTaken', 1)
    checktype(value, 'float', 'setDamageTaken', 2)
    self.def:setLvlDataUnreal('Def1', level, 1, value)
end

function AbilityDefinitionDefend:setChancetoDeflect(level, value)
    checktype(level, 'integer', 'setChancetoDeflect', 1)
    checktype(value, 'float', 'setChancetoDeflect', 2)
    self.def:setLvlDataUnreal('Def6', level, 6, value)
end

function AbilityDefinitionDefend:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Def3', level, 3, value)
end

function AbilityDefinitionDefend:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Def4', level, 4, value)
end

function AbilityDefinitionDefend:setDamageDealt(level, value)
    checktype(level, 'integer', 'setDamageDealt', 1)
    checktype(value, 'float', 'setDamageDealt', 2)
    self.def:setLvlDataUnreal('Def2', level, 2, value)
end

function AbilityDefinitionDefend:setDeflectDamageTakenSpells(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenSpells', 1)
    checktype(value, 'float', 'setDeflectDamageTakenSpells', 2)
    self.def:setLvlDataUnreal('Def8', level, 8, value)
end

function AbilityDefinitionDefend:setDeflectDamageTakenPiercing(level, value)
    checktype(level, 'integer', 'setDeflectDamageTakenPiercing', 1)
    checktype(value, 'float', 'setDeflectDamageTakenPiercing', 2)
    self.def:setLvlDataUnreal('Def7', level, 7, value)
end

function AbilityDefinitionDefend:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Def5', level, 5, value)
end

AbilityDefinitionSentryWardAIsw = class('AbilityDefinitionSentryWardAIsw', AbilityDefinition)
_G.AbilityDefinitionSentryWardAIsw = AbilityDefinitionSentryWardAIsw

function AbilityDefinitionSentryWardAIsw:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIsw')
end

function AbilityDefinitionSentryWardAIsw:setWardUnitType(level, value)
    checktype(level, 'integer', 'setWardUnitType', 1)
    checktype(value, 'string', 'setWardUnitType', 2)
    self.def:setLvlDataString('hwdu', level, 0, value)
end

AbilityDefinitionGrabTree = class('AbilityDefinitionGrabTree', AbilityDefinition)
_G.AbilityDefinitionGrabTree = AbilityDefinitionGrabTree

function AbilityDefinitionGrabTree:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Agra')
end

function AbilityDefinitionGrabTree:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('gra4', level, 4, value)
end

function AbilityDefinitionGrabTree:setMaximumAttacks(level, value)
    checktype(level, 'integer', 'setMaximumAttacks', 1)
    checktype(value, 'integer', 'setMaximumAttacks', 2)
    self.def:setLvlDataInt('gra5', level, 5, value)
end

function AbilityDefinitionGrabTree:setAttachDelay(level, value)
    checktype(level, 'integer', 'setAttachDelay', 1)
    checktype(value, 'float', 'setAttachDelay', 2)
    self.def:setLvlDataUnreal('gra1', level, 1, value)
end

function AbilityDefinitionGrabTree:setDisabledAttackIndex(level, value)
    checktype(level, 'integer', 'setDisabledAttackIndex', 1)
    checktype(value, 'integer', 'setDisabledAttackIndex', 2)
    self.def:setLvlDataInt('gra3', level, 3, value)
end

function AbilityDefinitionGrabTree:setRemoveDelay(level, value)
    checktype(level, 'integer', 'setRemoveDelay', 1)
    checktype(value, 'float', 'setRemoveDelay', 2)
    self.def:setLvlDataUnreal('gra2', level, 2, value)
end

AbilityDefinitionDecouple = class('AbilityDefinitionDecouple', AbilityDefinition)
_G.AbilityDefinitionDecouple = AbilityDefinitionDecouple

function AbilityDefinitionDecouple:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adec')
end

function AbilityDefinitionDecouple:setPartnerUnitTypeOne(level, value)
    checktype(level, 'integer', 'setPartnerUnitTypeOne', 1)
    checktype(value, 'string', 'setPartnerUnitTypeOne', 2)
    self.def:setLvlDataString('dcp1', level, 1, value)
end

function AbilityDefinitionDecouple:setPartnerUnitTypeTwo(level, value)
    checktype(level, 'integer', 'setPartnerUnitTypeTwo', 1)
    checktype(value, 'string', 'setPartnerUnitTypeTwo', 2)
    self.def:setLvlDataString('dcp2', level, 2, value)
end

AbilityDefinitionDustofAppearance = class('AbilityDefinitionDustofAppearance', AbilityDefinition)
_G.AbilityDefinitionDustofAppearance = AbilityDefinitionDustofAppearance

function AbilityDefinitionDustofAppearance:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItb')
end

function AbilityDefinitionDustofAppearance:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionAttackBonusAItc = class('AbilityDefinitionAttackBonusAItc', AbilityDefinition)
_G.AbilityDefinitionAttackBonusAItc = AbilityDefinitionAttackBonusAItc

function AbilityDefinitionAttackBonusAItc:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItc')
end

function AbilityDefinitionAttackBonusAItc:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionItemDetectAoe = class('AbilityDefinitionItemDetectAoe', AbilityDefinition)
_G.AbilityDefinitionItemDetectAoe = AbilityDefinitionItemDetectAoe

function AbilityDefinitionItemDetectAoe:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIta')
end

function AbilityDefinitionItemDetectAoe:setDetectionRadius(level, value)
    checktype(level, 'integer', 'setDetectionRadius', 1)
    checktype(value, 'string', 'setDetectionRadius', 2)
    self.def:setLvlDataString('Idet', level, 1, value)
end

AbilityDefinitionAttackBonusPlus5 = class('AbilityDefinitionAttackBonusPlus5', AbilityDefinition)
_G.AbilityDefinitionAttackBonusPlus5 = AbilityDefinitionAttackBonusPlus5

function AbilityDefinitionAttackBonusPlus5:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItj')
end

function AbilityDefinitionAttackBonusPlus5:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionAttackBonusPlus7 = class('AbilityDefinitionAttackBonusPlus7', AbilityDefinition)
_G.AbilityDefinitionAttackBonusPlus7 = AbilityDefinitionAttackBonusPlus7

function AbilityDefinitionAttackBonusPlus7:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItk')
end

function AbilityDefinitionAttackBonusPlus7:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionAttackBonusPlus2 = class('AbilityDefinitionAttackBonusPlus2', AbilityDefinition)
_G.AbilityDefinitionAttackBonusPlus2 = AbilityDefinitionAttackBonusPlus2

function AbilityDefinitionAttackBonusPlus2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIth')
end

function AbilityDefinitionAttackBonusPlus2:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionDevour = class('AbilityDefinitionDevour', AbilityDefinition)
_G.AbilityDefinitionDevour = AbilityDefinitionDevour

function AbilityDefinitionDevour:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adev')
end

function AbilityDefinitionDevour:setMaxCreepLevel(level, value)
    checktype(level, 'integer', 'setMaxCreepLevel', 1)
    checktype(value, 'integer', 'setMaxCreepLevel', 2)
    self.def:setLvlDataInt('Dev1', level, 1, value)
end

AbilityDefinitionAttackBonusPlus4 = class('AbilityDefinitionAttackBonusPlus4', AbilityDefinition)
_G.AbilityDefinitionAttackBonusPlus4 = AbilityDefinitionAttackBonusPlus4

function AbilityDefinitionAttackBonusPlus4:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIti')
end

function AbilityDefinitionAttackBonusPlus4:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionMountainKingThunderClap = class('AbilityDefinitionMountainKingThunderClap', AbilityDefinition)
_G.AbilityDefinitionMountainKingThunderClap = AbilityDefinitionMountainKingThunderClap

function AbilityDefinitionMountainKingThunderClap:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHtc')
end

function AbilityDefinitionMountainKingThunderClap:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Htc4', level, 4, value)
end

function AbilityDefinitionMountainKingThunderClap:setSpecificTargetDamage(level, value)
    checktype(level, 'integer', 'setSpecificTargetDamage', 1)
    checktype(value, 'float', 'setSpecificTargetDamage', 2)
    self.def:setLvlDataUnreal('Htc2', level, 2, value)
end

function AbilityDefinitionMountainKingThunderClap:setAOEDamage(level, value)
    checktype(level, 'integer', 'setAOEDamage', 1)
    checktype(value, 'float', 'setAOEDamage', 2)
    self.def:setLvlDataUnreal('Htc1', level, 1, value)
end

function AbilityDefinitionMountainKingThunderClap:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Htc3', level, 3, value)
end

AbilityDefinitionAttackBonusAItf = class('AbilityDefinitionAttackBonusAItf', AbilityDefinition)
_G.AbilityDefinitionAttackBonusAItf = AbilityDefinitionAttackBonusAItf

function AbilityDefinitionAttackBonusAItf:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItf')
end

function AbilityDefinitionAttackBonusAItf:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionAdet = class('AbilityDefinitionAdet', AbilityDefinition)
_G.AbilityDefinitionAdet = AbilityDefinitionAdet

function AbilityDefinitionAdet:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adet')
end

function AbilityDefinitionAdet:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionFingerofDeath = class('AbilityDefinitionFingerofDeath', AbilityDefinition)
_G.AbilityDefinitionFingerofDeath = AbilityDefinitionFingerofDeath

function AbilityDefinitionFingerofDeath:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANfd')
end

function AbilityDefinitionFingerofDeath:setGraphicDelay(level, value)
    checktype(level, 'integer', 'setGraphicDelay', 1)
    checktype(value, 'float', 'setGraphicDelay', 2)
    self.def:setLvlDataUnreal('Nfd1', level, 1, value)
end

function AbilityDefinitionFingerofDeath:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Nfd3', level, 3, value)
end

function AbilityDefinitionFingerofDeath:setGraphicDuration(level, value)
    checktype(level, 'integer', 'setGraphicDuration', 1)
    checktype(value, 'float', 'setGraphicDuration', 2)
    self.def:setLvlDataUnreal('Nfd2', level, 2, value)
end

AbilityDefinitionAttackBonusPlus1 = class('AbilityDefinitionAttackBonusPlus1', AbilityDefinition)
_G.AbilityDefinitionAttackBonusPlus1 = AbilityDefinitionAttackBonusPlus1

function AbilityDefinitionAttackBonusPlus1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AItg')
end

function AbilityDefinitionAttackBonusPlus1:setAttackBonus(level, value)
    checktype(level, 'integer', 'setAttackBonus', 1)
    checktype(value, 'integer', 'setAttackBonus', 2)
    self.def:setLvlDataInt('Iatt', level, 1, value)
end

AbilityDefinitionSeaWitchFrostArrows = class('AbilityDefinitionSeaWitchFrostArrows', AbilityDefinition)
_G.AbilityDefinitionSeaWitchFrostArrows = AbilityDefinitionSeaWitchFrostArrows

function AbilityDefinitionSeaWitchFrostArrows:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANfa')
end

function AbilityDefinitionSeaWitchFrostArrows:setStackFlags(level, value)
    checktype(level, 'integer', 'setStackFlags', 1)
    checktype(value, 'integer', 'setStackFlags', 2)
    self.def:setLvlDataInt('Hca4', level, 4, value)
end

function AbilityDefinitionSeaWitchFrostArrows:setExtraDamage(level, value)
    checktype(level, 'integer', 'setExtraDamage', 1)
    checktype(value, 'float', 'setExtraDamage', 2)
    self.def:setLvlDataUnreal('Hca1', level, 1, value)
end

function AbilityDefinitionSeaWitchFrostArrows:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Hca3', level, 3, value)
end

function AbilityDefinitionSeaWitchFrostArrows:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Hca2', level, 2, value)
end

AbilityDefinitionFireBolt = class('AbilityDefinitionFireBolt', AbilityDefinition)
_G.AbilityDefinitionFireBolt = AbilityDefinitionFireBolt

function AbilityDefinitionFireBolt:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANfb')
end

function AbilityDefinitionFireBolt:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Htb1', level, 1, value)
end

AbilityDefinitionMountainKingThunderBolt = class('AbilityDefinitionMountainKingThunderBolt', AbilityDefinition)
_G.AbilityDefinitionMountainKingThunderBolt = AbilityDefinitionMountainKingThunderBolt

function AbilityDefinitionMountainKingThunderBolt:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHtb')
end

function AbilityDefinitionMountainKingThunderBolt:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Htb1', level, 1, value)
end

AbilityDefinitionSentinel = class('AbilityDefinitionSentinel', AbilityDefinition)
_G.AbilityDefinitionSentinel = AbilityDefinitionSentinel

function AbilityDefinitionSentinel:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aesn')
end

function AbilityDefinitionSentinel:setHoveringSightRadius(level, value)
    checktype(level, 'integer', 'setHoveringSightRadius', 1)
    checktype(value, 'float', 'setHoveringSightRadius', 2)
    self.def:setLvlDataUnreal('Esn2', level, 2, value)
end

function AbilityDefinitionSentinel:setInFlightSightRadius(level, value)
    checktype(level, 'integer', 'setInFlightSightRadius', 1)
    checktype(value, 'float', 'setInFlightSightRadius', 2)
    self.def:setLvlDataUnreal('Esn1', level, 1, value)
end

function AbilityDefinitionSentinel:setNumberofOwls(level, value)
    checktype(level, 'integer', 'setNumberofOwls', 1)
    checktype(value, 'integer', 'setNumberofOwls', 2)
    self.def:setLvlDataInt('Esn4', level, 4, value)
end

function AbilityDefinitionSentinel:setHoveringHeight(level, value)
    checktype(level, 'integer', 'setHoveringHeight', 1)
    checktype(value, 'float', 'setHoveringHeight', 2)
    self.def:setLvlDataUnreal('Esn3', level, 3, value)
end

AbilityDefinitionArchMageSummonWaterElemental = class('AbilityDefinitionArchMageSummonWaterElemental', AbilityDefinition)
_G.AbilityDefinitionArchMageSummonWaterElemental = AbilityDefinitionArchMageSummonWaterElemental

function AbilityDefinitionArchMageSummonWaterElemental:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AHwe')
end

function AbilityDefinitionArchMageSummonWaterElemental:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionArchMageSummonWaterElemental:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionLoadBurrow = class('AbilityDefinitionLoadBurrow', AbilityDefinition)
_G.AbilityDefinitionLoadBurrow = AbilityDefinitionLoadBurrow

function AbilityDefinitionLoadBurrow:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Sloa')
end

function AbilityDefinitionLoadBurrow:setAllowedUnitType(level, value)
    checktype(level, 'integer', 'setAllowedUnitType', 1)
    checktype(value, 'string', 'setAllowedUnitType', 2)
    self.def:setLvlDataString('Loa1', level, 0, value)
end

AbilityDefinitionDispelMagiccreep = class('AbilityDefinitionDispelMagiccreep', AbilityDefinition)
_G.AbilityDefinitionDispelMagiccreep = AbilityDefinitionDispelMagiccreep

function AbilityDefinitionDispelMagiccreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adsm')
end

function AbilityDefinitionDispelMagiccreep:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'float', 'setManaLoss', 2)
    self.def:setLvlDataUnreal('Adm1', level, 1, value)
end

function AbilityDefinitionDispelMagiccreep:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Adm2', level, 2, value)
end

AbilityDefinitionFragShards = class('AbilityDefinitionFragShards', AbilityDefinition)
_G.AbilityDefinitionFragShards = AbilityDefinitionFragShards

function AbilityDefinitionFragShards:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Afsh')
end

function AbilityDefinitionFragShards:setSmallDamageRadius(level, value)
    checktype(level, 'integer', 'setSmallDamageRadius', 1)
    checktype(value, 'float', 'setSmallDamageRadius', 2)
    self.def:setLvlDataUnreal('flk2', level, 2, value)
end

function AbilityDefinitionFragShards:setSmallDamageAmount(level, value)
    checktype(level, 'integer', 'setSmallDamageAmount', 1)
    checktype(value, 'float', 'setSmallDamageAmount', 2)
    self.def:setLvlDataUnreal('flk5', level, 5, value)
end

function AbilityDefinitionFragShards:setMediumDamageAmount(level, value)
    checktype(level, 'integer', 'setMediumDamageAmount', 1)
    checktype(value, 'float', 'setMediumDamageAmount', 2)
    self.def:setLvlDataUnreal('flk4', level, 4, value)
end

function AbilityDefinitionFragShards:setMediumDamageRadius(level, value)
    checktype(level, 'integer', 'setMediumDamageRadius', 1)
    checktype(value, 'float', 'setMediumDamageRadius', 2)
    self.def:setLvlDataUnreal('flk1', level, 1, value)
end

function AbilityDefinitionFragShards:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('flk3', level, 3, value)
end

AbilityDefinitionDetectSentryWard = class('AbilityDefinitionDetectSentryWard', AbilityDefinition)
_G.AbilityDefinitionDetectSentryWard = AbilityDefinitionDetectSentryWard

function AbilityDefinitionDetectSentryWard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adt1')
end

function AbilityDefinitionDetectSentryWard:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionPhoenixFire = class('AbilityDefinitionPhoenixFire', AbilityDefinition)
_G.AbilityDefinitionPhoenixFire = AbilityDefinitionPhoenixFire

function AbilityDefinitionPhoenixFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apxf')
end

function AbilityDefinitionPhoenixFire:setInitialDamage(level, value)
    checktype(level, 'integer', 'setInitialDamage', 1)
    checktype(value, 'float', 'setInitialDamage', 2)
    self.def:setLvlDataUnreal('pxf1', level, 1, value)
end

function AbilityDefinitionPhoenixFire:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('pxf2', level, 2, value)
end

AbilityDefinitionRaiseDead = class('AbilityDefinitionRaiseDead', AbilityDefinition)
_G.AbilityDefinitionRaiseDead = AbilityDefinitionRaiseDead

function AbilityDefinitionRaiseDead:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arai')
end

function AbilityDefinitionRaiseDead:setUnitsSummonedTypeOne(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeOne', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeOne', 2)
    self.def:setLvlDataInt('Rai1', level, 1, value)
end

function AbilityDefinitionRaiseDead:setUnitTypeForLimitCheck(level, value)
    checktype(level, 'integer', 'setUnitTypeForLimitCheck', 1)
    checktype(value, 'string', 'setUnitTypeForLimitCheck', 2)
    self.def:setLvlDataString('Raiu', level, 0, value)
end

function AbilityDefinitionRaiseDead:setUnitsSummonedTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitsSummonedTypeTwo', 1)
    checktype(value, 'integer', 'setUnitsSummonedTypeTwo', 2)
    self.def:setLvlDataInt('Rai2', level, 2, value)
end

function AbilityDefinitionRaiseDead:setUnitTypeTwo(level, value)
    checktype(level, 'integer', 'setUnitTypeTwo', 1)
    checktype(value, 'string', 'setUnitTypeTwo', 2)
    self.def:setLvlDataString('Rai4', level, 4, value)
end

function AbilityDefinitionRaiseDead:setUnitTypeOne(level, value)
    checktype(level, 'integer', 'setUnitTypeOne', 1)
    checktype(value, 'string', 'setUnitTypeOne', 2)
    self.def:setLvlDataString('Rai3', level, 3, value)
end

AbilityDefinitionAnwm = class('AbilityDefinitionAnwm', AbilityDefinition)
_G.AbilityDefinitionAnwm = AbilityDefinitionAnwm

function AbilityDefinitionAnwm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Anwm')
end

function AbilityDefinitionAnwm:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionAnwm:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionShadowMeld = class('AbilityDefinitionShadowMeld', AbilityDefinition)
_G.AbilityDefinitionShadowMeld = AbilityDefinitionShadowMeld

function AbilityDefinitionShadowMeld:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ashm')
end

function AbilityDefinitionShadowMeld:setDayNightDuration(level, value)
    checktype(level, 'integer', 'setDayNightDuration', 1)
    checktype(value, 'float', 'setDayNightDuration', 2)
    self.def:setLvlDataUnreal('Shm2', level, 2, value)
end

function AbilityDefinitionShadowMeld:setActionDuration(level, value)
    checktype(level, 'integer', 'setActionDuration', 1)
    checktype(value, 'float', 'setActionDuration', 2)
    self.def:setLvlDataUnreal('Shm3', level, 3, value)
end

function AbilityDefinitionShadowMeld:setFadeDuration(level, value)
    checktype(level, 'integer', 'setFadeDuration', 1)
    checktype(value, 'float', 'setFadeDuration', 2)
    self.def:setLvlDataUnreal('Shm1', level, 1, value)
end

AbilityDefinitionRoarAra2 = class('AbilityDefinitionRoarAra2', AbilityDefinition)
_G.AbilityDefinitionRoarAra2 = AbilityDefinitionRoarAra2

function AbilityDefinitionRoarAra2:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ara2')
end

function AbilityDefinitionRoarAra2:setDamageIncrease(level, value)
    checktype(level, 'integer', 'setDamageIncrease', 1)
    checktype(value, 'float', 'setDamageIncrease', 2)
    self.def:setLvlDataUnreal('Roa1', level, 1, value)
end

function AbilityDefinitionRoarAra2:setDefenseIncrease(level, value)
    checktype(level, 'integer', 'setDefenseIncrease', 1)
    checktype(value, 'integer', 'setDefenseIncrease', 2)
    self.def:setLvlDataInt('Roa2', level, 2, value)
end

function AbilityDefinitionRoarAra2:setPreferHostiles(level, value)
    checktype(level, 'integer', 'setPreferHostiles', 1)
    checktype(value, 'boolean', 'setPreferHostiles', 2)
    self.def:setLvlDataBoolean('Roa5', level, 5, value)
end

function AbilityDefinitionRoarAra2:setManaRegen(level, value)
    checktype(level, 'integer', 'setManaRegen', 1)
    checktype(value, 'float', 'setManaRegen', 2)
    self.def:setLvlDataUnreal('Roa4', level, 4, value)
end

function AbilityDefinitionRoarAra2:setLifeRegenerationRate(level, value)
    checktype(level, 'integer', 'setLifeRegenerationRate', 1)
    checktype(value, 'float', 'setLifeRegenerationRate', 2)
    self.def:setLvlDataUnreal('Roa3', level, 3, value)
end

function AbilityDefinitionRoarAra2:setPreferFriendlies(level, value)
    checktype(level, 'integer', 'setPreferFriendlies', 1)
    checktype(value, 'boolean', 'setPreferFriendlies', 2)
    self.def:setLvlDataBoolean('Roa6', level, 6, value)
end

function AbilityDefinitionRoarAra2:setMaxUnits(level, value)
    checktype(level, 'integer', 'setMaxUnits', 1)
    checktype(value, 'integer', 'setMaxUnits', 2)
    self.def:setLvlDataInt('Roa7', level, 7, value)
end

AbilityDefinitionGhostVisible = class('AbilityDefinitionGhostVisible', AbilityDefinition)
_G.AbilityDefinitionGhostVisible = AbilityDefinitionGhostVisible

function AbilityDefinitionGhostVisible:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aeth')
end

function AbilityDefinitionGhostVisible:setDoesNotBlockBuildings(level, value)
    checktype(level, 'integer', 'setDoesNotBlockBuildings', 1)
    checktype(value, 'boolean', 'setDoesNotBlockBuildings', 2)
    self.def:setLvlDataBoolean('Eth2', level, 2, value)
end

function AbilityDefinitionGhostVisible:setImmunetoMorphEffects(level, value)
    checktype(level, 'integer', 'setImmunetoMorphEffects', 1)
    checktype(value, 'boolean', 'setImmunetoMorphEffects', 2)
    self.def:setLvlDataBoolean('Eth1', level, 1, value)
end

AbilityDefinitionDetectgeneral = class('AbilityDefinitionDetectgeneral', AbilityDefinition)
_G.AbilityDefinitionDetectgeneral = AbilityDefinitionDetectgeneral

function AbilityDefinitionDetectgeneral:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adtg')
end

function AbilityDefinitionDetectgeneral:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionPIlotTankRifleman = class('AbilityDefinitionPIlotTankRifleman', AbilityDefinition)
_G.AbilityDefinitionPIlotTankRifleman = AbilityDefinitionPIlotTankRifleman

function AbilityDefinitionPIlotTankRifleman:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Stpr')
end

function AbilityDefinitionPIlotTankRifleman:setConvertedUnitType(level, value)
    checktype(level, 'integer', 'setConvertedUnitType', 1)
    checktype(value, 'string', 'setConvertedUnitType', 2)
    self.def:setLvlDataString('tpi2', level, 2, value)
end

function AbilityDefinitionPIlotTankRifleman:setRequiredUnitType(level, value)
    checktype(level, 'integer', 'setRequiredUnitType', 1)
    checktype(value, 'string', 'setRequiredUnitType', 2)
    self.def:setLvlDataString('tpi1', level, 1, value)
end

AbilityDefinitionFreezeDamageBonus = class('AbilityDefinitionFreezeDamageBonus', AbilityDefinition)
_G.AbilityDefinitionFreezeDamageBonus = AbilityDefinitionFreezeDamageBonus

function AbilityDefinitionFreezeDamageBonus:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIzb')
end

function AbilityDefinitionFreezeDamageBonus:setEnabledAttackIndex(level, value)
    checktype(level, 'integer', 'setEnabledAttackIndex', 1)
    checktype(value, 'integer', 'setEnabledAttackIndex', 2)
    self.def:setLvlDataInt('Iob5', level, 5, value)
end

function AbilityDefinitionFreezeDamageBonus:setDamageBonus(level, value)
    checktype(level, 'integer', 'setDamageBonus', 1)
    checktype(value, 'float', 'setDamageBonus', 2)
    self.def:setLvlDataUnreal('Idam', level, 1, value)
end

AbilityDefinitionEtherealForm = class('AbilityDefinitionEtherealForm', AbilityDefinition)
_G.AbilityDefinitionEtherealForm = AbilityDefinitionEtherealForm

function AbilityDefinitionEtherealForm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aetf')
end

function AbilityDefinitionEtherealForm:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionEtherealForm:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionEtherealForm:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionEtherealForm:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionEtherealForm:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionDetonate = class('AbilityDefinitionDetonate', AbilityDefinition)
_G.AbilityDefinitionDetonate = AbilityDefinitionDetonate

function AbilityDefinitionDetonate:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Adtn')
end

function AbilityDefinitionDetonate:setDamagetoSummonedUnits(level, value)
    checktype(level, 'integer', 'setDamagetoSummonedUnits', 1)
    checktype(value, 'float', 'setDamagetoSummonedUnits', 2)
    self.def:setLvlDataUnreal('Dtn2', level, 2, value)
end

function AbilityDefinitionDetonate:setManaLossperunit(level, value)
    checktype(level, 'integer', 'setManaLossperunit', 1)
    checktype(value, 'float', 'setManaLossperunit', 2)
    self.def:setLvlDataUnreal('Dtn1', level, 1, value)
end

AbilityDefinitionRavenFormMedivh = class('AbilityDefinitionRavenFormMedivh', AbilityDefinition)
_G.AbilityDefinitionRavenFormMedivh = AbilityDefinitionRavenFormMedivh

function AbilityDefinitionRavenFormMedivh:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amrf')
end

function AbilityDefinitionRavenFormMedivh:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionRavenFormMedivh:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionRavenFormMedivh:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionRavenFormMedivh:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionRavenFormMedivh:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionShadowHunterSerpentWard = class('AbilityDefinitionShadowHunterSerpentWard', AbilityDefinition)
_G.AbilityDefinitionShadowHunterSerpentWard = AbilityDefinitionShadowHunterSerpentWard

function AbilityDefinitionShadowHunterSerpentWard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOsw')
end

function AbilityDefinitionShadowHunterSerpentWard:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionShadowHunterSerpentWard:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionAbsorbMana = class('AbilityDefinitionAbsorbMana', AbilityDefinition)
_G.AbilityDefinitionAbsorbMana = AbilityDefinitionAbsorbMana

function AbilityDefinitionAbsorbMana:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aabs')
end

function AbilityDefinitionAbsorbMana:setMaximumManaAbsorbed(level, value)
    checktype(level, 'integer', 'setMaximumManaAbsorbed', 1)
    checktype(value, 'float', 'setMaximumManaAbsorbed', 2)
    self.def:setLvlDataUnreal('abs2', level, 2, value)
end

function AbilityDefinitionAbsorbMana:setMaximumLifeAbsorbed(level, value)
    checktype(level, 'integer', 'setMaximumLifeAbsorbed', 1)
    checktype(value, 'float', 'setMaximumLifeAbsorbed', 2)
    self.def:setLvlDataUnreal('abs1', level, 1, value)
end

AbilityDefinitionAuraRegenerationStatue = class('AbilityDefinitionAuraRegenerationStatue', AbilityDefinition)
_G.AbilityDefinitionAuraRegenerationStatue = AbilityDefinitionAuraRegenerationStatue

function AbilityDefinitionAuraRegenerationStatue:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aabr')
end

function AbilityDefinitionAuraRegenerationStatue:setPercentage(level, value)
    checktype(level, 'integer', 'setPercentage', 1)
    checktype(value, 'boolean', 'setPercentage', 2)
    self.def:setLvlDataBoolean('Oar2', level, 2, value)
end

function AbilityDefinitionAuraRegenerationStatue:setAmountofHitPointsRegenerated(level, value)
    checktype(level, 'integer', 'setAmountofHitPointsRegenerated', 1)
    checktype(value, 'float', 'setAmountofHitPointsRegenerated', 2)
    self.def:setLvlDataUnreal('Oar1', level, 1, value)
end

AbilityDefinitionUnsummon = class('AbilityDefinitionUnsummon', AbilityDefinition)
_G.AbilityDefinitionUnsummon = AbilityDefinitionUnsummon

function AbilityDefinitionUnsummon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Auns')
end

function AbilityDefinitionUnsummon:setAccumulationStep(level, value)
    checktype(level, 'integer', 'setAccumulationStep', 1)
    checktype(value, 'integer', 'setAccumulationStep', 2)
    self.def:setLvlDataInt('Sal2', level, 2, value)
end

function AbilityDefinitionUnsummon:setSalvageCostRatio(level, value)
    checktype(level, 'integer', 'setSalvageCostRatio', 1)
    checktype(value, 'float', 'setSalvageCostRatio', 2)
    self.def:setLvlDataUnreal('Sal1', level, 1, value)
end

AbilityDefinitionTaurenChieftainShockWave = class('AbilityDefinitionTaurenChieftainShockWave', AbilityDefinition)
_G.AbilityDefinitionTaurenChieftainShockWave = AbilityDefinitionTaurenChieftainShockWave

function AbilityDefinitionTaurenChieftainShockWave:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOsh')
end

function AbilityDefinitionTaurenChieftainShockWave:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Osh1', level, 1, value)
end

function AbilityDefinitionTaurenChieftainShockWave:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Osh3', level, 3, value)
end

function AbilityDefinitionTaurenChieftainShockWave:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Osh4', level, 4, value)
end

function AbilityDefinitionTaurenChieftainShockWave:setMaximumDamage(level, value)
    checktype(level, 'integer', 'setMaximumDamage', 1)
    checktype(value, 'float', 'setMaximumDamage', 2)
    self.def:setLvlDataUnreal('Osh2', level, 2, value)
end

AbilityDefinitionCrippleWarlock = class('AbilityDefinitionCrippleWarlock', AbilityDefinition)
_G.AbilityDefinitionCrippleWarlock = AbilityDefinitionCrippleWarlock

function AbilityDefinitionCrippleWarlock:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Scri')
end

function AbilityDefinitionCrippleWarlock:setDamageReduction(level, value)
    checktype(level, 'integer', 'setDamageReduction', 1)
    checktype(value, 'float', 'setDamageReduction', 2)
    self.def:setLvlDataUnreal('Cri3', level, 3, value)
end

function AbilityDefinitionCrippleWarlock:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Cri2', level, 2, value)
end

function AbilityDefinitionCrippleWarlock:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Cri1', level, 1, value)
end

AbilityDefinitionFarseerSpiritWolf = class('AbilityDefinitionFarseerSpiritWolf', AbilityDefinition)
_G.AbilityDefinitionFarseerSpiritWolf = AbilityDefinitionFarseerSpiritWolf

function AbilityDefinitionFarseerSpiritWolf:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOsf')
end

function AbilityDefinitionFarseerSpiritWolf:setSummonedUnit(level, value)
    checktype(level, 'integer', 'setSummonedUnit', 1)
    checktype(value, 'string', 'setSummonedUnit', 2)
    self.def:setLvlDataString('Osf1', level, 0, value)
end

function AbilityDefinitionFarseerSpiritWolf:setNumberofSummonedUnits(level, value)
    checktype(level, 'integer', 'setNumberofSummonedUnits', 1)
    checktype(value, 'integer', 'setNumberofSummonedUnits', 2)
    self.def:setLvlDataInt('Osf2', level, 2, value)
end

AbilityDefinitionPilotTankMortarTeam = class('AbilityDefinitionPilotTankMortarTeam', AbilityDefinition)
_G.AbilityDefinitionPilotTankMortarTeam = AbilityDefinitionPilotTankMortarTeam

function AbilityDefinitionPilotTankMortarTeam:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Stpm')
end

function AbilityDefinitionPilotTankMortarTeam:setConvertedUnitType(level, value)
    checktype(level, 'integer', 'setConvertedUnitType', 1)
    checktype(value, 'string', 'setConvertedUnitType', 2)
    self.def:setLvlDataString('tpi2', level, 2, value)
end

function AbilityDefinitionPilotTankMortarTeam:setRequiredUnitType(level, value)
    checktype(level, 'integer', 'setRequiredUnitType', 1)
    checktype(value, 'string', 'setRequiredUnitType', 2)
    self.def:setLvlDataString('tpi1', level, 1, value)
end

AbilityDefinitionAntimagicShieldAIxs = class('AbilityDefinitionAntimagicShieldAIxs', AbilityDefinition)
_G.AbilityDefinitionAntimagicShieldAIxs = AbilityDefinitionAntimagicShieldAIxs

function AbilityDefinitionAntimagicShieldAIxs:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIxs')
end

function AbilityDefinitionAntimagicShieldAIxs:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Ixs2', level, 2, value)
end

function AbilityDefinitionAntimagicShieldAIxs:setDamageToSummonedUnits(level, value)
    checktype(level, 'integer', 'setDamageToSummonedUnits', 1)
    checktype(value, 'float', 'setDamageToSummonedUnits', 2)
    self.def:setLvlDataUnreal('Ixs1', level, 1, value)
end

function AbilityDefinitionAntimagicShieldAIxs:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'integer', 'setManaLoss', 2)
    self.def:setLvlDataInt('Ams4', level, 4, value)
end

function AbilityDefinitionAntimagicShieldAIxs:setShieldLife(level, value)
    checktype(level, 'integer', 'setShieldLife', 1)
    checktype(value, 'integer', 'setShieldLife', 2)
    self.def:setLvlDataInt('Ams3', level, 3, value)
end

AbilityDefinitionPermanentAllPlus1 = class('AbilityDefinitionPermanentAllPlus1', AbilityDefinition)
_G.AbilityDefinitionPermanentAllPlus1 = AbilityDefinitionPermanentAllPlus1

function AbilityDefinitionPermanentAllPlus1:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AIxm')
end

function AbilityDefinitionPermanentAllPlus1:setHideButton(level, value)
    checktype(level, 'integer', 'setHideButton', 1)
    checktype(value, 'boolean', 'setHideButton', 2)
    self.def:setLvlDataBoolean('Ihid', level, 4, value)
end

function AbilityDefinitionPermanentAllPlus1:setIntelligenceBonus(level, value)
    checktype(level, 'integer', 'setIntelligenceBonus', 1)
    checktype(value, 'integer', 'setIntelligenceBonus', 2)
    self.def:setLvlDataInt('Iint', level, 2, value)
end

function AbilityDefinitionPermanentAllPlus1:setAgilityBonus(level, value)
    checktype(level, 'integer', 'setAgilityBonus', 1)
    checktype(value, 'integer', 'setAgilityBonus', 2)
    self.def:setLvlDataInt('Iagi', level, 1, value)
end

function AbilityDefinitionPermanentAllPlus1:setStrengthBonus(level, value)
    checktype(level, 'integer', 'setStrengthBonus', 1)
    checktype(value, 'integer', 'setStrengthBonus', 2)
    self.def:setLvlDataInt('Istr', level, 3, value)
end

AbilityDefinitionAbolishMagic = class('AbilityDefinitionAbolishMagic', AbilityDefinition)
_G.AbilityDefinitionAbolishMagic = AbilityDefinitionAbolishMagic

function AbilityDefinitionAbolishMagic:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aadm')
end

function AbilityDefinitionAbolishMagic:setManaLoss(level, value)
    checktype(level, 'integer', 'setManaLoss', 1)
    checktype(value, 'float', 'setManaLoss', 2)
    self.def:setLvlDataUnreal('Adm1', level, 1, value)
end

function AbilityDefinitionAbolishMagic:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Adm2', level, 2, value)
end

AbilityDefinitionRavenFormDruidoftheTalon = class('AbilityDefinitionRavenFormDruidoftheTalon', AbilityDefinition)
_G.AbilityDefinitionRavenFormDruidoftheTalon = AbilityDefinitionRavenFormDruidoftheTalon

function AbilityDefinitionRavenFormDruidoftheTalon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arav')
end

function AbilityDefinitionRavenFormDruidoftheTalon:setNormalFormUnit(level, value)
    checktype(level, 'integer', 'setNormalFormUnit', 1)
    checktype(value, 'string', 'setNormalFormUnit', 2)
    self.def:setLvlDataString('Eme1', level, 1, value)
end

function AbilityDefinitionRavenFormDruidoftheTalon:setLandingDelayTime(level, value)
    checktype(level, 'integer', 'setLandingDelayTime', 1)
    checktype(value, 'float', 'setLandingDelayTime', 2)
    self.def:setLvlDataUnreal('Eme4', level, 4, value)
end

function AbilityDefinitionRavenFormDruidoftheTalon:setAltitudeAdjustmentDuration(level, value)
    checktype(level, 'integer', 'setAltitudeAdjustmentDuration', 1)
    checktype(value, 'float', 'setAltitudeAdjustmentDuration', 2)
    self.def:setLvlDataUnreal('Eme3', level, 3, value)
end

function AbilityDefinitionRavenFormDruidoftheTalon:setMorphingFlags(level, value)
    checktype(level, 'integer', 'setMorphingFlags', 1)
    checktype(value, 'integer', 'setMorphingFlags', 2)
    self.def:setLvlDataInt('Eme2', level, 2, value)
end

function AbilityDefinitionRavenFormDruidoftheTalon:setAlternateFormUnit(level, value)
    checktype(level, 'integer', 'setAlternateFormUnit', 1)
    checktype(value, 'string', 'setAlternateFormUnit', 2)
    self.def:setLvlDataString('Emeu', level, 0, value)
end

AbilityDefinitionPlagueToss = class('AbilityDefinitionPlagueToss', AbilityDefinition)
_G.AbilityDefinitionPlagueToss = AbilityDefinitionPlagueToss

function AbilityDefinitionPlagueToss:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Apts')
end

function AbilityDefinitionPlagueToss:setWardUnitType(level, value)
    checktype(level, 'integer', 'setWardUnitType', 1)
    checktype(value, 'string', 'setWardUnitType', 2)
    self.def:setLvlDataString('hwdu', level, 0, value)
end

AbilityDefinitionVampiricattack = class('AbilityDefinitionVampiricattack', AbilityDefinition)
_G.AbilityDefinitionVampiricattack = AbilityDefinitionVampiricattack

function AbilityDefinitionVampiricattack:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'SCva')
end

function AbilityDefinitionVampiricattack:setLifeStolenPerAttack(level, value)
    checktype(level, 'integer', 'setLifeStolenPerAttack', 1)
    checktype(value, 'float', 'setLifeStolenPerAttack', 2)
    self.def:setLvlDataUnreal('Ivam', level, 1, value)
end

AbilityDefinitionCargoHoldDeath = class('AbilityDefinitionCargoHoldDeath', AbilityDefinition)
_G.AbilityDefinitionCargoHoldDeath = AbilityDefinitionCargoHoldDeath

function AbilityDefinitionCargoHoldDeath:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Achd')
end

function AbilityDefinitionCargoHoldDeath:setMovementUpdateFrequency(level, value)
    checktype(level, 'integer', 'setMovementUpdateFrequency', 1)
    checktype(value, 'float', 'setMovementUpdateFrequency', 2)
    self.def:setLvlDataUnreal('Chd1', level, 1, value)
end

function AbilityDefinitionCargoHoldDeath:setSummonedUnitDamage(level, value)
    checktype(level, 'integer', 'setSummonedUnitDamage', 1)
    checktype(value, 'float', 'setSummonedUnitDamage', 2)
    self.def:setLvlDataUnreal('Chd3', level, 3, value)
end

function AbilityDefinitionCargoHoldDeath:setAttackUpdateFrequency(level, value)
    checktype(level, 'integer', 'setAttackUpdateFrequency', 1)
    checktype(value, 'float', 'setAttackUpdateFrequency', 2)
    self.def:setLvlDataUnreal('Chd2', level, 2, value)
end

AbilityDefinitionAcha = class('AbilityDefinitionAcha', AbilityDefinition)
_G.AbilityDefinitionAcha = AbilityDefinitionAcha

function AbilityDefinitionAcha:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Acha')
end

function AbilityDefinitionAcha:setNewUnitType(level, value)
    checktype(level, 'integer', 'setNewUnitType', 1)
    checktype(value, 'string', 'setNewUnitType', 2)
    self.def:setLvlDataString('Cha1', level, 0, value)
end

AbilityDefinitionUnholyFrenzycreep = class('AbilityDefinitionUnholyFrenzycreep', AbilityDefinition)
_G.AbilityDefinitionUnholyFrenzycreep = AbilityDefinitionUnholyFrenzycreep

function AbilityDefinitionUnholyFrenzycreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACuf')
end

function AbilityDefinitionUnholyFrenzycreep:setAttackSpeedBonus(level, value)
    checktype(level, 'integer', 'setAttackSpeedBonus', 1)
    checktype(value, 'float', 'setAttackSpeedBonus', 2)
    self.def:setLvlDataUnreal('Uhf1', level, 1, value)
end

function AbilityDefinitionUnholyFrenzycreep:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Uhf2', level, 2, value)
end

AbilityDefinitionRenew = class('AbilityDefinitionRenew', AbilityDefinition)
_G.AbilityDefinitionRenew = AbilityDefinitionRenew

function AbilityDefinitionRenew:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aren')
end

function AbilityDefinitionRenew:setPowerbuildRate(level, value)
    checktype(level, 'integer', 'setPowerbuildRate', 1)
    checktype(value, 'float', 'setPowerbuildRate', 2)
    self.def:setLvlDataUnreal('Rep4', level, 4, value)
end

function AbilityDefinitionRenew:setNavalRangeBonus(level, value)
    checktype(level, 'integer', 'setNavalRangeBonus', 1)
    checktype(value, 'float', 'setNavalRangeBonus', 2)
    self.def:setLvlDataUnreal('Rep5', level, 5, value)
end

function AbilityDefinitionRenew:setRepairTimeRatio(level, value)
    checktype(level, 'integer', 'setRepairTimeRatio', 1)
    checktype(value, 'float', 'setRepairTimeRatio', 2)
    self.def:setLvlDataUnreal('Rep2', level, 2, value)
end

function AbilityDefinitionRenew:setRepairCostRatio(level, value)
    checktype(level, 'integer', 'setRepairCostRatio', 1)
    checktype(value, 'float', 'setRepairCostRatio', 2)
    self.def:setLvlDataUnreal('Rep1', level, 1, value)
end

function AbilityDefinitionRenew:setPowerbuildCost(level, value)
    checktype(level, 'integer', 'setPowerbuildCost', 1)
    checktype(value, 'float', 'setPowerbuildCost', 2)
    self.def:setLvlDataUnreal('Rep3', level, 3, value)
end

AbilityDefinitionRegenLife = class('AbilityDefinitionRegenLife', AbilityDefinition)
_G.AbilityDefinitionRegenLife = AbilityDefinitionRegenLife

function AbilityDefinitionRegenLife:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arel')
end

function AbilityDefinitionRegenLife:setHitPointsRegeneratedPerSecond(level, value)
    checktype(level, 'integer', 'setHitPointsRegeneratedPerSecond', 1)
    checktype(value, 'integer', 'setHitPointsRegeneratedPerSecond', 2)
    self.def:setLvlDataInt('Ihpr', level, 1, value)
end

AbilityDefinitionBlightGrowthLarge = class('AbilityDefinitionBlightGrowthLarge', AbilityDefinition)
_G.AbilityDefinitionBlightGrowthLarge = AbilityDefinitionBlightGrowthLarge

function AbilityDefinitionBlightGrowthLarge:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abgl')
end

function AbilityDefinitionBlightGrowthLarge:setCreatesBlight(level, value)
    checktype(level, 'integer', 'setCreatesBlight', 1)
    checktype(value, 'boolean', 'setCreatesBlight', 2)
    self.def:setLvlDataBoolean('Bli2', level, 2, value)
end

function AbilityDefinitionBlightGrowthLarge:setExpansionAmount(level, value)
    checktype(level, 'integer', 'setExpansionAmount', 1)
    checktype(value, 'float', 'setExpansionAmount', 2)
    self.def:setLvlDataUnreal('Bli1', level, 1, value)
end

AbilityDefinitionBlightedGoldmine = class('AbilityDefinitionBlightedGoldmine', AbilityDefinition)
_G.AbilityDefinitionBlightedGoldmine = AbilityDefinitionBlightedGoldmine

function AbilityDefinitionBlightedGoldmine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abgm')
end

function AbilityDefinitionBlightedGoldmine:setGoldperInterval(level, value)
    checktype(level, 'integer', 'setGoldperInterval', 1)
    checktype(value, 'integer', 'setGoldperInterval', 2)
    self.def:setLvlDataInt('Bgm1', level, 1, value)
end

function AbilityDefinitionBlightedGoldmine:setRadiusofMiningRing(level, value)
    checktype(level, 'integer', 'setRadiusofMiningRing', 1)
    checktype(value, 'float', 'setRadiusofMiningRing', 2)
    self.def:setLvlDataUnreal('Bgm4', level, 4, value)
end

function AbilityDefinitionBlightedGoldmine:setIntervalDuration(level, value)
    checktype(level, 'integer', 'setIntervalDuration', 1)
    checktype(value, 'float', 'setIntervalDuration', 2)
    self.def:setLvlDataUnreal('Bgm2', level, 2, value)
end

function AbilityDefinitionBlightedGoldmine:setMaxNumberofMiners(level, value)
    checktype(level, 'integer', 'setMaxNumberofMiners', 1)
    checktype(value, 'integer', 'setMaxNumberofMiners', 2)
    self.def:setLvlDataInt('Bgm3', level, 3, value)
end

AbilityDefinitionUnholyAuracreep = class('AbilityDefinitionUnholyAuracreep', AbilityDefinition)
_G.AbilityDefinitionUnholyAuracreep = AbilityDefinitionUnholyAuracreep

function AbilityDefinitionUnholyAuracreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACua')
end

function AbilityDefinitionUnholyAuracreep:setPercentBonus(level, value)
    checktype(level, 'integer', 'setPercentBonus', 1)
    checktype(value, 'boolean', 'setPercentBonus', 2)
    self.def:setLvlDataBoolean('Uau3', level, 3, value)
end

function AbilityDefinitionUnholyAuracreep:setLifeRegenerationIncrease(level, value)
    checktype(level, 'integer', 'setLifeRegenerationIncrease', 1)
    checktype(value, 'float', 'setLifeRegenerationIncrease', 2)
    self.def:setLvlDataUnreal('Uau2', level, 2, value)
end

function AbilityDefinitionUnholyAuracreep:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Uau1', level, 1, value)
end

AbilityDefinitionRepairOrc = class('AbilityDefinitionRepairOrc', AbilityDefinition)
_G.AbilityDefinitionRepairOrc = AbilityDefinitionRepairOrc

function AbilityDefinitionRepairOrc:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arep')
end

function AbilityDefinitionRepairOrc:setPowerbuildRate(level, value)
    checktype(level, 'integer', 'setPowerbuildRate', 1)
    checktype(value, 'float', 'setPowerbuildRate', 2)
    self.def:setLvlDataUnreal('Rep4', level, 4, value)
end

function AbilityDefinitionRepairOrc:setNavalRangeBonus(level, value)
    checktype(level, 'integer', 'setNavalRangeBonus', 1)
    checktype(value, 'float', 'setNavalRangeBonus', 2)
    self.def:setLvlDataUnreal('Rep5', level, 5, value)
end

function AbilityDefinitionRepairOrc:setRepairTimeRatio(level, value)
    checktype(level, 'integer', 'setRepairTimeRatio', 1)
    checktype(value, 'float', 'setRepairTimeRatio', 2)
    self.def:setLvlDataUnreal('Rep2', level, 2, value)
end

function AbilityDefinitionRepairOrc:setRepairCostRatio(level, value)
    checktype(level, 'integer', 'setRepairCostRatio', 1)
    checktype(value, 'float', 'setRepairCostRatio', 2)
    self.def:setLvlDataUnreal('Rep1', level, 1, value)
end

function AbilityDefinitionRepairOrc:setPowerbuildCost(level, value)
    checktype(level, 'integer', 'setPowerbuildCost', 1)
    checktype(value, 'float', 'setPowerbuildCost', 2)
    self.def:setLvlDataUnreal('Rep3', level, 3, value)
end

AbilityDefinitionEntanglingSeaweed = class('AbilityDefinitionEntanglingSeaweed', AbilityDefinition)
_G.AbilityDefinitionEntanglingSeaweed = AbilityDefinitionEntanglingSeaweed

function AbilityDefinitionEntanglingSeaweed:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aenw')
end

function AbilityDefinitionEntanglingSeaweed:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Eer1', level, 1, value)
end

AbilityDefinitionNeutralSpies = class('AbilityDefinitionNeutralSpies', AbilityDefinition)
_G.AbilityDefinitionNeutralSpies = AbilityDefinitionNeutralSpies

function AbilityDefinitionNeutralSpies:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ansp')
end

function AbilityDefinitionNeutralSpies:setGoldCostperStructure(level, value)
    checktype(level, 'integer', 'setGoldCostperStructure', 1)
    checktype(value, 'integer', 'setGoldCostperStructure', 2)
    self.def:setLvlDataInt('Nsp1', level, 1, value)
end

function AbilityDefinitionNeutralSpies:setLumberCostperUse(level, value)
    checktype(level, 'integer', 'setLumberCostperUse', 1)
    checktype(value, 'integer', 'setLumberCostperUse', 2)
    self.def:setLvlDataInt('Nsp2', level, 2, value)
end

function AbilityDefinitionNeutralSpies:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Nsp3', level, 3, value)
end

AbilityDefinitionEntangle = class('AbilityDefinitionEntangle', AbilityDefinition)
_G.AbilityDefinitionEntangle = AbilityDefinitionEntangle

function AbilityDefinitionEntangle:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aent')
end

function AbilityDefinitionEntangle:setResultingUnitType(level, value)
    checktype(level, 'integer', 'setResultingUnitType', 1)
    checktype(value, 'string', 'setResultingUnitType', 2)
    self.def:setLvlDataString('ent1', level, 0, value)
end

AbilityDefinitionRejuvination = class('AbilityDefinitionRejuvination', AbilityDefinition)
_G.AbilityDefinitionRejuvination = AbilityDefinitionRejuvination

function AbilityDefinitionRejuvination:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Arej')
end

function AbilityDefinitionRejuvination:setManaPointsGained(level, value)
    checktype(level, 'integer', 'setManaPointsGained', 1)
    checktype(value, 'float', 'setManaPointsGained', 2)
    self.def:setLvlDataUnreal('Rej2', level, 2, value)
end

function AbilityDefinitionRejuvination:setNoTargetRequired(level, value)
    checktype(level, 'integer', 'setNoTargetRequired', 1)
    checktype(value, 'boolean', 'setNoTargetRequired', 2)
    self.def:setLvlDataBoolean('Rej4', level, 4, value)
end

function AbilityDefinitionRejuvination:setHitPointsGained(level, value)
    checktype(level, 'integer', 'setHitPointsGained', 1)
    checktype(value, 'float', 'setHitPointsGained', 2)
    self.def:setLvlDataUnreal('Rej1', level, 1, value)
end

function AbilityDefinitionRejuvination:setAllowWhenFull(level, value)
    checktype(level, 'integer', 'setAllowWhenFull', 1)
    checkenum(value, 'AllowWhenFull', 'setAllowWhenFull', 2)
    self.def:setLvlDataInt('Rej3', level, 3, value)
end

AbilityDefinitionEntanglingRootscreep = class('AbilityDefinitionEntanglingRootscreep', AbilityDefinition)
_G.AbilityDefinitionEntanglingRootscreep = AbilityDefinitionEntanglingRootscreep

function AbilityDefinitionEntanglingRootscreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aenr')
end

function AbilityDefinitionEntanglingRootscreep:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Eer1', level, 1, value)
end

AbilityDefinitionSelfDestruct = class('AbilityDefinitionSelfDestruct', AbilityDefinition)
_G.AbilityDefinitionSelfDestruct = AbilityDefinitionSelfDestruct

function AbilityDefinitionSelfDestruct:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asds')
end

function AbilityDefinitionSelfDestruct:setPartialDamageAmount(level, value)
    checktype(level, 'integer', 'setPartialDamageAmount', 1)
    checktype(value, 'float', 'setPartialDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda4', level, 4, value)
end

function AbilityDefinitionSelfDestruct:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda1', level, 1, value)
end

function AbilityDefinitionSelfDestruct:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda2', level, 2, value)
end

function AbilityDefinitionSelfDestruct:setExplodesonDeath(level, value)
    checktype(level, 'integer', 'setExplodesonDeath', 1)
    checktype(value, 'boolean', 'setExplodesonDeath', 2)
    self.def:setLvlDataBoolean('Sds6', level, 6, value)
end

function AbilityDefinitionSelfDestruct:setBuildingDamageFactor(level, value)
    checktype(level, 'integer', 'setBuildingDamageFactor', 1)
    checktype(value, 'float', 'setBuildingDamageFactor', 2)
    self.def:setLvlDataUnreal('Sds1', level, 5, value)
end

function AbilityDefinitionSelfDestruct:setPartialDamageRadius(level, value)
    checktype(level, 'integer', 'setPartialDamageRadius', 1)
    checktype(value, 'float', 'setPartialDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda3', level, 3, value)
end

AbilityDefinitionBlightGrowthSmall = class('AbilityDefinitionBlightGrowthSmall', AbilityDefinition)
_G.AbilityDefinitionBlightGrowthSmall = AbilityDefinitionBlightGrowthSmall

function AbilityDefinitionBlightGrowthSmall:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abgs')
end

function AbilityDefinitionBlightGrowthSmall:setCreatesBlight(level, value)
    checktype(level, 'integer', 'setCreatesBlight', 1)
    checktype(value, 'boolean', 'setCreatesBlight', 2)
    self.def:setLvlDataBoolean('Bli2', level, 2, value)
end

function AbilityDefinitionBlightGrowthSmall:setExpansionAmount(level, value)
    checktype(level, 'integer', 'setExpansionAmount', 1)
    checktype(value, 'float', 'setExpansionAmount', 2)
    self.def:setLvlDataUnreal('Bli1', level, 1, value)
end

AbilityDefinitionEnsnare = class('AbilityDefinitionEnsnare', AbilityDefinition)
_G.AbilityDefinitionEnsnare = AbilityDefinitionEnsnare

function AbilityDefinitionEnsnare:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aens')
end

function AbilityDefinitionEnsnare:setAirUnitHeight(level, value)
    checktype(level, 'integer', 'setAirUnitHeight', 1)
    checktype(value, 'float', 'setAirUnitHeight', 2)
    self.def:setLvlDataUnreal('Ens2', level, 2, value)
end

function AbilityDefinitionEnsnare:setAirUnitLowerDuration(level, value)
    checktype(level, 'integer', 'setAirUnitLowerDuration', 1)
    checktype(value, 'float', 'setAirUnitLowerDuration', 2)
    self.def:setLvlDataUnreal('Ens1', level, 1, value)
end

function AbilityDefinitionEnsnare:setMeleeAttackRange(level, value)
    checktype(level, 'integer', 'setMeleeAttackRange', 1)
    checktype(value, 'float', 'setMeleeAttackRange', 2)
    self.def:setLvlDataUnreal('Ens3', level, 3, value)
end

AbilityDefinitionDeathDamageAOEmineBIG = class('AbilityDefinitionDeathDamageAOEmineBIG', AbilityDefinition)
_G.AbilityDefinitionDeathDamageAOEmineBIG = AbilityDefinitionDeathDamageAOEmineBIG

function AbilityDefinitionDeathDamageAOEmineBIG:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amnz')
end

function AbilityDefinitionDeathDamageAOEmineBIG:setPartialDamageAmount(level, value)
    checktype(level, 'integer', 'setPartialDamageAmount', 1)
    checktype(value, 'float', 'setPartialDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda4', level, 4, value)
end

function AbilityDefinitionDeathDamageAOEmineBIG:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda1', level, 1, value)
end

function AbilityDefinitionDeathDamageAOEmineBIG:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda2', level, 2, value)
end

function AbilityDefinitionDeathDamageAOEmineBIG:setPartialDamageRadius(level, value)
    checktype(level, 'integer', 'setPartialDamageRadius', 1)
    checktype(value, 'float', 'setPartialDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda3', level, 3, value)
end

AbilityDefinitionSerpentWardtentacleForgottenone = class('AbilityDefinitionSerpentWardtentacleForgottenone', AbilityDefinition)
_G.AbilityDefinitionSerpentWardtentacleForgottenone = AbilityDefinitionSerpentWardtentacleForgottenone

function AbilityDefinitionSerpentWardtentacleForgottenone:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACtn')
end

function AbilityDefinitionSerpentWardtentacleForgottenone:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionSerpentWardtentacleForgottenone:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionTornadoDamage = class('AbilityDefinitionTornadoDamage', AbilityDefinition)
_G.AbilityDefinitionTornadoDamage = AbilityDefinitionTornadoDamage

function AbilityDefinitionTornadoDamage:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Atdg')
end

function AbilityDefinitionTornadoDamage:setMediumDamageRadius(level, value)
    checktype(level, 'integer', 'setMediumDamageRadius', 1)
    checktype(value, 'float', 'setMediumDamageRadius', 2)
    self.def:setLvlDataUnreal('Tdg2', level, 2, value)
end

function AbilityDefinitionTornadoDamage:setMediumDamagePerSecond(level, value)
    checktype(level, 'integer', 'setMediumDamagePerSecond', 1)
    checktype(value, 'float', 'setMediumDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Tdg3', level, 3, value)
end

function AbilityDefinitionTornadoDamage:setSmallDamageRadius(level, value)
    checktype(level, 'integer', 'setSmallDamageRadius', 1)
    checktype(value, 'float', 'setSmallDamageRadius', 2)
    self.def:setLvlDataUnreal('Tdg4', level, 4, value)
end

function AbilityDefinitionTornadoDamage:setSmallDamagePerSecond(level, value)
    checktype(level, 'integer', 'setSmallDamagePerSecond', 1)
    checktype(value, 'float', 'setSmallDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Tdg5', level, 5, value)
end

function AbilityDefinitionTornadoDamage:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Tdg1', level, 1, value)
end

AbilityDefinitionThunderBoltCreep = class('AbilityDefinitionThunderBoltCreep', AbilityDefinition)
_G.AbilityDefinitionThunderBoltCreep = AbilityDefinitionThunderBoltCreep

function AbilityDefinitionThunderBoltCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACtb')
end

function AbilityDefinitionThunderBoltCreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ctb1', level, 1, value)
end

AbilityDefinitionThunderClapCreep = class('AbilityDefinitionThunderClapCreep', AbilityDefinition)
_G.AbilityDefinitionThunderClapCreep = AbilityDefinitionThunderClapCreep

function AbilityDefinitionThunderClapCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACtc')
end

function AbilityDefinitionThunderClapCreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Ctc1', level, 1, value)
end

function AbilityDefinitionThunderClapCreep:setExtraDamageToTarget(level, value)
    checktype(level, 'integer', 'setExtraDamageToTarget', 1)
    checktype(value, 'float', 'setExtraDamageToTarget', 2)
    self.def:setLvlDataUnreal('Ctc2', level, 2, value)
end

function AbilityDefinitionThunderClapCreep:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('Ctc4', level, 4, value)
end

function AbilityDefinitionThunderClapCreep:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('Ctc3', level, 3, value)
end

AbilityDefinitionSelfDestructClockwerkGoblins = class('AbilityDefinitionSelfDestructClockwerkGoblins', AbilityDefinition)
_G.AbilityDefinitionSelfDestructClockwerkGoblins = AbilityDefinitionSelfDestructClockwerkGoblins

function AbilityDefinitionSelfDestructClockwerkGoblins:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asdg')
end

function AbilityDefinitionSelfDestructClockwerkGoblins:setExplodesonDeath(level, value)
    checktype(level, 'integer', 'setExplodesonDeath', 1)
    checktype(value, 'boolean', 'setExplodesonDeath', 2)
    self.def:setLvlDataBoolean('Sds6', level, 6, value)
end

AbilityDefinitionDeathDamageAOEmine = class('AbilityDefinitionDeathDamageAOEmine', AbilityDefinition)
_G.AbilityDefinitionDeathDamageAOEmine = AbilityDefinitionDeathDamageAOEmine

function AbilityDefinitionDeathDamageAOEmine:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amnx')
end

function AbilityDefinitionDeathDamageAOEmine:setPartialDamageAmount(level, value)
    checktype(level, 'integer', 'setPartialDamageAmount', 1)
    checktype(value, 'float', 'setPartialDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda4', level, 4, value)
end

function AbilityDefinitionDeathDamageAOEmine:setFullDamageRadius(level, value)
    checktype(level, 'integer', 'setFullDamageRadius', 1)
    checktype(value, 'float', 'setFullDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda1', level, 1, value)
end

function AbilityDefinitionDeathDamageAOEmine:setFullDamageAmount(level, value)
    checktype(level, 'integer', 'setFullDamageAmount', 1)
    checktype(value, 'float', 'setFullDamageAmount', 2)
    self.def:setLvlDataUnreal('Dda2', level, 2, value)
end

function AbilityDefinitionDeathDamageAOEmine:setPartialDamageRadius(level, value)
    checktype(level, 'integer', 'setPartialDamageRadius', 1)
    checktype(value, 'float', 'setPartialDamageRadius', 2)
    self.def:setLvlDataUnreal('Dda3', level, 3, value)
end

AbilityDefinitionManaBurndemon = class('AbilityDefinitionManaBurndemon', AbilityDefinition)
_G.AbilityDefinitionManaBurndemon = AbilityDefinitionManaBurndemon

function AbilityDefinitionManaBurndemon:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Amnb')
end

function AbilityDefinitionManaBurndemon:setMaxManaDrained(level, value)
    checktype(level, 'integer', 'setMaxManaDrained', 1)
    checktype(value, 'float', 'setMaxManaDrained', 2)
    self.def:setLvlDataUnreal('Emb1', level, 1, value)
end

function AbilityDefinitionManaBurndemon:setBoltLifetime(level, value)
    checktype(level, 'integer', 'setBoltLifetime', 1)
    checktype(value, 'float', 'setBoltLifetime', 2)
    self.def:setLvlDataUnreal('Emb3', level, 3, value)
end

function AbilityDefinitionManaBurndemon:setBoltDelay(level, value)
    checktype(level, 'integer', 'setBoltDelay', 1)
    checktype(value, 'float', 'setBoltDelay', 2)
    self.def:setLvlDataUnreal('Emb2', level, 2, value)
end

AbilityDefinitionShockwaveTrap = class('AbilityDefinitionShockwaveTrap', AbilityDefinition)
_G.AbilityDefinitionShockwaveTrap = AbilityDefinitionShockwaveTrap

function AbilityDefinitionShockwaveTrap:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACst')
end

function AbilityDefinitionShockwaveTrap:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Osh1', level, 1, value)
end

function AbilityDefinitionShockwaveTrap:setDistance(level, value)
    checktype(level, 'integer', 'setDistance', 1)
    checktype(value, 'float', 'setDistance', 2)
    self.def:setLvlDataUnreal('Osh3', level, 3, value)
end

function AbilityDefinitionShockwaveTrap:setFinalArea(level, value)
    checktype(level, 'integer', 'setFinalArea', 1)
    checktype(value, 'float', 'setFinalArea', 2)
    self.def:setLvlDataUnreal('Osh4', level, 4, value)
end

function AbilityDefinitionShockwaveTrap:setMaximumDamage(level, value)
    checktype(level, 'integer', 'setMaximumDamage', 1)
    checktype(value, 'float', 'setMaximumDamage', 2)
    self.def:setLvlDataUnreal('Osh2', level, 2, value)
end

AbilityDefinitionShadowStrikeCreep = class('AbilityDefinitionShadowStrikeCreep', AbilityDefinition)
_G.AbilityDefinitionShadowStrikeCreep = AbilityDefinitionShadowStrikeCreep

function AbilityDefinitionShadowStrikeCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACss')
end

function AbilityDefinitionShadowStrikeCreep:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Esh2', level, 2, value)
end

function AbilityDefinitionShadowStrikeCreep:setInitialDamage(level, value)
    checktype(level, 'integer', 'setInitialDamage', 1)
    checktype(value, 'float', 'setInitialDamage', 2)
    self.def:setLvlDataUnreal('Esh5', level, 5, value)
end

function AbilityDefinitionShadowStrikeCreep:setDecayPower(level, value)
    checktype(level, 'integer', 'setDecayPower', 1)
    checktype(value, 'float', 'setDecayPower', 2)
    self.def:setLvlDataUnreal('Esh4', level, 4, value)
end

function AbilityDefinitionShadowStrikeCreep:setDecayingDamage(level, value)
    checktype(level, 'integer', 'setDecayingDamage', 1)
    checktype(value, 'float', 'setDecayingDamage', 2)
    self.def:setLvlDataUnreal('Esh1', level, 1, value)
end

function AbilityDefinitionShadowStrikeCreep:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Esh3', level, 3, value)
end

AbilityDefinitionBashmaulSPBearlevel3 = class('AbilityDefinitionBashmaulSPBearlevel3', AbilityDefinition)
_G.AbilityDefinitionBashmaulSPBearlevel3 = AbilityDefinitionBashmaulSPBearlevel3

function AbilityDefinitionBashmaulSPBearlevel3:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ANb2')
end

function AbilityDefinitionBashmaulSPBearlevel3:setNeverMiss(level, value)
    checktype(level, 'integer', 'setNeverMiss', 1)
    checktype(value, 'boolean', 'setNeverMiss', 2)
    self.def:setLvlDataBoolean('Hbh5', level, 5, value)
end

AbilityDefinitionSlowCreep = class('AbilityDefinitionSlowCreep', AbilityDefinition)
_G.AbilityDefinitionSlowCreep = AbilityDefinitionSlowCreep

function AbilityDefinitionSlowCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACsw')
end

function AbilityDefinitionSlowCreep:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo1', level, 1, value)
end

function AbilityDefinitionSlowCreep:setAlwaysAutocast(level, value)
    checktype(level, 'integer', 'setAlwaysAutocast', 1)
    checktype(value, 'boolean', 'setAlwaysAutocast', 2)
    self.def:setLvlDataBoolean('Slo3', level, 3, value)
end

function AbilityDefinitionSlowCreep:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Slo2', level, 2, value)
end

AbilityDefinitionReturnGold = class('AbilityDefinitionReturnGold', AbilityDefinition)
_G.AbilityDefinitionReturnGold = AbilityDefinitionReturnGold

function AbilityDefinitionReturnGold:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Argd')
end

function AbilityDefinitionReturnGold:setAcceptsGold(level, value)
    checktype(level, 'integer', 'setAcceptsGold', 1)
    checktype(value, 'boolean', 'setAcceptsGold', 2)
    self.def:setLvlDataBoolean('Rtn1', level, 1, value)
end

function AbilityDefinitionReturnGold:setAcceptsLumber(level, value)
    checktype(level, 'integer', 'setAcceptsLumber', 1)
    checktype(value, 'boolean', 'setAcceptsLumber', 2)
    self.def:setLvlDataBoolean('Rtn2', level, 2, value)
end

AbilityDefinitionWarStompseagiant = class('AbilityDefinitionWarStompseagiant', AbilityDefinition)
_G.AbilityDefinitionWarStompseagiant = AbilityDefinitionWarStompseagiant

function AbilityDefinitionWarStompseagiant:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awrg')
end

function AbilityDefinitionWarStompseagiant:setTerrainDeformationAmplitude(level, value)
    checktype(level, 'integer', 'setTerrainDeformationAmplitude', 1)
    checktype(value, 'float', 'setTerrainDeformationAmplitude', 2)
    self.def:setLvlDataUnreal('Wrs2', level, 2, value)
end

function AbilityDefinitionWarStompseagiant:setTerrainDeformationDurationms(level, value)
    checktype(level, 'integer', 'setTerrainDeformationDurationms', 1)
    checktype(value, 'integer', 'setTerrainDeformationDurationms', 2)
    self.def:setLvlDataInt('Wrs3', level, 3, value)
end

function AbilityDefinitionWarStompseagiant:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Wrs1', level, 1, value)
end

AbilityDefinitionBladeMasterBladestorm = class('AbilityDefinitionBladeMasterBladestorm', AbilityDefinition)
_G.AbilityDefinitionBladeMasterBladestorm = AbilityDefinitionBladeMasterBladestorm

function AbilityDefinitionBladeMasterBladestorm:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOww')
end

function AbilityDefinitionBladeMasterBladestorm:setMagicDamageReduction(level, value)
    checktype(level, 'integer', 'setMagicDamageReduction', 1)
    checktype(value, 'float', 'setMagicDamageReduction', 2)
    self.def:setLvlDataUnreal('Oww2', level, 2, value)
end

function AbilityDefinitionBladeMasterBladestorm:setDamagePerSecond(level, value)
    checktype(level, 'integer', 'setDamagePerSecond', 1)
    checktype(value, 'float', 'setDamagePerSecond', 2)
    self.def:setLvlDataUnreal('Oww1', level, 1, value)
end

AbilityDefinitionTaurenChieftainWarStomp = class('AbilityDefinitionTaurenChieftainWarStomp', AbilityDefinition)
_G.AbilityDefinitionTaurenChieftainWarStomp = AbilityDefinitionTaurenChieftainWarStomp

function AbilityDefinitionTaurenChieftainWarStomp:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOws')
end

function AbilityDefinitionTaurenChieftainWarStomp:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Wrs1', level, 1, value)
end

AbilityDefinitionWarStomphydra = class('AbilityDefinitionWarStomphydra', AbilityDefinition)
_G.AbilityDefinitionWarStomphydra = AbilityDefinitionWarStomphydra

function AbilityDefinitionWarStomphydra:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awrh')
end

function AbilityDefinitionWarStomphydra:setTerrainDeformationAmplitude(level, value)
    checktype(level, 'integer', 'setTerrainDeformationAmplitude', 1)
    checktype(value, 'float', 'setTerrainDeformationAmplitude', 2)
    self.def:setLvlDataUnreal('Wrs2', level, 2, value)
end

function AbilityDefinitionWarStomphydra:setTerrainDeformationDurationms(level, value)
    checktype(level, 'integer', 'setTerrainDeformationDurationms', 1)
    checktype(value, 'integer', 'setTerrainDeformationDurationms', 2)
    self.def:setLvlDataInt('Wrs3', level, 3, value)
end

function AbilityDefinitionWarStomphydra:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Wrs1', level, 1, value)
end

AbilityDefinitionBladeMasterWindWalk = class('AbilityDefinitionBladeMasterWindWalk', AbilityDefinition)
_G.AbilityDefinitionBladeMasterWindWalk = AbilityDefinitionBladeMasterWindWalk

function AbilityDefinitionBladeMasterWindWalk:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'AOwk')
end

function AbilityDefinitionBladeMasterWindWalk:setBackstabDamage(level, value)
    checktype(level, 'integer', 'setBackstabDamage', 1)
    checktype(value, 'boolean', 'setBackstabDamage', 2)
    self.def:setLvlDataBoolean('Owk4', level, 4, value)
end

function AbilityDefinitionBladeMasterWindWalk:setMovementSpeedIncrease(level, value)
    checktype(level, 'integer', 'setMovementSpeedIncrease', 1)
    checktype(value, 'float', 'setMovementSpeedIncrease', 2)
    self.def:setLvlDataUnreal('Owk2', level, 2, value)
end

function AbilityDefinitionBladeMasterWindWalk:setTransitionTime(level, value)
    checktype(level, 'integer', 'setTransitionTime', 1)
    checktype(value, 'float', 'setTransitionTime', 2)
    self.def:setLvlDataUnreal('Owk1', level, 1, value)
end

function AbilityDefinitionBladeMasterWindWalk:setBackstabDamage1(level, value)
    checktype(level, 'integer', 'setBackstabDamage1', 1)
    checktype(value, 'float', 'setBackstabDamage1', 2)
    self.def:setLvlDataUnreal('Owk3', level, 3, value)
end

AbilityDefinitionSummonSeaElemental = class('AbilityDefinitionSummonSeaElemental', AbilityDefinition)
_G.AbilityDefinitionSummonSeaElemental = AbilityDefinitionSummonSeaElemental

function AbilityDefinitionSummonSeaElemental:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACwe')
end

function AbilityDefinitionSummonSeaElemental:setSummonedUnitCount(level, value)
    checktype(level, 'integer', 'setSummonedUnitCount', 1)
    checktype(value, 'integer', 'setSummonedUnitCount', 2)
    self.def:setLvlDataInt('Hwe2', level, 1, value)
end

function AbilityDefinitionSummonSeaElemental:setSummonedUnitType(level, value)
    checktype(level, 'integer', 'setSummonedUnitType', 1)
    checktype(value, 'string', 'setSummonedUnitType', 2)
    self.def:setLvlDataString('Hwe1', level, 0, value)
end

AbilityDefinitionWebcreep = class('AbilityDefinitionWebcreep', AbilityDefinition)
_G.AbilityDefinitionWebcreep = AbilityDefinitionWebcreep

function AbilityDefinitionWebcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACwb')
end

function AbilityDefinitionWebcreep:setAirUnitHeight(level, value)
    checktype(level, 'integer', 'setAirUnitHeight', 1)
    checktype(value, 'float', 'setAirUnitHeight', 2)
    self.def:setLvlDataUnreal('Ens2', level, 2, value)
end

function AbilityDefinitionWebcreep:setAirUnitLowerDuration(level, value)
    checktype(level, 'integer', 'setAirUnitLowerDuration', 1)
    checktype(value, 'float', 'setAirUnitLowerDuration', 2)
    self.def:setLvlDataUnreal('Ens1', level, 1, value)
end

function AbilityDefinitionWebcreep:setMeleeAttackRange(level, value)
    checktype(level, 'integer', 'setMeleeAttackRange', 1)
    checktype(value, 'float', 'setMeleeAttackRange', 2)
    self.def:setLvlDataUnreal('Ens3', level, 3, value)
end

AbilityDefinitionReturnGoldLumber = class('AbilityDefinitionReturnGoldLumber', AbilityDefinition)
_G.AbilityDefinitionReturnGoldLumber = AbilityDefinitionReturnGoldLumber

function AbilityDefinitionReturnGoldLumber:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Argl')
end

function AbilityDefinitionReturnGoldLumber:setAcceptsGold(level, value)
    checktype(level, 'integer', 'setAcceptsGold', 1)
    checktype(value, 'boolean', 'setAcceptsGold', 2)
    self.def:setLvlDataBoolean('Rtn1', level, 1, value)
end

function AbilityDefinitionReturnGoldLumber:setAcceptsLumber(level, value)
    checktype(level, 'integer', 'setAcceptsLumber', 1)
    checktype(value, 'boolean', 'setAcceptsLumber', 2)
    self.def:setLvlDataBoolean('Rtn2', level, 2, value)
end

AbilityDefinitionSelfDestruct3ClockwerkGoblins = class('AbilityDefinitionSelfDestruct3ClockwerkGoblins', AbilityDefinition)
_G.AbilityDefinitionSelfDestruct3ClockwerkGoblins = AbilityDefinitionSelfDestruct3ClockwerkGoblins

function AbilityDefinitionSelfDestruct3ClockwerkGoblins:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asd3')
end

function AbilityDefinitionSelfDestruct3ClockwerkGoblins:setExplodesonDeath(level, value)
    checktype(level, 'integer', 'setExplodesonDeath', 1)
    checktype(value, 'boolean', 'setExplodesonDeath', 2)
    self.def:setLvlDataBoolean('Sds6', level, 6, value)
end

AbilityDefinitionSelfDestruct2ClockwerkGoblins = class('AbilityDefinitionSelfDestruct2ClockwerkGoblins', AbilityDefinition)
_G.AbilityDefinitionSelfDestruct2ClockwerkGoblins = AbilityDefinitionSelfDestruct2ClockwerkGoblins

function AbilityDefinitionSelfDestruct2ClockwerkGoblins:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asd2')
end

function AbilityDefinitionSelfDestruct2ClockwerkGoblins:setExplodesonDeath(level, value)
    checktype(level, 'integer', 'setExplodesonDeath', 1)
    checktype(value, 'boolean', 'setExplodesonDeath', 2)
    self.def:setLvlDataBoolean('Sds6', level, 6, value)
end

AbilityDefinitionGraveyard = class('AbilityDefinitionGraveyard', AbilityDefinition)
_G.AbilityDefinitionGraveyard = AbilityDefinitionGraveyard

function AbilityDefinitionGraveyard:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Agyd')
end

function AbilityDefinitionGraveyard:setRadiusofCorpses(level, value)
    checktype(level, 'integer', 'setRadiusofCorpses', 1)
    checktype(value, 'float', 'setRadiusofCorpses', 2)
    self.def:setLvlDataUnreal('Gyd3', level, 3, value)
end

function AbilityDefinitionGraveyard:setMaximumNumberofCorpses(level, value)
    checktype(level, 'integer', 'setMaximumNumberofCorpses', 1)
    checktype(value, 'integer', 'setMaximumNumberofCorpses', 2)
    self.def:setLvlDataInt('Gyd1', level, 1, value)
end

function AbilityDefinitionGraveyard:setRadiusofGravestones(level, value)
    checktype(level, 'integer', 'setRadiusofGravestones', 1)
    checktype(value, 'float', 'setRadiusofGravestones', 2)
    self.def:setLvlDataUnreal('Gyd2', level, 2, value)
end

function AbilityDefinitionGraveyard:setCorpseUnitType(level, value)
    checktype(level, 'integer', 'setCorpseUnitType', 1)
    checktype(value, 'string', 'setCorpseUnitType', 2)
    self.def:setLvlDataString('Gydu', level, 0, value)
end

AbilityDefinitionWarStompcreep = class('AbilityDefinitionWarStompcreep', AbilityDefinition)
_G.AbilityDefinitionWarStompcreep = AbilityDefinitionWarStompcreep

function AbilityDefinitionWarStompcreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awrs')
end

function AbilityDefinitionWarStompcreep:setTerrainDeformationAmplitude(level, value)
    checktype(level, 'integer', 'setTerrainDeformationAmplitude', 1)
    checktype(value, 'float', 'setTerrainDeformationAmplitude', 2)
    self.def:setLvlDataUnreal('Wrs2', level, 2, value)
end

function AbilityDefinitionWarStompcreep:setTerrainDeformationDurationms(level, value)
    checktype(level, 'integer', 'setTerrainDeformationDurationms', 1)
    checktype(value, 'integer', 'setTerrainDeformationDurationms', 2)
    self.def:setLvlDataInt('Wrs3', level, 3, value)
end

function AbilityDefinitionWarStompcreep:setDamage(level, value)
    checktype(level, 'integer', 'setDamage', 1)
    checktype(value, 'float', 'setDamage', 2)
    self.def:setLvlDataUnreal('Wrs1', level, 1, value)
end

AbilityDefinitionWarp = class('AbilityDefinitionWarp', AbilityDefinition)
_G.AbilityDefinitionWarp = AbilityDefinitionWarp

function AbilityDefinitionWarp:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Awrp')
end

function AbilityDefinitionWarp:setTeleportAreaWidth(level, value)
    checktype(level, 'integer', 'setTeleportAreaWidth', 1)
    checktype(value, 'float', 'setTeleportAreaWidth', 2)
    self.def:setLvlDataUnreal('Wrp1', level, 1, value)
end

function AbilityDefinitionWarp:setTeleportAreaHeight(level, value)
    checktype(level, 'integer', 'setTeleportAreaHeight', 1)
    checktype(value, 'float', 'setTeleportAreaHeight', 2)
    self.def:setLvlDataUnreal('Wrp2', level, 2, value)
end

AbilityDefinitionVampiricAuracreep = class('AbilityDefinitionVampiricAuracreep', AbilityDefinition)
_G.AbilityDefinitionVampiricAuracreep = AbilityDefinitionVampiricAuracreep

function AbilityDefinitionVampiricAuracreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACvp')
end

function AbilityDefinitionVampiricAuracreep:setAttackDamageStolen(level, value)
    checktype(level, 'integer', 'setAttackDamageStolen', 1)
    checktype(value, 'float', 'setAttackDamageStolen', 2)
    self.def:setLvlDataUnreal('Uav1', level, 1, value)
end

AbilityDefinitionVenomSpearsCreep = class('AbilityDefinitionVenomSpearsCreep', AbilityDefinition)
_G.AbilityDefinitionVenomSpearsCreep = AbilityDefinitionVenomSpearsCreep

function AbilityDefinitionVenomSpearsCreep:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'ACvs')
end

function AbilityDefinitionVenomSpearsCreep:setAttackSpeedFactor(level, value)
    checktype(level, 'integer', 'setAttackSpeedFactor', 1)
    checktype(value, 'float', 'setAttackSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi2', level, 2, value)
end

function AbilityDefinitionVenomSpearsCreep:setStackingType(level, value)
    checktype(level, 'integer', 'setStackingType', 1)
    checktype(value, 'integer', 'setStackingType', 2)
    self.def:setLvlDataInt('Poi4', level, 4, value)
end

function AbilityDefinitionVenomSpearsCreep:setDamageperSecond(level, value)
    checktype(level, 'integer', 'setDamageperSecond', 1)
    checktype(value, 'float', 'setDamageperSecond', 2)
    self.def:setLvlDataUnreal('Poi1', level, 1, value)
end

function AbilityDefinitionVenomSpearsCreep:setMovementSpeedFactor(level, value)
    checktype(level, 'integer', 'setMovementSpeedFactor', 1)
    checktype(value, 'float', 'setMovementSpeedFactor', 2)
    self.def:setLvlDataUnreal('Poi3', level, 3, value)
end

AbilityDefinitionBurrowDetectionFlyers = class('AbilityDefinitionBurrowDetectionFlyers', AbilityDefinition)
_G.AbilityDefinitionBurrowDetectionFlyers = AbilityDefinitionBurrowDetectionFlyers

function AbilityDefinitionBurrowDetectionFlyers:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abdt')
end

function AbilityDefinitionBurrowDetectionFlyers:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionBlightDispelSmall = class('AbilityDefinitionBlightDispelSmall', AbilityDefinition)
_G.AbilityDefinitionBlightDispelSmall = AbilityDefinitionBlightDispelSmall

function AbilityDefinitionBlightDispelSmall:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abds')
end

function AbilityDefinitionBlightDispelSmall:setCreatesBlight(level, value)
    checktype(level, 'integer', 'setCreatesBlight', 1)
    checktype(value, 'boolean', 'setCreatesBlight', 2)
    self.def:setLvlDataBoolean('Bli2', level, 2, value)
end

function AbilityDefinitionBlightDispelSmall:setExpansionAmount(level, value)
    checktype(level, 'integer', 'setExpansionAmount', 1)
    checktype(value, 'float', 'setExpansionAmount', 2)
    self.def:setLvlDataUnreal('Bli1', level, 1, value)
end

AbilityDefinitionLiquidFire = class('AbilityDefinitionLiquidFire', AbilityDefinition)
_G.AbilityDefinitionLiquidFire = AbilityDefinitionLiquidFire

function AbilityDefinitionLiquidFire:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Aliq')
end

function AbilityDefinitionLiquidFire:setAttackSpeedReduction(level, value)
    checktype(level, 'integer', 'setAttackSpeedReduction', 1)
    checktype(value, 'float', 'setAttackSpeedReduction', 2)
    self.def:setLvlDataUnreal('liq3', level, 3, value)
end

function AbilityDefinitionLiquidFire:setMovementSpeedReduction(level, value)
    checktype(level, 'integer', 'setMovementSpeedReduction', 1)
    checktype(value, 'float', 'setMovementSpeedReduction', 2)
    self.def:setLvlDataUnreal('liq2', level, 2, value)
end

function AbilityDefinitionLiquidFire:setRepairsAllowed(level, value)
    checktype(level, 'integer', 'setRepairsAllowed', 1)
    checktype(value, 'boolean', 'setRepairsAllowed', 2)
    self.def:setLvlDataBoolean('liq4', level, 4, value)
end

function AbilityDefinitionLiquidFire:setExtraDamagePerSecond(level, value)
    checktype(level, 'integer', 'setExtraDamagePerSecond', 1)
    checktype(value, 'float', 'setExtraDamagePerSecond', 2)
    self.def:setLvlDataUnreal('liq1', level, 1, value)
end

AbilityDefinitionDetectGyrocopter = class('AbilityDefinitionDetectGyrocopter', AbilityDefinition)
_G.AbilityDefinitionDetectGyrocopter = AbilityDefinitionDetectGyrocopter

function AbilityDefinitionDetectGyrocopter:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Agyv')
end

function AbilityDefinitionDetectGyrocopter:setDetectionType(level, value)
    checktype(level, 'integer', 'setDetectionType', 1)
    checktype(value, 'string', 'setDetectionType', 2)
    self.def:setLvlDataString('Det1', level, 1, value)
end

AbilityDefinitionLightningAttack = class('AbilityDefinitionLightningAttack', AbilityDefinition)
_G.AbilityDefinitionLightningAttack = AbilityDefinitionLightningAttack

function AbilityDefinitionLightningAttack:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Alit')
end

function AbilityDefinitionLightningAttack:setGraphicDuration(level, value)
    checktype(level, 'integer', 'setGraphicDuration', 1)
    checktype(value, 'float', 'setGraphicDuration', 2)
    self.def:setLvlDataUnreal('Lit2', level, 2, value)
end

function AbilityDefinitionLightningAttack:setGraphicDelay(level, value)
    checktype(level, 'integer', 'setGraphicDelay', 1)
    checktype(value, 'float', 'setGraphicDelay', 2)
    self.def:setLvlDataUnreal('Lit1', level, 1, value)
end

AbilityDefinitionBlightDispelLarge = class('AbilityDefinitionBlightDispelLarge', AbilityDefinition)
_G.AbilityDefinitionBlightDispelLarge = AbilityDefinitionBlightDispelLarge

function AbilityDefinitionBlightDispelLarge:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Abdl')
end

function AbilityDefinitionBlightDispelLarge:setCreatesBlight(level, value)
    checktype(level, 'integer', 'setCreatesBlight', 1)
    checktype(value, 'boolean', 'setCreatesBlight', 2)
    self.def:setLvlDataBoolean('Bli2', level, 2, value)
end

function AbilityDefinitionBlightDispelLarge:setExpansionAmount(level, value)
    checktype(level, 'integer', 'setExpansionAmount', 1)
    checktype(value, 'float', 'setExpansionAmount', 2)
    self.def:setLvlDataUnreal('Bli1', level, 1, value)
end

AbilityDefinitionChaosCargoLoad = class('AbilityDefinitionChaosCargoLoad', AbilityDefinition)
_G.AbilityDefinitionChaosCargoLoad = AbilityDefinitionChaosCargoLoad

function AbilityDefinitionChaosCargoLoad:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Achl')
end

function AbilityDefinitionChaosCargoLoad:setUnitTypeAllowed(level, value)
    checktype(level, 'integer', 'setUnitTypeAllowed', 1)
    checktype(value, 'string', 'setUnitTypeAllowed', 2)
    self.def:setLvlDataString('Chl1', level, 0, value)
end

AbilityDefinitionSunderingBlades = class('AbilityDefinitionSunderingBlades', AbilityDefinition)
_G.AbilityDefinitionSunderingBlades = AbilityDefinitionSunderingBlades

function AbilityDefinitionSunderingBlades:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Ahsb')
end

function AbilityDefinitionSunderingBlades:setBonusDamageFlat(level, value)
    checktype(level, 'integer', 'setBonusDamageFlat', 1)
    checktype(value, 'float', 'setBonusDamageFlat', 2)
    self.def:setLvlDataUnreal('Hsb1', level, 1, value)
end

function AbilityDefinitionSunderingBlades:setBonusDamagePercent(level, value)
    checktype(level, 'integer', 'setBonusDamagePercent', 1)
    checktype(value, 'float', 'setBonusDamagePercent', 2)
    self.def:setLvlDataUnreal('Hsb2', level, 2, value)
end

function AbilityDefinitionSunderingBlades:setDefenseTypeAffected(level, types)
    checktype(level, 'integer', 'setDefenseTypeAffected', 1)
    checktype(types, 'integer', 'setDefenseTypeAffected', 2)
    self.def:setLvlDataInt('Hsb3', level, 3, types)
end

AbilityDefinitionOrb = class('AbilityDefinitionOrb', AbilityDefinition)
_G.AbilityDefinitionOrb = AbilityDefinitionOrb

function AbilityDefinitionOrb:constructor(id)
    self.def = createDefinition(DefinitionType.Ability, id, 'Asph')
end
