local scene = composer.newScene()

group = {}

function scene:create(event)
    local sceneGroup = self.view
    local background = nil
    local deltax, deltay, globalx, globaly = 0, 0, 0, 0

    local function fieldmover(event)
        if(event.phase=="began")then
            deltax = globalx-event.x
            deltay = globaly-event.y

        elseif(event.phase=="moved") then
            if(deltax==nil)then return end
            globalx = event.x+deltax
            globaly = event.y+deltay

            for i = 1, 6 do
                group[i].x = globalx
                group[i].y = globaly
            end

        elseif(event.phase=="ended" or event.phase=="cancelled")then
            deltax = nil
            deltay = nil
            
        end

        return true
    end

    group[0] = newGroup(sceneGroup) -- background
    group[1] = newGroup(sceneGroup) -- field
    group[2] = newGroup(sceneGroup) -- towers
    group[3] = newGroup(sceneGroup) -- enemies
    group[4] = newGroup(sceneGroup) -- sub-info
    group[5] = newGroup(sceneGroup) -- projectiles
    group[6] = newGroup(sceneGroup) -- texttags
    group[7] = newGroup(sceneGroup) -- war interface
    group[8] = newGroup(sceneGroup) -- game interface

    background = display.newRect(group[0], -10, -10, 1300, 740)
    background:setFillColor(0, 0, 0, 0)
    background.isVisible = true
    background.isHitTestable = true
    background:addEventListener("touch",fieldmover)
    
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