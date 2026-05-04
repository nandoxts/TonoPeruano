local module = {}

-- Lista de jugadores autorizados
module.AuthorizedPlayers = {
	["xlm_brem"] = true,
	["AngeloGarciia"] = true,
}

function module:IsAuthorized(player)
	return self.AuthorizedPlayers[player.Name] == true
end

return module
