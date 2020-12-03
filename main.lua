fontMain = native.newFont("content/comicsans.ttf")
--preload
require("mylib")
require("indexer")

display.setDefault("anchorX", 0)
display.setDefault("anchorY", 0)

composer = require("composer")
composer.loadScene("scenes.mainmenu")
composer.loadScene("scenes.levels")
composer.loadScene("scenes.level")

require("engine.enemy")
require("engine.gameloop")
require("engine.level")
require("engine.player")
require("engine.projectile")
require("engine.texttag")
require("engine.tower")
require("engine.wave")
require("engine.interface")
require("engine.gamelog")

require("content.enemydb")
require("content.towerdb")
--preload end
composer.gotoScene("scenes.mainmenu")