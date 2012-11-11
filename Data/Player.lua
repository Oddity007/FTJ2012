local CurrentGame = ...
local CurrentPlayer = {x = 0, y = 0, targetX = 0, targetY = 0, queuedActions = {}, queuedActions}

function CurrentPlayer:pushAction(action)
	self.queuedActions[#self.queuedActions + 1] = action
	if self.queuedActions[1] then return end
	local newQueuedActions = {}
	local i = 1
	for _, action in pairs(self.queuedActions) do
		if action then
			newQueuedActions[i] = action
			i = i + 1
		end
	end
	self.queuedActions = newQueuedActions
end

function CurrentPlayer:onRender()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.circle("fill", self.x, self.y, 20, 50)
	love.graphics.setColor(255, 255 * 0.6, 255 * 0.5, 255)
	love.graphics.setLine(10, "smooth")
	local lastAction = self
	for _, action in pairs(self.queuedActions) do
		if action then
			--if lastAction then
				love.graphics.line(lastAction.x, lastAction.y, action.x, action.y)
			--end
			lastAction = action
		end
	end
end

function CurrentPlayer:onUpdate(seconds)
	--[[if love.mouse.isDown("r") then
		self.targetX, self.targetY = love.mouse.getPosition()
	end]]
	
	local firstAction = nil
	local firstActionIndex = nil
	local previousAction = nil
	for i, action in pairs(self.queuedActions) do
		if action then
			if not self.queuedActions[i - 1] then
				self.targetX, self.targetY = action.x, action.y
			end
			firstAction = action
			--firstAction.duration = firstAction.duration - seconds
			--[[if firstAction.duration < 0 then 
				self.queuedActions[i] = nil
			end]]
			
			firstActionIndex = i
			
			break
		end
	end
	
	if firstAction then
		local x, y = self.targetX, self.targetY
		x, y = x - self.x, y - self.y
		local distance = math.sqrt(x * x + y * y)
		if distance > 5 then
			x, y = x/distance, y/distance
			local speed = 500 * seconds
			self.x, self.y = self.x + x * speed, self.y + y * speed
		else
			self.queuedActions[firstActionIndex] = nil
		end
	end
end

function CurrentPlayer:onMousePress(x, y, button)
	if button == "l" then
		local action = {x = x, y = y, type = "attack"}
		self:pushAction(action)
		--self.targetX, self.targetY = x, y
	elseif button == "r" then
		local action = {x = x, y = y, type = "move"}
		self:pushAction(action)
		--self.targetX, self.targetY = x, y
	end
end

return CurrentPlayer