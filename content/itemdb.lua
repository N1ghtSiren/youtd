itemdb = {}

local items = {}

local itemnames = {
    "testitem",
}

function itemdb.loadAll()
    local n = 1
    local maxn = #itemnames

    for _,id in ipairs(itemnames) do
        items[id] = require("content.item."..id)
        print("items loaded: "..id.." | "..n.."/"..maxn)
        n = n + 1
    end
end

function itemdb.get(id)
    if(items[id])then
        return items[id]
    end
    
    return false
end

function itemdb.getRandom()
    return itemnames[math.random(1,#itemnames)]
end

itemdb.loadAll()