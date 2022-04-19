import "CoreLibs/sprites"

class('Paddle').extends(playdate.graphics.sprite)

local gfx<const> = playdate.graphics
local geom = playdate.geometry

function Paddle:init(options)
    Paddle.super.init(self)

    self.speed = options.speed
    self.normal = geom.vector2D.new(0, -1)
    self.initY = playdate.display.getHeight() - options.height - options.bottomPadding

    self:setCenter(0.5, 0)
    self:setBounds(0, 0, options.width, options.height)
    self:setCollideRect(0, 0, options.width, options.height)

    self:reset()

    self:add()
end

function Paddle:reset()
    self:moveTo(playdate.display.getWidth() / 2, self.initY)
end

function Paddle:draw(x, y, width, height)
    gfx.setColor(gfx.kColorWhite)
    gfx.setBackgroundColor(gfx.kColorWhite)
    gfx.fillRect(x, y, width, height)
end

function Paddle:update()
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        self:moveWithCollisions(self.x + self.speed, self.y)
    elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
        self:moveWithCollisions(self.x - self.speed, self.y)
    end
end
