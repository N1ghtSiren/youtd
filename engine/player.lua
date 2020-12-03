player = {}

local p = {
    gold = 100,
    life = 100,
    books = 100,
    food = 0,
    foodmax = 65,
}

function player.reset()
    p.gold = 100
    p.life = 100
    p.books = 100
    p.food = 0
    p.foodmax = 65

    interface.setBooks(p.books)
    interface.setGold(p.gold)
    interface.setLife(p.life)
    interface.setFood(p.food, p.foodmax)
end

function player.addGold(amount)
    p.gold = p.gold + amount
    interface.setGold(p.gold)
end

function player.addBooks(amount)
    p.books = p.books + amount
    interface.setBooks(p.books)
end

function player.addFood(amount)
    p.food = p.food + amount
    interface.setFood(p.food, p.foodmax)
end

function player.addMaxFood(amount)
    p.foodmax = p.foodmax + amount
    interface.setFood(p.food, p.foodmax)
end

function player.damage(amount, lifeleft, monstername)
    p.life = p.life - amount
    interface.setLife(p.life)
    gamelog.add(monstername.." passed with "..lifeleft.." life left; you took "..amount.." damage")
end