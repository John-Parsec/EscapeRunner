local menu = {}

function menu:init()
    selectedOption = 1
    options = {
        "Novo Jogo",
        "Carregar",
        "Sobre",
        "Sair"
    }
end

function menu:update(dt)

end


function menu:keypressed(key)
    if key == "up" then
        selectedOption = selectedOption - 1
        if selectedOption < 1 then
            selectedOption = #options
        end
    elseif key == "down" then
        selectedOption = selectedOption + 1
        if selectedOption > #options then
            selectedOption = 1
        end
    elseif key == "return" then
        if selectedOption == 1 then
            State.switch(States.game)
        elseif selectedOption == 2 then
            
        elseif selectedOption == 3 then

        elseif selectedOption == 4 then
            love.event.quit()
        end
    end
end


function menu:mousepressed(x, y, mbutton)

end

function menu:draw()
    love.graphics.clear()

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.print("Cave Story - escape Runner", 200, 100)

    for i, option in ipairs(options) do
        if i == selectedOption then
            love.graphics.setColor(1, 0, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end

        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.print(option, 250, 200 + i * 50)
    end
end

return menu
