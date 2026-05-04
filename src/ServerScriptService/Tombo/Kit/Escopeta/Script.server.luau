local tool = script.Parent
local remote = tool:WaitForChild("ShootEvent")
local damage = 4
local ballsCount = 2

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

remote.OnServerEvent:Connect(function(player, targetPos)
	local character = player.Character
	if not character then return end

	local head = character:FindFirstChild("Head")
	if not head then return end

	local handle = tool:FindFirstChild("Handle")
	if handle then
		local fireSound = handle:FindFirstChild("FireSound")
		if fireSound and fireSound:IsA("Sound") then
			fireSound:Play()
		end
	end

	local damagedPlayers = {}

	for i = 1, ballsCount do
		local bola = Instance.new("Part")
		bola.Shape = Enum.PartType.Ball
		bola.Material = Enum.Material.Plastic
		bola.BrickColor = BrickColor.new(Color3.fromRGB(163, 162, 165))
		bola.Size = Vector3.new(0.25, 0.25, 0.25)
		bola.CFrame = head.CFrame
		bola.CanCollide = false
		bola.Anchored = false
		bola.Name = "Bola"
		bola.Parent = workspace

		local direction = (targetPos - head.Position).Unit

		local bv = Instance.new("BodyVelocity")
		bv.Velocity = direction * 120
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Parent = bola

		local alive = true

		-- Daño manual por proximidad
		local connection
		connection = RunService.Heartbeat:Connect(function()
			if not alive then return end
			for _, otherPlayer in pairs(Players:GetPlayers()) do
				if otherPlayer ~= player then
					local otherChar = otherPlayer.Character
					if otherChar then
						local hum = otherChar:FindFirstChildOfClass("Humanoid")
						local hrp = otherChar:FindFirstChild("HumanoidRootPart")
						if hum and hrp and (hrp.Position - bola.Position).Magnitude < 2 then
							if not damagedPlayers[otherChar] then
								hum:TakeDamage(damage)
								damagedPlayers[otherChar] = true
								alive = false
								connection:Disconnect()
								bola:Destroy()
								break
							end
						end
					end
				end
			end
		end)

		game:GetService("Debris"):AddItem(bola, 5)
	end
end)
