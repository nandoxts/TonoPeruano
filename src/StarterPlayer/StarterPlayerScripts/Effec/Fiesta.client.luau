local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local fiestaEvent = ReplicatedStorage:WaitForChild("FiestaEvent")

local function HSVtoRGB(h, s, v)
	local c = v * s
	local x = c * (1 - math.abs((h * 6) % 2 - 1))
	local m = v - c
	local r, g, b = 0, 0, 0

	if h < 1/6 then
		r, g, b = c, x, 0
	elseif h < 2/6 then
		r, g, b = x, c, 0
	elseif h < 3/6 then
		r, g, b = 0, c, x
	elseif h < 4/6 then
		r, g, b = 0, x, c
	elseif h < 5/6 then
		r, g, b = x, 0, c
	else
		r, g, b = c, 0, x
	end

	return Color3.new(r + m, g + m, b + m)
end

local function startFiestaEffect()
	-- Crear el efecto de color si no existe
	local colorEffect = Lighting:FindFirstChild("FiestaColor")
	if not colorEffect then
		colorEffect = Instance.new("ColorCorrectionEffect")
		colorEffect.Name = "FiestaColor"
		colorEffect.Parent = Lighting
	end

	local hue = 0
	local duration = 10
	local startTime = tick()

	local lastTick = tick()

	while tick() - startTime < duration do
		local now = tick()
		local deltaTime = now - lastTick
		lastTick = now

		hue = (hue + 0.01) % 1
		colorEffect.TintColor = HSVtoRGB(hue, 1, 1)
		colorEffect.Saturation = 1

		RunService.RenderStepped:Wait()
	end

	colorEffect:Destroy()
end

fiestaEvent.OnClientEvent:Connect(startFiestaEffect)
