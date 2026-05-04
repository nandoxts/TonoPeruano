local tool = script.Parent
local anim = Instance.new("Animation")
anim.Name = "Anim1"
anim.AnimationId = "rbxassetid://133147807027051" -- Animación Estática

local track

tool.Equipped:Connect(function()
	local humanoid = tool.Parent:FindFirstChildOfClass("Humanoid")
	if humanoid then
		track = humanoid:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Movement
		track.Looped = true
		track:Play()
	end
end)

tool.Unequipped:Connect(function()
	if track then
		track:Stop()
	end
end)
