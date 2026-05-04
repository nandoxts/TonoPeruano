local luzPart = script.Parent.Parent:WaitForChild("LUZDELANTERA")

script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	if luzPart.SurfaceLight.Enabled == false then
		luzPart.Color = Color3.fromRGB(180,180,180)
		luzPart.Material = Enum.Material.Neon
		luzPart.SurfaceLight.Enabled = true
	else
		luzPart.Color = Color3.fromRGB(125,125,125)
		luzPart.Material = Enum.Material.Plastic
		luzPart.SurfaceLight.Enabled = false
	end
end)
