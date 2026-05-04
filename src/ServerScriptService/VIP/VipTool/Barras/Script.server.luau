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

local function stopRainbow()
	rainbowActive = false
end

local function updateVisuals(part, color)
	if not part then return end
	part.Color = color

	local trail = part:FindFirstChildOfClass("Trail")
	if trail then
		trail.Color = ColorSequence.new(color)
	end

	local attachment = part:FindFirstChild("Attachment3")
	if attachment then
		local particle = attachment:FindFirstChildOfClass("ParticleEmitter")
		if particle then
			particle.Color = ColorSequence.new(color)
		end
	end
end

local function applyColorToParts(color)
	if color == "Multicolor" then
		if not rainbowActive then
			rainbowActive = true
			rainbowThread = task.spawn(function()
				while rainbowActive do
					for i = 0, 255, 5 do
						if not rainbowActive then break end
						local c = Color3.fromHSV(i / 255, 1, 1)
						updateVisuals(tool:FindFirstChild("Handle"), c)
						updateVisuals(clonedHandle, c)
						task.wait(0.03)
					end
				end
			end)
		end
	else
		updateVisuals(tool:FindFirstChild("Handle"), color)
		updateVisuals(clonedHandle, color)
	end
end

local function applyColor()
	local handle = tool:FindFirstChild("Handle")
	if not handle then return end
	stopRainbow()
	local selectedColor = colorModes[currentColorIndex]
	applyColorToParts(selectedColor)
end

local function cycleColor()
	currentColorIndex += 1
	if currentColorIndex > #colorModes then
		currentColorIndex = 1
	end
	applyColor()
end

tool.Equipped:Connect(function()
	local character = tool.Parent
	if not character or not character:IsA("Model") then return end
	local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
	local leftHand = character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm")
	local handle = tool:FindFirstChild("Handle")

	if not (rightHand and leftHand and handle) then return end

	local motor1 = Instance.new("Motor6D")
	motor1.Part0 = rightHand
	motor1.Part1 = handle
	motor1.C0 = CFrame.Angles(math.rad(50), 0, math.rad(90))
	motor1.Parent = rightHand

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

	applyColor()
end)

tool.Unequipped:Connect(function()
	stopRainbow()
	if clonedHandle then
		clonedHandle:Destroy()
		clonedHandle = nil
	end
end)

tool.Activated:Connect(cycleColor)
