local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local VIP_GAMEPASS_ID = 1092300393
local event = ReplicatedStorage:WaitForChild("ChangeNameColor")
local vipCache = {}

local function isVip(player)
	if vipCache[player.UserId] ~= nil then
		return vipCache[player.UserId]
	end
	local success, owns = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, VIP_GAMEPASS_ID)
	end)
	vipCache[player.UserId] = success and owns or false
	return vipCache[player.UserId]
end

local function ensureStroke(label)
	local stroke = label:FindFirstChild("UIStroke")
	if not stroke then
		stroke = Instance.new("UIStroke")
		stroke.Thickness = 1
		stroke.Color = Color3.new(1, 1, 1)
		stroke.Parent = label
	end
	return stroke
end

event.OnServerEvent:Connect(function(player, _, colorValue, hasStroke)
	if not isVip(player) then return end
	local char = player.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end
	local tag = head:FindFirstChild("NameTag")
	if not tag then return end
	local nameLabel = tag:FindFirstChild("Name")
	local roleLabel = tag:FindFirstChild("Rol")
	if not nameLabel or not roleLabel then return end

	local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(nameLabel, tweenInfo, {TextColor3 = colorValue}):Play()

	if roleLabel.Text == "Invitado" then
		TweenService:Create(roleLabel, tweenInfo, {TextColor3 = colorValue}):Play()
	end

	if hasStroke then
		ensureStroke(nameLabel).Enabled = true
		if roleLabel.Text == "Invitado" then
			ensureStroke(roleLabel).Enabled = true
		end
	else
		local ns = nameLabel:FindFirstChild("UIStroke")
		if ns then ns.Enabled = false end
		local rs = roleLabel:FindFirstChild("UIStroke")
		if rs then rs.Enabled = false end
	end
end)

game.Players.PlayerRemoving:Connect(function(p)
	vipCache[p.UserId] = nil
end)
