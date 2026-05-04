
local BaseSlider = script:WaitForChild("BaseSlider")

local EasySlider = {}

for _, v in pairs(BaseSlider:GetChildren()) do
	if v:IsA("ModuleScript") then
		EasySlider[v.Name] = require(v)
	end
end

return EasySlider