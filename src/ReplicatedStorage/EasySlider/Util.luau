
local Util = {}

for _, v in pairs(script:GetChildren()) do
	if v:IsA("ModuleScript") then
		Util[v.Name] = require(v)
	end
end

return Util