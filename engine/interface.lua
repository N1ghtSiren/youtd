interface = {}
interface.waveList = {}
interface.items = {}
interface.towers = {}
interface.thistower = {}

local parentGroup = group[7]
local interfaceGroup = nil
local textGold = nil
local textBooks = nil
local textFood = nil
local textWave = nil
local textLife = nil
--
local selectedItem = nil

--0
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
    interface.items.init()
    interface.towers.init()
    interface.thistower.init()
end

--1
function interface.waveList.init()
    local background = nil
    local isVisible = false

    local function toggle_ui(event)
        if(event.phase~="began")then return end

        isVisible = not isVisible
        interfaceGroup[1].isVisible = isVisible

        return true
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

    interfaceGroup[1] = newGroup(parentGroup)
    interfaceGroup[1].isVisible = false

    background = display.newRect(interfaceGroup[1], 880, 50, 400, 670)
    background:setFillColor(0, 0, 0, 0.75)
    background:addEventListener("touch", stealTouch)

    textWave:addEventListener("touch", toggle_ui)
end

--2
function interface.items.init()
    local icon = nil
    local isVisible = false
    local background = nil
    local textBackground = nil
    local textItemName = nil
    local textItemDescription = nil
    local textPage = nil

    local pageCurrent = 1
    local pageMax = 1

    local pageArrowLeft = nil
    local pageArrowRight = nil

    local itempool = {
        ids = {}
    }
    local itemImages = {}

    local function swapPage(event)
        if(event.phase~="began")then return end
        
        if(event.target.id==0)then  --left
            pageCurrent = pageCurrent - 1

            if(pageCurrent<1)then
                pageCurrent = pageMax
            end

        elseif(event.target.id==1)then  --right
            pageCurrent = pageCurrent + 1

            if(pageCurrent>pageMax)then
                pageCurrent = 1
            end
        end

        interface.items.clearSelection()
        interface.items.updatePageText()
        interface.items.refresh()
    end

    icon = display.newImageRect(interfaceGroup[0], "img/icons/locked-chest.png", 70, 70)
    icon.x, icon.y = 10, 60

    interfaceGroup[2] = newGroup(parentGroup)
    interfaceGroup[2].isVisible = false

    background = display.newRect(interfaceGroup[2], 1030, 50, 250, 670)
    background:setFillColor(0, 0, 0, 0.75)
    background:addEventListener("touch", stealTouch)

    textBackground = display.newRect(interfaceGroup[2], 530, 520, 500, 200)
    textBackground:setFillColor(0, 0, 0, 0.75)
    textBackground:addEventListener("touch", stealTouch)
    textBackground.isVisible = false

    textItemName = display.newText(interfaceGroup[2], "Selected Item Name", 540, 520, fontMain, 25)
    textItemName.isVisible = false

    textItemDescription = display.newText(interfaceGroup[2], "Selected Item Description", 540, 555, fontMain, 25)
    textItemDescription.isVisible = false

    pageArrowLeft = display.newImageRect(interfaceGroup[2], "img/icons/arrow_left.png", 60, 60)
    pageArrowLeft.x, pageArrowLeft.y = 1030, 50
    pageArrowLeft.id = 0
    pageArrowLeft:addEventListener("touch", swapPage)

    pageArrowRight = display.newImageRect(interfaceGroup[2], "img/icons/arrow_right.png", 60, 60)
    pageArrowRight.x, pageArrowRight.y = 1220, 50
    pageArrowRight.id = 1
    pageArrowRight:addEventListener("touch", swapPage)

    textPage = display.newText(interfaceGroup[2], "100/100", 1155, 60, fontMain, 30)
    textPage.anchorX = 0.5

    function interface.items.updatePageText()
        textPage.text = pageCurrent.."/"..pageMax
    end

    function interface.items.toggle_ui(event)
        if(event.phase~="began")then return end

        isVisible = not isVisible
        interfaceGroup[2].isVisible = isVisible

        return true
    end

    function interface.items.updatePageCount()
        pageMax = math.floor((#itempool.ids-1)/10)+1
        interface.items.updatePageText()
    end

    function interface.items.updateDescription()
        if(selectedItem)then
            itemImages[selectedItem]:setFillColor(1,0,0,1)

            textItemName.text = itempool.ids[selectedItem].name
            textItemDescription.text = textCutter(itempool.ids[selectedItem].description, 35)

            textItemName.isVisible = true
            textItemDescription.isVisible = true
            textBackground.isVisible = true
        else

            textItemName.isVisible = false
            textItemDescription.isVisible = false
            textBackground.isVisible = false
        end
    end

    function interface.items.select(event)
        if(event.phase~="began")then return end
        local oldSelection = selectedItem

        if(selectedItem)then
            itemImages[selectedItem]:setFillColor(1,1,1,1)
        end        
        
        if(oldSelection == event.target.id)then
            selectedItem = nil
        else
            selectedItem = event.target.id
        end

        interface.items.updateDescription()
        return true
    end

    function interface.items.refresh()
        local startx, starty = 1040, 120
        local n = 1
        local horisontalRow = 0
        local verticalRow = 0
        local startn = (pageCurrent-1)*10+1
        local endn = pageCurrent*10

        if(pageCurrent == pageMax)then
            endn = pageCurrent*10-(pageCurrent*10-#itempool.ids)
        end
        
        for k, v in pairs(itemImages)do
            v:removeSelf()
            itemImages[k] = nil
        end

        for i = startn, endn do
            itemImages[n] = display.newImageRect(interfaceGroup[2], itempool.ids[i].image, 100, 100)
            itemImages[n].x, itemImages[n].y = startx+(horisontalRow*110), starty+(verticalRow*110)
            itemImages[n].id = n
            itemImages[n]:addEventListener("touch", interface.items.select)

            n = n + 1
            horisontalRow = horisontalRow + 1
            if(horisontalRow>1)then
                horisontalRow = 0
                verticalRow = verticalRow + 1
            end

        end

        if(selectedItem)then
            itemImages[selectedItem]:setFillColor(1,0,0,1)
        end

        interface.items.updatePageCount()
    end

    function interface.items.add(itemid)
        table.insert(itempool.ids, itemdb.get(itemid))
        interface.items.refresh()
    end

    function interface.items.remove(itemNumber)
        table.remove(itempool.ids, itemNumber)
        interface.items.refresh()
    end

    function interface.items.clearSelection()
        selectedItem = nil
        interface.items.updateDescription()
    end

    icon:addEventListener("touch", interface.items.toggle_ui)

end

--3
function interface.towers.init()
    local icon = nil
    local isVisible = false

    local function toggle()

    end

    icon = display.newImageRect(interfaceGroup[0], "img/icons/white-tower.png", 70, 70)
    icon.x, icon.y = 10, 140
end

--4
function interface.thistower.init()
    local background = nil
    local itemslots = {}
    local selectedTower = nil
    local textSelectedTowerName = nil

    local function hideTowerItems(event)
        if(event.phase~="began")then return end

        for i = 1, #itemslots do
            if(itemslots[i])then
                itemslots[i]:removeSelf()
                itemslots[i] = nil
            end
        end

        textSelectedTowerName.isVisible = false

        return true
    end

    local function onInventorySlotTouch(event)
        if(event.phase~="began")then return end

        if(selectedItem and event.target.type == "empty")then
            selectedTower:addItem(interface.items.getcurrent(), event.target.slotn)
            interface.items.remove(selectedItem)
        end

        return true
    end

    function interface.thistower.ontouch(event)
        if(event.phase~="began")then return end
        selectedTower = event.target.id

        if(selectedTower)then
            textSelectedTowerName.text = selectedTower.name
            textSelectedTowerName.isVisible = true

            --remove old
            for i = 1, #itemslots do
                if(itemslots[i])then
                    itemslots[i]:removeSelf()
                    itemslots[i] = nil
                end
            end

            --fill
            for i = 1, selectedTower.maxitems do
                local posx, posy = 10, 500
                local image = "img/items/emptyslot.png"
                local type = "empty"

                if(selectedTower.items[i])then
                    image = selectedTower.items[i].image
                    type = "not empty"
                end

                itemslots[i] = display.newImageRect(interfaceGroup[4], image, 70, 70)
                itemslots[i].x, itemslots[i].y = posx+80*(i-1), posy
                itemslots[i].type = type
                itemslots[i].slotn = i

                itemslots[i]:addEventListener("touch", onInventorySlotTouch)

            end
        end
        
        return true
    end

    function interface.thistower.registertap(tower)
        tower:addEventListener("touch", interface.thistower.ontouch)
    end

    interfaceGroup[4] = display.newGroup(parentGroup)
    textSelectedTowerName = display.newText(interfaceGroup[4], "Selected Tower", 10, 465, fontMain, 25)
    textSelectedTowerName.isVisible = false
    textSelectedTowerName:addEventListener("touch", hideTowerItems)
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