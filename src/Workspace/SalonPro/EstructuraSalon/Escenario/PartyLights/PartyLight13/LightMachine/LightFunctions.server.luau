local rainbow = {
	Color3.new(1, 0 ,1);
	Color3.new(1, 0.333333333 ,0);
	Color3.new(1, 1 ,0);
	Color3.new(0, 1 ,0);
	Color3.new(0, 0 ,1);
	Color3.new(1, 0 ,1);
}

local hue = 0

while true do
	if script.Parent.Power.Value then
		local directionMultiplier = math.clamp(script.Parent.RotationDirection.Value, -1, 1)

		if script.Parent.Mode.Value == 1 then
			script.Parent.Parent.MoveableStand.LeftRight.HingeConstraint.TargetAngle =
				30 * math.sin((tick() / 2) * script.Parent.Speed.Value * directionMultiplier)
			script.Parent.Parent.MoveableStand.UpDown.HingeConstraint.TargetAngle =
				60 * math.sin((tick()) * script.Parent.Speed.Value) - 30
		elseif script.Parent.Mode.Value == 2 then
			script.Parent.Parent.MoveableStand.LeftRight.HingeConstraint.TargetAngle =
				30 * math.sin((tick() * 2) * script.Parent.Speed.Value * directionMultiplier)
			script.Parent.Parent.MoveableStand.UpDown.HingeConstraint.TargetAngle =
				30 * math.sin((tick() / 2) * script.Parent.Speed.Value) - 60
		end

		if script.Parent.Strobe.Value then
			local strobeSpeed = script.Parent.Strobe.StrobeHertz.Value
			if ((tick() % 2 * strobeSpeed) % 2) < 1 then
				script.Parent.LightPart.Transparency = 0
				script.Parent.LightPart.LightBeam.SpotLight.Enabled = true
				script.Parent.LightPart.LightBeam2.SpotLight.Enabled = true
				script.Parent.LightPart.BeamMain.Enabled = true
			else
				script.Parent.LightPart.Transparency = 1
				script.Parent.LightPart.LightBeam.SpotLight.Enabled = false
				script.Parent.LightPart.LightBeam2.SpotLight.Enabled = false
				script.Parent.LightPart.BeamMain.Enabled = false
			end
		else
			script.Parent.LightPart.Transparency = 0
			script.Parent.LightPart.LightBeam.SpotLight.Enabled = true
			script.Parent.LightPart.LightBeam2.SpotLight.Enabled = true
			script.Parent.LightPart.BeamMain.Enabled = true
		end

		if script.Parent.Rainbow.Value then
			hue = (hue + 0.01) % 1
			local color = Color3.fromHSV(hue, 1, 1)
			script.Parent.LightPart.LightBeam.SpotLight.Color = color
			script.Parent.LightPart.LightBeam2.SpotLight.Color = color
			script.Parent.LightPart.Color = color
			script.Parent.LightPart.BeamMain.Color = ColorSequence.new(color)
		else
			local baseColor = script.Parent.LightColor.Value
			script.Parent.LightPart.LightBeam.SpotLight.Color = baseColor
			script.Parent.LightPart.LightBeam2.SpotLight.Color = baseColor
			script.Parent.LightPart.Color = baseColor
			script.Parent.LightPart.BeamMain.Color = ColorSequence.new(baseColor)
		end

		script.Parent.Body.InitialDisabler.Enabled = false
		script.Parent.Parent.MoveableStand.Union.InitialDisabler.Enabled = false
		task.wait()
	else
		script.Parent.LightPart.Transparency = 0
		script.Parent.LightPart.Color = Color3.new()
		script.Parent.LightPart.LightBeam.SpotLight.Enabled = false
		script.Parent.LightPart.LightBeam2.SpotLight.Enabled = false
		script.Parent.LightPart.BeamMain.Enabled = false
		script.Parent.Parent.MoveableStand.LeftRight.HingeConstraint.TargetAngle = 0
		script.Parent.Parent.MoveableStand.UpDown.HingeConstraint.TargetAngle = -75
		task.wait(1)
	end
end