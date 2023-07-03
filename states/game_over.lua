local gameover = {}

function gameover.load()
    
end

function gameover.update(dt)
    if love.keyboard.isDown("escape") then
        State.switch(States.menu)
    end
end

function gameover.draw()
    love.graphics.setColor(1, 0, 0) -- Vermelho
    love.graphics.setFont(love.graphics.newFont(24))
    
    -- Desenhe o texto "Você Perdeu" no centro da tela
    local text = "Você Perdeu"
    local textWidth = love.graphics.getFont():getWidth(text)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local textX = (screenWidth - textWidth) / 2
    local textY = screenHeight / 2 - love.graphics.getFont():getHeight() / 2
    love.graphics.print(text, textX, textY)
    
    -- Desenhe o texto "Aperte Esc para ir pro menu" logo abaixo do texto principal
    local subText = "Aperte Esc para ir pro menu"
    local subTextWidth = love.graphics.getFont():getWidth(subText)
    local subTextX = (screenWidth - subTextWidth) / 2
    local subTextY = textY + love.graphics.getFont():getHeight() + 20
    love.graphics.print(subText, subTextX, subTextY)
end

return gameover