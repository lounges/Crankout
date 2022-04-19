import "CoreLibs/sprites"

class('Paddle').extends(playdate.graphics.sprite)

local gfx<const> = playdate.graphics

function Paddle:init(options)
    Paddle.super.init(self)

    local screenWidth = playdate.display.getWidth()
    local screenHeight = playdate.display.getHeight()

    self.speed = options.speed

    self:setCenter(0.5, 0)
    self:setBounds(0, 0, options.width, options.height)
    self:setCollideRect(0, 0, options.width, options.height)

    local yPosition =
    self:moveTo(screenWidth / 2, screenHeight - options.height - options.bottomPadding)
    self:add()
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
