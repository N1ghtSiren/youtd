indexer = {}

local id = {}

function indexer.new(str)
    id[str] = {}
    id[str].keys = {}
    id[str].size = 0
    id[str].content = {}
    id[str].index = 1
    print("indexer.new: "..str.." created")
end

function indexer.add(str, thing)
    local k = id[str].index
    id[str].content[k] = thing
    id[str].keys[thing] = k

    id[str].size = id[str].size + 1
    id[str].index = id[str].index + 1

    return k
end

function indexer.remove(str, thing)
    local k = id[str].keys[thing]
    id[str].keys[thing] = nil
    id[str].content[k] = nil
    id[str].size = id[str].size - 1
    return true
end

function indexer.gettable(str)
    return id[str].content
end

function indexer.getkeys(str)
    return id[str].keys
end

function indexer.size(str)
    return id[str].size
end

function indexer.reset(str)
    for k, _ in pairs(id[str]) do
        for _, v in pairs(id[k].content)do
            indexer.rm(k, v)
        end
    end
end

function indexer.inside(str,thing)
    if(id[str].keys[thing]~=nil)then 
        return true
    end
    return false
end


indexer.new("e")
indexer.new("t")
indexer.new("l")