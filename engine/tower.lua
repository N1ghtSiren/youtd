tower = {}
local parentGroup = group[2]

local methods = {}
methods.__index = methods

function methods.remove(self)
    self.model:removeSelf()
    indexer.remove("t", self)
end

function methods.onkill(self)
    for _, func in pairs(self.actions_onkill)do
        func(self)
    end
end

function methods.ondamage(self, target)
    if(self==nil or target==nil or target.alive==false)then return end

    local isKill, exp = target:ondamage(self.tempdamage)

    if(isKill)then
        self:addxp(exp)
    end
end

function methods.attack(self)
    if(self.target and self.cooldown>=self.cooldownmax)then
        
        self.tempdamage = self.damage
        --crits goes there

        for _, func in pairs(self.actions_onattack)do
            func(self, self.target)
        end

        if(self.mainattack)then
            self:mainattack(self.target)
        end

        self.cooldown = 0
    end
end

function methods.searchTarget(self)
    if(not self.target)then
        for _, e in pairs(indexer.gettable("e"))do
            if(dist2(self.x, self.y, e.x, e.y)<=self.range)then
                self.target = e
                break
            end
        end
    end
end

function methods.checkTarget(self)
    if(self.target)then
        if(dist2(self.x, self.y, self.target.x, self.target.y)>self.range or self.target.alive==false)then
            self.target = nil
        end
    end
end

function methods.update(self)
    self.cooldown = self.cooldown + 16.7
    self:searchTarget()
    self:checkTarget()
    self:attack()
end


function methods.onlvlup(self)
    for _, func in pairs(self.actions_onlvlup)do
        func(self)
    end
end

function methods.onlvldown(self)
    for _, func in pairs(self.actions_onlvldown)do
        func(self)
    end
end

function methods.addxp(self, amount)
    self.exp = self.exp + amount
    local oldlvl = self.lvl
    local newlvl = nil

    local function checkExp(exp)
        local c = 0
        local lvl = 25
        local nextlvl = 0

        for i = 1, 25 do
            c = c + i + 13
            if(exp<c)then lvl=i-1; nexlvl=c; break end
        end

        return lvl, nextlvl
    end

    newlvl = checkExp(self.exp)
    texttag.new(amount.." exp", self.x+math.random(-40,40), self.y+math.random(-10,10), 0.9)

    if(oldlvl~=newlvl)then
        local lvlup = (oldlvl<newlvl)
        local lvldiff = newlvl - oldlvl

        if(lvlup)then
            for i = 1, lvldiff, 1 do
                self:onlvlup()
                texttag.new("levelup!", self.x+math.random(-40,40), self.y+math.random(-10,10), 0.9)
            end
        else
            for i = -1, lvldiff, -1 do
                self:onlvldown()
                texttag.new("level lost!", self.x+math.random(-40,40), self.y+math.random(-10,10), 0.9)
            end
        end

        self.lvl = newlvl
    end

end

function tower.new(id, gridx, gridy)
    local tower = towerdb.get(id)

    local obj = {
        name = tower.name,
        x = gridx*100-50,
        y = gridy*100-50,
        group = newGroup(parentGroup),
        target = nil,

        exp = 0,
        lvl = 0,
        cooldown = 0,

        mainattack = tower.mainattack or false,
        tempdamage = 0,

        --unnecessary stats
        projectilespeed = tower.projectilespeed or 666,

        --base stats

        damage = tower.damage,
        range = tower.range,
        cooldownmax = tower.cooldownmax,

        --tables
        actions_special = tower.actions_special or {},
        actions_onattack = tower.actions_onattack or {},
        actions_onlvlup = tower.actions_onlvlup or {},
        actions_onlvldown = tower.actions_onlvldown or {},
        actions_onkill = tower.action_onkill or {},
    }

    obj.index = indexer.add("t", obj)
    setmetatable(obj, methods)
    
    obj.model = display.newImageRect(obj.group, tower.image, 100, 100)
    setAnchor(obj.model, 0.5, 0.5)
    obj.model.x = obj.x
    obj.model.y = obj.y
end