local Replicated = game:GetService("ReplicatedStorage")
local music = game.Workspace:WaitForChild("CancionSIstema")
local icon = require(Replicated.Modulos.Icon)
local icon5 = icon.new() 

icon5:setImage(8511921026)
icon5:oneClick(true)
icon5:setOrder(5)
icon5:bindEvent("selected", function()

	if music.Volume == 0 then
		music.Volume = 0.5
	else
		music.Volume = 0
	end
end)