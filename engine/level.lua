level = {}
local currentLevel = nil

local grid = 0
local parentGroup = group[1]
local lvls = {}
local wavetimer = 0
--
lvls[1] = require("content.level.1")
--]]

function level.load(id)
    currentLevel = deepcopy(lvls[id])
end

function level.updateGrid()

    local function clearGrid()
        if(grid==0)then return end

        for y = 1, #grid do
            for x = 1, #grid[y] do
                grid[y][x]:removeSelf()
            end
        end

        grid = 0
    end
    clearGrid()

    grid = {}

    for y = 1, #currentLevel.field do
        grid[y] = {}

        for x = 1, #currentLevel.field[y] do
            local str = "build"

            if(currentLevel.field[y][x]==1)then 
                str = "path"
            elseif(currentLevel.field[y][x]==2)then 
                str = "start"
            elseif(currentLevel.field[y][x]==3)then 
                str = "end"
            end
            grid[y][x] = display.newImageRect(parentGroup,"img/spots/"..str..".png", 100, 100)
            grid[y][x].x = -100+100*x
            grid[y][x].y = -100+100*y
        end
    end

end

function level.start(id)
    level.load(id)
    level.updateGrid()

    player.reset()
    wave.generateAll(currentLevel)
    interface.waveList.create()

    gameloop.start()

    wave.startLevel()

    tower.new("t01", 3, 3)
    composer.gotoScene("scenes.level")
end

function level.current()
    return currentLevel
end