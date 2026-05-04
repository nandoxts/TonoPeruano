local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = tool:WaitForChild("ScreenGui1")
local mira = screenGui:WaitForChild("Mira")
local munLabel = screenGui.Bal1.Mun

-- Configuración de sonidos

local handle = tool:WaitForChild("Handle")
local fireSound = handle:WaitForChild("FireSound")
local reloadSound = handle:WaitForChild("Reload")
local reloadAllSound = handle:WaitForChild("Reload2")
local equipSound = handle:WaitForChild("EquipSound")

local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local remote = tool:WaitForChild("ShootEvent")

local maxAmmo = 5
local currentAmmo = maxAmmo
local reloading = false
local cooldown = false
local moveConnection

local function updateUI()
	munLabel.Text = tostring(currentAmmo)
end

local function fullReload()
	if reloading then return end
	reloading = true
	currentAmmo = 0
	updateUI()
	reloadAllSound:Play()
	local stepTime = reloadAllSound.TimeLength / maxAmmo
	for i = 1, maxAmmo do
		task.wait(stepTime)
		currentAmmo += 1
		updateUI()
	end
	reloading = false
end

tool.Equipped:Connect(function()
	equipSound:Play()
	userInputService.MouseIconEnabled = false
	screenGui.Parent = player:WaitForChild("PlayerGui")
	screenGui.Enabled = true
	updateUI()
	moveConnection = runService.RenderStepped:Connect(function()
		mira.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
	end)
end)

tool.Unequipped:Connect(function()
	userInputService.MouseIconEnabled = true
	screenGui.Enabled = false
	if moveConnection then
		moveConnection:Disconnect()
		moveConnection = nil
	end
end)

tool.Activated:Connect(function()
	if reloading or cooldown or currentAmmo <= 0 then
		if currentAmmo <= 0 and not reloading then
			fullReload()
		end
		return
	end

	if mouse and mouse.Hit then
		remote:FireServer(mouse.Hit.Position)
		fireSound:Play()
		currentAmmo -= 1
		updateUI()
		cooldown = true
		task.delay(0.5, function()
			reloadSound:Play()
			task.wait(reloadSound.TimeLength)
			cooldown = false
			if currentAmmo <= 0 then
				fullReload()
			end
		end)
	end
end)
