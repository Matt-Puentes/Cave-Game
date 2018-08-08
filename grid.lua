local w = require "window"

local grid = {}

grid.gridWidth = 150
grid.gridHeight = 150
grid.deathCount = 3
grid.birthCount = 4
gameGrid = {}

function grid.getGameGrid()
    return gameGrid
end

function grid.generateGrid(chanceToBeBorn)
    --print("makin w/ ", chanceToBeBorn)
    newGrid = {}
    for i = 1, grid.gridWidth do
        newGrid[i] = {}
        for j = 1, grid.gridHeight do
            if(math.random() < chanceToBeBorn) then
                newGrid[i][j] = 1
            else
                newGrid[i][j] = 0
            end
        end
    end
    gameGrid = newGrid
end

function grid.stepGridGeneration()
    local newGrid = gameGrid
    for x = 1, grid.gridWidth do
        for y = 1, grid.gridHeight do
            --Get the neighbors of each cell
            neighbors = getCellNeighbors(x,y)
            --If the cell is dead, see if it should live
            if gameGrid[x][y] == 0 then
                if neighbors > grid.birthCount then
                    newGrid[x][y] = 1
                end
            else -- If the cell is alive, see if it should die
                if neighbors < grid.deathCount then
                    newGrid[x][y] = 0
                end
            end
        end
    end
    gameGrid = newGrid
end

function getCellNeighbors(x,y)
    local neighbors = 0
    for i = -1, 1 do
        for j = -1, 1 do
            --Don't count the cell itself
            if not (i == 0 and j == 0) then
                --Make sure the check is in-bounds
                if x+i <= grid.gridWidth and y+j <= grid.gridHeight and x+i > 0 and y+j > 0 then
                    if gameGrid[x+i][y+j] ~= 0 then
                        neighbors = neighbors + 1
                    end
                else
                    neighbors = neighbors + 1
                end
            end
        end
    end
    return neighbors
end
--[[
function grid.drawGrid()
    print(grid.gridSize)
    for x = 1, #gameGrid do
        for y = 1, #gameGrid[x] do
            love.graphics.setColor(0, 0.4, 0.4)
            if gameGrid[x][y] ~= 0 then
                love.graphics.setColor(0.2, 0, 0.2)
            end
            local screenSize = grid.gridSize--*w.zoomRatio
            love.graphics.rectangle("fill", (x-1)*screenSize, (y-1)*screenSize,
                                    screenSize, screenSize)
        end
    end
end
]]

return grid
