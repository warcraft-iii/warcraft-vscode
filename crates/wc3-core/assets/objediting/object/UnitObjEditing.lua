W3UDefinition = class('W3UDefinition')
_G.W3UDefinition = W3UDefinition

function W3UDefinition:constructor(id, superId)
    self.def = createDefinition(DefinitionType.Unit, id, superId)
end

function W3UDefinition:setTooltipExtended(data)
    checktype(data, 'string', 'setTooltipExtended', 1)
    self.def:setString('utub', data)
end

function W3UDefinition:setTooltipBasic(data)
    checktype(data, 'string', 'setTooltipBasic', 1)
    self.def:setString('utip', data)
end

function W3UDefinition:setRequirementsLevels(data)
    checktype(data, 'string', 'setRequirementsLevels', 1)
    self.def:setString('urqa', data)
end

function W3UDefinition:setRequirements(data)
    checktype(data, 'string', 'setRequirements', 1)
    self.def:setString('ureq', data)
end

function W3UDefinition:setName(data)
    checktype(data, 'string', 'setName', 1)
    self.def:setString('unam', data)
end

function W3UDefinition:setHotkey(data)
    checktype(data, 'string', 'setHotkey', 1)
    self.def:setString('uhot', data)
end

function W3UDefinition:setDescription(data)
    checktype(data, 'string', 'setDescription', 1)
    self.def:setString('ides', data)
end

function W3UDefinition:setButtonPositionY(data)
    checktype(data, 'integer', 'setButtonPositionY', 1)
    self.def:setInt('ubpy', data)
end

function W3UDefinition:setButtonPositionX(data)
    checktype(data, 'integer', 'setButtonPositionX', 1)
    self.def:setInt('ubpx', data)
end

UnitOrBuildingOrHeroDefinition = class('UnitOrBuildingOrHeroDefinition', W3UDefinition)
_G.UnitOrBuildingOrHeroDefinition = UnitOrBuildingOrHeroDefinition

function UnitOrBuildingOrHeroDefinition:setItemsSold(data)
    checktype(data, 'string', 'setItemsSold', 1)
    self.def:setString('usei', data)
end

function UnitOrBuildingOrHeroDefinition:setUnitsSold(data)
    checktype(data, 'string', 'setUnitsSold', 1)
    self.def:setString('useu', data)
end

function UnitOrBuildingOrHeroDefinition:setHideMinimapDisplay(flag)
    checktype(flag, 'boolean', 'setHideMinimapDisplay', 1)
    self.def:setBoolean('uhom', flag)
end

function UnitOrBuildingOrHeroDefinition:setUseExtendedLineofSight(data)
    checktype(data, 'boolean', 'setUseExtendedLineofSight', 1)
    self.def:setBoolean('ulos', data)
end

function UnitOrBuildingOrHeroDefinition:setUseClickHelper(data)
    checktype(data, 'boolean', 'setUseClickHelper', 1)
    self.def:setBoolean('uuch', data)
end

function UnitOrBuildingOrHeroDefinition:setUpgradesUsed(data)
    checktype(data, 'string', 'setUpgradesUsed', 1)
    self.def:setString('upgr', data)
end

function UnitOrBuildingOrHeroDefinition:setUnitSoundSet(data)
    checktype(data, 'string', 'setUnitSoundSet', 1)
    self.def:setString('usnd', data)
end

function UnitOrBuildingOrHeroDefinition:setUnitClassification(data)
    checktype(data, 'string', 'setUnitClassification', 1)
    self.def:setString('utyp', data)
end

function UnitOrBuildingOrHeroDefinition:setMovementType(mtype)
    checkenum(mtype, 'MovementType', 'setMovementType', 1)
    self.def:setString('umvt', mtype)
end

function UnitOrBuildingOrHeroDefinition:setTurnRate(data)
    checktype(data, 'float', 'setTurnRate', 1)
    self.def:setUnreal('umvr', data)
end

function UnitOrBuildingOrHeroDefinition:setTintingColorBlue(data)
    checktype(data, 'integer', 'setTintingColorBlue', 1)
    self.def:setInt('uclb', data)
end

function UnitOrBuildingOrHeroDefinition:setTintingColorGreen(data)
    checktype(data, 'integer', 'setTintingColorGreen', 1)
    self.def:setInt('uclg', data)
end

function UnitOrBuildingOrHeroDefinition:setTintingColorRed(data)
    checktype(data, 'integer', 'setTintingColorRed', 1)
    self.def:setInt('uclr', data)
end

function UnitOrBuildingOrHeroDefinition:setTilesets(data)
    checktype(data, 'string', 'setTilesets', 1)
    self.def:setString('util', data)
end

function UnitOrBuildingOrHeroDefinition:setTeamColor(data)
    checktype(data, 'integer', 'setTeamColor', 1)
    self.def:setInt('utco', data)
end

function UnitOrBuildingOrHeroDefinition:setTargetedAs(data)
    checktype(data, 'string', 'setTargetedAs', 1)
    self.def:setString('utar', data)
end

function UnitOrBuildingOrHeroDefinition:setTarget(data)
    checktype(data, 'string', 'setTarget', 1)
    self.def:setString('utaa', data)
end

function UnitOrBuildingOrHeroDefinition:setArtTarget(data)
    checktype(data, 'string', 'setArtTarget', 1)
    self.def:setString('utaa', data)
end

function UnitOrBuildingOrHeroDefinition:setStockStartDelay(data)
    checktype(data, 'integer', 'setStockStartDelay', 1)
    self.def:setInt('usst', data)
end

function UnitOrBuildingOrHeroDefinition:setStockReplenishInterval(data)
    checktype(data, 'integer', 'setStockReplenishInterval', 1)
    self.def:setInt('usrg', data)
end

function UnitOrBuildingOrHeroDefinition:setStockMaximum(data)
    checktype(data, 'integer', 'setStockMaximum', 1)
    self.def:setInt('usma', data)
end

function UnitOrBuildingOrHeroDefinition:setSpeedMinimum(data)
    checktype(data, 'integer', 'setSpeedMinimum', 1)
    self.def:setInt('umis', data)
end

function UnitOrBuildingOrHeroDefinition:setSpeedMaximum(data)
    checktype(data, 'integer', 'setSpeedMaximum', 1)
    self.def:setInt('umas', data)
end

function UnitOrBuildingOrHeroDefinition:setSpeedBase(data)
    checktype(data, 'integer', 'setSpeedBase', 1)
    self.def:setInt('umvs', data)
end

function UnitOrBuildingOrHeroDefinition:setSpecial(data)
    checktype(data, 'string', 'setSpecial', 1)
    self.def:setString('uspa', data)
end

function UnitOrBuildingOrHeroDefinition:setArtSpecial(data)
    checktype(data, 'string', 'setArtSpecial', 1)
    self.def:setString('uspa', data)
end

function UnitOrBuildingOrHeroDefinition:setSleeps(data)
    checktype(data, 'boolean', 'setSleeps', 1)
    self.def:setBoolean('usle', data)
end

function UnitOrBuildingOrHeroDefinition:setSightRadiusNight(data)
    checktype(data, 'integer', 'setSightRadiusNight', 1)
    self.def:setInt('usin', data)
end

function UnitOrBuildingOrHeroDefinition:setSightRadiusDay(data)
    checktype(data, 'integer', 'setSightRadiusDay', 1)
    self.def:setInt('usid', data)
end

function UnitOrBuildingOrHeroDefinition:setShadowTextureBuilding(data)
    checktype(data, 'string', 'setShadowTextureBuilding', 1)
    self.def:setString('ushb', data)
end

function UnitOrBuildingOrHeroDefinition:setShadowImageWidth(data)
    checktype(data, 'float', 'setShadowImageWidth', 1)
    self.def:setReal('ushw', data)
end

function UnitOrBuildingOrHeroDefinition:setShadowImageUnit(data)
    checktype(data, 'string', 'setShadowImageUnit', 1)
    self.def:setString('ushu', data)
end

function UnitOrBuildingOrHeroDefinition:setShadowImageHeight(data)
    checktype(data, 'float', 'setShadowImageHeight', 1)
    self.def:setReal('ushh', data)
end

function UnitOrBuildingOrHeroDefinition:setShadowImageCenterY(data)
    checktype(data, 'float', 'setShadowImageCenterY', 1)
    self.def:setReal('ushy', data)
end

function UnitOrBuildingOrHeroDefinition:setShadowImageCenterX(data)
    checktype(data, 'float', 'setShadowImageCenterX', 1)
    self.def:setReal('ushx', data)
end

function UnitOrBuildingOrHeroDefinition:setSelectionScale(data)
    checktype(data, 'float', 'setSelectionScale', 1)
    self.def:setReal('ussc', data)
end

function UnitOrBuildingOrHeroDefinition:setSelectionCircleOnWater(data)
    checktype(data, 'boolean', 'setSelectionCircleOnWater', 1)
    self.def:setBoolean('usew', data)
end

function UnitOrBuildingOrHeroDefinition:setSelectionCircleHeight(data)
    checktype(data, 'float', 'setSelectionCircleHeight', 1)
    self.def:setReal('uslz', data)
end

function UnitOrBuildingOrHeroDefinition:setScalingValue(data)
    checktype(data, 'float', 'setScalingValue', 1)
    self.def:setReal('usca', data)
end

function UnitOrBuildingOrHeroDefinition:setScaleProjectiles(data)
    checktype(data, 'boolean', 'setScaleProjectiles', 1)
    self.def:setBoolean('uscb', data)
end

function UnitOrBuildingOrHeroDefinition:setRequiredBoneNames(data)
    checktype(data, 'string', 'setRequiredBoneNames', 1)
    self.def:setString('ubpr', data)
end

function UnitOrBuildingOrHeroDefinition:setRequiredAttachmentLinkNames(data)
    checktype(data, 'string', 'setRequiredAttachmentLinkNames', 1)
    self.def:setString('ualp', data)
end

function UnitOrBuildingOrHeroDefinition:setRequiredAnimationNamesAttachments(data)
    checktype(data, 'string', 'setRequiredAnimationNamesAttachments', 1)
    self.def:setString('uaap', data)
end

function UnitOrBuildingOrHeroDefinition:setRequiredAnimationNames(data)
    checktype(data, 'string', 'setRequiredAnimationNames', 1)
    self.def:setString('uani', data)
end

function UnitOrBuildingOrHeroDefinition:setRepairTime(data)
    checktype(data, 'integer', 'setRepairTime', 1)
    self.def:setInt('urtm', data)
end

function UnitOrBuildingOrHeroDefinition:setRepairLumberCost(data)
    checktype(data, 'integer', 'setRepairLumberCost', 1)
    self.def:setInt('ulur', data)
end

function UnitOrBuildingOrHeroDefinition:setRepairGoldCost(data)
    checktype(data, 'integer', 'setRepairGoldCost', 1)
    self.def:setInt('ugor', data)
end

function UnitOrBuildingOrHeroDefinition:setRandomSound(data)
    checktype(data, 'string', 'setRandomSound', 1)
    self.def:setString('ursl', data)
end

function UnitOrBuildingOrHeroDefinition:setRace(data)
    checkenum(data, 'Race', 'setRace', 1)
    self.def:setString('urac', data)
end

function UnitOrBuildingOrHeroDefinition:setPropulsionWindowdegrees(data)
    checktype(data, 'float', 'setPropulsionWindowdegrees', 1)
    self.def:setUnreal('uprw', data)
end

function UnitOrBuildingOrHeroDefinition:setProjectileLaunchZSwimming(data)
    checktype(data, 'float', 'setProjectileLaunchZSwimming', 1)
    self.def:setUnreal('ulsz', data)
end

function UnitOrBuildingOrHeroDefinition:setProjectileLaunchZ(data)
    checktype(data, 'float', 'setProjectileLaunchZ', 1)
    self.def:setUnreal('ulpz', data)
end

function UnitOrBuildingOrHeroDefinition:setProjectileLaunchY(data)
    checktype(data, 'float', 'setProjectileLaunchY', 1)
    self.def:setUnreal('ulpy', data)
end

function UnitOrBuildingOrHeroDefinition:setProjectileLaunchX(data)
    checktype(data, 'float', 'setProjectileLaunchX', 1)
    self.def:setUnreal('ulpx', data)
end

function UnitOrBuildingOrHeroDefinition:setProjectileImpactZSwimming(data)
    checktype(data, 'float', 'setProjectileImpactZSwimming', 1)
    self.def:setUnreal('uisz', data)
end

function UnitOrBuildingOrHeroDefinition:setProjectileImpactZ(data)
    checktype(data, 'float', 'setProjectileImpactZ', 1)
    self.def:setUnreal('uimz', data)
end

function UnitOrBuildingOrHeroDefinition:setPriority(data)
    checktype(data, 'integer', 'setPriority', 1)
    self.def:setInt('upri', data)
end

function UnitOrBuildingOrHeroDefinition:setPointValue(data)
    checktype(data, 'integer', 'setPointValue', 1)
    self.def:setInt('upoi', data)
end

function UnitOrBuildingOrHeroDefinition:setPlaceableInEditor(data)
    checktype(data, 'boolean', 'setPlaceableInEditor', 1)
    self.def:setBoolean('uine', data)
end

function UnitOrBuildingOrHeroDefinition:setOrientationInterpolation(data)
    checktype(data, 'integer', 'setOrientationInterpolation', 1)
    self.def:setInt('uori', data)
end

function UnitOrBuildingOrHeroDefinition:setOccluderHeight(data)
    checktype(data, 'float', 'setOccluderHeight', 1)
    self.def:setUnreal('uocc', data)
end

function UnitOrBuildingOrHeroDefinition:setNormalAbilities(data)
    checktype(data, 'string', 'setNormalAbilities', 1)
    self.def:setString('uabi', data)
end

function UnitOrBuildingOrHeroDefinition:setNameEditorSuffix(data)
    checktype(data, 'string', 'setNameEditorSuffix', 1)
    self.def:setString('unsf', data)
end

function UnitOrBuildingOrHeroDefinition:setMovementSound(data)
    checktype(data, 'string', 'setMovementSound', 1)
    self.def:setString('umsl', data)
end

function UnitOrBuildingOrHeroDefinition:setModelFileExtraVersions(data)
    checktype(data, 'string', 'setModelFileExtraVersions', 1)
    self.def:setString('uver', data)
end

function UnitOrBuildingOrHeroDefinition:setModelFile(data)
    checktype(data, 'string', 'setModelFile', 1)
    self.def:setString('umdl', data)
end

function UnitOrBuildingOrHeroDefinition:setMinimumAttackRange(data)
    checktype(data, 'integer', 'setMinimumAttackRange', 1)
    self.def:setInt('uamn', data)
end

function UnitOrBuildingOrHeroDefinition:setMaximumRollAngledegrees(data)
    checktype(data, 'float', 'setMaximumRollAngledegrees', 1)
    self.def:setReal('umxr', data)
end

function UnitOrBuildingOrHeroDefinition:setMaximumPitchAngledegrees(data)
    checktype(data, 'float', 'setMaximumPitchAngledegrees', 1)
    self.def:setReal('umxp', data)
end

function UnitOrBuildingOrHeroDefinition:setManaRegeneration(data)
    checktype(data, 'float', 'setManaRegeneration', 1)
    self.def:setUnreal('umpr', data)
end

function UnitOrBuildingOrHeroDefinition:setManaMaximum(data)
    checktype(data, 'integer', 'setManaMaximum', 1)
    self.def:setInt('umpm', data)
end

function UnitOrBuildingOrHeroDefinition:setManaInitialAmount(data)
    checktype(data, 'integer', 'setManaInitialAmount', 1)
    self.def:setInt('umpi', data)
end

function UnitOrBuildingOrHeroDefinition:setLumberCost(data)
    checktype(data, 'integer', 'setLumberCost', 1)
    self.def:setInt('ulum', data)
end

function UnitOrBuildingOrHeroDefinition:setSoundLoopingFadeOutRate(data)
    checktype(data, 'integer', 'setSoundLoopingFadeOutRate', 1)
    self.def:setInt('ulfo', data)
end

function UnitOrBuildingOrHeroDefinition:setSoundLoopingFadeInRate(data)
    checktype(data, 'integer', 'setSoundLoopingFadeInRate', 1)
    self.def:setInt('ulfi', data)
end

function UnitOrBuildingOrHeroDefinition:setIsaBuilding(data)
    checktype(data, 'boolean', 'setIsaBuilding', 1)
    self.def:setBoolean('ubdg', data)
end

function UnitOrBuildingOrHeroDefinition:setIconScoreScreen(data)
    checktype(data, 'string', 'setIconScoreScreen', 1)
    self.def:setString('ussi', data)
end

function UnitOrBuildingOrHeroDefinition:setIconGameInterface(data)
    checktype(data, 'string', 'setIconGameInterface', 1)
    self.def:setString('uico', data)
end

function UnitOrBuildingOrHeroDefinition:setHitPointsRegenerationType(data)
    checktype(data, 'string', 'setHitPointsRegenerationType', 1)
    self.def:setString('uhrt', data)
end

function UnitOrBuildingOrHeroDefinition:setHitPointsRegenerationRate(data)
    checktype(data, 'float', 'setHitPointsRegenerationRate', 1)
    self.def:setUnreal('uhpr', data)
end

function UnitOrBuildingOrHeroDefinition:setHitPointsMaximumBase(data)
    checktype(data, 'integer', 'setHitPointsMaximumBase', 1)
    self.def:setInt('uhpm', data)
end

function UnitOrBuildingOrHeroDefinition:setMovementHeightMinimum(data)
    checktype(data, 'float', 'setMovementHeightMinimum', 1)
    self.def:setUnreal('umvf', data)
end

function UnitOrBuildingOrHeroDefinition:setMovementHeight(data)
    checktype(data, 'float', 'setMovementHeight', 1)
    self.def:setUnreal('umvh', data)
end

function UnitOrBuildingOrHeroDefinition:setHasWaterShadow(data)
    checktype(data, 'boolean', 'setHasWaterShadow', 1)
    self.def:setBoolean('ushr', data)
end

function UnitOrBuildingOrHeroDefinition:setHasTilesetSpecificData(data)
    checktype(data, 'boolean', 'setHasTilesetSpecificData', 1)
    self.def:setBoolean('utss', data)
end

function UnitOrBuildingOrHeroDefinition:setGoldCost(data)
    checktype(data, 'integer', 'setGoldCost', 1)
    self.def:setInt('ugol', data)
end

function UnitOrBuildingOrHeroDefinition:setGoldBountyAwardedSidesperDie(data)
    checktype(data, 'integer', 'setGoldBountyAwardedSidesperDie', 1)
    self.def:setInt('ubsi', data)
end

function UnitOrBuildingOrHeroDefinition:setGoldBountyAwardedNumberofDice(data)
    checktype(data, 'integer', 'setGoldBountyAwardedNumberofDice', 1)
    self.def:setInt('ubdi', data)
end

function UnitOrBuildingOrHeroDefinition:setGoldBountyAwardedBase(data)
    checktype(data, 'integer', 'setGoldBountyAwardedBase', 1)
    self.def:setInt('ubba', data)
end

function UnitOrBuildingOrHeroDefinition:setLumberBountyAwardedSidesperDie(data)
    checktype(data, 'integer', 'setLumberBountyAwardedSidesperDie', 1)
    self.def:setInt('ulbs', data)
end

function UnitOrBuildingOrHeroDefinition:setLumberBountyAwardedNumberofDice(data)
    checktype(data, 'integer', 'setLumberBountyAwardedNumberofDice', 1)
    self.def:setInt('ulbd', data)
end

function UnitOrBuildingOrHeroDefinition:setLumberBountyAwardedBase(data)
    checktype(data, 'integer', 'setLumberBountyAwardedBase', 1)
    self.def:setInt('ulba', data)
end

function UnitOrBuildingOrHeroDefinition:setFoodProduced(data)
    checktype(data, 'integer', 'setFoodProduced', 1)
    self.def:setInt('ufma', data)
end

function UnitOrBuildingOrHeroDefinition:setFoodCost(data)
    checktype(data, 'integer', 'setFoodCost', 1)
    self.def:setInt('ufoo', data)
end

function UnitOrBuildingOrHeroDefinition:setFogOfWarSampleRadius(data)
    checktype(data, 'float', 'setFogOfWarSampleRadius', 1)
    self.def:setReal('ufrd', data)
end

function UnitOrBuildingOrHeroDefinition:setElevationSampleRadius(data)
    checktype(data, 'float', 'setElevationSampleRadius', 1)
    self.def:setReal('uerd', data)
end

function UnitOrBuildingOrHeroDefinition:setElevationSamplePoints(data)
    checktype(data, 'integer', 'setElevationSamplePoints', 1)
    self.def:setInt('uept', data)
end

function UnitOrBuildingOrHeroDefinition:setDisplayasNeutralHostile(data)
    checktype(data, 'boolean', 'setDisplayasNeutralHostile', 1)
    self.def:setBoolean('uhos', data)
end

function UnitOrBuildingOrHeroDefinition:setDependencyEquivalents(data)
    checktype(data, 'string', 'setDependencyEquivalents', 1)
    self.def:setString('udep', data)
end

function UnitOrBuildingOrHeroDefinition:setDefenseUpgradeBonus(data)
    checktype(data, 'integer', 'setDefenseUpgradeBonus', 1)
    self.def:setInt('udup', data)
end

function UnitOrBuildingOrHeroDefinition:setArmorType(data)
    checkenum(data, 'ArmorType', 'setArmorType', 1)
    self.def:setString('udty', data)
end

function UnitOrBuildingOrHeroDefinition:setDefenseBase(data)
    checktype(data, 'integer', 'setDefenseBase', 1)
    self.def:setInt('udef', data)
end

function UnitOrBuildingOrHeroDefinition:setDefaultActiveAbility(data)
    checktype(data, 'string', 'setDefaultActiveAbility', 1)
    self.def:setString('udaa', data)
end

function UnitOrBuildingOrHeroDefinition:setDeathType(data)
    checktype(data, 'integer', 'setDeathType', 1)
    self.def:setInt('udea', data)
end

function UnitOrBuildingOrHeroDefinition:setDeathTimeseconds(data)
    checktype(data, 'float', 'setDeathTimeseconds', 1)
    self.def:setUnreal('udtm', data)
end

function UnitOrBuildingOrHeroDefinition:setCollisionSize(data)
    checktype(data, 'float', 'setCollisionSize', 1)
    self.def:setUnreal('ucol', data)
end

function UnitOrBuildingOrHeroDefinition:setCategorizationSpecial(data)
    checktype(data, 'boolean', 'setCategorizationSpecial', 1)
    self.def:setBoolean('uspe', data)
end

function UnitOrBuildingOrHeroDefinition:setCategorizationCampaign(data)
    checktype(data, 'boolean', 'setCategorizationCampaign', 1)
    self.def:setBoolean('ucam', data)
end

function UnitOrBuildingOrHeroDefinition:setCanFlee(data)
    checktype(data, 'boolean', 'setCanFlee', 1)
    self.def:setBoolean('ufle', data)
end

function UnitOrBuildingOrHeroDefinition:setCanDropItemsOnDeath(data)
    checktype(data, 'boolean', 'setCanDropItemsOnDeath', 1)
    self.def:setBoolean('udro', data)
end

function UnitOrBuildingOrHeroDefinition:setBuildTime(data)
    checktype(data, 'integer', 'setBuildTime', 1)
    self.def:setInt('ubld', data)
end

function UnitOrBuildingOrHeroDefinition:setAttacksEnabled(data)
    checktype(data, 'integer', 'setAttacksEnabled', 1)
    self.def:setInt('uaen', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2WeaponType(wepType)
    checkenum(wepType, 'WeaponType', 'setAttack2WeaponType', 1)
    self.def:setString('ua2w', wepType)
end

function UnitOrBuildingOrHeroDefinition:setAttack2WeaponSound(data)
    checkenum(data, 'WeaponSound', 'setAttack2WeaponSound', 1)
    self.def:setString('ucs2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2TargetsAllowed(data)
    checktype(data, 'string', 'setAttack2TargetsAllowed', 1)
    self.def:setString('ua2g', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2ShowUI(data)
    checktype(data, 'boolean', 'setAttack2ShowUI', 1)
    self.def:setBoolean('uwu2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2RangeMotionBuffer(data)
    checktype(data, 'float', 'setAttack2RangeMotionBuffer', 1)
    self.def:setUnreal('urb2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2Range(data)
    checktype(data, 'integer', 'setAttack2Range', 1)
    self.def:setInt('ua2r', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2ProjectileSpeed(data)
    checktype(data, 'integer', 'setAttack2ProjectileSpeed', 1)
    self.def:setInt('ua2z', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2ProjectileHomingEnabled(data)
    checktype(data, 'boolean', 'setAttack2ProjectileHomingEnabled', 1)
    self.def:setBoolean('umh2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2ProjectileArt(data)
    checktype(data, 'string', 'setAttack2ProjectileArt', 1)
    self.def:setString('ua2m', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2ProjectileArc(data)
    checktype(data, 'float', 'setAttack2ProjectileArc', 1)
    self.def:setUnreal('uma2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2MaximumNumberofTargets(data)
    checktype(data, 'integer', 'setAttack2MaximumNumberofTargets', 1)
    self.def:setInt('utc2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageUpgradeAmount(data)
    checktype(data, 'integer', 'setAttack2DamageUpgradeAmount', 1)
    self.def:setInt('udu2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageSpillRadius(data)
    checktype(data, 'float', 'setAttack2DamageSpillRadius', 1)
    self.def:setUnreal('usr2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageSpillDistance(data)
    checktype(data, 'float', 'setAttack2DamageSpillDistance', 1)
    self.def:setUnreal('usd2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageSidesperDie(data)
    checktype(data, 'integer', 'setAttack2DamageSidesperDie', 1)
    self.def:setInt('ua2s', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageNumberofDice(data)
    checktype(data, 'integer', 'setAttack2DamageNumberofDice', 1)
    self.def:setInt('ua2d', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageLossFactor(data)
    checktype(data, 'float', 'setAttack2DamageLossFactor', 1)
    self.def:setUnreal('udl2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageFactorSmall(data)
    checktype(data, 'float', 'setAttack2DamageFactorSmall', 1)
    self.def:setUnreal('uqd2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageFactorMedium(data)
    checktype(data, 'float', 'setAttack2DamageFactorMedium', 1)
    self.def:setUnreal('uhd2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2DamageBase(data)
    checktype(data, 'integer', 'setAttack2DamageBase', 1)
    self.def:setInt('ua2b', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2CooldownTime(data)
    checktype(data, 'float', 'setAttack2CooldownTime', 1)
    self.def:setUnreal('ua2c', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2AttackType(data)
    checkenum(data, 'AttackType', 'setAttack2AttackType', 1)
    self.def:setString('ua2t', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2AreaofEffectTargets(data)
    checktype(data, 'string', 'setAttack2AreaofEffectTargets', 1)
    self.def:setString('ua2p', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2AreaofEffectSmallDamage(data)
    checktype(data, 'integer', 'setAttack2AreaofEffectSmallDamage', 1)
    self.def:setInt('ua2q', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2AreaofEffectMediumDamage(data)
    checktype(data, 'integer', 'setAttack2AreaofEffectMediumDamage', 1)
    self.def:setInt('ua2h', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2AreaofEffectFullDamage(data)
    checktype(data, 'integer', 'setAttack2AreaofEffectFullDamage', 1)
    self.def:setInt('ua2f', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2AnimationDamagePoint(data)
    checktype(data, 'float', 'setAttack2AnimationDamagePoint', 1)
    self.def:setUnreal('udp2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack2AnimationBackswingPoint(data)
    checktype(data, 'float', 'setAttack2AnimationBackswingPoint', 1)
    self.def:setUnreal('ubs2', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1WeaponType(weaponType)
    checkenum(weaponType, 'WeaponType', 'setAttack1WeaponType', 1)
    self.def:setString('ua1w', weaponType)
end

function UnitOrBuildingOrHeroDefinition:setAttack1WeaponSound(data)
    checkenum(data, 'WeaponSound', 'setAttack1WeaponSound', 1)
    self.def:setString('ucs1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1TargetsAllowed(data)
    checktype(data, 'string', 'setAttack1TargetsAllowed', 1)
    self.def:setString('ua1g', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1ShowUI(data)
    checktype(data, 'boolean', 'setAttack1ShowUI', 1)
    self.def:setBoolean('uwu1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1RangeMotionBuffer(data)
    checktype(data, 'float', 'setAttack1RangeMotionBuffer', 1)
    self.def:setUnreal('urb1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1Range(data)
    checktype(data, 'integer', 'setAttack1Range', 1)
    self.def:setInt('ua1r', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1ProjectileSpeed(data)
    checktype(data, 'integer', 'setAttack1ProjectileSpeed', 1)
    self.def:setInt('ua1z', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1ProjectileHomingEnabled(data)
    checktype(data, 'boolean', 'setAttack1ProjectileHomingEnabled', 1)
    self.def:setBoolean('umh1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1ProjectileArt(data)
    checktype(data, 'string', 'setAttack1ProjectileArt', 1)
    self.def:setString('ua1m', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1ProjectileArc(data)
    checktype(data, 'float', 'setAttack1ProjectileArc', 1)
    self.def:setUnreal('uma1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1MaximumNumberofTargets(data)
    checktype(data, 'integer', 'setAttack1MaximumNumberofTargets', 1)
    self.def:setInt('utc1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageUpgradeAmount(data)
    checktype(data, 'integer', 'setAttack1DamageUpgradeAmount', 1)
    self.def:setInt('udu1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageSpillRadius(data)
    checktype(data, 'float', 'setAttack1DamageSpillRadius', 1)
    self.def:setUnreal('usr1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageSpillDistance(data)
    checktype(data, 'float', 'setAttack1DamageSpillDistance', 1)
    self.def:setUnreal('usd1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageSidesperDie(data)
    checktype(data, 'integer', 'setAttack1DamageSidesperDie', 1)
    self.def:setInt('ua1s', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageNumberofDice(data)
    checktype(data, 'integer', 'setAttack1DamageNumberofDice', 1)
    self.def:setInt('ua1d', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageLossFactor(data)
    checktype(data, 'float', 'setAttack1DamageLossFactor', 1)
    self.def:setUnreal('udl1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageFactorSmall(data)
    checktype(data, 'float', 'setAttack1DamageFactorSmall', 1)
    self.def:setUnreal('uqd1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageFactorMedium(data)
    checktype(data, 'float', 'setAttack1DamageFactorMedium', 1)
    self.def:setUnreal('uhd1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1DamageBase(data)
    checktype(data, 'integer', 'setAttack1DamageBase', 1)
    self.def:setInt('ua1b', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1CooldownTime(data)
    checktype(data, 'float', 'setAttack1CooldownTime', 1)
    self.def:setUnreal('ua1c', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1AttackType(data)
    checkenum(data, 'AttackType', 'setAttack1AttackType', 1)
    self.def:setString('ua1t', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1AreaofEffectTargets(data)
    checktype(data, 'string', 'setAttack1AreaofEffectTargets', 1)
    self.def:setString('ua1p', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1AreaofEffectSmallDamage(data)
    checktype(data, 'integer', 'setAttack1AreaofEffectSmallDamage', 1)
    self.def:setInt('ua1q', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1AreaofEffectMediumDamage(data)
    checktype(data, 'integer', 'setAttack1AreaofEffectMediumDamage', 1)
    self.def:setInt('ua1h', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1AreaofEffectFullDamage(data)
    checktype(data, 'integer', 'setAttack1AreaofEffectFullDamage', 1)
    self.def:setInt('ua1f', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1AnimationDamagePoint(data)
    checktype(data, 'float', 'setAttack1AnimationDamagePoint', 1)
    self.def:setUnreal('udp1', data)
end

function UnitOrBuildingOrHeroDefinition:setAttack1AnimationBackswingPoint(data)
    checktype(data, 'float', 'setAttack1AnimationBackswingPoint', 1)
    self.def:setUnreal('ubs1', data)
end

function UnitOrBuildingOrHeroDefinition:setArmorSoundType(data)
    checkenum(data, 'ArmorSoundType', 'setArmorSoundType', 1)
    self.def:setString('uarm', data)
end

function UnitOrBuildingOrHeroDefinition:setAnimationWalkSpeed(data)
    checktype(data, 'float', 'setAnimationWalkSpeed', 1)
    self.def:setReal('uwal', data)
end

function UnitOrBuildingOrHeroDefinition:setAnimationRunSpeed(data)
    checktype(data, 'float', 'setAnimationRunSpeed', 1)
    self.def:setReal('urun', data)
end

function UnitOrBuildingOrHeroDefinition:setAnimationCastPoint(data)
    checktype(data, 'float', 'setAnimationCastPoint', 1)
    self.def:setUnreal('ucpt', data)
end

function UnitOrBuildingOrHeroDefinition:setAnimationCastBackswing(data)
    checktype(data, 'float', 'setAnimationCastBackswing', 1)
    self.def:setUnreal('ucbs', data)
end

function UnitOrBuildingOrHeroDefinition:setAnimationBlendTimeseconds(data)
    checktype(data, 'float', 'setAnimationBlendTimeseconds', 1)
    self.def:setReal('uble', data)
end

function UnitOrBuildingOrHeroDefinition:setAllowCustomTeamColor(data)
    checktype(data, 'boolean', 'setAllowCustomTeamColor', 1)
    self.def:setBoolean('utcc', data)
end

function UnitOrBuildingOrHeroDefinition:setAIPlacementType(data)
    checktype(data, 'string', 'setAIPlacementType', 1)
    self.def:setString('uabt', data)
end

function UnitOrBuildingOrHeroDefinition:setAIPlacementRadius(data)
    checktype(data, 'float', 'setAIPlacementRadius', 1)
    self.def:setUnreal('uabr', data)
end

function UnitOrBuildingOrHeroDefinition:setAcquisitionRange(data)
    checktype(data, 'float', 'setAcquisitionRange', 1)
    self.def:setUnreal('uacq', data)
end

function UnitOrBuildingOrHeroDefinition:setStructuresBuilt(data)
    checktype(data, 'string', 'setStructuresBuilt', 1)
    self.def:setString('ubui', data)
end

UnitOrHeroDefinition = class('UnitOrHeroDefinition', UnitOrBuildingOrHeroDefinition)
_G.UnitOrHeroDefinition = UnitOrHeroDefinition

function UnitOrHeroDefinition:setTransportedSize(data)
    checktype(data, 'integer', 'setTransportedSize', 1)
    self.def:setInt('ucar', data)
end

function UnitOrHeroDefinition:setLevel(data)
    checktype(data, 'integer', 'setLevel', 1)
    self.def:setInt('ulev', data)
end

function UnitOrHeroDefinition:setGroupSeparationPriority(data)
    checktype(data, 'integer', 'setGroupSeparationPriority', 1)
    self.def:setInt('urpr', data)
end

function UnitOrHeroDefinition:setGroupSeparationParameter(data)
    checktype(data, 'integer', 'setGroupSeparationParameter', 1)
    self.def:setInt('urpp', data)
end

function UnitOrHeroDefinition:setGroupSeparationGroupNumber(data)
    checktype(data, 'integer', 'setGroupSeparationGroupNumber', 1)
    self.def:setInt('urpg', data)
end

function UnitOrHeroDefinition:setGroupSeparationEnabled(data)
    checktype(data, 'boolean', 'setGroupSeparationEnabled', 1)
    self.def:setBoolean('urpo', data)
end

function UnitOrHeroDefinition:setFormationRank(data)
    checktype(data, 'integer', 'setFormationRank', 1)
    self.def:setInt('ufor', data)
end

HeroDefinition = class('HeroDefinition', UnitOrHeroDefinition)
_G.HeroDefinition = HeroDefinition

function HeroDefinition:hideHeroDeathMsg(flag)
    checktype(flag, 'boolean', 'hideHeroDeathMsg', 1)
    self.def:setBoolean('uhhd', flag)
end

function HeroDefinition:hideHeroInterfaceIcon(flag)
    checktype(flag, 'boolean', 'hideHeroInterfaceIcon', 1)
    self.def:setBoolean('uhhb', flag)
end

function HeroDefinition:hideHeroMinimapDisplay(flag)
    checktype(flag, 'boolean', 'hideHeroMinimapDisplay', 1)
    self.def:setBoolean('uhhm', flag)
end

function HeroDefinition:setTooltipRevive(data)
    checktype(data, 'string', 'setTooltipRevive', 1)
    self.def:setString('utpr', data)
end

function HeroDefinition:setTooltipAwaken(data)
    checktype(data, 'string', 'setTooltipAwaken', 1)
    self.def:setString('uawt', data)
end

function HeroDefinition:setStrengthPerLevel(data)
    checktype(data, 'float', 'setStrengthPerLevel', 1)
    self.def:setUnreal('ustp', data)
end

function HeroDefinition:setStartingStrength(data)
    checktype(data, 'integer', 'setStartingStrength', 1)
    self.def:setInt('ustr', data)
end

function HeroDefinition:setStartingIntelligence(data)
    checktype(data, 'integer', 'setStartingIntelligence', 1)
    self.def:setInt('uint', data)
end

function HeroDefinition:setStartingAgility(data)
    checktype(data, 'integer', 'setStartingAgility', 1)
    self.def:setInt('uagi', data)
end

function HeroDefinition:setProperNamesUsed(data)
    checktype(data, 'integer', 'setProperNamesUsed', 1)
    self.def:setInt('upru', data)
end

function HeroDefinition:setProperNames(data)
    checktype(data, 'string', 'setProperNames', 1)
    self.def:setString('upro', data)
end

function HeroDefinition:setPrimaryAttribute(data)
    checktype(data, 'string', 'setPrimaryAttribute', 1)
    self.def:setString('upra', data)
end

function HeroDefinition:setIntelligencePerLevel(data)
    checktype(data, 'float', 'setIntelligencePerLevel', 1)
    self.def:setUnreal('uinp', data)
end

function HeroDefinition:setHeroRevivalLocations(data)
    checktype(data, 'string', 'setHeroRevivalLocations', 1)
    self.def:setString('urva', data)
end

function HeroDefinition:setHeroAbilities(data)
    checktype(data, 'string', 'setHeroAbilities', 1)
    self.def:setString('uhab', data)
end

function HeroDefinition:setAgilityPerLevel(data)
    checktype(data, 'float', 'setAgilityPerLevel', 1)
    self.def:setUnreal('uagp', data)
    --[[ sets the techtree requirements for a specific tier
    for example use setRequierements
    ]]--
end

function HeroDefinition:setRequierementsForTier(tier, data)
    checktype(tier, 'integer', 'setRequierementsForTier', 1)
    checktype(data, 'string', 'setRequierementsForTier', 2)
    if tier == 2 then
        self.def:setString('urq1', data)
    elseif tier == 3 then
        self.def:setString('urq2', data)
    elseif tier == 4 then
        self.def:setString('urq3', data)
    elseif tier == 5 then
        self.def:setString('urq4', data)
    elseif tier == 6 then
        self.def:setString('urq5', data)
    elseif tier == 7 then
        self.def:setString('urq6', data)
    elseif tier == 8 then
        self.def:setString('urq7', data)
    elseif tier == 9 then
        self.def:setString('urq8', data)
    end
end

UnitDefinition = class('UnitDefinition', UnitOrHeroDefinition)
_G.UnitDefinition = UnitDefinition

function UnitDefinition:setCasterUpgradeTips(data)
    checktype(data, 'string', 'setCasterUpgradeTips', 1)
    self.def:setString('ucut', data)
end

function UnitDefinition:setCasterUpgradeNames(data)
    checktype(data, 'string', 'setCasterUpgradeNames', 1)
    self.def:setString('ucun', data)
end

function UnitDefinition:setCasterUpgradeArt(data)
    checktype(data, 'string', 'setCasterUpgradeArt', 1)
    self.def:setString('ucua', data)
end

BuildingDefinition = class('BuildingDefinition', UnitOrBuildingOrHeroDefinition)
_G.BuildingDefinition = BuildingDefinition

function BuildingDefinition:setUpgradesTo(data)
    checktype(data, 'string', 'setUpgradesTo', 1)
    self.def:setString('uupt', data)
end

function BuildingDefinition:setUnitsTrained(data)
    checktype(data, 'string', 'setUnitsTrained', 1)
    self.def:setString('utra', data)
end

function BuildingDefinition:setRevivesDeadHeros(data)
    checktype(data, 'boolean', 'setRevivesDeadHeros', 1)
    self.def:setBoolean('urev', data)
end

function BuildingDefinition:setResearchesAvailable(data)
    checktype(data, 'string', 'setResearchesAvailable', 1)
    self.def:setString('ures', data)
end

function BuildingDefinition:setPlacementRequiresWaterRadius(data)
    checktype(data, 'float', 'setPlacementRequiresWaterRadius', 1)
    self.def:setUnreal('upaw', data)
end

function BuildingDefinition:setPlacementRequires(data)
    checktype(data, 'string', 'setPlacementRequires', 1)
    self.def:setString('upap', data)
end

function BuildingDefinition:setPlacementPreventedBy(data)
    checktype(data, 'string', 'setPlacementPreventedBy', 1)
    self.def:setString('upar', data)
end

function BuildingDefinition:setPathingMap(data)
    checktype(data, 'string', 'setPathingMap', 1)
    self.def:setString('upat', data)
end

function BuildingDefinition:setNeutralBuildingValidAsRandomBuilding(data)
    checktype(data, 'boolean', 'setNeutralBuildingValidAsRandomBuilding', 1)
    self.def:setBoolean('unbr', data)
end

function BuildingDefinition:setNeutralBuildingShowsMinimapIcon(data)
    checktype(data, 'boolean', 'setNeutralBuildingShowsMinimapIcon', 1)
    self.def:setBoolean('unbm', data)
end

function BuildingDefinition:setItemsMade(data)
    checktype(data, 'string', 'setItemsMade', 1)
    self.def:setString('umki', data)
end

function BuildingDefinition:setGroundTexture(data)
    checktype(data, 'string', 'setGroundTexture', 1)
    self.def:setString('uubs', data)
end

function BuildingDefinition:setConstructionSound(data)
    checktype(data, 'string', 'setConstructionSound', 1)
    self.def:setString('ubsl', data)
end

function BuildingDefinition:setCanBuildOn(data)
    checktype(data, 'boolean', 'setCanBuildOn', 1)
	self.def:setBoolean('ucbo', data)
end

function BuildingDefinition:setIsBuildOn(data)
    checktype(data, 'boolean', 'setCanBuildOn', 1)
	self.def:setBoolean('uibo', data)
end

BuildingAndHeroDefinition = class('BuildingAndHeroDefinition', UnitOrBuildingOrHeroDefinition)
_G.BuildingAndHeroDefinition = BuildingAndHeroDefinition

function BuildingAndHeroDefinition:setUpgradesTo(data)
    checktype(data, 'string', 'setUpgradesTo', 1)
    self.def:setString('uupt', data)
end

function BuildingAndHeroDefinition:setUnitsTrained(data)
    checktype(data, 'string', 'setUnitsTrained', 1)
    self.def:setString('utra', data)
end

function BuildingAndHeroDefinition:setRevivesDeadHeros(data)
    checktype(data, 'boolean', 'setRevivesDeadHeros', 1)
    self.def:setBoolean('urev', data)
end

function BuildingAndHeroDefinition:setResearchesAvailable(data)
    checktype(data, 'string', 'setResearchesAvailable', 1)
    self.def:setString('ures', data)
end

function BuildingAndHeroDefinition:setPlacementRequiresWaterRadius(data)
    checktype(data, 'float', 'setPlacementRequiresWaterRadius', 1)
    self.def:setUnreal('upaw', data)
end

function BuildingAndHeroDefinition:setPlacementRequires(data)
    checktype(data, 'string', 'setPlacementRequires', 1)
    self.def:setString('upap', data)
end

function BuildingAndHeroDefinition:setPlacementPreventedBy(data)
    checktype(data, 'string', 'setPlacementPreventedBy', 1)
    self.def:setString('upar', data)
end

function BuildingAndHeroDefinition:setPathingMap(data)
    checktype(data, 'string', 'setPathingMap', 1)
    self.def:setString('upat', data)
end

function BuildingAndHeroDefinition:setNeutralBuildingValidAsRandomBuilding(data)
    checktype(data, 'boolean', 'setNeutralBuildingValidAsRandomBuilding', 1)
    self.def:setBoolean('unbr', data)
end

function BuildingAndHeroDefinition:setNeutralBuildingShowsMinimapIcon(data)
    checktype(data, 'boolean', 'setNeutralBuildingShowsMinimapIcon', 1)
    self.def:setBoolean('unbm', data)
end

function BuildingAndHeroDefinition:setItemsMade(data)
    checktype(data, 'string', 'setItemsMade', 1)
    self.def:setString('umki', data)
end

function BuildingAndHeroDefinition:setGroundTexture(data)
    checktype(data, 'string', 'setGroundTexture', 1)
    self.def:setString('uubs', data)
end

function BuildingAndHeroDefinition:setConstructionSound(data)
    checktype(data, 'string', 'setConstructionSound', 1)
    self.def:setString('ubsl', data)
end

function BuildingAndHeroDefinition:setTooltipRevive(data)
    checktype(data, 'string', 'setTooltipRevive', 1)
    self.def:setString('utpr', data)
end

function BuildingAndHeroDefinition:setTooltipAwaken(data)
    checktype(data, 'string', 'setTooltipAwaken', 1)
    self.def:setString('uawt', data)
end

function BuildingAndHeroDefinition:setStrengthPerLevel(data)
    checktype(data, 'float', 'setStrengthPerLevel', 1)
    self.def:setUnreal('ustp', data)
end

function BuildingAndHeroDefinition:setStartingStrength(data)
    checktype(data, 'integer', 'setStartingStrength', 1)
    self.def:setInt('ustr', data)
end

function BuildingAndHeroDefinition:setStartingIntelligence(data)
    checktype(data, 'integer', 'setStartingIntelligence', 1)
    self.def:setInt('uint', data)
end

function BuildingAndHeroDefinition:setStartingAgility(data)
    checktype(data, 'integer', 'setStartingAgility', 1)
    self.def:setInt('uagi', data)
end

function BuildingAndHeroDefinition:setProperNamesUsed(data)
    checktype(data, 'integer', 'setProperNamesUsed', 1)
    self.def:setInt('upru', data)
end

function BuildingAndHeroDefinition:setProperNames(data)
    checktype(data, 'string', 'setProperNames', 1)
    self.def:setString('upro', data)
end

function BuildingAndHeroDefinition:setPrimaryAttribute(data)
    checktype(data, 'string', 'setPrimaryAttribute', 1)
    self.def:setString('upra', data)
end

function BuildingAndHeroDefinition:setIntelligencePerLevel(data)
    checktype(data, 'float', 'setIntelligencePerLevel', 1)
    self.def:setUnreal('uinp', data)
end

function BuildingAndHeroDefinition:setHeroRevivalLocations(data)
    checktype(data, 'string', 'setHeroRevivalLocations', 1)
    self.def:setString('urva', data)
end

function BuildingAndHeroDefinition:setHeroAbilities(data)
    checktype(data, 'string', 'setHeroAbilities', 1)
    self.def:setString('uhab', data)
end

function BuildingAndHeroDefinition:setAgilityPerLevel(data)
    checktype(data, 'float', 'setAgilityPerLevel', 1)
    self.def:setUnreal('uagp', data)
end
