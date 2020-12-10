local function mainattack(self, target)
    projectile.homing(self, target)
end

local obj = {
    name = "Lesser Darkness Defender",
    description = "Common Elemental Defender",

    image = "img/towers/t00.png",

    range = 950,
    damage = 70,
    cooldownmax = 800,
    goldcost = 65,
    
    projectilespeed = 1000,

    mainattack = mainattack,

    actions_onattack = {onattack},
    actions_onlvlup = {onlvlup},
    actions_onlvldown = {onlvldown},
}

return obj