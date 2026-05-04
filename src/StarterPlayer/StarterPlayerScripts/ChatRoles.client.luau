local premiumIcon = true

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

-- Lista de roles
local creators = {
	"xlm_brem",
	"AngeloGarciia"
}

local admins = {
	-- Puedes agregar nombres aquí
}

local verifiedUsers = {
	"xlm_brem",
	"AngeloGarciia"
}

-- Función para verificar si un jugador está en una lista
local function isInList(name, list)
	for _, v in ipairs(list) do
		if v == name then
			return true
		end
	end
	return false
end

-- Función para verificar si el jugador tiene el GamePass VIP
local function hasVIPGamePass(player)
	return player:GetAttribute("HasVIP") == true
end

-- Función que retorna los tags del chat
local function getChatTag(player)
	local tags = {}
	local showVerificadoSymbol = false

	-- Tag de Premium
	if premiumIcon and player.MembershipType == Enum.MembershipType.Premium then
		table.insert(tags, { Tag = "", Color = Color3.fromRGB(203, 203, 203) })
	end

	-- Tag de VIP GamePass
	if hasVIPGamePass(player) then
		table.insert(tags, { Tag = "VIP", Color = Color3.fromRGB(230, 180, 0) })
	end

	local name = player.Name

	-- Tag de Creador
	if isInList(name, creators) then
		table.insert(tags, { Tag = "Creador", Color = Color3.fromRGB(255, 217, 1) })

		-- Tag de Administrador
	elseif isInList(name, admins) then
		table.insert(tags, { Tag = "Administrador", Color = Color3.fromRGB(255, 0, 0) })
	end

	-- Verificado
	if isInList(name, verifiedUsers) then
		showVerificadoSymbol = true
	end

	return tags, showVerificadoSymbol
end

-- Configura los mensajes de chat entrantes
TextChatService.OnIncomingMessage = function(message)
	local success, result = pcall(function()
		local textSource = message.TextSource
		if not textSource then return Instance.new("TextChatMessageProperties") end

		local player = Players:GetPlayerByUserId(textSource.UserId)
		if not player then return Instance.new("TextChatMessageProperties") end

		local tags, isVerified = getChatTag(player)
		local tagTexts = {}

		for _, tagInfo in ipairs(tags) do
			if tagInfo.Tag == "" then
				table.insert(tagTexts, string.format(
					"<font color='rgb(%d, %d, %d)'>%s</font>",
					tagInfo.Color.R * 255, tagInfo.Color.G * 255, tagInfo.Color.B * 255,
					tagInfo.Tag
					))
			else
				table.insert(tagTexts, string.format(
					"<font color='rgb(%d, %d, %d)'>[%s]</font>",
					tagInfo.Color.R * 255, tagInfo.Color.G * 255, tagInfo.Color.B * 255,
					tagInfo.Tag
					))
			end
		end

		local newProps = Instance.new("TextChatMessageProperties")
		local nameWithVerified = player.Name
		if isVerified then
			nameWithVerified = nameWithVerified .. ":"
		end

		newProps.PrefixText = table.concat(tagTexts, " ") .. " " .. nameWithVerified
		newProps.Text = message.Text
		return newProps
	end)

	if not success or not result then
		warn("Fallo al modificar ChatTag:", result)
		local fallback = Instance.new("TextChatMessageProperties")
		fallback.Text = message.Text
		fallback.PrefixText = message.PrefixText
		return fallback
	end

	return result
end
