local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
camera.MaxZoomDistance = 60
camera.FieldOfView = 70

Lighting.GlobalShadows = false
Lighting.FogEnd = 500
Lighting.Brightness = 1
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0

for _, effect in ipairs(Lighting:GetChildren()) do
	if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("BloomEffect") or effect:IsA("ColorCorrectionEffect") then
		effect.Enabled = false
	end
end

for _, obj in ipairs(workspace:GetDescendants()) do
	if obj:IsA("Texture") or obj:IsA("Decal") then
		obj.Transparency = 1
	elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
		obj.Enabled = false
	end
end

local fps = 60
local counter = 0
RunService.RenderStepped:Connect(function(dt)
	counter += 1
	if counter >= 10 then
		fps = math.floor(1 / dt)
		counter = 0
	end
end)

print("Optimizador cargado")