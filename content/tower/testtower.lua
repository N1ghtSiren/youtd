local function onlvlup(self)
    self.cooldownmax = self.cooldownmax - 100
end

local function onlvldown(self)
    self.cooldownmax = self.cooldownmax + 100
end

local function mainattack(self, target)

    --on attack fire laser with same damage to all targets
    for _, enemy in pairs(indexer.gettable("e"))do
        local dist = dist2(self.x, self.y, enemy.x, enemy.y)
        
        if(dist<self.range and enemy.alive)then
            projectile.laser(self, enemy)
        end
    end
end

local obj = {
    name = "testtower",
    image = "img/towers/t00.png",

    range = 1000,
    damage = 200,
    cooldownmax = 5000,
    
    projectilespeed = 1000,

    mainattack = mainattack,

    actions_onattack = {onattack},
    actions_onlvlup = {onlvlup},
    actions_onlvldown = {onlvldown},
}

return obj