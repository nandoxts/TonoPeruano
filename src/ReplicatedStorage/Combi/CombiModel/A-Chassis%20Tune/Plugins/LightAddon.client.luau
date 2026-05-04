--- Valid names: Brakes,Headlights, highlights, Right, Left ---

--- Also, if you're reading this, then check out this light model i have, if you want to use it: https://www.roblox.com/library/4548192430/Lights-for-Inspare-Cars-KIT
local FE = workspace.FilteringEnabled
local car = script.Parent.Car.Value
local _Tune = require(car["A-Chassis Tune"])

local body = car.Body

local event=car.SmeersLightsHandler

local dtapdleft=false

local uis=game:GetService("UserInputService")

uis.InputBegan:connect(function(input, gp)
	if not gp then
		if input.KeyCode==Enum.KeyCode.Z or input.KeyCode==Enum.KeyCode.DPadLeft then
			event:FireServer({["ToggleLeftBlink"]=true})
		elseif input.KeyCode==Enum.KeyCode.C or input.KeyCode==Enum.KeyCode.DPadRight then
			event:FireServer({["ToggleRightBlink"]=true})
		elseif input.KeyCode==Enum.KeyCode.L then
			event:FireServer({["ToggleStandlicht"]=true})
		end
	end
end)

local Time, Activate, Blink, End = .2, 40, .1, 3
local CurrTime = 0 -- don't change this

car.DriveSeat.Changed:Connect(function(Change)
	if Change == "Throttle" then
		if car.DriveSeat.Throttle == -1 then
			event:FireServer({["EnableBrakes"]=true})
			if math.floor((10/12) * (60/88)*car.DriveSeat.Velocity.Magnitude) >= Activate then
				repeat if math.floor((10/12) * (60/88)*car.DriveSeat.Velocity.Magnitude) >= Activate then 
					if car.DriveSeat.Throttle == -1 then
					   CurrTime = CurrTime + .05
					else
				     CurrTime = 0
				      break 						
					end
			else
				CurrTime = 0
				break 
				 end
				wait(.05)
				 until CurrTime >= Time 
				 if CurrTime >= Time then
					CurrTime = 0
					if math.floor((10/12) * (60/88)*car.DriveSeat.Velocity.Magnitude) >= Activate then
					repeat	
				 if math.floor((10/12) * (60/88)*car.DriveSeat.Velocity.Magnitude) >= Activate or car.DriveSeat.Throttle == -1 then					
					event:FireServer({["EnableBrakes"]=true})
					wait(Blink)
					event:FireServer({["DisableBrakes"]=true})
					wait(Blink)	
					end
					until math.floor((10/12) * (60/88)*car.DriveSeat.Velocity.Magnitude) <= End or car.DriveSeat.Throttle ~= -1
					if math.floor((10/12) * (60/88)*car.DriveSeat.Velocity.Magnitude) <= End then
                       event:FireServer({["ToggleHazards"]=true})
					   event:FireServer({["EnableBrakes"]=true})						
					end
					end
				else
					CurrTime = 0
				end
			end
		else
			event:FireServer({["DisableBrakes"]=true})
		end
	end
end)

script.Parent.Values.Gear.Changed:connect(function()
	if script.Parent.Values.Gear.Value == -1 then
		event:FireServer({["ReverseOn"]=true})
	elseif script.Parent.Values.Gear.Value ~= -1 then
		event:FireServer({["ReverseOff"]=true})
	end
end)
