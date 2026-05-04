local tool = script.Parent
local currentColorIndex = 1
local rainbowActive = false
local rainbowThread = nil
local clonedHandle = nil

local colorModes = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(85, 0, 255),
	Color3.fromRGB(255, 215, 0),
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(71, 221, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(0, 0, 0),
	"Multicolor"
}

-- Función para detener el efecto Rainbow
local function stopRainbow()
	rainbowActive = false
end

-- Función para aplicar color al handle
local function applyColorToPart(part, color)
	if not part then return end
	local trail = part:FindFirstChildOfClass("Trail")

	if color == "Multicolor" then
		rainbowActive = true
		rainbowThread = coroutine.create(function()
			while rainbowActive do
				for i = 0, 255, 5 do
					local c = Color3.fromHSV(i / 255, 1, 1)
					part.Color = c
					if trail then
						trail.Color = ColorSequence.new(c)
					end
					task.wait(0.03)
				end
			end
		end)
		coroutine.resume(rainbowThread)
	else
		part.Color = color
		if trail then
			trail.Color = ColorSequence.new(color)
		end
	end
end

-- Función para aplicar el color actual
local function applyColor()
	local handle = tool:FindFirstChild("Handle")
	if not handle then return end
	stopRainbow()
	local selectedColor = colorModes[currentColorIndex]
	applyColorToPart(handle, selectedColor)
	if clonedHandle then
		applyColorToPart(clonedHandle, selectedColor)
	end
end

-- Función para alternar entre los colores
local function cycleColor()
	currentColorIndex += 1
	if currentColorIndex > #colorModes then
		currentColorIndex = 1
	end
	applyColor()
end

-- Cuando el tool se equipa
tool.Equipped:Connect(function()
	local character = tool.Parent
	if not character or not character:IsA("Model") then return end
	local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
	local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
	local handle = tool:FindFirstChild("Handle")

	if not (rightHand and leftHand and handle) then return end

	-- Adjuntar el handle a la mano derecha
	local motor1 = Instance.new("Motor6D")
	motor1.Part0 = rightHand
	motor1.Part1 = handle
	motor1.C0 = CFrame.Angles(math.rad(50), 0, math.rad(90))
	motor1.Parent = rightHand

	-- Clonar el handle y ponerlo en la mano izquierda
	clonedHandle = handle:Clone()
	clonedHandle.Name = "ClonedHandle"
	clonedHandle.Parent = character
	clonedHandle.Anchored = false
	clonedHandle.CanCollide = false

	local motor2 = Instance.new("Motor6D")
	motor2.Part0 = leftHand
	motor2.Part1 = clonedHandle
	motor2.C0 = CFrame.Angles(math.rad(90), 0, -math.rad(90))
	motor2.Parent = leftHand

	-- Aplicar color al handle
	applyColor()
end)

-- Cuando el tool se desequipa
tool.Unequipped:Connect(function()
	stopRainbow()
	if clonedHandle then
		clonedHandle:Destroy()
		clonedHandle = nil
	end
end)

-- Cuando el tool es activado (clic)
tool.Activated:Connect(cycleColor)
