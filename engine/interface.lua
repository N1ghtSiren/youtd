interface = {}
interface.waveList = {}

local parentGroup = group[7]
local interfaceGroup = nil
local textGold = nil
local textBooks = nil
local textFood = nil
local textWave = nil
local textLife = nil

function interface.init()
    local background = nil
    local icon = nil
    local text = nil

    interfaceGroup = {}
    --ui
    interfaceGroup[0] = newGroup(parentGroup)
    background = display.newRect(interfaceGroup[0], -10, -10, 1300, 60)
    background:setFillColor(0, 0, 0, 0.75)
    background:addEventListener("touch", stealTouch)

    icon = display.newImageRect(interfaceGroup[0],"img/icons/gold.png", 50, 50)
    icon.x, icon.y = 0, 0
    textGold = display.newText(interfaceGroup[0], "122112", 55, -3, fontMain, 40)

    icon = display.newImageRect(interfaceGroup[0],"img/icons/book.png", 50, 50)
    icon.x, icon.y = 200, 0
    textBooks = display.newText(interfaceGroup[0], "122", 255, -3, fontMain, 40)

    icon = display.newImageRect(interfaceGroup[0],"img/icons/food.png", 50, 50)
    icon.x, icon.y = 350, 0
    textFood = display.newText(interfaceGroup[0], "80/80", 405, -3, fontMain, 40)

    textWave = display.newText(interfaceGroup[0], "wave 241", 1080, -5, fontMain, 40)
    setAnchor(textWave, 1, 0)

    icon = display.newImageRect(interfaceGroup[0],"img/icons/life.png", 50, 50)
    icon.x, icon.y = 1110, 0

    textLife = display.newText(interfaceGroup[0], "102%", 1280, -3, fontMain, 40)
    setAnchor(textLife, 1, 0)

    interface.waveList.init()
end

function interface.waveList.init()
    local background = nil
    local isVisible = false

    local function toggle_ui(event)
        if(event.phase~="began")then return end

        isVisible = not isVisible
        interfaceGroup[1].isVisible = isVisible
    end

    interfaceGroup[1] = newGroup(parentGroup)
    interfaceGroup[1].isVisible = false

    background = display.newRect(interfaceGroup[1], 880, 50, 400, 670)
    background:setFillColor(0, 0, 0, 0.75)
    background:addEventListener("touch", stealTouch)

    textWave:addEventListener("touch", toggle_ui)
end

function interface.waveList.create()
    local text = nil
    local texts = {}
    local waves = wave.getAllWaves()
    local startx, starty = 880, 50

    for i = 1, level.current().maxwaves do
        texts[i] = display.newText(interfaceGroup[1], i..": "..waves[i].mobs.." "..waves[i].type..", life: "..waves[i].life, startx+10, starty+(i*30), fontMain, 25)
    end

    waves = nil

    function interface.waveList.remove(number)
        if(texts[number])then
            texts[number]:removeSelf()
            texts[number] = nil
        end
        
        for k,v in pairs(texts)do
            texts[k].y = texts[k].y - 30
        end
    end
end




















function interface.setGold(value)
    textGold.text = value
end

function interface.setBooks(value)
    textBooks.text = value
end

function interface.setFood(current, max)
    textFood.text = current.."/"..max
end

function interface.setWave(value)
    textWave.text = "wave "..value
end
function interface.setLife(value)
    textLife.text = math.floor(value).."%"
end

interface.init()