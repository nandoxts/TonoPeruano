
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local IsMobile = UserInputService.TouchEnabled

local Input = require(script:WaitForChild("Input"))

local Slider = {}
Slider.__index = Slider

function Slider.new(SliderButton, Container)
	local self = setmetatable({}, Slider)
	
	local ValueChangedEvent = Instance.new("BindableEvent")
	
	self.SliderButton = SliderButton
	self.Container = Container
	self.PercentChanged = ValueChangedEvent.Event
	self.ValueChangedEvent = ValueChangedEvent
	self.Dragging = false
	self.Percent = 0
	self.MinValue = 0
	self.MaxValue = 1
	
	SliderButton.AnchorPoint = Vector2.new(0.5, 0.5)
	SliderButton.MouseButton1Down:Connect(function()
		self:Start()
	end)
	
	self:SetPercent(0)
	
	return self
end

local function GetDragPosition()
	if IsMobile then
		return Input:GetTouchPosition()
	else
		return UserInputService:GetMouseLocation()
	end
end

local function FirePercentEvent(SliderClass, NewPercent)
	local ValueChangedEvent = SliderClass.ValueChangedEvent
	if ValueChangedEvent and NewPercent ~= SliderClass.Percent then
		SliderClass.Percent = NewPercent
		ValueChangedEvent:Fire(NewPercent)
	end
end

--function Slider:FirePercentEvent(NewPercent)
--	local ValueChangedEvent = self.ValueChangedEvent
--	if ValueChangedEvent then
--		local OldPercent = self.Percent
--		if OldPercent ~= NewPercent then
--			ValueChangedEvent:Fire(NewPercent)
--		end
		
--		self.Percent = NewPercent
--	end
--end

function Slider:GetValue()
	local Min = self.MinValue
	local Max = self.MaxValue
	local Percent = self.Percent
	if Min and Max and Percent then
		if Percent > 0.5 then
			return Max * Percent
		else
			return Min + (Max * Percent)
		end
	end
end

function Slider:SetPercent(Percent)
	local Dragging = self.Dragging
	local SliderButton = self.SliderButton
	local Container = self.Container
	if SliderButton and Container then
		local ContainerSize = Container.AbsoluteSize
		local SliderButtonSize = SliderButton.AbsoluteSize
		local Padding = SliderButtonSize.X * 0.5
		local PaddingConverted = Padding / ContainerSize.X
		
		FirePercentEvent(self, Percent)
		
		SliderButton.Position = UDim2.fromScale(math.clamp(Percent, PaddingConverted, 1 - PaddingConverted), 0.5)
	end
end

function Slider:Start()
	local Dragging = self.Dragging
	local SliderButton = self.SliderButton
	local Container = self.Container
	if not Dragging and SliderButton and Container then
		local ContainerPosition = Container.AbsolutePosition
		local ContainerSize = Container.AbsoluteSize
		local SliderButtonSize = SliderButton.AbsoluteSize
		local Padding = SliderButtonSize.X * 0.5
		local PaddingConverted = Padding / ContainerSize.X
		local BasePosition = ContainerPosition.X
		local MaxPosition = ContainerSize.X
		
		self.Dragging = true
		Input:SetSlider(self)
		
		RunService:BindToRenderStep("DragRender", 1, function()
			local DragPosition = GetDragPosition()
			local Difference = DragPosition.X - BasePosition
			
			local DragPercent = math.clamp(Difference / MaxPosition, 0, 1)
			self:SetPercent(DragPercent)
		end)
	end
end

function Slider:Stop()
	local Dragging = self.Dragging
	if Dragging then
		RunService:UnbindFromRenderStep("DragRender")
		self.Dragging = false
	end
end


return Slider