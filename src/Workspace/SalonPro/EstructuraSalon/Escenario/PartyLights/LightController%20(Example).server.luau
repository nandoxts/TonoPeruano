script.Parent.PartyLights.PartyLight1.LightMachine.Power.Value = true
script.Parent.PartyLights.PartyLight2.LightMachine.Power.Value = true
script.Parent.PartyLights.PartyLight3.LightMachine.Power.Value = true
script.Parent.PartyLights.PartyLight4.LightMachine.Power.Value = true
script.Parent.PartyLights.PartyLight5.LightMachine.Power.Value = true
script.Parent.PartyLights.PartyLight6.LightMachine.Power.Value = true
script.Parent.Lasers.PartyLasersL.LaserMachine.Lasers.Power.Value = true
script.Parent.Lasers.PartyLasersR.LaserMachine.Lasers.Power.Value = true

while true do
	script.Parent.PartyLights.Preset.Value = math.random(1, 24)
	script.Parent.Lasers.Preset.Value = math.random(1, 36)
	task.wait(1)
end
