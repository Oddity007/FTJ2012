--local SceneManager = require "SceneManager"
--local CurrentSceneManagerInstance
local Game = require "Game"
local CurrentGame

function love.load()
	--CurrentSceneManagerInstance = SceneManager()
	CurrentGame = Game()
end

--local circleX, circleY = 0, 0

function love.draw()
	CurrentGame:onRender()
	--love.graphics.circle("fill", circleX, circleY, 20, 50)
end

function love.focus(element)
	
end

--[[local targetX, targetY = 400, 400
local time = 0]]
function love.update(seconds)
	CurrentGame:onUpdate(seconds)
	--[[if love.mouse.isDown("r") then
		targetX, targetY = love.mouse.getPosition()
	end
	time = time + seconds
	if time > 10 then
		time = 0
		print(targetX, targetY)
	end
	local x, y = targetX, targetY
	x, y = x - circleX, y - circleY
	local distance = math.sqrt(x * x + y * y)
	if distance > 5 then
		x, y = x/distance, y/distance
		local speed = 1000 * seconds
		circleX, circleY = circleX + x * speed, circleY + y * speed
	end]]
	
end

function love.quit()
	
end

function love.mousepressed(x, y, button)
	CurrentGame:onMousePress(x, y, button)
end

function love.keypressed(key, unicode)
	CurrentGame:onKeyPress(key, unicode)
end