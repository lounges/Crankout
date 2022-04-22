import "CoreLibs/sprites"
import "CoreLibs/sprites"

class('Ball').extends(playdate.graphics.sprite)

local gfx<const> = playdate.graphics
local geom = playdate.geometry

function Ball:init(options)
    Ball.super.init(self)

    self.speed = options.speed
    self.radius = options.radius

    --TODO: randomize between -0.5 and 0.5
    self.vector = geom.vector2D.new(-0.3, -1)
    print("spawning")

    self:setCenter(0.5, 0.5)
    self:setBounds(0, 0, options.radius * 2, options.radius * 2)
    self:setCollideRect(0, 0, options.radius * 2, options.radius * 2)

    self:add()
end

function Ball:draw(x, y, width, height)
    gfx.setColor(gfx.kColorWhite)
    gfx.setBackgroundColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(self.radius, self.radius, self.radius)
end

function Ball:destroy()
    print("destroying ball!")
    self:setUpdatesEnabled(false)
end

function Ball:update()
    local move = self.vector * self.speed
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + move.x, self.y + move.y)
    if (length > 0) then
        local hit = collisions[1]

        --reflect it
        local dn = 2 * self.vector:dotProduct(hit.normal)
        self.vector = self.vector - hit.normal * dn
    end
end
