import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "paddle"

local gfx<const> = playdate.graphics
local sprite<const> = playdate.graphics.sprite

local screenWidth = playdate.display.getWidth()
local screenHeight = playdate.display.getHeight()
local edgePadding = 5

Paddle {
    width = 100,
    height = 15,
    bottomPadding = edgePadding,
    speed = 7
}

sprite.setBackgroundDrawingCallback(
    function(x, y, width, height)
        gfx.setClipRect(x, y, width, height)
        gfx.clear(gfx.kColorBlack)
        gfx.clearClipRect()
    end
)

local leftBlocker = sprite.new()
leftBlocker:setCenter(1, 0)
leftBlocker:setBounds(0, 0, 50, screenHeight)
leftBlocker:setCollideRect(0, 0, 50, screenHeight)
leftBlocker:moveTo(edgePadding, 0)
leftBlocker:add()

local rightBlocker = sprite.new()
rightBlocker:setCenter(0, 0)
rightBlocker:setBounds(0, 0, 50, screenHeight)
rightBlocker:setCollideRect(0, 0, 50, screenHeight)
rightBlocker:moveTo(screenWidth - edgePadding, 0)
rightBlocker:add()

function playdate.update()
    sprite.update()
end
