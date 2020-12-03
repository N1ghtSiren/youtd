texttag = {}

local parentGroup = group[6]

local function create(text, x, y, fontsize)
    local texttag = display.newText(parentGroup, text, x+math.random(-10,10) , y+math.random(-40,-20), fontMain, fontsize)
    setAnchor(texttag, 0.5, 0.5)

    return texttag
end

function texttag.new(text, x, y, lifetime)
    local texttag = create(text, x, y, 30)
    texttag:setFillColor(1, 1, 1, 1)
    local Timer = nil
    
    lifetime = lifetime * 60

    local function remove()
        lifetime = lifetime - 1

        if(lifetime<=0)then
            timer.cancel(Timer)
            texttag:removeSelf()
        else
            texttag.alpha = 1-(1.3/lifetime)
            texttag.y = texttag.y - lifetime*0.01
        end
    end

    Timer = timer.performWithDelay(16.7, remove, -1)
end

function texttag.new2(text, x, y, lifetime)
    local texttag = create(text, x, y, 30)
    texttag:setFillColor(1, 1, 1, 1)
    local Timer = nil
    
    lifetime = lifetime * 60

    local function remove()
        lifetime = lifetime - 1

        if(lifetime<=0)then
            timer.cancel(Timer)
            texttag:removeSelf()
        else
            texttag.alpha = 1-(1.3/lifetime)
            texttag.y = texttag.y + lifetime*0.01
        end
    end

    Timer = timer.performWithDelay(16.7, remove, -1)
end