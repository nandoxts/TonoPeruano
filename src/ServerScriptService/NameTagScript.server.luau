local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")

local VIP_GAMEPASS_ID = 1092300393
local nametag = ReplicatedStorage:WaitForChild("NameTag")
local streakStore = DataStoreService:GetDataStore("LoginStreaks")

local dj = {
	"Dj_Sicotic",
}

local creators = {
	"xlm_brem",
	"AngeloGarciia",
	"VALLEIDS",
	"nxndoxt"
}

local admins = {
	"beemo_peruanito"
}

local mods = {
	"TILINPECAUS4"
}

local contributors = {

}

local topDonors = {

}

local influencers = {
	"nikushime",
	"Elspot97",
	"YoutuberGamerLos"
}

local HELPERS = {
	"XxxMaryoriUwUxxX",
	"cabracha"
}

local starUsers = {
	"xlm_brem",
	"AngeloGarciia"
}

local dibujito = {
	"pincheratata",
	"Blane_0100",
	"marcosyuik12",
	"Maxckac32",
	"Carlos_2004pro",
	"YoshinoT402",
	"Macr0xzzz",
	"xXyohandi",
	"brehmelu3",
	"The_dangerr"
}

local conejita = {
	"enotrass",
	"J0d3_rclaroqsi",
	"Gia_14537",
	"Estrellalisbeth4",
	"kitty_FFw",
	"rose_luanaUwU",
	"Stefy_cr",
	"Ruth_MRM",
	"heidiblanco_ff3",
	"militux08",
	"tumama_itk1",
	"lilipilu5"
}

local roles = {
	{list = dj, text = "🎧DJ🎧", color = "rainbow"},
	{list = admins, text = "🚨ADMINISTRADOR🚨", color = Color3.fromRGB(255, 0, 0)},
	{list = mods, text = "🔰MODERADOR🔰", color = Color3.fromRGB(38, 255, 0)},
	{list = contributors, text = "COLABORADOR", color = Color3.fromRGB(255, 140, 0)},
	{list = influencers, text = "⭐INFLUENCER⭐", color = Color3.fromRGB(0, 213, 255)},
	{list = topDonors, text = "💸TOP DONADOR💸", color = Color3.fromRGB(17, 255, 0)},
	{list = creators, text = "👑CREADOR👑", color = Color3.fromRGB(255, 255, 0)},
	{list = HELPERS, text = "🛠️HELPERS🛠️", color = Color3.fromRGB(0, 123, 255)},
	{list = dibujito, text = "🤡DIBUJITO🤡", color = Color3.fromRGB(255, 0, 123)},
	{list = conejita, text = "🐰CONEJITA🐰", color = Color3.fromRGB(255, 179, 202)},
}

local function getDayCountSinceEpoch()
	local now = os.date("!*t")
	now.hour, now.min, now.sec = 0, 0, 0
	local dayZero = os.time({year = 1970, month = 1, day = 1, hour = 0})
	return math.floor((os.time(now) - dayZero) / 86400)
end

local function updateStreak(player)
	local userId = player.UserId
	local currentDay = getDayCountSinceEpoch()

	local success, data = pcall(function()
		return streakStore:GetAsync(tostring(userId))
	end)

	local streak = 1
	local lastLoginDay = -1

	if success and data then
		lastLoginDay = data.lastLoginDay or -1

		if lastLoginDay == currentDay then
			streak = data.streak or 1
		elseif lastLoginDay == currentDay - 1 then
			streak = (data.streak or 1) + 1
		else
			streak = 1
		end
	end

	pcall(function()
		streakStore:SetAsync(tostring(userId), {
			streak = streak,
			lastLoginDay = currentDay
		})
	end)

	return streak
end

local function assignRole(player, label)
	for _, role in ipairs(roles) do
		if table.find(role.list, player.Name) then
			label.Text = role.text
			if role.color ~= "rainbow" then
				label.TextColor3 = role.color
			else
				task.spawn(function()
					local h = 0
					while label.Parent and label:IsDescendantOf(game) do
						h = (h + 0.01) % 1
						label.TextColor3 = Color3.fromHSV(h, 1, 1)
						task.wait(0.05)
					end
				end)
			end
			return
		end
	end
	label.Text = "INVITADO"
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
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
			local streakText = tostring(streak) .. "🔥 "

			if table.find(starUsers, player.Name) then
				nameLabel.Text = streakText .. player.DisplayName .. ""
			else
				nameLabel.Text = streakText .. player.DisplayName
			end
		end)

		assignRole(player, roleLabel)

		task.spawn(function()
			local success, hasPass = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, VIP_GAMEPASS_ID)
			end)
			if success and hasPass then
				vipLabel.Text = "[VIP]"
				vipLabel.TextColor3 = Color3.fromRGB(226, 196, 0)
				vipLabel.BackgroundTransparency = 1
				vipLabel.TextScaled = true
			end
		end)
	end)
end)