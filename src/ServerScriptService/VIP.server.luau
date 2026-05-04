local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local comidasFolder = script:WaitForChild("VipTool")
local gamepassId = 1092300393

local korbloxRightLegID = 139607718
local headlessHeadID = 15093053680

local highlights = {}

local function rainbowColor(t)
	local speed = 5
	local r = math.sin(t * speed) * 0.5 + 0.5
	local g = math.sin(t * speed + 2) * 0.5 + 0.5
	local b = math.sin(t * speed + 4) * 0.5 + 0.5
	return Color3.new(r, g, b)
end

task.spawn(function()
	while true do
		local t = os.clock()
		for _, highlight in pairs(highlights) do
			if highlight and highlight.Parent then
				highlight.OutlineColor = rainbowColor(t)
			end
		end
		task.wait(0.1)
	end
end)

local function giveTools(player)
	local backpack = player:WaitForChild("Backpack", 5)
	if not backpack then return end
	for _, tool in ipairs(comidasFolder:GetChildren()) do
		if tool:IsA("Tool") and not backpack:FindFirstChild(tool.Name) then
			tool:Clone().Parent = backpack
		end
	end
end

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
		["/glow"] = function(player)
			if not highlights[player] then
				local char = player.Character or player.CharacterAdded:Wait()
				local h = Instance.new("Highlight")
				h.Adornee = char
				h.Name = "Glow"
				h.FillTransparency = 1
				h.OutlineTransparency = 0
				h.DepthMode = Enum.HighlightDepthMode.Occluded
				h.Parent = char
				highlights[player] = h
			end
		end,
		["/unglow"] = function(player)
			if highlights[player] then
				highlights[player]:Destroy()
				highlights[player] = nil
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
