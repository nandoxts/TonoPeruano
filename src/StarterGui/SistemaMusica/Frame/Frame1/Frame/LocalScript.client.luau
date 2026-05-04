local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EasySlider = require(ReplicatedStorage:WaitForChild("Slider"))

local Container = script.Parent
local Main = Container.Parent
local Button = Container:WaitForChild("Button")
local PercentLabel = Main:WaitForChild("PercentLabel")
local Music = workspace:WaitForChild("CancionSIstema")

local Slider = EasySlider.new(Button, Container)
Slider:SetPercent(1)

Slider.PercentChanged:Connect(function(Percent)
	Music.Volume = Percent * 0.5 
	local RoundedPercent = math.floor(Percent * 100)
	PercentLabel.Text = string.format(
		"Volumen: %s%%", tostring(RoundedPercent)
	)
	Slider.MinValue = -50
	Slider.MaxValue = 50

end)