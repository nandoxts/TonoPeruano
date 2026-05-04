local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local GAMEPASS_ID = 1179926968 -- id del gamepass
local kitFolder = script:WaitForChild("Kit")

-- Ropa
local SHIRT_ID = "rbxassetid://18976947213"
local PANTS_ID = "rbxassetid://112542385271545"

local function playerHasTool(player)
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return false end
	for _, tool in ipairs(kitFolder:GetChildren()) do
		if tool:IsA("Tool") and backpack:FindFirstChild(tool.Name) then
			return true
		end
	end
	return false
end

local function giveKit(player)
	if playerHasTool(player) then return end

	local character = player.Character or player.CharacterAdded:Wait()
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return end

	for _, item in ipairs(kitFolder:GetChildren()) do
		if item:IsA("Tool") then
			item:Clone().Parent = backpack
		end
	end

	local shirt = character:FindFirstChildOfClass("Shirt") or Instance.new("Shirt", character)
	shirt.ShirtTemplate = SHIRT_ID

	local pants = character:FindFirstChildOfClass("Pants") or Instance.new("Pants", character)
	pants.PantsTemplate = PANTS_ID
end

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if msg:lower() == "/tombo" then
			if MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID) then
				giveKit(player)
			end
		end
	end)
end)
