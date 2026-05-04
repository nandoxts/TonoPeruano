local light1 = script.Parent.PartyLight1
local light2 = script.Parent.PartyLight2
local light3 = script.Parent.PartyLight3
local light4 = script.Parent.PartyLight4
local light5 = script.Parent.PartyLight5
local light6 = script.Parent.PartyLight6
-- Add to the list if more lights are added, and do the same for under the lines 183.

script.Parent.Preset.Changed:Connect(function()
	if script.Parent.Preset.Value == 1 then -- SLOW SOLID MONOCHROME MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 2 then -- FAST SOLID MONOCHROME MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 3 then -- SLOW SLOW-STROBE MONOCHROME MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 4 then -- SLOW FAST-STROBE MONOCHROME MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	elseif script.Parent.Preset.Value == 5 then -- FAST SLOW-STROBE MONOCHROME MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 6 then -- FAST FAST-STROBE MONOCHROME MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	elseif script.Parent.Preset.Value == 7 then -- SLOW SOLID RAINBOW MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 8 then -- FAST SOLID RAINBOW MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 9 then -- SLOW SLOW-STROBE RAINBOW MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 10 then -- SLOW FAST-STROBE RAINBOW MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	elseif script.Parent.Preset.Value == 11 then -- FAST SLOW-STROBE RAINBOW MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 12 then -- FAST FAST-STROBE RAINBOW MODE1
		light1.LightMachine.Mode.Value = 1
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	elseif script.Parent.Preset.Value == 13 then -- SLOW SOLID MONOCHROME MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 14 then -- FAST SOLID MONOCHROME MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 15 then -- SLOW SLOW-STROBE MONOCHROME MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 16 then -- SLOW FAST-STROBE MONOCHROME MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	elseif script.Parent.Preset.Value == 17 then -- FAST SLOW-STROBE MONOCHROME MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 18 then -- FAST FAST-STROBE MONOCHROME MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = false
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	elseif script.Parent.Preset.Value == 19 then -- SLOW SOLID RAINBOW MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 20 then -- FAST SOLID RAINBOW MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = false
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 21 then -- SLOW SLOW-STROBE RAINBOW MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 22 then -- SLOW FAST-STROBE RAINBOW MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 1
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	elseif script.Parent.Preset.Value == 23 then -- FAST SLOW-STROBE RAINBOW MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 3
	elseif script.Parent.Preset.Value == 24 then -- FAST FAST-STROBE RAINBOW MODE2
		light1.LightMachine.Mode.Value = 2
		light1.LightMachine.Speed.Value = 10
		light1.LightMachine.Strobe.Value = true
		light1.LightMachine.Rainbow.Value = true
		light1.LightMachine.Strobe.StrobeHertz.Value = 10
	end
	light2.LightMachine.Mode.Value = light1.LightMachine.Mode.Value
	light2.LightMachine.Speed.Value = light1.LightMachine.Speed.Value
	light2.LightMachine.Strobe.Value = light1.LightMachine.Strobe.Value
	light2.LightMachine.Rainbow.Value = light1.LightMachine.Rainbow.Value
	light2.LightMachine.Strobe.StrobeHertz.Value = light1.LightMachine.Strobe.StrobeHertz.Value

	light3.LightMachine.Mode.Value = light1.LightMachine.Mode.Value
	light3.LightMachine.Speed.Value = light1.LightMachine.Speed.Value
	light3.LightMachine.Strobe.Value = light1.LightMachine.Strobe.Value
	light3.LightMachine.Rainbow.Value = light1.LightMachine.Rainbow.Value
	light3.LightMachine.Strobe.StrobeHertz.Value = light1.LightMachine.Strobe.StrobeHertz.Value

	light4.LightMachine.Mode.Value = light1.LightMachine.Mode.Value
	light4.LightMachine.Speed.Value = light1.LightMachine.Speed.Value
	light4.LightMachine.Strobe.Value = light1.LightMachine.Strobe.Value
	light4.LightMachine.Rainbow.Value = light1.LightMachine.Rainbow.Value
	light4.LightMachine.Strobe.StrobeHertz.Value = light1.LightMachine.Strobe.StrobeHertz.Value

	light5.LightMachine.Mode.Value = light1.LightMachine.Mode.Value
	light5.LightMachine.Speed.Value = light1.LightMachine.Speed.Value
	light5.LightMachine.Strobe.Value = light1.LightMachine.Strobe.Value
	light5.LightMachine.Rainbow.Value = light1.LightMachine.Rainbow.Value
	light5.LightMachine.Strobe.StrobeHertz.Value = light1.LightMachine.Strobe.StrobeHertz.Value

	light6.LightMachine.Mode.Value = light1.LightMachine.Mode.Value
	light6.LightMachine.Speed.Value = light1.LightMachine.Speed.Value
	light6.LightMachine.Strobe.Value = light1.LightMachine.Strobe.Value
	light6.LightMachine.Rainbow.Value = light1.LightMachine.Rainbow.Value
	light6.LightMachine.Strobe.StrobeHertz.Value = light1.LightMachine.Strobe.StrobeHertz.Value
end)
