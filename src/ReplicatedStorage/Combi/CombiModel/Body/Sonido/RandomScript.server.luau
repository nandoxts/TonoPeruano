Sound = script.Parent.Sound
Clicker = script.Parent.ClickDetector

function onClick(mouse)
	Sound:Play()
end

script.Parent.ClickDetector.MouseClick:Connect(onClick)