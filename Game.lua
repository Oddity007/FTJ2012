local Class = require "Class"
local Game = Class()
local SceneManager = require "SceneManager"

local LowerActionButtonWidth, LowerActionButtonHeight = 50, 50

function Game:__init__()
	self.sceneManager = SceneManager()
	self.renderableObjects = {}
	self.entities = {player = self.sceneManager:aquireObject("Player", self)}
	love.graphics.setBackgroundColor(255, 255, 255)
	self.actionBar = {actions = {{name = "Move"}, {name = "Shoot"}, {name = "Bomb"}}}
end

function Game:onRender()
	if self.isInPlanningMode then
		love.graphics.setLine(3, "smooth")
		local mouseX, mouseY = love.mouse.getPosition()
		local windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
		local w = LowerActionButtonWidth
		local h = LowerActionButtonHeight
		local x = 0
		local y = windowHeight - h
		for _, action in pairs(self.actionBar.actions) do
			local name = action.name or "???"
			local isSelected = (self.selectedAction == action)
			if isSelected then love.graphics.setColor(255, 255, 255, 255)
			else love.graphics.setColor(127, 127, 127, 255) end
			love.graphics.rectangle("fill", x, y, w, h)
			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.rectangle("line", x, y, w, h)
			local isHovered = (x < mouseX and x + w > mouseX) and (y < mouseY  and y + h > mouseY)
			if isHovered then
				love.graphics.setColor(0, 0, 0, 255)
				love.graphics.print(name, mouseX, mouseY)
			end
			x = x + w
		end
	end

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

function Game:onMousePress(mouseX, mouseY, button)
	if self.isInPlanningMode then
		local mouseX, mouseY = love.mouse.getPosition()
		local windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
		local w = LowerActionButtonWidth
		local h = LowerActionButtonHeight
		local x = 0
		local y = windowHeight - h
		for _, action in pairs(self.actionBar.actions) do
			local isClicked = (x < mouseX and x + w > mouseX) and (y < mouseY  and y + h > mouseY)
			if isClicked then
				self.selectedAction = action
				return
			end
			x = x + w
		end
		
		if self.selectedAction then
			if self.selectedAction.name == "Shoot" then
				self.entities.player.firingTargetX, self.entities.player.firingTargetY = mouseX, mouseY
			elseif self.selectedAction.name == "Move" then
				local action = {x = mouseX, y = mouseY, type = "move"}
				self.entities.player:pushAction(action)
				--self.targetX, self.targetY = x, y
			end
		end
	end
	
	for _, entity in pairs(self.entities) do
		local f = entity.onMousePress
		if f then
			f(entity, mouseX, mouseY, button)
		end
	end
end

function Game:onKeyPress(key, unicode)
	if key == " " then
		self.isInPlanningMode = not self.isInPlanningMode
	end
end

return Game