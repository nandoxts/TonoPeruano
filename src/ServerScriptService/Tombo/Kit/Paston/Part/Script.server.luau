local lastHitTime = 0
local cooldown = 5 -- segundos
local sound = script.Parent:FindFirstChild("Sound") -- asegúrate de que haya un objeto Sound dentro del Part

function onTouched(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")

	if humanoid and tick() - lastHitTime >= cooldown then
		humanoid.Sit = true
		lastHitTime = tick()

		-- Reproduce el sonido si existe
		if sound then
			sound:Play()
		end
	end
end

script.Parent.Touched:Connect(onTouched)
