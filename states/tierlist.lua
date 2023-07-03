local tierlist = {}

function tierlist.load()
    records = {}
    
    if love.filesystem.getInfo("states/tierlist.txt") then
        local data = love.filesystem.read("states/tierlist.txt")
        
        records = love.data.decode("table", data)
    end
end

function tierlist.save()
    local data = love.data.encode("table", records)
    
    love.filesystem.write("tierlist.txt", data)
end

function tierlist.addRecord(name, time)
    local record = {
        name = name,
        time = time
    }
    
    table.insert(records, record)
    
    table.sort(records, function(a, b) return a.time < b.time end)
    
    while #records > 10 do
        table.remove(records, 1)
    end
    
    tierlist.save()
end

function tierlist.draw()
    love.graphics.setColor(1, 1, 1) -- Branco
    love.graphics.setFont(love.graphics.newFont(24))
    
    local title = "Top 10"
    local titleWidth = love.graphics.getFont():getWidth(title)
    local screenWidth = love.graphics.getWidth()
    local titleX = (screenWidth - titleWidth) / 2
    local titleY = 50
    love.graphics.print(title, titleX, titleY)
    
    local recordY = titleY + love.graphics.getFont():getHeight() + 20
    for i, record in ipairs(records) do
        local recordText = string.format("%d. %s - %d:%02d", i, record.name, math.floor(record.time / 60), record.time % 60)
        local recordTextWidth = love.graphics.getFont():getWidth(recordText)
        local recordTextX = (screenWidth - recordTextWidth) / 2
        love.graphics.print(recordText, recordTextX, recordY)
        recordY = recordY + love.graphics.getFont():getHeight() + 10
    end
end

return tierlist
