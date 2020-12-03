towerdb = {}

local towers = {}

local towernames = {
    "testtower",
}

function towerdb.loadAll()
    local n = 1
    local maxn = #towernames

    for _,id in ipairs(towernames) do
        towers[id] = require("content.tower."..id)
        print("tower loaded: "..id.." | "..n.."/"..maxn)
        n = n + 1
    end
end

function towerdb.get(id)
    if(towers[id])then
        return towers[id]
    end
    
    return false
end

function towerdb.getRandom()
    return towernames[math.random(1,#towernames)]
end

towerdb.loadAll()