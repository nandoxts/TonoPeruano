local on = true

script.Parent.MouseButton1Click:Connect(function()
	
	if on == true then
		
		on = false
		script.Parent.TextLabel.Text = "Off"

		
	else
		on = true
		script.Parent.TextLabel.Text = "On"

		
	end
	
end)