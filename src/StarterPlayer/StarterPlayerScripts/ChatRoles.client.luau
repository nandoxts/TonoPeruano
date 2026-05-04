local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("RolesConfig"))

local function colorToHex(c)
	return string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
end

local function makeTag(text, color)
	return string.format('<font color="%s">[%s]</font>', colorToHex(color), text)
end

TextChatService.OnIncomingMessage = function(message)
	local props = Instance.new("TextChatMessageProperties")
	local textSource = message.TextSource
	if not textSource then return props end

	local player = Players:GetPlayerByUserId(textSource.UserId)
	if not player then return props end

	local tags = {}

	-- Premium
	if player.MembershipType == Enum.MembershipType.Premium then
		table.insert(tags, '<font color="#CBCBCB"></font>')
	end

	local rank = Config:GetRank(player.Name)
	if rank then
		-- Tiene rango: solo muestra el rango, no VIP
		if rank.chat then
			table.insert(tags, makeTag(rank.chat.tag, rank.chat.color))
		end
	else
		-- Sin rango: muestra VIP si lo tiene
		if player:GetAttribute("HasVIP") then
			table.insert(tags, makeTag("VIP", Color3.fromRGB(226, 196, 0)))
		end
	end

	local verify = Config:IsStarUser(player.Name) and " \u{2714}" or ""
	local prefix = table.concat(tags, " ")
	if prefix ~= "" then prefix = prefix .. " " end
	props.PrefixText = prefix .. player.Name .. verify .. ":"
	return props
end
