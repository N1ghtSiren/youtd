local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    local button = nil
    local text = display.newText(sceneGroup,"tutorial", 10, 5, fontMain, 40)

    local function listener(event)
        if(event.phase~="began")then return end

        if(event.target.id==1)then
            level.start(1)
        end
    end
    
    button = display.newImageRect(sceneGroup, "img/buttons/leveltemplate.png", 100, 100)
    setPosition(button, 10, 60)
    button.id = 1
    button:addEventListener("touch", listener)
    text = display.newText(sceneGroup, 1, 35, 55, fontMain, 80)

    button = display.newImageRect(sceneGroup, "img/buttons/leveltemplate.png", 100, 100)
    setPosition(button, 120, 60)
    button.id = 2
    button:addEventListener("touch", listener)
    text = display.newText(sceneGroup, 2, 145, 55, fontMain, 80)

    button = display.newImageRect(sceneGroup, "img/buttons/leveltemplate.png", 100, 100)
    setPosition(button, 230, 60)
    button.id = 3
    button:addEventListener("touch", listener)
    text = display.newText(sceneGroup, 3, 255, 55, fontMain, 80)

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