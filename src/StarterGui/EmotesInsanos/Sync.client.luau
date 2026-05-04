--[[ SERVICES ]]--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[ REMOTES ]]--
local Remotes = ReplicatedStorage.RemotesSync
local syncremote = Remotes.Sync

--[[ LOCALS ]]--

local Player = game.Players.LocalPlayer; local Mouse = Player:GetMouse()

local GUI = script.BillboardGui
local Target

local SyncKey = Enum.KeyCode.E
local debounce = false
local syncOn = false

--[[ SYNC FUNCTIONS ]]--

UserInputService.InputChanged:Connect(function(Input, Processed)
	Target = nil
	if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then 
		local MouseTarget = Mouse.Target
		if MouseTarget == nil then return end
		local Humanoid = MouseTarget.Parent:FindFirstChild('Humanoid') or MouseTarget.Parent.Parent:FindFirstChild('Humanoid')

		if Humanoid then
			local Message 
			if Input.UserInputType == Enum.UserInputType.MouseMovement then
				Message = "Sync E"
			elseif Input.UserInputType == Enum.UserInputType.Touch then
				Message = "Sync"	
			end
			if Humanoid.RigType == Enum.HumanoidRigType.R15 then
				Target = Players:GetPlayerFromCharacter(Humanoid.Parent)
				if Target then
					local upperTorso = Humanoid.Parent.UpperTorso
					if upperTorso then 
						GUI.Adornee = upperTorso; GUI.Parent = workspace
						GUI.SyncText.Text = Message
						GUI.SyncText.Visible = true
					end
				end
			end
		else
			GUI.Adornee = nil; GUI.Parent = nil
			GUI.SyncText.Text = ""
			GUI.SyncText.Visible = false
		end
	end
end)


UserInputService.InputBegan:Connect(function(Input, Processed)
	if Input.KeyCode == SyncKey then
		if Target == nil then return end
		if not debounce then
			debounce = true
			if Player.Character.SyncOnOff.Value then
				syncremote:FireServer("unsync")
			else
				syncremote:FireServer("sync",Target)
			end

			wait(1)
			debounce = false
		end
	end
end)
	
--[[
UserInputService.TouchLongPress:connect(function(Input, Processed)
	if Target == nil then return end
	if not debounce then
		debounce = true
		game.ReplicatedStorage:FindFirstChild("Sync"):FireServer(Target)
		wait(1)
		debounce = false
	end
end)

]]