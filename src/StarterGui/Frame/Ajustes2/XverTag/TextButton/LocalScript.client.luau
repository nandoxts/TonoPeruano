
local button = script.Parent
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer


local hidden = false

button.MouseButton1Click:Connect(function()
	hidden = not hidden

	for _, player in ipairs(Players:GetPlayers()) do

		if player.Character then
			local head = player.Character:FindFirstChild("Head")
			if head then
				local tag = head:FindFirstChild("NameTag")
				if tag and tag:IsA("BillboardGui") then
					tag.Enabled = not hidden
				end
			end
		end
	end
end)
