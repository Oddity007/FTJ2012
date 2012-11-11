return function(constructionData)
	local image = constructionData.image
	return function(object, messageName, ...)
		local position = object:getAttribute("position")
		if messageName == "onRender" then love.graphics.draw(image, position.x, position.y) end
	end
end