local function onequip(tower)
    tower.cooldownmax = tower.cooldownmax - 300
end

local function onloose(tower)
    tower.cooldownmax = tower.cooldownmax + 300
end

local obj = {
    name = "Strange Mark",
    image = "img/items/evil-wings.png",
    description = "Decreases base attackspeed of tower by 300ms",

    onequip = onequip,
    onloose = onloose,
}

return obj