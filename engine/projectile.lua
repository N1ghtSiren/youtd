projectile = {}

local parentGroup = group[5]

function projectile.predictPosition(target, time) --in seconds
    local x, y = target.x, target.y
    local frames = time*60
    local movespeed = target.movespeed/60

    if(target.movedirection == "r")then
        x = x + movespeed*frames
    elseif(target.movedirection == "l")then
        x = x - movespeed*frames
    elseif(target.movedirection == "u")then
        y = y - movespeed*frames
    elseif(target.movedirection == "d")then
        y = y + movespeed*frames
    end

    return x, y
end

function projectile.laser(tower, target)
    local line = display.newLine(parentGroup, tower.x, tower.y, target.x, target.y)
    line:setStrokeColor(0.9, 0.9, 0.9, 1)
    line.strokeWidth = 30

    local Timer = nil
    local lifetime = 30

    local function updater()
        lifetime = lifetime - 1
        
        if(lifetime>0)then
            line.strokeWidth = lifetime
            line.alpha = lifetime/30
        else
            line:removeSelf()
            timer.cancel(Timer)
        end
    end

    tower:ondamage(target)
    
    Timer = timer.performWithDelay(16.7, updater, -1)
end

function projectile.homing(tower, target)
    local distTemp = dist2(tower.x, tower.y, target.x, target.y)
    local flytimeTemp = distTemp/tower.projectilespeed
    local newx, newy = projectile.predictPosition(target, flytimeTemp)

    local dist = dist2(tower.x, tower.y, newx, newy)
    local angle = angle2(tower.x, tower.y, newx, newy)
    local flytime = dist/tower.projectilespeed
    local deltadist = (dist/flytime)*0.0167

    local distCurrent = 0
    local flytimeCurrent = 0
    local projectile = nil
    local Timer = nil
    
    local function updater()
        flytimeCurrent = flytimeCurrent + 0.0167

        if(flytimeCurrent>=flytime)then
            tower:ondamage(target)
            projectile:removeSelf()
            timer.cancel(Timer)
        end

        distCurrent = distCurrent + deltadist
        projectile.x, projectile.y = polarProjection2(tower.x, tower.y, distCurrent, angle)
    end

    projectile = display.newImageRect(parentGroup, "img/projectiles/test.png", 10, 10)
    setAnchor(projectile, 0.5, 0.5)
    projectile.x, projectile.y = tower.x, tower.y

    Timer = timer.performWithDelay(16.7, updater, -1)
end