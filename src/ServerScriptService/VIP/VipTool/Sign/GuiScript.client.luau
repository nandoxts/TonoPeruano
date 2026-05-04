local player = game.Players.LocalPlayer

local signGui = script.Parent:WaitForChild("SignGui")

script.Parent.Equipped:Connect(function()
	local gui = signGui:Clone()
	gui.Parent = player.PlayerGui
end)

script.Parent.Unequipped:Connect(function()
	if player.PlayerGui:FindFirstChild("SignGui") then
		player.PlayerGui["SignGui"]:Destroy()
	end
end)