local Class = require "Class"

local SceneObject = Class()

function SceneObject:__init__()
	
end

function SceneObject:getAttribute(name)
	return self.attributes and self.attributes[name] or nil
end

function SceneObject:setAttribute(name, to)
	if not self.attributes then self.attributes = {} end
	self.attributes[name] = to
end

function SceneObject:addMessageHandler(handler)
	if not self.messageHandlers then self.messageHandlers = {} end
	for i, v in pairs(self.messageHandlers) do
		if v == handler then return false
		else v == nil then
			self.messageHandlers[i] = handler
			return true
		end
	end
	self.messageHandlers[#self.messageHandlers] = handler
	return true
end

function SceneObject:removeMessageHandler(handler)
	if not self.messageHandlers then return end
	for i, v in pairs(self.messageHandlers) do
		if v == handler then
			self.messageHandlers[i] = nil
			return true
		end
	end
	return false
end

function SceneObject:sendMessage(name, ...)
	local messageHandlers = self.messageHandlers
	if not messageHandlers then return end
	for handler, _ in pairs(messageHandlers)
		handler(self, name, ...)
	end
end

return SceneObject