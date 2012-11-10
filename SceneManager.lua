local Class = require "Class"

local SceneManager = Class()

function SceneManager:__init__()
	self.aquiredObjects = setmetatable({}, {__mode = "v"})
end

function SceneManager:aquireObject(path, ...)
	local aquiredObject = self.aquiredObjects[path]
	if aquiredObject then return aquiredObject end
	aquiredObject = assert(loadfile("Data/" .. path .. ".lua"))(...)
	self.aquiredObjects[path] = aquiredObject
	return aquiredObject
end

return SceneManager