
local BaseSlider = script.Parent
local EasySlider = BaseSlider.Parent
local LimitedSlider = require(script:WaitForChild("LimitedSlider"))

local Util = require(EasySlider:WaitForChild("Util"))
local Signal = Util.Signal

local DualSlider = {}
DualSlider.__index = DualSlider

function DualSlider.new(Container, Min, Max, Middle)
	local self = setmetatable({}, DualSlider)
	
	self.MinSlider = LimitedSlider.new(Container)
	self.MaxSlider = LimitedSlider.new(Container)
	self.MinTrigger = Min
	self.MaxTrigger = Max
	self.Container = Container
	self.Middle = Middle
	
	self.PercentChanged = Signal.new()
	self.DraggingStarted = Signal.new()
	self.DraggingEnded = Signal.new()
	
	local MinPadding = (self.MinTrigger.AbsoluteSize.X / self.Container.AbsoluteSize.X) / 2
	local MaxPadding = (self.MaxTrigger.AbsoluteSize.X / self.Container.AbsoluteSize.X) / 2
	
	self.MinSlider.Minimum = 0
	self.MaxSlider.Maximum = 1
	self.MinSlider:SetPercent(self.MinSlider.Minimum)
	self.MaxSlider:SetPercent(self.MaxSlider.Maximum)
	self:Refresh()
	
	Min.MouseButton1Down:Connect(function()
		self.MinSlider:StartDragging()
	end)
	
	Max.MouseButton1Down:Connect(function()
		self.MaxSlider:StartDragging()
	end)
	
	self.MinSlider.PercentChanged:Connect(function()
		self:Refresh()
	end)
	
	self.MaxSlider.PercentChanged:Connect(function()
		self:Refresh()
	end)
	
	self.MinSlider.DraggingStarted:Connect(function()
		self.DraggingStarted:Fire()
	end)
	
	self.MaxSlider.DraggingStarted:Connect(function()
		self.DraggingStarted:Fire()
	end)
	
	self.MinSlider.DraggingEnded:Connect(function()
		self.DraggingEnded:Fire()
	end)
	
	self.MaxSlider.DraggingEnded:Connect(function()
		self.DraggingEnded:Fire()
	end)
	
	return self
end

function DualSlider:SetDefault(Min, Max)
	if Min > Max then
		error("Min cannot be greater than max")
	elseif Max < Min then
		error("Max cannot be less than min")
	end
	
	self.MinSlider:SetPercent(Min)
	self.MaxSlider:SetPercent(Max)
	self:Refresh()
end

function DualSlider:GetMinimum()
	return self.MinSlider:GetPercent()
end

function DualSlider:GetMaximum()
	return self.MaxSlider:GetPercent()
end

function DualSlider:Refresh()
	local MinPercent = self:GetMinimum()
	local MaxPercent = self:GetMaximum()
	local MinPadding = (self.MinTrigger.AbsoluteSize.X / self.Container.AbsoluteSize.X)
	local MaxPadding = (self.MaxTrigger.AbsoluteSize.X / self.Container.AbsoluteSize.X)
	
	self.MinSlider.Maximum = MaxPercent - MaxPadding
	self.MaxSlider.Minimum = MinPercent + MinPadding
	
	self.MaxTrigger.Position = UDim2.fromScale(
		math.clamp(
			MaxPercent,
			0,
			1 - (MaxPadding / 2)
		),
		0.5
	)
	
	self.MinTrigger.Position = UDim2.fromScale(
		math.clamp(
			MinPercent,
			MinPadding / 2,
			1
		),
		0.5
	)
	
	self.Middle.Size = UDim2.fromScale(
		MaxPercent - MinPercent,
		1
	)
	
	self.Middle.Position = UDim2.fromScale(
		MinPercent,
		0.5
	)
	
	self.PercentChanged:Fire(
		self:GetMinimum(),
		self:GetMaximum()
	)
end

return DualSlider