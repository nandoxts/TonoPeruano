--Servicios--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Animaciones =  require(ReplicatedStorage:WaitForChild("Modulos"):WaitForChild("Animaciones"))

--Remotes--
local Remotes = ReplicatedStorage.RemotesSync
local SyncRemote = Remotes.Sync
local PlayAnimationRemote = Remotes.PlayAnimation
local StopAnimationRemote = Remotes.StopAnimation

---Data--
local SyncData = {}

--Functions--

local Commands = {
	["Sync"] = function(Plr,SyncPlayer)
		if SyncData[SyncPlayer]["StoredAnimation"] ~= nil then
			if SyncData[Plr]["StoredAnimation"] ~= nil then
				SyncData[Plr]["StoredAnimation"]:Stop()
				SyncData[Plr]["StoredAnimation"]:Destroy()
				SyncData[Plr]["StoredAnimation"] = nil
			end
			local Character = Plr.Character
			local Humanoid = Character.Humanoid
			local Animation = Character.Baile
			Animation.AnimationId = SyncData[SyncPlayer]["StoredAnimation"].Animation.AnimationId
			local animator = Humanoid:FindFirstChild("Animator")
			if animator then
				local AnimationTrack = animator:LoadAnimation(Animation)
				AnimationTrack:Play()
				AnimationTrack.TimePosition = SyncData[SyncPlayer]["StoredAnimation"].TimePosition
				
				SyncData[Plr]["StoredAnimation"] = AnimationTrack
			end
		end
	end;
	["SetSync"] = function(Plr,SyncPlayer)
		if SyncData[Plr]["SyncDebounce"] == false then
			SyncData[Plr]["SyncDebounce"] = true
			if SyncData[SyncPlayer]["StoredAnimation"] ~= nil then
				if SyncData[Plr]["StoredAnimation"]  ~= nil then
					SyncData[Plr]["StoredAnimation"]:Stop()
					SyncData[Plr]["StoredAnimation"]:Destroy()
					SyncData[Plr]["StoredAnimation"] = nil
				end
				local Character = Plr.Character
				local Humanoid = Character.Humanoid
				local Animation = Character.Baile
				
				Animation.AnimationId = SyncData[SyncPlayer]["StoredAnimation"].Animation.AnimationId
				local animator = Humanoid:FindFirstChild("Animator")
				if animator then
					local AnimationTrack = animator:LoadAnimation(Animation)
					AnimationTrack.Priority = Enum.AnimationPriority.Action
					AnimationTrack:Play()
					AnimationTrack.TimePosition = SyncData[SyncPlayer]["StoredAnimation"].TimePosition
					
					SyncData[Plr]["StoredAnimation"] = AnimationTrack
					if not table.find(SyncData[SyncPlayer]["SyncPlayers"],Plr) then
						table.insert(SyncData[SyncPlayer]["SyncPlayers"],Plr)
					end
				end
			end
		elseif SyncData[Plr]["SyncDebounce"] == true then
			if SyncData[SyncPlayer]["StoredAnimation"] ~= nil then
				for i,PlayerTable in pairs(SyncData)do
					for Index,v in pairs(PlayerTable["SyncPlayers"])do
						if v == Plr then
							table.remove(PlayerTable["SyncPlayers"],Index)
						end
					end
				end
				if SyncData[Plr]["StoredAnimation"]  ~= nil then
					SyncData[Plr]["StoredAnimation"]:Stop()
					SyncData[Plr]["StoredAnimation"]:Destroy()
					SyncData[Plr]["StoredAnimation"] = nil
				end
				local Character = Plr.Character
				local Humanoid = Character.Humanoid
				local Animation = Character.Baile
				Animation.AnimationId = SyncData[SyncPlayer]["StoredAnimation"].Animation.AnimationId
				local animator = Humanoid:FindFirstChild("Animator")
				if animator then
					local AnimationTrack = animator:LoadAnimation(Animation)
					AnimationTrack.Priority = Enum.AnimationPriority.Action
					AnimationTrack:Play()
					AnimationTrack.TimePosition = SyncData[SyncPlayer]["StoredAnimation"].TimePosition
					SyncData[Plr]["StoredAnimation"] = AnimationTrack
					if not table.find(SyncData[SyncPlayer]["SyncPlayers"],Plr) then
						table.insert(SyncData[SyncPlayer]["SyncPlayers"],Plr)
					end
				end
			end
		end
	end;
	["Unsync"] = function(Plr)
		if SyncData[Plr]["SyncDebounce"] == true then
			SyncData[Plr]["SyncDebounce"] = false 
			if SyncData[Plr]["StoredAnimation"] ~= nil then
				SyncData[Plr]["StoredAnimation"]:Stop()
				SyncData[Plr]["StoredAnimation"]:Destroy()
				SyncData[Plr]["StoredAnimation"] = nil
			end
			for i,PlayerTable in pairs(SyncData)do
				for Index,v in pairs(PlayerTable["SyncPlayers"])do
					if v == Plr then
						table.remove(PlayerTable["SyncPlayers"],Index)
					end
				end
			end
			if #SyncData[Plr]["SyncPlayers"] >= 1 then
				for _,Player in pairs(SyncData[Plr]["SyncPlayers"])do
					if SyncData[Player]["StoredAnimation"] ~= nil then
						SyncData[Player]["StoredAnimation"]:Stop()
						SyncData[Player]["StoredAnimation"]:Destroy()
						SyncData[Player]["StoredAnimation"] = nil
						
						if Plr.Character ~= nil then
							local SyncOnOff = Plr.Character:FindFirstChild("SyncOnOff")
							if SyncOnOff then
								SyncOnOff.Value = false
							end
						end	
					end
				end
			end
		end
	end;
	["Disconnect"] = function(Plr)
		for _,Player in pairs(SyncData[Plr]["SyncPlayers"])do
			if SyncData[Player]["StoredAnimation"] ~= nil then
				SyncData[Player]["StoredAnimation"]:Stop()
				SyncData[Player]["StoredAnimation"]:Destroy()
				SyncData[Player]["StoredAnimation"] = nil
			end
			for Index,SyncPlr in pairs(SyncData[Player]["SyncPlayers"])do
				if SyncData[SyncPlr]["StoredAnimation"] ~= nil then
					SyncData[SyncPlr]["StoredAnimation"]:Stop()
					SyncData[SyncPlr]["StoredAnimation"]:Destroy()
					SyncData[SyncPlr]["StoredAnimation"] = nil
				end
			end
			SyncData[Player]["SyncDebounce"] = false
		end
		for i,PlayerTable in pairs(SyncData)do
			for Index,v in pairs(PlayerTable["SyncPlayers"])do
				if v == Plr then
					table.remove(PlayerTable["SyncPlayers"],Index)
				end
			end
		end
		SyncData[Plr]["StoredAnimation"] = nil
		SyncData[Plr]["SyncPlayers"] = nil
		SyncData[Plr]["SyncDebounce"] = nil
		SyncData[Plr] = nil
	end;
}

local function GetPlr(Plr)
	if Plr ~= "" then
		Plr = Plr.Name:lower()
		for _, player in ipairs(Players:GetPlayers()) do
			if Plr == player.Name:lower():sub(1, #Plr) then
				return player
			end
		end
		return nil
	end
end

local StopAnimation = function(Plr)
	if SyncData[Plr]["StoredAnimation"] ~= nil then
		SyncData[Plr]["StoredAnimation"]:Stop()
		SyncData[Plr]["StoredAnimation"]:Destroy()
		SyncData[Plr]["StoredAnimation"] = nil
	end
	if #SyncData[Plr]["SyncPlayers"] >= 1 then
		for _,Player in pairs(SyncData[Plr]["SyncPlayers"])do
			if SyncData[Player]["StoredAnimation"] ~= nil then
				SyncData[Player]["StoredAnimation"]:Stop()
				SyncData[Player]["StoredAnimation"]:Destroy()
				SyncData[Player]["StoredAnimation"] = nil
			end
			for index,SyncPlayer in pairs(SyncData[Player]["SyncPlayers"])do
				if SyncData[SyncPlayer]["StoredAnimation"] ~= nil then
					SyncData[SyncPlayer]["StoredAnimation"]:Stop()
					SyncData[SyncPlayer]["StoredAnimation"]:Destroy()
					SyncData[SyncPlayer]["StoredAnimation"] = nil
				end
			end
		end
	end
end

local PlayAnimation = function(Plr,func,AnimationData)
	if func == "playAnim" and AnimationData and tonumber(AnimationData) then
		Commands.Unsync(Plr)
		if SyncData[Plr]["StoredAnimation"] then
			StopAnimation(Plr)
		end
		local Character = Plr.Character
		local Humanoid = Character.Humanoid
		local Animation = Character.Baile
		Animation.AnimationId = "rbxassetid://"..tostring(AnimationData)
		local animator = Humanoid:FindFirstChild("Animator")
		if animator then
			local AnimationTrack = animator:LoadAnimation(Animation)
			AnimationTrack.Priority = Enum.AnimationPriority.Action
			AnimationTrack:Play()
			AnimationTrack.TimePosition = 0
			SyncData[Plr]["StoredAnimation"] = AnimationTrack
			if #SyncData[Plr]["SyncPlayers"] >= 1 then
				for _,Player in pairs(SyncData[Plr]["SyncPlayers"])do
					Commands.Sync(Player,Plr)
					for index,SyncPlr in pairs(SyncData[Player]["SyncPlayers"])do
						Commands.Sync(SyncPlr,Plr)
					end
				end
			end
		end	
	end
end

local SyncAction = function(Plr,action,Name)
	StopAnimation(Plr)
	if action == "sync" then
		local PlayerSync = GetPlr(Name)
		if PlayerSync then
			if Plr ~= PlayerSync then
				if Plr and Plr.Character and Plr.Character.SyncOnOff then
					Plr.Character.SyncOnOff.Value = true
					Commands.SetSync(Plr,PlayerSync)
				end
			end
		end
	elseif action == "unsync" then
		if Plr and Plr.Character and Plr.Character.SyncOnOff then
			Plr.Character.SyncOnOff.Value = false
			Commands.Unsync(Plr)
		end
	end
end

local PlayerRemoving = function(Plr)
	Commands.Disconnect(Plr)
end

local CharacterAdded = function(Character)
	local Animation = Instance.new("Animation")
	Animation.Name = "Baile"
	Animation.Parent = Character
	local SyncOnOFf = Instance.new("BoolValue")
	SyncOnOFf.Name = "SyncOnOff"
	SyncOnOFf.Parent = Character
	
	local Plr = Players:GetPlayerFromCharacter(Character)
	local Humanoid = Character.Humanoid
	if Humanoid then
		Humanoid.Died:Connect(function()
			if SyncData[Plr]["StoredAnimation"] ~= nil then
				SyncData[Plr]["StoredAnimation"]:Stop()
				SyncData[Plr]["StoredAnimation"]:Destroy()
				SyncData[Plr]["StoredAnimation"] = nil
			end
			SyncData[Plr]["SyncDebounce"] = false

			if #SyncData[Plr]["SyncPlayers"] >= 1 then
				for _,Player in pairs(SyncData[Plr]["SyncPlayers"])do
					if SyncData[Player]["StoredAnimation"] ~= nil then
						SyncData[Player]["StoredAnimation"]:Stop()
						SyncData[Player]["StoredAnimation"]:Destroy()
						SyncData[Player]["StoredAnimation"] = nil
					end
					for Index,SyncPlr in pairs(SyncData[Player]["SyncPlayers"])do
						if SyncData[SyncPlr]["StoredAnimation"] ~= nil then
							SyncData[SyncPlr]["StoredAnimation"]:Stop()
							SyncData[SyncPlr]["StoredAnimation"]:Destroy()
							SyncData[SyncPlr]["StoredAnimation"] = nil
						end
					end
					SyncData[Player]["SyncDebounce"] = false
				end
			end
			SyncData[Plr]["SyncPlayers"] = {}
			for i,PlayerTable in pairs(SyncData)do
				for Index,v in pairs(PlayerTable["SyncPlayers"])do
					if v == Plr then
						table.remove(PlayerTable["SyncPlayers"],Index)
					end
				end
			end
		end)
	end
end

local PlayerAdded = function(Plr)
	SyncData[Plr] = {
		["StoredAnimation"] = nil;
		["SyncPlayers"] = {};
		["SyncDebounce"] = false;
	}
	Plr.CharacterAdded:Connect(CharacterAdded)
	
	local Character = Plr.Character
	if Character then
		CharacterAdded(Character)
	end
end

--Event Handlers--
Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)
PlayAnimationRemote.OnServerEvent:Connect(PlayAnimation)
StopAnimationRemote.OnServerEvent:Connect(StopAnimation)
SyncRemote.OnServerEvent:Connect(SyncAction)

for _,Player in pairs(Players:GetPlayers())do
	PlayerAdded(Player)
end