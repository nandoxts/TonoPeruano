
local UserInputService = game:GetService("UserInputService")

local IsMobile = UserInputService.TouchEnabled

local Input = {
	TouchPosition = Vector2.zero
}

function Input:SetSlider(Slider)
	self.ActiveSlider = Slider
end

function Input:GetSlider()
	return self.ActiveSlider
end

function Input:GetTouchPosition()
	return self.TouchPosition
end

if IsMobile then
	UserInputService.TouchEnded:Connect(function(InputObject)
		local ActiveSlider = Input.ActiveSlider
		if ActiveSlider and ActiveSlider.Dragging then
			ActiveSlider:Stop()
		end
	end)
	
	UserInputService.TouchMoved:Connect(function(InputObject)
		Input.TouchPosition = InputObject.Position
	end)
else
	UserInputService.InputEnded:Connect(function(InputObject)
		local ActiveSlider = Input.ActiveSlider
		if InputObject.UserInputType == Enum.UserInputType.MouseButton1 and ActiveSlider and ActiveSlider.Dragging then
			ActiveSlider:Stop()
		end
	end)
end

return Input