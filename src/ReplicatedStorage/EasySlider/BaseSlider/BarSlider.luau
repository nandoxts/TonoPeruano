
local BaseSlider = require(script.Parent)

local BarSlider = {}
BarSlider.__index = setmetatable(BarSlider, BaseSlider)

function BarSlider.new(Container, Trigger, Bar)
	local self = setmetatable(
		BaseSlider.new(Container),
		BarSlider
	)
	
	Trigger.MouseButton1Down:Connect(function()
		self:StartDragging()
	end)
	
	self.Bar = Bar
	
	return self
end

function BarSlider:Refresh()
	self.Bar.Size = UDim2.fromScale(
		self:GetPercent(),
		1
	)
end

return BarSlider