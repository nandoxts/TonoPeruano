local TweenService = game:GetService("TweenService")
local firesFolder = script.Parent.Parent:WaitForChild("Fires")

local tiempoEncendido = 2
local tiempoApagado = 6
local tiempoOn = 0.3
local tiempoOff = 2

local colorOn = Color3.fromHex("#2c6ee8")
local colorOff = Color3.fromHex("#000000")

for i = 1,10 do
	local fireModel = firesFolder:FindFirstChild(tostring(i))
	if fireModel and fireModel:FindFirstChild("Use") then
		local fPart = fireModel.Use:FindFirstChild("F")
		if fPart then
			local emitters = fPart:GetChildren()
			coroutine.wrap(function()
				while true do
					for _, e in pairs(emitters) do
						if e:IsA("ParticleEmitter") then e.Enabled = true end
					end
					TweenService:Create(fPart, TweenInfo.new(tiempoOn, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = colorOn}):Play()
					wait(tiempoEncendido)

					for _, e in pairs(emitters) do
						if e:IsA("ParticleEmitter") then e.Enabled = false end
					end
					TweenService:Create(fPart, TweenInfo.new(tiempoOff, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = colorOff}):Play()
					wait(tiempoApagado)
				end
			end)()
		end
	end
end
