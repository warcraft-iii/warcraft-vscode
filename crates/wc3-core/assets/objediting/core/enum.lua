-- enum.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/14/2019, 10:17:08 PM

Race = {
    Commoner = 'commoner',
    Creeps = 'creeps',
    Critters = 'critters',
    Demon = 'demon',
    Human = 'human',
    Naga = 'naga',
    Nightelf = 'nightelf',
    Orc = 'orc',
    Other = 'other',
    Undead = 'undead',
    Unknown = 'unknown',
}
_G.Race = Race

AllowWhenFull = {
    Never = 0, --
    LifeOnly = 1, --
    ManaOnly = 2, --
    Always = 3, --
}
_G.AllowWhenFull = AllowWhenFull

StackingType = {
    Damage = 0, --
    Movement = 1, --
    AttackRate = 2, --
    KillUnit = 3, --
}
_G.StackingType = StackingType

ArmorType = {
    Normal = 'normal',
    Small = 'small',
    Medium = 'medium',
    Large = 'large',
    Fortified = 'fort',
    Hero = 'hero',
    Divine = 'divine',
    Unarmored = 'none',
}
_G.ArmorType = ArmorType

MovementType = {
    Foot = 'foot', --
    Horse = 'horse', --
    Fly = 'fly', --
    Hover = 'hover', --
    Float = 'float', --
    Amphipic = 'amph', --
}
_G.MovementType = MovementType

WeaponType = {
    Normal = 'normal',
    Instant = 'instant',
    Artillery = 'artillery',
    ArtilleryLine = 'aline',
    Missile = 'missile',
    MissileSplash = 'msplash',
    MissileBounce = 'mbounce',
    MissileLine = 'mline',
    None = '_',
}
_G.WeaponType = WeaponType

WeaponSound = {
    Nothing = 'Nothing',
    AxeMediumChop = 'AxeMediumChop',
    MetalHeavyBash = 'MetalHeavyBash',
    MetalHeavyChop = 'MetalHeavyChop',
    MetalHeavySlice = 'MetalHeavySlice',
    MetalLightChop = 'MetalLightChop',
    MetalLightSlice = 'MetalLightSlice',
    MetalMediumBash = 'MetalMediumBash',
    MetalMediumChop = 'MetalMediumChop',
    MetalMediumSlice = 'MetalMediumSlice',
    RockHeavyBash = 'RockHeavyBash',
    WoodHeavyBash = 'WoodHeavyBash',
    WoodLightBash = 'WoodLightBash',
    WoodMediumBash = 'WoodMediumBash',
}
_G.WeaponSound = WeaponSound

AttackType = {
    Unknown = 'unknown',
    Normal = 'normal',
    Pierce = 'pierce',
    Siege = 'siege',
    Spells = 'spells',
    Chaos = 'chaos',
    Magic = 'magic',
    Hero = 'hero',
}
_G.AttackType = AttackType

ArmorSoundType = {
    Ethereal = 'Ethereal', --
    Flesh = 'Flesh', --
    Wood = 'Wood', --
    Stone = 'Stone', --
    Metal = 'Metal', --
}
_G.ArmorSoundType = ArmorSoundType

UpgradeClass = {
    None = '',
    Armor = 'armor',
    Artillery = 'artillery',
    Melee = 'melee',
    Ranged = 'ranged',
    Caster = 'caster',
}
_G.UpgradeClass = UpgradeClass

UpgradeEffectType = {
    None = '',
    AbilityLevelBonus = 'rlev',
    AddUltravision = 'rauv',
    ApplyAttackUpgradeBonus = 'ratt',
    ApplyDefenseUpgradeBonus = 'rarm',
    AttackDamageBonus = 'ratx',
    AttackDamageLoss = 'radl',
    AttackDiceBonus = 'ratd',
    AttackRangeBonus = 'ratr',
    AttackSpeedBonus = 'rats',
    AttackSpillDistanceBonus = 'rasd',
    AttackSpillRadiusBonus = 'rasr',
    AttackTargetCountBonus = 'ratc',
    AuraDataBonus = 'raud',
    DefenseTypeChange = 'rart',
    EnableAttacks = 'renw',
    EnableAttacksRooted = 'rroo',
    EnableAttacksUprooted = 'ruro',
    GoldHarvestBonus = 'rmin',
    GoldHarvestBonusEntangle = 'rent',
    HitPointBonus = 'rhpx',
    HitPointBonusPercent = 'rhpo',
    HitPointRegeneration = 'rhpr',
    LumberHarvestBonus = 'rlum',
    MagicImmunity = 'rmim',
    ManaPointBonus = 'rmnx',
    ManaPointBonusPercent = 'rman',
    ManaRegeneration = 'rmnr',
    MovementSpeedBonus = 'rmvx',
    MovementspeedBonusPercent = 'rmov',
    RaiseDeadDurationBonus = 'rrai',
    SightRangeBonus = 'rsig',
    SpikedBarricades = 'rspi',
    UnitAvailabilityChange = 'rtma',
}
_G.UpgradeEffectType = UpgradeEffectType

AttacksEnabled = {
    None = 0, --
    AttackOneOnly = 1, --
    AttackTwoOnly = 2, --
    Both = 3, --
}
_G.AttacksEnabled = AttacksEnabled
