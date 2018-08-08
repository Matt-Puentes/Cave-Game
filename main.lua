local g = require "grid"
local w = require "window"


function love.load()
    --init grid
    g.generateGrid(.40)
    w.setBounds(g.gridWidth, g.gridHeight, g.gridSize)
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    g.stepGridGeneration()

    if(love.keyboard.isDown("r")) then --Regenerate the grid
        g.generateGrid(.40)
    end

    w.moveCamera(love.keyboard.isDown("left", "a"),
                love.keyboard.isDown("right", "d"),
                love.keyboard.isDown("up", "w"),
                love.keyboard.isDown("down", "s"),
                love.keyboard.isDown("."),
                love.keyboard.isDown("/"))
end


-- Draw a coloured rectangle.
function love.draw()
    --draw grid
    drawGrid(g.getGameGrid())
    love.graphics.setColor(1,0,0)
    --[[x,y = w.getOldCenter()
    dx,dy = w.getNewCenter()
    drawX, drawY = w.gridToWorldCoordinates(x,y)
    love.graphics.circle("fill", x, y,
                            w.zoomRatio, w.zoomRatio)
    love.graphics.setColor(1,1,1)
    drawX, drawY = w.gridToWorldCoordinates(dx,dy)
    love.graphics.circle("fill", dx, dy,
                            w.zoomRatio, w.zoomRatio)
                            love.graphics.setColor(1,0,1)]]--
    love.graphics.circle("fill", 360,360,3,3)


end

function drawGrid(gameGrid)
    for x = 1, #gameGrid do
        for y = 1, #gameGrid[x] do
            love.graphics.setColor(0, 0.4, 0.4)
            if gameGrid[x][y] ~= 0 then
                love.graphics.setColor(0.2, 0, 0.2)
            end
            drawX, drawY = w.gridToWorldCoordinates(x-1,y-1)
            love.graphics.rectangle("fill", drawX, drawY,
                                    w.zoomRatio, w.zoomRatio)
        end
    end
end
