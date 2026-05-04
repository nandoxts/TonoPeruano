
local DualSlider = script.Parent
local BaseSliderObject = DualSlider.Parent
local EasySlider = BaseSliderObject.Parent
local Util = require(EasySlider:WaitForChild("Util"))

local Input = Util.Input
local BaseSlider = require(BaseSliderObject)

local LimitedSlider = {}
LimitedSlider.__index = setmetatable(LimitedSlider, BaseSlider)

function LimitedSlider.new(Container)
	local self = setmetatable(
		BaseSlider.new(Container),
		LimitedSlider
	)
	
	self.Minimum = 0
	self.Maximum = 1
	
	return self
end

function LimitedSlider:_CalculatePercent()
	local ContainerPosition = self.Container.AbsolutePosition
	local ContainerSize = self.Container.AbsoluteSize
	local InputPosition = Input:GetInputPosition()
	
	local StartDifference = InputPosition.X - ContainerPosition.X
	local Percent = StartDifference / ContainerSize.X
	local ClampedPercent = math.clamp(Percent, self.Minimum, self.Maximum)
	
	self:SetPercent(ClampedPercent)
end

function LimitedSlider:SetPercent(NewPercent)
	local Percent = math.clamp(NewPercent, self.Minimum, self.Maximum)
	if Percent ~= self._Percent then
		self._Percent = Percent
		self.PercentChanged:Fire(self._Percent)
	end
end

return LimitedSlider