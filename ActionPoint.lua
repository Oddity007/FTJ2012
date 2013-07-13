local Class = require "Class"
local ActionPoint = Class()

function ActionPoint:__init__(type, target, id, x, y)
	self.type = type or "???"
	self.target = target
	self.id = id or 1
	self.x = x or 0
	self.y = y or 0
end

function ActionPoint:onRender()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print(self.type .. " " .. tostring(self.id), self.x, self.y)
end

