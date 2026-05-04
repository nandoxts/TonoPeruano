local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local modelFolder = ReplicatedStorage:WaitForChild("Moto")
local modelName = "MotoTaxi"
local gamepassId = 1422194701
local VOID_Y = -50

local playerModels = {}

local function hasGamepass(player)
	local success, result = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
	end)
	return success and result
end

local function moveModelTo(model, position)
	local parts, totalPos, count = {}, Vector3.zero, 0
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(parts, part)
			totalPos += part.Position
			count += 1
		end
	end
	if count == 0 then return end
	local center = totalPos / count
	local offset = position - center
	for _, part in ipairs(parts) do
		part.CFrame += offset
	end
end

local function monitorVoid(model, player)
	task.spawn(function()
		while model and model.Parent do
			local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
			if not primary then break end
			if primary.Position.Y < VOID_Y then
				model:Destroy()
				playerModels[player] = nil
				break
			end
			task.wait(1)
		end
	end)
end

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		if message:lower() == "/moto" and hasGamepass(player) then
			local char = player.Character
			local modelTemplate = modelFolder:FindFirstChild(modelName)

			if char and char:FindFirstChild("HumanoidRootPart") and modelTemplate then
				if playerModels[player] then
					playerModels[player]:Destroy()
					playerModels[player] = nil
				end

				local clone = modelTemplate:Clone()
				clone.Parent = workspace
				moveModelTo(clone, char.HumanoidRootPart.Position + char.HumanoidRootPart.CFrame.LookVector * 10)
				playerModels[player] = clone
				monitorVoid(clone, player)
			end
		end
	end)

	player.AncestryChanged:Connect(function(_, parent)
		if not parent and playerModels[player] then
			playerModels[player]:Destroy()
			playerModels[player] = nil
		end
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	if playerModels[player] then
		playerModels[player]:Destroy()
	end
	playerModels[player] = nil
end)
