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

function SceneObject:addEventHandler(handler)
	if not self.eventHandlers then self.eventHandlers = {} end
	self.eventHandlers[handler] = true
end

function SceneObject:removeEventHandler(handler)
	if not self.eventHandlers then return end
	self.eventHandlers[handler] = nil
end

function SceneObject:sendMessage(name, ...)
	local eventHandlers = self.eventHandlers
	if not eventHandlers then return end
	for handler, _ in pairs(eventHandlers)
		handler(self, name, ...)
	end
end

return SceneObject