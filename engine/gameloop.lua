gameloop = {}

local gameloopTimer = nil

function gameloop.start()

    local function loop()
        for _,v in pairs(indexer.gettable("e"))do
            v:update()
        end

        for _,v in pairs(indexer.gettable("t"))do
            v:update()
        end

    end

    gameloopTimer = timer.performWithDelay(16.7, loop, -1)
end

function gameloop.pause()
    timer.pause(gameloopTimer)
end

function gameloop.resume()
    timer.resume(gameloopTimer)
end

function gameloop.finish()
    timer.cancel(gameloopTimer)
end