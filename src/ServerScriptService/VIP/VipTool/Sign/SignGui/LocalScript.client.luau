local player = game.Players.LocalPlayer

local TextMsg = script.Parent.CreateMsg:WaitForChild("TextMsg")

TextMsg.Changed:Connect(function()
	if player.Character:FindFirstChild("Sign") then
		player.Character["Sign"]:WaitForChild("UpdateSign"):FireServer(TextMsg.Text)
	end
end)