enemy = {}

local parentGroup = group[3]

local methods = {}
methods.__index = methods

function methods.remove(self)
    self.model:removeSelf()
    self.group:removeSelf()
    self.alive = false

    indexer.remove("e", self)

    if(indexer.size("e")==0 and wave.enemiesLeft()==0)then
        wave.finish(true)
        --wave.start()
    end
end

function methods.ondeath(self)
    if(self.bounty>0)then
        self.alive = false
        texttag.new2("+"..self.bounty, self.x, self.y, 1.5)
        player.addGold(self.bounty)
        self:remove()
    end
end

function methods.ondamage(self, damage)
    if(self==nil or self.alive==false)then return end

    texttag.new(round(damage).."!", self.x, self.y, 2)

    self.life = self.life - damage
    self.model.alpha = math.max(getPercent(self.life, self.maxlife), 0.1)

    if(self.life<=0)then
        self:ondeath()
        return true, self.experience
    end

    return false
end

function methods.move(self)
    local level = level.current()

    if(self.waypoint<=#level.wpx)then
        local dx = dist1(self.x, level.wpx[self.waypoint])
        local dy = dist1(self.y, level.wpy[self.waypoint])

        if(dx<=20 and dy<=20)then
            self.waypoint = self.waypoint + 1

        elseif(dx>20)then
            if(self.x<level.wpx[self.waypoint])then
                self.x = self.x + self.movespeed/60
                self.movedirection = "r"
            elseif(self.x>level.wpx[self.waypoint])then
                self.x = self.x - self.movespeed/60
                self.movedirection = "l"
            end

        elseif(dy>20)then
            if(self.y<level.wpy[self.waypoint])then
                self.y = self.y + self.movespeed/60
                self.movedirection = "d"
            elseif(self.y>level.wpy[self.waypoint])then
                self.y = self.y - self.movespeed/60
                self.movedirection = "u"
            end
        end
    end

    if(dist1(self.x, level.exitx)<=20 and dist1(self.y, level.exity)<=20)then
        self:onloose()
        self:remove()
        return
    end
end

function methods.onloose(self)
    player.damage(self.playerdamage*getPercent(self.life, self.maxlife), self.life, self.name)
end

function methods.update(self)
    self:move()
    self.model.x = self.x + self.offsetx
    self.model.y = self.y + self.offsety
end

function enemy.new(wave)
    local mob = enemydb.get(wave.name)

    local obj = {
        name = wave.name,
        x = level.current().startx,
        y = level.current().starty,
        alive = true,
        waypoint = 0,
        group = newGroup(parentGroup),

        type = wave.type,

        movedirection = nil,

        --visual
        width = mob.width,
        height = mob.height,
        image = mob.image,
        offsetx = mob.offsetx or 0,
        offsety = mob.offsety or 0,

        --base stats
        life = wave.life,
        maxlife = wave.life,
        movespeed = wave.movespeed,
        playerdamage = wave.playerdamage,
        experience = wave.experience,
        bounty = wave.bounty,
    }

    mob = nil

    obj.index = indexer.add("e",obj)
    setmetatable(obj, methods)

    obj.model = display.newImageRect(obj.group, obj.image, obj.width, obj.height)
    setAnchor(obj.model, 0.5, 0.5)

    obj.model.x = obj.x + obj.offsetx
    obj.model.y = obj.y + obj.offsety
end