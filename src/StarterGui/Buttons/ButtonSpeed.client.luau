local Replicated = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local icon = require(Replicated.Modulos.Icon)
local icon4 = icon.new()

icon4:setImage(8977565968)
icon4:oneClick(true)
icon4:setOrder(5)
icon4:bindEvent("selected", function()
				
	local humanoid = player.Character.Humanoid			
	if not humanoid then
		return
	end
	if humanoid.WalkSpeed == 16 then
		humanoid.WalkSpeed = 4
	else
		humanoid.WalkSpeed = 16
	end
	
end)