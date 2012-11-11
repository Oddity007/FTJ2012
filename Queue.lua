local Class = require "Class"
local Queue = Class()

function Queue:__init__()
	self.items = {}
	self.first = 0
	self.count = 0
end

function Queue:enqueue(item)
	if self.first > 10 then
		local newItems = {}
		local items = self.items
		local first = self.first
		for i = 0, self.count-1 do
			newItems[i + 1] = items[first + i]
		end
		self.first = 0
		self.items = newItems
	end
	self.count = self.count + 1
	self.items[self.first + self.count] = item
end

function Queue:dequeue()
	local item = self.items[self.first]
	self.items[self.first] = nil
	self.first = self.first + 1
	self.count = self.count - 1
	return item
end

local function Iterate(items, index)
	index = index + 1
	local item = items[index]
	if item then return index, item end
	return nil
end

function Queue:pairs()
	return Iterate, queue.items, queue.first
end

return Queue