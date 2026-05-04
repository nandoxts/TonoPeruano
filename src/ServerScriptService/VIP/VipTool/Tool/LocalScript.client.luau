local tool = script.Parent

-- Crear la animación estática
local anim = Instance.new("Animation")
anim.Name = "Anim1"
anim.AnimationId = "rbxassetid://137253788316828" -- Reemplaza con el ID de tu animación estática

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
		track = nil
	end
end)
