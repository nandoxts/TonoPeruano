-- Testing AC FE support

local event = script.Parent
local car=script.Parent.Parent
local LichtNum = 0


event.OnServerEvent:connect(function(player,data)
	if data['ToggleLight'] then
		if car.Body.Light.on.Value==true then
			car.Body.Light.on.Value=false
		else
			car.Body.Light.on.Value=true
		end
	elseif data['EnableBrakes'] then
		car.Body.Brakes.on.Value=true
	elseif data['DisableBrakes'] then
		car.Body.Brakes.on.Value=false
	elseif data['ToggleLeftBlink'] then
		if car.Body.Left.on.Value==true then
			car.Body.Left.on.Value=false
		else
			car.Body.Left.on.Value=true
		end
	elseif data['ToggleRightBlink'] then
		if car.Body.Right.on.Value==true then
			car.Body.Right.on.Value=false
		else
			car.Body.Right.on.Value=true
		end
	elseif data['ReverseOn'] then
		car.Body.Reverse.on.Value=true
	elseif data['ReverseOff'] then
		car.Body.Reverse.on.Value=false
	elseif data['ToggleStandlicht'] then
		if LichtNum == 0 then
			LichtNum = 2
			car.Body.Headlight.on.Value = true
		elseif LichtNum == 1 then
			LichtNum = 2
			car.Body.Headlight.on.Value = true
		elseif LichtNum == 2 then
			LichtNum = 3
			car.Body.Highlight.on.Value = true
		elseif LichtNum == 3 then
			LichtNum = 1
			car.Body.Highlight.on.Value = false
			car.Body.Headlight.on.Value = false
		end
	end
end)