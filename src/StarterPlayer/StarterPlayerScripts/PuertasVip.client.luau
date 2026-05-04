local MarketplaceService = game:GetService("MarketplaceService")
local player = game.Players.LocalPlayer
local gamepassId = 1092300393

local folder = game.Workspace:WaitForChild("Puertas")
local puertas = {
	folder:WaitForChild("Vip1"),
	folder:WaitForChild("Vip2")
}

local function ComprobarGamepass()
	local tienePaseVip = MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
	if tienePaseVip then
		for _, puerta in ipairs(puertas) do
			puerta.CanCollide = false
			puerta.Transparency = 1
		end
	end
end

for _, puerta in ipairs(puertas) do
	puerta.Touched:Connect(function(hit)
		if hit.Parent == player.Character then
			local tienePaseVip = MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
			if not tienePaseVip then
				MarketplaceService:PromptGamePassPurchase(player, gamepassId)
			else
				puerta.CanCollide = false
				puerta.Transparency = 1
			end
		end
	end)
end

player.CharacterAdded:Connect(ComprobarGamepass)
ComprobarGamepass()
