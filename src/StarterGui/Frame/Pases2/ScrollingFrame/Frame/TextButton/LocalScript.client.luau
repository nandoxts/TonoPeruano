local Marketplace = game:GetService("MarketplaceService")
local gamepassid = 1422194701	

script.Parent.MouseButton1Click:Connect(function()
	Marketplace:PromptGamePassPurchase(game.Players.LocalPlayer, gamepassid)
end)