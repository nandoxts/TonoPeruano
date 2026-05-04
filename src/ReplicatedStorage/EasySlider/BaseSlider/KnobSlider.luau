
local BaseSlider = require(script.Parent)

local KnobSlider = {}
KnobSlider.__index = setmetatable(KnobSlider, BaseSlider)

function KnobSlider.new(Container, Trigger, Bar)
	local self = setmetatable(
		BaseSlider.new(Container),
		KnobSlider
	)
	
	self.Trigger = Trigger
	self.Bar = Bar
	
	Trigger.MouseButton1Down:Connect(function()
		self:StartDragging()
	end)
	
	return self
end

function KnobSlider:Refresh()
	local TriggerPadding = (self.Trigger.AbsoluteSize.X / self.Container.AbsoluteSize.X) / 2
	
	self.Bar.Size = UDim2.fromScale(
		math.clamp(
			self:GetPercent(),
			TriggerPadding,
			1 - TriggerPadding
		),
		1
	)
end

return KnobSlider