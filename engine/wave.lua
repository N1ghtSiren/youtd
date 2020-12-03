wave = {}

local wavetimer = nil
local allWaves = {}
local currentWave = 0

function wave.generateAll(level)
    if(allWaves)then
        allWaves = {}
    end

    for i = 1, level.maxwaves do
        local type = oneof("boss", "normal", "mass")
        local mobs = 0
        local movespeed = 60+(i*0.3)
        local playerdamage = 0
        local name = enemydb.getRandom()

        local lifeValue = 100+(i*10)
        local bountyValue = 20+(i*2)
        local experienceValue = 20+(i*0.5)
        

        if(type=="boss")then
            mobs = 1
            playerdamage = 50
        elseif(type=="normal")then
            mobs = math.random(6,9)
            playerdamage = 5
        elseif(type=="mass")then
            mobs = math.random(12,22)
            playerdamage = 3
        end

        allWaves[i] = {
            type = type,
            life = round(lifeValue/mobs),
            movespeed = round(movespeed),
            mobs = mobs,
            bounty = round(bountyValue/mobs),
            playerdamage = playerdamage,
            experience = round(experienceValue/mobs),
            name = name,

        }

    end

end

function wave.enemiesLeft()
    if(currentWave == 0)then
        return 0
    end
    return allWaves[currentWave].mobs
end

function wave.spawn()
    if(allWaves[currentWave].mobs>0)then
        enemy.new(allWaves[currentWave])
        allWaves[currentWave].mobs = allWaves[currentWave].mobs - 1
    else
        if(#allWaves<currentWave)then

        else
            wave.finish()
            print("all enemies spawned")
        end
    end
end

function wave.start()
    if(wavetimer~=nil)then return end

    currentWave = currentWave + 1

    if(currentWave<=#allWaves)then
        interface.waveList.remove(currentWave-1)
        gamelog.add("wave: "..currentWave.." enemies: "..allWaves[currentWave].mobs.." "..allWaves[currentWave].type.." life: "..allWaves[currentWave].life)
        wavetimer = timer.performWithDelay(750, wave.spawn, -1)
        interface.setWave(currentWave)
    else
        gamelog.add("level completed")
    end
end

function wave.pause()
    timer.pause(wavetimer)
end

function wave.resume()
    timer.resume(wavetimer)
end

function wave.finish()
    if(wavetimer)then
        timer.cancel(wavetimer)
        wavetimer = nil
    end
end

function wave.startLevel()
    currentWave = 0
    wave.start()
end

function wave.getAllWaves()
    return allWaves
end