local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local function optimizarPartesEstaticas()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Anchored then
			obj.CanCollide = false
			obj.CastShadow = false
		end
	end
end

local function ocultarPartesLejanas()
	local character = getCharacter()
	local hrp = character:WaitForChild("HumanoidRootPart")
	local distanciaMax = 50

	for _, parte in pairs(workspace:GetDescendants()) do
		if parte:IsA("BasePart") and parte:FindFirstChild("Desactivable") then
			local distancia = (parte.Position - hrp.Position).Magnitude
			if distancia > distanciaMax then
				parte.Transparency = 1
				parte.CanCollide = false
			else
				parte.Transparency = 0
				parte.CanCollide = true
			end
		end
	end
end

-- ⏱️ Bucle de optimización (ligero)
RunService.RenderStepped:Connect(function()
	pcall(ocultarPartesLejanas)
end)

-- 🛠️ Ejecutar al inicio
optimizarPartesEstaticas()
