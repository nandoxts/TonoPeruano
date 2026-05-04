local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EffectModule = require(game.ServerScriptService:WaitForChild("EffectModule"))

local rotateEvent = ReplicatedStorage:FindFirstChild("RotateEffectEvent")
if not rotateEvent then
	rotateEvent = Instance.new("RemoteEvent")
	rotateEvent.Name = "RotateEffectEvent"
	rotateEvent.Parent = ReplicatedStorage
end

-- Función para manejar comandos del chat
local function onPlayerChatted(player, message)
	if message:lower() == "/gire" then
		if EffectModule:IsAuthorized(player) then
			rotateEvent:FireAllClients()
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		onPlayerChatted(player, msg)
	end)
end)
