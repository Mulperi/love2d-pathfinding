-- 1. make zip and rename it to .love
-- 2. copy /b love.exe+mygame.love mygame.exe
-- or cmd /c copy /b love.exe+mygame.love mygame.exe

-- D:\repos\love-11.4-win64/lovec.exe .
function love.load()
    TileSize = 16
    GridLength = 32

    Grid = require "grid"
    Grid:init(TileSize, GridLength)
    Terrain = require "terrain"
    Terrain:generate(Grid.cells, 2)
    Cursor = require "cursor"
end

function love.keypressed(key)
    Cursor:keypressed(key, #Grid.cells)

    if key == "up"
        or key == "right"
        or key == "down"
        or key == "left"
    then
        if Cursor.selected then
            Grid:findPath(Cursor.selected.x, Cursor.selected.y, Cursor.pos.x, Cursor.pos.y)
        end
    end

    if key == "escape" then
        love.event.quit()
    end

    if key == "space" then
        Grid:init(TileSize, GridLength)
        Terrain:generate(Grid.cells, 2)
        Cursor.selected = nil
    end
end

function love.update(dt)
end

function love.draw(dt)
    Terrain:draw(Grid.cells, Grid.tileSize)
    Grid:draw()
    Cursor:draw(Grid)
end
