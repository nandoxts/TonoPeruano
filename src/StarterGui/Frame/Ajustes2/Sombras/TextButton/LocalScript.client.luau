local on = true

script.Parent.MouseButton1Click:Connect(function()
	
	if on == true then
		
		on = false
		script.Parent.TextLabel.Text = "Off"
		game.Lighting.GlobalShadows = false
		
	else
		on = true
		script.Parent.TextLabel.Text = "On"
		game.Lighting.GlobalShadows = true
		
	end
	
end)