function TerrainCreate()
    return {
        setBlockedCells = function(self, grid, blockValue)
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    if cell.terrainValue == blockValue then
                        cell.blocked = true
                    end
                end
            end
        end,
        generate = function(self, grid, iterations)
            -- Create initial terrain values.
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    cell.terrainValue = love.math.random(1, 2) - 1 > 0 and 1 or 0
                end
            end

            -- Iterate and create terrain types.
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    local north = cell.neighbors[0] and cell.neighbors[0].terrainValue or 0
                    local east = cell.neighbors[1] and cell.neighbors[1].terrainValue or 0
                    local south = cell.neighbors[2] and cell.neighbors[2].terrainValue or 0
                    local west = cell.neighbors[3] and cell.neighbors[3].terrainValue or 0
                    for i = 1, iterations do
                        if north + east + south + west < 1 then
                            cell.terrainValue = 0
                        elseif north + east + south + west > 1 then
                            cell.terrainValue = 1
                        end
                    end
                end
            end

            -- Set blocked to cells that should be blocked.
            self:setBlockedCells(grid, 0)
        end,
        draw = function(self, grid, tileSize)
            for x = 1, #grid do
                for y = 1, #grid do
                    local cell = grid[x][y]
                    if cell.terrainValue == 1 then
                        love.graphics.setColor(0.2, 0.5, 0.2, 1)
                        love.graphics.rectangle("fill",
                            x * tileSize - tileSize,
                            y * tileSize - tileSize,
                            tileSize,
                            tileSize)
                    else
                        love.graphics.setColor(0.2, 0.5, 0.9, 1)
                        love.graphics.rectangle("fill",
                            x * tileSize - tileSize,
                            y * tileSize - tileSize,
                            tileSize,
                            tileSize)
                    end

                    -- Terrain value.
                    -- love.graphics.setColor(1, 1, 1, 1)
                    -- love.graphics.print(cell.terrainValue, x * tileSize, y * tileSize)
                end
            end
        end
    }
end

return TerrainCreate()
