

local UserInputService = game:GetService("UserInputService")

local EasySlider = script.Parent

local Signal = require(EasySlider:WaitForChild("Signal"))

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local TouchPosition = Vector2.zero

local Input = {
	InputEnded = Signal.new()
}

function Input:GetInputPosition()
	if IsMobile then
		return TouchPosition
	else
		return UserInputService:GetMouseLocation()
	end
end

if IsMobile then
	UserInputService.TouchEnded:Connect(function(InputObject)
		Input.InputEnded:Fire()
	end)
	
	UserInputService.TouchMoved:Connect(function(InputObject)
		Input.TouchPosition = InputObject.Position
	end)
else
	UserInputService.InputEnded:Connect(function(InputObject)
		if InputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			Input.InputEnded:Fire()
		end
	end)
end

return Input