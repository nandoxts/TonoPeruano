local ReplicatedStorage = game:GetService("ReplicatedStorage")
local event = ReplicatedStorage:WaitForChild("ChangeNameColor")

local colorFrame = script.Parent

for _, button in pairs(colorFrame:GetChildren()) do
	if button:IsA("TextButton") then
		button.MouseButton1Click:Connect(function()
			local hasStroke = button:FindFirstChildOfClass("UIStroke") ~= nil
			event:FireServer(button.Name, button.BackgroundColor3, hasStroke)
		end)
	end
end
