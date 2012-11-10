local Class = require "Class"
local SceneObject = require "SceneObject"

local ComponentConstructors = require "Components/ComponentConstructorTable"

return function(data)
	local object = SceneObject()
	object.attributes = data.attributes
	if data.components then
		for componentName, componentData in pairs(data.components) do
			local componentConstructor = ComponentConstructors[componentName]
			if componentConstructor then object:addEventHandler(componentConstructor(componentData)) end
		end 
	end
	return object
end