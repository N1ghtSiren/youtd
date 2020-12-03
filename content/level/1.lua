local obj = {}
obj.wpx = {}
obj.wpy = {}
obj.mobs = {}

obj.field = {   {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 1, 3, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 1, 2, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, }

obj.startx = 850
obj.starty = 450

obj.exitx = 870
obj.exity = 150

obj.startgold = 100
obj.startresearch = 80

obj.wpx[0] = obj.startx
obj.wpy[0] = obj.starty

obj.wpx[1] = 150
obj.wpy[1] = 450

obj.wpx[2] = 150
obj.wpy[2] = 150

obj.wpx[3] = obj.exitx
obj.wpy[3] = obj.exity

obj.maxwaves = 8

return obj