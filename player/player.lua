local player = {}

function player:init()
    player.x = 0
    player.y = 0
    player.speed = 5
    player.spriteSheet = love.graphics.newImage('assets/images/Quote.png')
    player.grid = anim8.newGrid( 32, 32, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

    player.animations = {}
    player.animations.left = anim8.newAnimation( player.grid('1-3', 1), 0.2 )
    player.animations.right = anim8.newAnimation( player.grid('1-3', 2), 0.2 )

    player.anim = player.animations.right
end

function player:update(dt)

end

function player:draw()
    player.anim:draw(player.spriteSheet, player.x, player.y)
end

return player