local Config = require(game:GetService("ReplicatedStorage"):WaitForChild("RolesConfig"))

local module = {}

function module:IsAuthorized(player)
	return Config:HasEffectAccess(player.Name)
end

return module
