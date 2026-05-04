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
	"VALLEIDS",
	"AngeloGarciia"
}

local Headadmin = {
	"keithprincs",
	"Mavet7zxt",
	"Fercho_ZP"
}

local admins = {
	"TILINPECAUS4",
	"mrclauss22",
	"ignxts",
	"isma_ccc77",
	"SrMyster27",
	"Amigo_deloajen0",
	"R0Danny",
	"xXyohandi",
	"ISASI0220",
	"Fueg2oh",
	"Sebasxcxs"
}

local mods = {
	"anonymous12220",
	"Solrc12",
	"WilliamVR29",
	"000_iiReyner",
	"DiegoHotPlay",
	"Jeankskx",
	"Nightwing_196",
	"jhoanmaykc",
	"zRenzolucho",
	"elfortnite12345",
	"alalaud22",
	"xChecooo420",
	"checfito2802",
	"fulltuboamiga",
	"Rengifo2006M",
	"DracoPrr",
	"Dadvijay",
	"kat02L20",
	"Shiion25",
	"duraznoHOD"
	
}

local influencers = {
	"kringtapia",
	"dlFers",
	"Ahlekxxz",
	"chetumari",
	"WincitoMix",
	"PANARABIT1248",
	"stefanosktr",
	"FabianRs1"
}

local Ga = {
	"essechinito"
}

local Monos = {
	"gxrardo04",
	"Adrianzazano",
	"jack_goku55",
	"PowerFullFo" --
}

local starUsers = {
	"xlm_brem",
	"AngeloGarciia",
	"VALLEIDS",
	"marcosyuik12",
	"dlFers",
	"keithprincs",
	"Mavet7zxt",
	"Fercho_ZP",
	"FabianRs1",
	"shyshybuu_u"
}

local dibujito = {
	"pincheratata",
	"Blane_0100",
	"Maxckac32",
	"Carlos_2004pro",
	"YoshinoT402",
	"Macr0xzzz",
	"xXyohandi",
	"The_dangerr",
	"vegeta_francow",
	"carlos_2004pro",
	"CHRISPAPU1",
	"FrodoxKing"
}

local BANDIDO = {
	"ANGEL_JISUS1",
	"galletadeagua20",
	"SH3L4O",
	"Jeankskx",
	"mijailll_01",
	"Jeankskx",
	"GalletaDeAgua20",
	"distemper6",
	"mijailll_01",
	"frankym1234",
	"Noone1237473",
	"chamoy_siuu",
	"TarzanPingon",
	"alalaud22",
	"its_loaded20",
	"Kantar0o",
	"Zack_06104",
	"llCamotitoUwull",
	"EsleiterXrX"
}

local conejita = {
	"enotrass",
	"J0d3_rclaroqsi",
	"Gia_14537",
	"Estrellalisbeth4",
	"kitty_FFw",
	"rose_luanaUwU",
	"Stefy_cr",
	"heidiblanco_ff3",
	"militux08",
	"tumama_itk1",
	"dahyun_ap",
	"arleth420xd",
	"shecid017",
	"mafelamanca",
	"SioXiio",
	"Raingirl2407",
	"kimiti_1",
	"BB_Lunita31",
	"Conejiitaaah"
}

local Catador = {
	"Guilleproo12345678",
}
local fiel = {
	"alguierandom123",
	"r3zaka"
}

local Gatita = {
	"shyshybuu_u"
}

local Sau = {
	"brehmelu3",
}

local gatito = {
	"JackFox188",
}

local bandida = {
	"stayyyyys5",
	"Noem_CHV2"
}

local lider = {
	"vVI_EZ",
}

local Seguridad = {
	"tigranpa",
}

local DUEna = {
	"rubialvarez2108",
}

local booss = {
	"DuraznoHOD",
}

local roles = {
	{list = dj, text = "🎧DJ🎧", color = "rainbow"},
	{list = Headadmin, text = "🔰HEAD-ADMIN🔰", color = Color3.fromRGB(255, 200, 4)},
	{list = admins, text = "🚨ADMINISTRADOR🚨", color = Color3.fromRGB(179, 0, 0)},
	{list = mods, text = "🛡️MODERADOR🛡️", color = Color3.fromRGB(38, 255, 0)},
	{list = influencers, text = "⭐INFLUENCER⭐", color = Color3.fromRGB(0, 213, 255)},
	{list = creators, text = "👑CREADOR👑", color = Color3.fromRGB(255, 255, 0)},
	{list = Ga, text = "👿OquendoGrone👿", color = Color3.fromRGB(255, 48, 48)},
	{list = dibujito, text = "🤡DIBUJITO🤡", color = Color3.fromRGB(255, 0, 123)},
	{list = BANDIDO, text = "🔫BANDIDO🔫", color = Color3.fromRGB(230, 0, 4)},
	{list = conejita, text = "🐰CONEJITA🐰", color = Color3.fromRGB(255, 179, 202)},
	{list = Monos, text = "🐵MONO-MAFIA🍌", color = Color3.fromRGB(184, 85, 35)},
	{list = fiel, text = "FIEL🤓", color = Color3.fromRGB(254, 21, 21)},
	{list = Gatita, text = "🎀GATITA🎀", color = Color3.fromRGB(255, 179, 202)},
	{list = Catador, text = "😈Catador De Mayores😈", color = Color3.fromRGB(255, 0, 0)},
	{list = Sau, text = "🎀Mister Pisado🎀", color = Color3.fromRGB(255, 0, 242)},
	{list = gatito, text = "CAT🐱", color = Color3.fromRGB(162, 0, 255)},
	{list = bandida, text = "😈BANDIDA😈", color = Color3.fromRGB(255, 0, 4)},
	{list = lider, text = "♦️LIDER_CLAN_DZN♦️", color = Color3.fromRGB(255, 0, 4)},
	{list = Seguridad, text = "👮‍SEGURIDAD👮‍", color = Color3.fromRGB(0, 0, 255)},
	{list = DUEna, text = "👮‍Dueña MR.Pisado👮‍", color = Color3.fromRGB(255, 0, 234)},
	{list = booss, text = "💸BOSS💸", color = Color3.fromRGB(255, 140, 0)},
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
	label.Text = "TONERO"
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