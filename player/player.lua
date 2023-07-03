local player = {
    x = 0,
    y = 0,
    speed = 200,
}

local spriteSheet = love.graphics.newImage('assets/images/Quote.png')
local grid = anim8.newGrid( 32, 32, spriteSheet:getWidth(), spriteSheet:getHeight() )

local animations = {
    left = anim8.newAnimation( grid('1-3', 1), 0.2 ),
    right = anim8.newAnimation( grid('1-3', 2), 0.2 )
}

local anim = animations.right


function updatePlayer(dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed * dt
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed * dt
    end

    anim:update(dt)
end

function drawPlayer()
    anim:draw(spriteSheet, player.x, player.y)
end

function getPosition()
    return player.x, player.y
end

return {
    player,
    getPosition = getPosition,
    update = updatePlayer,
    draw = drawPlayer
}