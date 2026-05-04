local chat = game:GetService("Chat")

script.Parent.Unequipped:Connect(function()
	script.Parent.SignPart.SurfaceGui.TextLabel.Text = ""
end)

script.Parent.UpdateSign.OnServerEvent:Connect(function(player, msg)
	if player.Character:FindFirstChild("Sign") then
		script.Parent.SignPart.SurfaceGui.TextLabel.Text = msg
	end
end)
