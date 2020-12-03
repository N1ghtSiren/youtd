local scene = composer.newScene()

local function listener(event)
    if(event.phase~="began")then return end

    if(event.target.id==0)then
        composer.gotoScene("scenes.levels")
    elseif(event.target.id==1)then
        print("classicmode")
    end
end

function scene:create(event)
    local sceneGroup = self.view
    local buttonLevels = nil
    local buttonClassic = nil
    local imageCastle = nil
    
    buttonLevels = display.newImageRect(sceneGroup, "img/buttons/levels.png", 300, 100)
    setPosition(buttonLevels, 10, 10)
    buttonLevels.id = 0
    buttonLevels:addEventListener("touch", listener)

    buttonClassic = display.newImageRect(sceneGroup, "img/buttons/classicmode.png", 300, 100)
    setPosition(buttonClassic, 10, 110)
    buttonClassic.id = 1
    buttonClassic:addEventListener("touch", listener)

    --castle
    imageCastle = display.newImageRect(sceneGroup, "img/rest/elven-castle.png", 512, 512)
    setPosition(imageCastle, 768, 208)

end 

function scene:hide(event)
    local sceneGroup = self.view

    if(event.phase=="will")then
        sceneGroup.isVisible = true
    end
end

function scene:show(event)
    local sceneGroup = self.view

    if(event.phase=="will")then
        sceneGroup.isVisible = true
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("show", scene)

return scene