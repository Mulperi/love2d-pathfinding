require("bfs")

function GridCreate()
    return {
        tileSize = 16,
        cells = {},
        path = {},
        findPath = function(self, startX, startY, targetX, targetY)
            -- Clear visited information and parent info since they are related to path.
            -- TODO: Move these fields to pathfinding.
            for x = 1, #self.cells do
                for y = 1, #self.cells do
                    self.cells[x][y].visited = false
                    self.cells[x][y].parent = nil
                end
            end

            self.path = Bfs(self.cells[startX][startY], self.cells[targetX][targetY])
            print(startX .. "-" .. startY .. " -> " .. targetX .. "-" .. targetY)
            print(#self.path)
        end,
        init = function(self, tileSize, gridLength)
            self.tileSize = tileSize
            print(gridLength)
            -- Init cells.
            for x = 1, gridLength do
                print(x)
                self.cells[x] = {}
                for y = 1, gridLength do
                    self.cells[x][y] = {
                        x = x,
                        y = y,
                        visited = false,
                        blocked = false,
                        stepsToTarget = nil,
                        terrainValue = nil,
                        parent = nil,
                        neighbors = {
                            nil, -- North.
                            nil, -- East.
                            nil, -- South.
                            nil, -- West.
                        }        -- Array of cells (nil if no neighbor).
                    }
                end
            end

            -- Set neighbors.
            for x = 1, gridLength do
                for y = 1, gridLength do
                    -- North neighbor.
                    if y == 1 then
                        self.cells[x][y].neighbors[1] = nil
                    else
                        self.cells[x][y].neighbors[1] = self.cells[x][y - 1]
                    end
                    -- East neighbor.
                    if x == gridLength then
                        self.cells[x][y].neighbors[2] = nil
                    else
                        self.cells[x][y].neighbors[2] = self.cells[x + 1][y]
                    end
                    -- South neighbor.
                    if y == gridLength then
                        self.cells[x][y].neighbors[3] = nil
                    else
                        self.cells[x][y].neighbors[3] = self.cells[x][y + 1]
                    end
                    -- West neighbor.
                    if x == 1 then
                        self.cells[x][y].neighbors[4] = nil
                    else
                        self.cells[x][y].neighbors[4] = self.cells[x - 1][y]
                    end
                end
            end

            self.path = {}
        end,
        draw = function(self, debug)
            for x = 1, #self.cells do
                for y = 1, #self.cells do
                    local cell = self.cells[x][y]

                    if debug and cell.blocked then
                        love.graphics.setColor(1, 0, 0, 0.5)
                        love.graphics.rectangle("line", x * self.tileSize, y * self.tileSize, self.tileSize,
                            self.tileSize)
                        love.graphics.setColor(1, 0, 0, 1)
                        love.graphics.print(x .. "-" .. y, x * self.tileSize, y * self.tileSize)
                    end



                    -- if cell.visited then
                    --     love.graphics.setColor(1, 1, 1, 0.2)
                    --     love.graphics.rectangle("fill", x * self.tileSize, y * self.tileSize, self.tileSize,
                    --         self.tileSize)
                    -- end

                    -- Lines.
                    -- love.graphics.setColor(1, 2, 0, 1)
                    -- love.graphics.rectangle("line", x * self.tileSize, y * self.tileSize, self.tileSize, self.tileSize)
                end
            end

            for i = 1, #self.path do
                -- Path line.
                love.graphics.setColor(0, 1, 0, 1)
                love.graphics.rectangle("line",
                    self.path[i].x * self.tileSize - self.tileSize,
                    self.path[i].y * self.tileSize - self.tileSize,
                    self.tileSize,
                    self.tileSize)
                -- Path target.
                if i == 1 then
                    love.graphics.setColor(0, 1, 0, 0.5)
                    love.graphics.rectangle("fill",
                        self.path[i].x * self.tileSize - self.tileSize,
                        self.path[i].y * self.tileSize - self.tileSize,
                        self.tileSize,
                        self.tileSize)
                end
                -- Path start.
                if i == #self.path then
                    love.graphics.setColor(1, 1, 1, 0.5)
                    love.graphics.rectangle("fill",
                        self.path[i].x * self.tileSize - self.tileSize,
                        self.path[i].y * self.tileSize - self.tileSize,
                        self.tileSize,
                        self.tileSize)
                end
            end
        end
    }
end

return GridCreate()
