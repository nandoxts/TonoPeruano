local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local comidasFolder = script:WaitForChild("VipTool")
local gamepassId = 1092300393

local korbloxRightLegID = 139607718
local headlessHeadID = 15093053680

local function giveTools(player)
	local backpack = player:WaitForChild("Backpack", 5)
	if not backpack then return end
	for _, tool in ipairs(comidasFolder:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Clone().Parent = backpack
		end
	end
end

--// Commands Vip

local comandos = {
	["+comandos"] = {
		["/korblox"] = function(player)
			local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local desc = humanoid:GetAppliedDescription()
				desc.RightLeg = korbloxRightLegID
				humanoid:ApplyDescription(desc)
			end
		end,
		["/headless"] = function(player)
			local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local desc = humanoid:GetAppliedDescription()
				desc.Head = headlessHeadID
				humanoid:ApplyDescription(desc)
			end
		end,
	}
}

Players.PlayerAdded:Connect(function(player)
	task.spawn(function()
		local success, hasPass = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, gamepassId)
		if not success or not hasPass then return end

		player.CharacterAdded:Connect(function()
			giveTools(player)
		end)
		if player.Character then
			giveTools(player)
		end

		player.Chatted:Connect(function(msg)
			local cmd = comandos["+comandos"][msg:lower()]
			if cmd then
				cmd(player)
			end
		end)
	end)
end)
