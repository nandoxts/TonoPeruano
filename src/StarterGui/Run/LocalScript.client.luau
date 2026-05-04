local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")

local gui = script.Parent
local button = gui:WaitForChild("Button")

local walkSpeed, sprintSpeed = 16, 22

local function setSpeed(speed)
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speed
	end
end

player.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid").WalkSpeed = walkSpeed
end)

local function sprintAction(_, state)
	if state == Enum.UserInputState.Begin then
		setSpeed(sprintSpeed)
	elseif state == Enum.UserInputState.End then
		setSpeed(walkSpeed)
	end
	return Enum.ContextActionResult.Sink
end

if not UIS.TouchEnabled then
	CAS:BindAction("SprintAction", sprintAction, true, Enum.KeyCode.LeftControl)
end

if UIS.TouchEnabled then
	button.Visible = true

	button.MouseButton1Down:Connect(function()
		setSpeed(sprintSpeed)
	end)

	button.MouseButton1Up:Connect(function()
		setSpeed(walkSpeed)
	end)
else
	button.Visible = false
end
