local about = {}

function about.update(dt)
    if love.keyboard.isDown("escape") then
        State.switch(States.menu)
    end
end

function about.draw()
    love.graphics.setColor(1, 1, 1)

    local credits = {
        "Este é um jogo homenagem a Cave Story",
        "Desenvolvedor: João 'John Parsec' Manoel A. oliveira",
        "Música: Studio Pixel",
        "Arte: Studio Pixel",
        "Trabalho de: TAC I - Jogos",
        "Professor responsavel: Elinaldo"
    }

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local startY = (screenHeight - (#credits * love.graphics.getFont():getHeight() + (#credits - 1) * 10)) / 2

    for i, text in ipairs(credits) do
        local textWidth = love.graphics.getFont():getWidth(text)
        local textX = (screenWidth - textWidth) / 2
        local textY = startY + (i - 1) * (love.graphics.getFont():getHeight() + 10)
        love.graphics.print(text, textX, textY)
    end
end

return about

