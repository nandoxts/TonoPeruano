
local RunService = game:GetService("RunService")

local EasySlider = script.Parent

local Util = require(EasySlider:WaitForChild("Util"))
local Signal = Util.Signal
local Input = Util.Input

local BaseSlider = {}
BaseSlider.__index = BaseSlider

function BaseSlider.new(Container)
	local self = setmetatable({}, BaseSlider)
	
	self.DraggingStarted = Signal.new()
	self.DraggingEnded = Signal.new()
	self.PercentChanged = Signal.new()
	
	self._Percent = nil
	self.Dragging = false
	
	self.Container = Container
	
	Input.InputEnded:Connect(function()
		if self.Dragging then
			self:StopDragging()
		end
	end)
	
	return self
end

function BaseSlider:SetPercent(NewPercent)
	if NewPercent ~= self._Percent then
		self._Percent = NewPercent
		self:Refresh()
		self.PercentChanged:Fire(self._Percent)
	end
end

function BaseSlider:GetPercent()
	return self._Percent
end

function BaseSlider:_CalculatePercent()
	local ContainerPosition = self.Container.AbsolutePosition
	local ContainerSize = self.Container.AbsoluteSize
	local InputPosition = Input:GetInputPosition()
	
	local StartDifference = InputPosition.X - ContainerPosition.X
	local Percent = StartDifference / ContainerSize.X
	local ClampedPercent = math.clamp(Percent, 0, 1)
	
	self:SetPercent(ClampedPercent)
end

function BaseSlider:Refresh()
	-- base implementation is empty
end

function BaseSlider:StartDragging()
	if not self.Dragging then
		RunService:BindToRenderStep("DraggerUpdate", 1, function()
			self:_CalculatePercent()
		end)
		
		self.Dragging = true
	end
end

function BaseSlider:StopDragging()
	if self.Dragging then
		RunService:UnbindFromRenderStep("DraggerUpdate")
		
		self.Dragging = false
	end
end

return BaseSlider