local Marketplace = game:GetService("MarketplaceService")
local gamepassid = 1415780496	

script.Parent.MouseButton1Click:Connect(function()
	Marketplace:PromptGamePassPurchase(game.Players.LocalPlayer, gamepassid)
end)