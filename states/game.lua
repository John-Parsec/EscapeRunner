local game = {}

function game:init()
    level = 1
    world = WR.newWorld(0, 300000)
    world:addCollisionClass('Spike')
    world:addCollisionClass('Begin')
    world:addCollisionClass('Final')
    world:addCollisionClass('Player', {ignores = {'Spike', 'Final', 'Begin'}})
    
    cam = Camera()

    startTime = love.timer.getTime()
    totalTime = 1 * 60


    maps = {}
    table.insert(maps, Sti('assets/maps/fase1.lua'))
    table.insert(maps, Sti('assets/maps/fase2.lua'))
    table.insert(maps, Sti('assets/maps/fase3.lua'))


    player = {}
    player.collider = world:newBSGRectangleCollider(0, 0, 27, 32, 5)
    player.collider:setFixedRotation(true)
    player.collider:setCollisionClass('Player')
    player.collider:setObject(self)
    player.x = 0
    player.y = 0
    player.speed = 250
    player.jumpForce = -600000
    player.isJumping = false
    player.spriteSheet = love.graphics.newImage('assets/images/Quote.png')
    player.grid = anim8.newGrid( 32, 32, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )  

    player.animations = {}
    player.animations.left = anim8.newAnimation( player.grid('1-3', 1), 0.2 )
    player.animations.right = anim8.newAnimation( player.grid('1-3', 2), 0.2 )
    
    player.anim = player.animations.right

    define_collisions()
end

function game:enter()

end

function game:update(dt)
    world:update(dt)
    player.x = player.collider:getX() - 16
    player.y = player.collider:getY() - 16

    local elapsedTime = love.timer.getTime() - startTime

    remainingTime = totalTime - elapsedTime
    
    if remainingTime <= 0 then
        State.switch(States.menu)
    end

    if player.collider:enter('Spike') then
        State.switch(States.game_over)
    end

    if player.collider:enter('Final') then
        if level == 1 then
            level = 2
            destroy_collisions()
            define_collisions()
            local x, y = begins[1]:getPosition()
            player.collider:setPosition(x, y )
        elseif level == 2 then
            level = 3
            destroy_collisions()
            define_collisions()
            local x, y = begins[1]:getPosition()
            player.collider:setPosition(x, y )
        elseif level == 3 then
            State.switch(States.final)
        end
    end

    local isMoving = false

    local vx = 0

    if love.keyboard.isDown("right") then
        vx = player.speed
        player.anim = player.animations.right
        isMoving = true
    end

    if love.keyboard.isDown("left") then
        vx = player.speed * -1
        player.anim = player.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("space") and not player.isJumping then
        player.collider:applyLinearImpulse(0, player.jumpForce)
    end

    player.collider:setLinearVelocity(vx, 0)

    if isMoving == false then
        player.anim:gotoFrame(1)
    end


    player.anim:update(dt)

    cam:lookAt(player.x, player.y)

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

        player.anim:draw(player.spriteSheet, player.x, player.y)
        --world:draw()
    cam:detach()

    local minutes = math.floor(remainingTime / 60)
    local seconds = math.floor(remainingTime % 60)

    local timeText = string.format("%02d:%02d", minutes, seconds)

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 50, 20)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(timeText, 0, 0)
end

function define_collisions()
    begins = {}
    if maps[level].layers["Begin"] then
        for i, obj in ipairs(maps[level].layers["Begin"].objects) do
            local begin = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            begin:setType('static')
            begin:setCollisionClass('Begin')
            begin:setObject(self)
            table.insert(begins, begin)
        end
    end

    walls = {}
    if maps[level].layers["Wall"] then
        for i, obj in ipairs(maps[level].layers["Wall"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end

    spikes = {}
    if maps[level].layers["Spike"] then
        for i, obj in ipairs(maps[level].layers["Spike"].objects) do
            local spike = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            spike:setType('static')
            spike:setCollisionClass('Spike')
            spike:setObject(self)
            table.insert(spikes, spike)
        end
    end

    finals = {}
    if maps[level].layers["Final"] then
        for i, obj in ipairs(maps[level].layers["Final"].objects) do
            local final = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            final:setType('static')
            final:setCollisionClass('Final')
            final:setObject(self)
            table.insert(finals, final)
        end
    end
end

function destroy_collisions()
    for i, obj in ipairs(begins) do
        obj:destroy()
    end

    for i, obj in ipairs(walls) do
        obj:destroy()
    end

    for i, obj in ipairs(spikes) do
        obj:destroy()
    end

    for i, obj in ipairs(finals) do
        obj:destroy()
    end
end


return game
