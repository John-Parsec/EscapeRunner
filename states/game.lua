local game = {}

function game:init()
    level = 1
    world = WR.newWorld(6, 0)
    cam = Camera()


    maps = {}
    table.insert(maps, Sti('assets/maps/fase1.lua'))
    table.insert(maps, Sti('assets/maps/fase2.lua'))
    table.insert(maps, Sti('assets/maps/fase3.lua'))

end

function game:enter()

end

function game:update(dt)
    
    world:update(dt)
end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, mbutton)

end

function game:draw()
    cam:attach()
        maps[level]:drawLayer(maps[level].layers["background"])
        maps[level]:drawLayer(maps[level].layers["blocos"])
        maps[level]:drawLayer(maps[level].layers["spikes"])

        Player:draw()
        world:draw()
    cam:detach()
end

return game
