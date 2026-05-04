local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local PathFinding = game:GetService("PathfindingService")

local Anims = script:WaitForChild("Animations")

local Events = RS:WaitForChild("Events2")
local HugEvents = Events:WaitForChild("HugEvents")
local HugAsk = Events:WaitForChild("HugAsk")
local FIXHUG = Events:WaitForChild("FIXHUG")
local GetHugging = Events:WaitForChild("GetHugging")

local Hugging = {}

local function isHugging(name)
	local char = Hugging[name]
	return char ~= nil and char:FindFirstChild("Humanoid") ~= nil
end

local function stopHug(charA, charB)
	for _, char in ipairs({ charA, charB }) do
		if not char then continue end
		pcall(function()
			Hugging[char.Name] = nil
			local hum = char:FindFirstChild("Humanoid")
			if hum then
				for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
					if track.Name == "Hug" then track:Stop() end
				end
				hum.PlatformStand = false
			end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then
				local weld = hrp:FindFirstChild("HugWeld")
				if weld then weld:Destroy() end
				for _, part in ipairs(char:GetChildren()) do
					if part:IsA("BasePart") then
						local plr = Players:GetPlayerFromCharacter(char)
						if plr then
							part:SetNetworkOwner(plr)
						end
					end
				end
			end
			local plr = Players:GetPlayerFromCharacter(char)
			if plr then
				HugEvents:FireClient(plr, true)
			end
		end)
	end
end

local function Stop(player, char)
	if player and not char then
		char = player.Character
	end
	if not char then return end
	if typeof(char) == "Instance" and char:IsA("Player") then
		char = char.Character
	end
	if not char then return end

	local charB = char
	local charA = Hugging[charB.Name]

	local hum = charB:FindFirstChild("Humanoid")
	if hum and hum.PlatformStand and charA then
		stopHug(charA, charB)
	else
		stopHug(charB, charA)
	end
end

local function Ask(plr, target)
	if not target or not target:IsA("Player") then return end
	if isHugging(plr.Name) or isHugging(target.Name) then return end
	HugAsk:FireClient(target, plr)
end

local function Hug(target, plr)
	if not target or not plr then return end
	local charA = target.Character
	local charB = plr.Character
	if not charA or not charB then return end

	local humA = charA:FindFirstChild("Humanoid")
	local humB = charB:FindFirstChild("Humanoid")
	if not humA or not humB then return end

	if isHugging(charA.Name) or isHugging(charB.Name) then return end

	HugEvents:FireClient(target, false)
	HugEvents:FireClient(plr, false)

	local hrpA = charA:FindFirstChild("HumanoidRootPart")
	local hrpB = charB:FindFirstChild("HumanoidRootPart")
	if not hrpA or not hrpB then return end

	local ok = pcall(function()
		local path = PathFinding:CreatePath({ AgentCanJump = true })
		path:ComputeAsync(hrpB.Position, hrpA.Position)
		if path.Status == Enum.PathStatus.Success then
			for _, wp in ipairs(path:GetWaypoints()) do
				if wp.Action == Enum.PathWaypointAction.Jump then
					humB:ChangeState(Enum.HumanoidStateType.Jumping)
				end
				humB:MoveTo(wp.Position)
				humB.MoveToFinished:Wait()
			end
		end
	end)
	if not ok then return end

	Hugging[charA.Name] = charB
	Hugging[charB.Name] = charA

	hrpB.CFrame = hrpA.CFrame * CFrame.new(0, 0, -1.2)
	hrpB.Orientation = Vector3.new(0, hrpA.Orientation.Y - 180, 0)

	local weld = Instance.new("WeldConstraint")
	weld.Name = "HugWeld"
	weld.Part0 = hrpA
	weld.Part1 = hrpB
	weld.Parent = hrpA

	humA.PlatformStand = true

	local rigA = humA.RigType == Enum.HumanoidRigType.R6 and "HugR6" or "Hug"
	local rigB = humB.RigType == Enum.HumanoidRigType.R6 and "HugR6" or "Hug"
	local animObjA = Anims:FindFirstChild(rigA)
	local animObjB = Anims:FindFirstChild(rigB)

	if animObjA and animObjB then
		local animatorA = humA:FindFirstChild("Animator")
		local animatorB = humB:FindFirstChild("Animator")
		if animatorA and animatorB then
			local trackA = animatorA:LoadAnimation(animObjA)
			local trackB = animatorB:LoadAnimation(animObjB)
			trackA.Priority = Enum.AnimationPriority.Action
			trackB.Priority = Enum.AnimationPriority.Action
			trackA:Play()
			trackB:Play()
		end
	end

	task.wait(0.1)
	HugEvents:FireClient(plr, true)
	HugEvents:FireClient(target, false)
end

local Functions = {
	Stop = Stop,
	Hug = Hug,
	Ask = Ask,
}

local function setupPlayer(plr)
	plr.CharacterRemoving:Connect(function()
		Stop(plr)
	end)
end

for _, plr in ipairs(Players:GetPlayers()) do
	setupPlayer(plr)
end
Players.PlayerAdded:Connect(setupPlayer)

Players.PlayerRemoving:Connect(function(plr)
	local char = Hugging[plr.Name]
	if not char then return end
	local partnerChar = Hugging[char.Name]
	stopHug(char, partnerChar)
end)

HugEvents.OnServerEvent:Connect(function(player, func, arg1)
	local fn = Functions[func]
	if fn then
		fn(player, arg1)
	end
end)

GetHugging.OnServerInvoke = function(plr)
	return isHugging(plr.Name)
end

FIXHUG.Event:Connect(function(plr)
	local char = plr.Character
	if not char then return end
	local hum = char:FindFirstChild("Humanoid")
	if hum then
		for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
			if track.Name == "Hug" then track:Stop() end
		end
		hum.PlatformStand = false
	end
	Hugging[char.Name] = nil
	HugEvents:FireClient(plr, true)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp and hrp:FindFirstChild("HugWeld") then
		hrp.HugWeld:Destroy()
	end
end)
