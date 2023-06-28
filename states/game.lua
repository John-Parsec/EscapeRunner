local game = {}

function game:init()
    map = Sti('assets/maps/fase2.lua')
end

function game:enter()

end

function game:update(dt)

end

function game:keypressed(key, code)

end

function game:mousepressed(x, y, mbutton)

end

function game:draw()
    map:draw()
end

return game
