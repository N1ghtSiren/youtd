local function mainattack(self, target)
    local maxTargets = 2
    local currentTargets = 0

    for _, enemy in pairs(indexer.gettable("e"))do
        if(currentTargets<maxTargets)then
            
            if(dist2(self.x, self.y, enemy.x, enemy.y)<self.range and enemy.alive)then
                projectile.homing(self, enemy)
                currentTargets = currentTargets + 1
            end
        else
            break
        end

    end
end

local obj = {
    name = "Bonefire pit",
    description = "cat hit up to 2 different enemies on attack",

    image = "img/towers/t01.png",

    range = 850,
    damage = 35,
    cooldownmax = 1100,
    goldcost = 50,
    
    projectilespeed = 500,

    maxitems = 2,

    mainattack = mainattack,

    actions_onattack = {onattack},
    actions_onlvlup = {onlvlup},
    actions_onlvldown = {onlvldown},
}

return obj