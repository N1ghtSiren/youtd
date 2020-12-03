enemydb = {}

local enemies = {}

local enemynames = {
    "cube",
}

function enemydb.loadAll()
    local n = 1
    local maxn = #enemynames

    for _,name in ipairs(enemynames) do
        enemies[name] = require("content.enemy."..name)
        print("enemy loaded: "..name.." | "..n.."/"..maxn)
        n = n + 1
    end
end

function enemydb.get(name)
    if(enemies[name])then
        return enemies[name]
    end
    
    return false
end

function enemydb.getRandom()
    return enemynames[math.random(1,#enemynames)]
end

enemydb.loadAll()