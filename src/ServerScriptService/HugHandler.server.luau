--[[ By Owner ]]--
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local PathFinding = game:GetService("PathfindingService")

local Anims = script:WaitForChild("Animations")

--[[ Remotes ]]--

local Events = RS:WaitForChild("Events2")
local HugEvents = Events:WaitForChild("HugEvents")
local HugAsk = Events:WaitForChild("HugAsk")
local FIXHUG = Events:WaitForChild("FIXHUG")
local GetHugging = Events:WaitForChild("GetHugging")

local Hugging = {}

function Stop(player, char)
	if player and not char then
		char = player.Character    
	end
	if char ~= nil and char:IsA("Player") then
		char = char.Character
	end
	local CharacterB = char
	local CharacterA = Hugging[CharacterB.Name]

	if char and char:FindFirstChild("Humanoid") and char.Humanoid.PlatformStand then
		CharacterB = CharacterA
		CharacterA = char
	end

	pcall(function()
		if CharacterA then
			Hugging[CharacterA.Name] = nil
			for _,v in pairs(CharacterA.Humanoid:GetPlayingAnimationTracks()) do
				if v.Name == "Hug" then v:Stop() end
			end
			for _,v in pairs(CharacterA:GetChildren()) do
				if v:IsA("BasePart") then
					v:SetNetworkOwner(Players:GetPlayerFromCharacter(CharacterA))
				end
			end
			CharacterA.Humanoid.PlatformStand = false

			if CharacterA.HumanoidRootPart:FindFirstChild("HugWeld") then
				CharacterA.HumanoidRootPart.HugWeld:Destroy()
			end
			HugEvents:FireClient(Players:GetPlayerFromCharacter(CharacterA), true)
		end
	end)

	pcall(function()
		if CharacterB then
			Hugging[CharacterB.Name] = nil
			for _,v in pairs(CharacterB.Humanoid:GetPlayingAnimationTracks()) do
				if v.Name == "Hug" then v:Stop() end
			end
			for _,v in pairs(CharacterB:GetChildren()) do
				if v:IsA("BasePart") then
					v:SetNetworkOwner(Players:GetPlayerFromCharacter(CharacterB))
				end
			end
			CharacterB.Humanoid.PlatformStand = false

			if CharacterB.HumanoidRootPart:FindFirstChild("HugWeld") then
				CharacterB.HumanoidRootPart.HugWeld:Destroy()
			end
			HugEvents:FireClient(Players:GetPlayerFromCharacter(CharacterB), true) 
		end
	end)
end

function isNil(name)
	local char = Hugging[name]
	if not char then return true end
	if not char:FindFirstChild("Humanoid") then return true end
	return false
end

function Ask(plr, target)
	if not isNil(plr.Name) or not isNil(target.Name) then return end
	HugAsk:FireClient(target, plr)
end

function Hug(target, plr)
	local CharacterA = target.Character or target.CharacterAdded:Wait()
	local CharacterB = plr.Character
	if not CharacterA or not CharacterB then return end

	if CharacterB:FindFirstChild("Humanoid") and CharacterA:FindFirstChild("Humanoid") then
		if not isNil(CharacterA.Name) and not isNil(CharacterB.Name) then return end

		local humanoid = CharacterB:FindFirstChild("Humanoid")

		HugEvents:FireClient(target, false)
		HugEvents:FireClient(plr, false)

		local path = PathFinding:CreatePath()
		path:ComputeAsync(CharacterB.HumanoidRootPart.Position, CharacterA.HumanoidRootPart.Position)
		for _, v in pairs(path:GetWaypoints()) do
			if v.Action == Enum.PathWaypointAction.Jump then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
			humanoid:MoveTo(v.Position)
			humanoid.MoveToFinished:Wait()
		end

		Hugging[CharacterA.Name] = CharacterB
		Hugging[CharacterB.Name] = CharacterA

		CharacterB.HumanoidRootPart.CFrame = CharacterA.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.2)
		CharacterB.HumanoidRootPart.Orientation = Vector3.new(0, CharacterA.HumanoidRootPart.Orientation.Y - 180, 0)

		local weld = Instance.new("WeldConstraint")
		weld.Name = "HugWeld"
		weld.Part0 = CharacterA.HumanoidRootPart
		weld.Part1 = CharacterB.HumanoidRootPart
		weld.Parent = CharacterA.HumanoidRootPart

		CharacterA.Humanoid.PlatformStand = true

		local animA = CharacterA.Humanoid:FindFirstChild("Animator"):LoadAnimation(Anims:FindFirstChild(CharacterA.Humanoid.RigType == Enum.HumanoidRigType.R6 and "HugR6" or "Hug"))
		local animB = CharacterB.Humanoid:FindFirstChild("Animator"):LoadAnimation(Anims:FindFirstChild(CharacterB.Humanoid.RigType == Enum.HumanoidRigType.R6 and "HugR6" or "Hug"))

		animA.Priority = Enum.AnimationPriority.Action
		animB.Priority = Enum.AnimationPriority.Action

		animA:Play()
		animB:Play()

		wait(0.1)
		HugEvents:FireClient(plr, true)
		HugEvents:FireClient(target, false)
	end
end

local Functions = {
	["Stop"] = Stop;
	["Hug"] = Hug;
	["Ask"] = Ask;
}

Players.PlayerAdded:Connect(function(plr)
	plr.CharacterRemoving:Connect(function()
		Stop(plr)
	end)
end)

Players.PlayerRemoving:Connect(function(plr)
	local char = Hugging[plr.Name]
	if not char or not char:FindFirstChild("Humanoid") then return end
	Hugging[plr.Name] = nil
	Hugging[char.Name] = nil

	for _,v in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
		if v.Name == "Hug" then v:Stop() end
	end
	char.Humanoid.PlatformStand = false
	HugEvents:FireClient(Players:GetPlayerFromCharacter(char), true)
end)

HugEvents.OnServerEvent:Connect(function(player, func, arg1)
	if Functions[func] then
		Functions[func](player, arg1)
	end
end)

GetHugging.OnServerInvoke = function(plr)
	return Hugging[plr.Name] ~= nil
end

FIXHUG.Event:Connect(function(plr)
	local char = plr.Character
	if not char or not char:FindFirstChild("Humanoid") then return end
	for _,v in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
		if v.Name == "Hug" then v:Stop() end
	end
	Hugging[char.Name] = nil
	char.Humanoid.PlatformStand = false
	HugEvents:FireClient(plr, true)
	if char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("HugWeld") then
		char.HumanoidRootPart.HugWeld:Destroy()
	end
end)