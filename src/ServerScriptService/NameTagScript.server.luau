local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")

local Config = require(ReplicatedStorage:WaitForChild("RolesConfig"))
local nametag = ReplicatedStorage:WaitForChild("NameTag")
local streakStore = DataStoreService:GetDataStore("LoginStreaks")

local function getDayCountSinceEpoch()
	local now = os.date("!*t")
	now.hour, now.min, now.sec = 0, 0, 0
	return math.floor((os.time(now) - os.time({year=1970,month=1,day=1,hour=0})) / 86400)
end

local function updateStreak(player)
	local userId = tostring(player.UserId)
	local currentDay = getDayCountSinceEpoch()
	local ok, data = pcall(function() return streakStore:GetAsync(userId) end)
	local streak = 1
	if ok and data then
		local last = data.lastLoginDay or -1
		if last == currentDay then
			streak = data.streak or 1
		elseif last == currentDay - 1 then
			streak = (data.streak or 1) + 1
		end
	end
	pcall(function()
		streakStore:SetAsync(userId, { streak = streak, lastLoginDay = currentDay })
	end)
	return streak
end

local function assignRole(player, label)
	local rank = Config:GetRank(player.Name)
	if rank then
		label.Text = rank.nametag.text
		if rank.nametag.color == "rainbow" then
			task.spawn(function()
				local h = 0
				while label.Parent and label:IsDescendantOf(game) do
					h = (h + 0.01) % 1
					label.TextColor3 = Color3.fromHSV(h, 1, 1)
					task.wait(0.05)
				end
			end)
		else
			label.TextColor3 = rank.nametag.color
		end
	else
		label.Text = "TONERO"
		label.TextColor3 = Color3.fromRGB(200, 200, 200)
	end
end

local function onCharacterAdded(player, char)
	local head = char:WaitForChild("Head")
	local newTag = nametag:Clone()
	local nameLabel = newTag:WaitForChild("Name")
	local roleLabel = newTag:WaitForChild("Rol")
	local vipLabel = newTag:WaitForChild("VIP")
	local humanoid = char:WaitForChild("Humanoid")

	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	newTag.Parent = head
	newTag.Adornee = head

	task.spawn(function()
		local streak = updateStreak(player)
		local verify = Config:IsStarUser(player.Name) and "" or ""
		nameLabel.Text = tostring(streak) .. "\xF0\x9F\x94\xA5 " .. player.DisplayName .. verify
	end)

	assignRole(player, roleLabel)

	task.spawn(function()
		local ok, hasPass = pcall(function()
			return MarketplaceService:UserOwnsGamePassAsync(player.UserId, Config.VIP_GAMEPASS_ID)
		end)
		if ok and hasPass then
			vipLabel.Text = "[VIP]"
			vipLabel.TextColor3 = Color3.fromRGB(226, 196, 0)
			vipLabel.BackgroundTransparency = 1
			vipLabel.TextScaled = true
		end
	end)
end

local function setupPlayer(player)
	player.CharacterAdded:Connect(function(char)
		onCharacterAdded(player, char)
	end)
	if player.Character then
		onCharacterAdded(player, player.Character)
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end
Players.PlayerAdded:Connect(setupPlayer)
