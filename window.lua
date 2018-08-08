local window = {}

window.lookingAt = {0,0}
window.panSpeed = 2
window.zoomRatio = 5 --how many pixels a grid "Block" should be
window.maxZoomRatio = 100
window.zoomSpeed = .1
local cameraMoveSpeed = zoomRatio

function window.moveCamera(left, right, up, down, zoomin, zoomout)
    if zoomin then
        window.zoomRatio = window.zoomRatio - window.zoomSpeed
    end
    if zoomout then
        window.zoomRatio = window.zoomRatio + window.zoomSpeed
    end

    --keep zoom in bounds
    if window.zoomRatio <= window.minZoomRatio then
        window.zoomRatio = window.zoomRatio + window.zoomSpeed
    end
    if window.zoomRatio > 10 then
        window.zoomRatio = window.zoomRatio - window.zoomSpeed
    end

    dx = 0
    dy = 0
    if left then
        dx = dx + window.panSpeed
    end
    if right then
        dx = dx - window.panSpeed
    end
    if up then
        dy = dy + window.panSpeed
    end
    if down then
        dy = dy - window.panSpeed
    end
    window.lookingAt[1] = window.lookingAt[1] + dx
    window.lookingAt[2] = window.lookingAt[2] + dy
    window.lookingAt[1] = math.min(window.lookingAt[1], 0)
    window.lookingAt[2] = math.min(window.lookingAt[2], 0)

    --print(left,right,up,down,zoomin,zoomout,window.zoomRatio)
end

--function keepViewInBounds()

function window.setBounds(gridWidth, gridHeight, gridSize)
    windowWidth, windowHeight = love.window.getMode()
    window.minZoomRatio = math.min(windowWidth/gridWidth, windowHeight/gridHeight)
end

function window.gridToWorldCoordinates(gridX, gridY)

    return gridX*window.zoomRatio+window.lookingAt[1],
            gridY*window.zoomRatio+window.lookingAt[2], window.zoomRatio
end

return window
