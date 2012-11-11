local Class = require "Class"
local Game = Class()
local SceneManager = require "SceneManager"

function Game:__init__()
	self.sceneManager = SceneManager()
	self.renderableObjects = {}
	self.entities = {player = self.sceneManager:aquireObject("Player", self)}
	love.graphics.setBackgroundColor(255, 255, 255)
end

function Game:onRender()
	for _, entity in pairs(self.entities) do
		local f = entity.onRender
		if f then f(entity) end
	end
end

function Game:onUpdate(seconds)
	if not self.isInPlanningMode then
		for _, entity in pairs(self.entities) do
			local f = entity.onUpdate
			if f then f(entity, seconds) end
		end
	end
end

function Game:onMousePress(x, y, button)
	for _, entity in pairs(self.entities) do
		local f = entity.onMousePress
		if f then
			f(entity, x, y, button)
		end
	end
end

function Game:onKeyPress(key, unicode)
	if key == " " then
		self.isInPlanningMode = not self.isInPlanningMode
	end
end

return Game