local F = {}
local body = script.Parent.Parent.Parent.Body.Lights
local tk = script.Parent.Parent.Parent.Misc.TG.UT.Lights
local car = script.Parent.Parent.Parent
local BlinkersEnabled = true
local player = nil

F.updateLights = function(lights, bool)
	if lights == 'brake' then
		body.RLeft.BrickColor = bool and BrickColor.new("Really red") or BrickColor.new("Pearl")
		body.RRight.BrickColor = bool and BrickColor.new("Really red") or BrickColor.new("Pearl")
		body.RLeft.Material = bool and "Neon" or "SmoothPlastic"
		body.RRight.Material = bool and "Neon" or "SmoothPlastic"
		
		tk.RLeft.Material = bool and "Neon" or "SmoothPlastic"
		tk.RLeft.BrickColor = bool and BrickColor.new("Really red") or BrickColor.new("Pearl")
		tk.RRight.Material = bool and "Neon" or "SmoothPlastic"
		tk.RRight.BrickColor = bool and BrickColor.new("Really red") or BrickColor.new("Pearl")
		
		
	elseif lights == 'beam' then
		body.FB.Material = bool and "Neon" or "SmoothPlastic"
		body.RB.Material = bool and "Neon" or "SmoothPlastic"
		tk.RB.Material = bool and "Neon" or "SmoothPlastic"
		body.L.Light.Enabled = bool
	end
end

local b = ''

function Toggle(dir, tog)
	if dir == 'Left' then
		body.RLeft.Material = tog and "Neon" or "SmoothPlastic"
		body.RLeft.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		tk.RLeft.Material = tog and "Neon" or "SmoothPlastic"
		tk.RLeft.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		
		body.LeftIn.Material = tog and "Neon" or "SmoothPlastic"
		body.LeftIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		car.Misc.FL.Mirror.Ind.Material = tog and "Neon" or "SmoothPlastic"
		car.Misc.FL.Mirror.Ind.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		car.DriveSeat.LI.Value = tog
	elseif dir == 'Right' then
		body.RRight.Material = tog and "Neon" or "SmoothPlastic"
		body.RRight.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		
		tk.RRight.Material = tog and "Neon" or "SmoothPlastic"
		tk.RRight.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		
		body.RightIn.Material = tog and "Neon" or "SmoothPlastic"
		body.RightIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		car.Misc.FR.Mirror.Ind.Material = tog and "Neon" or "SmoothPlastic"
		car.Misc.FR.Mirror.Ind.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		car.DriveSeat.RI.Value = tog
	elseif dir == 'Hazards' then
		body.RLeft.Material = tog and "Neon" or "SmoothPlastic"
		body.RRight.Material = tog and "Neon" or "SmoothPlastic"
		
		body.RLeft.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		body.RRight.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		
		tk.RLeft.Material = tog and "Neon" or "SmoothPlastic"
		tk.RLeft.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		tk.RRight.Material = tog and "Neon" or "SmoothPlastic"
		tk.RRight.BrickColor = tog and BrickColor.new("Really red") or BrickColor.new("Pearl")
		
		body.LeftIn.Material = tog and "Neon" or "SmoothPlastic"
		body.LeftIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		body.RightIn.Material = tog and "Neon" or "SmoothPlastic"
		body.RightIn.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		car.Misc.FL.Mirror.Ind.Material = tog and "Neon" or "SmoothPlastic"
		car.Misc.FL.Mirror.Ind.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		car.Misc.FR.Mirror.Ind.Material = tog and "Neon" or "SmoothPlastic"
		car.Misc.FR.Mirror.Ind.BrickColor = tog and BrickColor.new("Deep orange") or BrickColor.new("Pearl")
		
		car.DriveSeat.LI.Value = tog
		car.DriveSeat.RI.Value = tog
	end
end

function blink(typ)
	b = typ
	if blinking == true then
		blinking = false
	else
		blinking = true
		while blinking do
			Toggle(typ, true)
			script.Parent:FireClient(player, 'blink', .9, true)
			wait(1/3)
			Toggle(typ, false)
			script.Parent:FireClient(player, 'blink', 0.8, true)
			wait(1/3)
		end
		Toggle('Hazards', false)
		script.Parent:FireClient(player, 'blink', .9, false)
	end
end

script.Parent.Parent.ChildRemoved:connect(function(child)
	if child:IsA("Weld") and BlinkersEnabled then
		if blinking == true and b == 'Hazards' then
			return
		else
			blinking = false
		end
	end
end)

F.blinkers = function(dir)
	blink(dir)
end

script.Parent.OnServerEvent:connect(function(pl,Fnc,...)
	player = pl
	F[Fnc](...)
end)