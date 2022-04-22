import "CoreLibs/sprites"

class('Brick').extends(playdate.graphics.sprite)

local gfx<const> = playdate.graphics
local geom = playdate.geometry

local width = 50
local height = 15

function Brick:init(x, y)
    Brick.super.init(self)

    self:setCenter(0, 0)
    self:setBounds(0, 0, width, height)
    self:setCollideRect(0, 0, width, height)
    self:moveTo(x, y)

    self:add()
end

function Brick:draw(x, y, w, h)
    gfx.setColor(gfx.kColorWhite)
    gfx.setBackgroundColor(gfx.kColorWhite)
    gfx.fillRect(0, 0, width, height)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(0, 0, width, height)
end
