local Class = require "Class"
local Projectile = Class()

function Projectile:__init__(game, duration)
	self.x = 0
	self.y = 0
	self.velocityX = 0
	self.velocityY = 0
	self.game = game
	self.duration = duration
end

function Projectile:onRender()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.circle("fill", self.x, self.y, 10, 6)
end

function Projectile:onUpdate(seconds)
	self.x = self.x + self.velocityX * seconds
	self.y = self.y + self.velocityY * seconds
	if self.duration then
		if self.duration < 0 then
			for i, entity in pairs(self.game.entities) do
				if entity == self then
					self.game.entities[i] = nil
					break
				end
			end
		end
		self.duration = self.duration - seconds
	end
end

return Projectile