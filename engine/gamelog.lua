gamelog = {}

local parentGroup = group[7]

function gamelog.add(...)
    local text = ""
    local textObj = nil
    local locTimer = nil
    local alpha = 100

    local function remove()
        alpha = alpha - 1
        if(alpha > 0)then
            textObj.alpha = alpha/100
        else
            indexer.remove("l", textObj)
            timer.cancel(locTimer)
            textObj:removeSelf()
        end
    end

    for k,v in pairs{...}do
        text = text..tostring(v).." "
    end

    for k,v in pairs(indexer.gettable("l"))do
        v.y = v.y - 40
    end

    textObj = display.newText(parentGroup, text, 10, 680, fontMain, 30)
    indexer.add("l", textObj)
    locTimer = timer.performWithDelay(100, remove, -1)
end
