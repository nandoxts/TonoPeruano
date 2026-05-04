local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local VIPGamePassID = 1092300393

Players.PlayerAdded:Connect(function(player)
	local success, hasPass = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, VIPGamePassID)
	end)

	if success and hasPass then
		player:SetAttribute("HasVIP", true)
	else
		player:SetAttribute("HasVIP", false)
	end
end)
