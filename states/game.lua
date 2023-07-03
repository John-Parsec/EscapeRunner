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
    Player.update(dt)
    world:update(dt)

    local playerX, playerY = Player.getPosition()
    cam:lookAt(playerX, playerY)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    
    if cam.x < w/2 then
        cam.x = w/2
    end
    
    if cam.y < h/2 then
        cam.y = h/2
    end
    
    local mapW = maps[level].width * maps[level].tilewidth
    local mapH = maps[level].height * maps[level].tileheight
    
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end

    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end
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

        Player.draw()
        world:draw()
    cam:detach()
end


return game
