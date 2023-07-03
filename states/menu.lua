local menu = {}

function menu:init()
    self.selectedOption = 1
    self.options = {
        "Novo Jogo",
        "Tierlist",
        "Sobre",
        "Sair"
    }
end

function menu:update(dt)

end


function menu:keypressed(key)
    if key == "up" then
        self.selectedOption = self.selectedOption - 1
        if self.selectedOption < 1 then
            self.selectedOption = #self.options
        end
    elseif key == "down" then
        self.selectedOption = self.selectedOption + 1
        if self.selectedOption > #self.options then
            self.selectedOption = 1
        end
    elseif key == "return" then
        if self.selectedOption == 1 then
            State.switch(States.game)
        elseif self.selectedOption == 2 then
            State.switch(States.tierlist)
        elseif self.selectedOption == 3 then
            State.switch(States.about)
        elseif self.selectedOption == 4 then
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

    for i, option in ipairs(self.options) do
        if i == self.selectedOption then
            love.graphics.setColor(1, 0, 0)
        else
            love.graphics.setColor(1, 1, 1)
        end

        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.print(option, 250, 200 + i * 50)
    end
end

return menu
