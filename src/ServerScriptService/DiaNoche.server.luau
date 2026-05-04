local lighting = game:GetService("Lighting")

local startTime = 3.921
local endTime = 6.228

local firstPhaseDuration = 20 * 60
local transitionDuration = 10
local secondPhaseDuration = 5 * 60 

local function transitionLighting()
	lighting.ClockTime = startTime
	wait(firstPhaseDuration)

	local startTick = tick()
	local endTick = startTick + transitionDuration
	while tick() < endTick do
		local elapsedTime = tick() - startTick
		local progress = elapsedTime / transitionDuration
		lighting.ClockTime = startTime + (endTime - startTime) * progress
		wait(0.03)
	end

	lighting.ClockTime = endTime
	wait(secondPhaseDuration)
end

transitionLighting()
