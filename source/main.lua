import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "paddle"
import "ball"

local gfx<const> = playdate.graphics
local sprite<const> = playdate.graphics.sprite
local geom = playdate.geometry

local screenWidth = playdate.display.getWidth()
local screenHeight = playdate.display.getHeight()
local edgePadding = 5

paddle = Paddle {
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

local topBlocker = sprite.new()
topBlocker:setCenter(0, 1)
topBlocker:setBounds(0, 0, screenWidth, 50)
topBlocker:setCollideRect(0, 0, screenWidth, 50)
topBlocker:moveTo(0, edgePadding)
topBlocker:add()

local bottomBlocker = sprite.new()
bottomBlocker.tag = "Bottom"
bottomBlocker:setCenter(0, 0)
bottomBlocker:setBounds(0, 0, screenWidth, 50)
bottomBlocker:setCollideRect(0, 0, screenWidth, 50)
bottomBlocker:moveTo(0, screenHeight - edgePadding)
bottomBlocker:add()

function killBallAndStartOver(ball)
    paddle:reset()
    ball:remove()
    ball:setUpdatesEnabled(false)
    playdate.wait(1000)
    spawnBall()
end

function spawnBall()
    local ball = Ball {
        radius = 5,
        speed = 5,
    }

    ball.collisionResponse = function(self, other)
        print("hit something")
        if (other == bottomBlocker) then
            killBallAndStartOver(ball)
        end
    end

    ball:moveTo(screenWidth / 2, paddle.y - ball.radius - edgePadding)
end

function playdate.update()
    sprite.update()
end

spawnBall()
