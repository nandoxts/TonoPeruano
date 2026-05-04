local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local VIP_GAMEPASS_ID = 1092300393
local event = ReplicatedStorage:WaitForChild("ChangeNameColor")

event.OnServerEvent:Connect(function(player, _, colorValue, hasStroke)
	local hasPass = false
	local success = pcall(function()
		hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, VIP_GAMEPASS_ID)
	end)
	if not success or not hasPass then return end

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

	local function toggleStroke(label, enable)
		local stroke = label:FindFirstChild("UIStroke")
		if enable then
			if not stroke then
				stroke = Instance.new("UIStroke")
				stroke.Thickness = 1
				stroke.Color = Color3.new(1, 1, 1)
				stroke.Parent = label
			end
		elseif stroke then
			stroke:Destroy()
		end
	end

	toggleStroke(nameLabel, hasStroke)
	if roleLabel.Text == "Invitado" then
		toggleStroke(roleLabel, hasStroke)
	end
end)
