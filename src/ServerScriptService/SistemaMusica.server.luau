local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Market = game:GetService("MarketplaceService")

local SisMusic = Replicated:WaitForChild("SisMusica")
local SkipMusica = Replicated:WaitForChild("SkipMusica")

local AnadirSong = SisMusic:WaitForChild("AnadirSong")
local ObtenerCatalogo = SisMusic:WaitForChild("ObtenerCatalog")
local DarPlaylist = SisMusic:WaitForChild("DarPlaylist")
local DarCurrent = SisMusic:WaitForChild("DarCurrent")
local DarAviso = SisMusic:WaitForChild("AvisoLocal")

local CancionSistema = workspace.CancionSIstema
local IDS = script:WaitForChild("Catalogo")
local CancionElegida
local loadingsong = false
local UltimaCancionID = nil

local GamePassID = 1092300393

local AdminsSkip = {
	1836329833, 7520662615, 5819550352, 522683358,
	3115867419, 2888323694, 5752546451, 1402882826, 606751335,
}

local Catalogo = require(IDS)
local Playlist = {}
local CancionesPorJugador = {}

local function len(t)
	local n = 0
	for _ in pairs(t) do n += 1 end
	return n
end

local function EstaEnCatalogo(id)
	for _, songs in pairs(Catalogo.IDS) do
		for songID, _ in pairs(songs) do
			if tostring(songID) == tostring(id) then return true end
		end
	end
	return false
end

local function ObtenerName(id)
	local name = ""
	for _, v in pairs(Catalogo.IDS) do
		for j, k in pairs(v) do
			if tostring(j) == tostring(id) then
				name = k
				break
			end
		end
	end
	if name == "" then
		pcall(function()
			name = Market:GetProductInfo(tonumber(id), Enum.InfoType.Asset).Name
		end)
	end
	return name
end

ObtenerCatalogo.OnServerInvoke = function(jugador)
	return Catalogo.IDS , Catalogo.DjUserId
end

AnadirSong.OnServerInvoke = function(jugador, id)
	if not EstaEnCatalogo(id) then
		return "Error: Esta canción no está en el catálogo."
	end

	if CancionElegida and tostring(CancionElegida.ID) == tostring(id) then
		return "Esa canción ya se está reproduciendo."
	end
	for _, song in ipairs(Playlist) do
		if tostring(song.ID) == tostring(id) then
			return "Esa canción ya está en la cola."
		end
	end

	local userId = jugador.UserId
	local esAdmin = table.find(AdminsSkip, userId) ~= nil
	local esPrivado = (game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0)

	local limite = 2
	if esAdmin or esPrivado then
		limite = math.huge
	else
		local success, hasPass = pcall(function()
			return Market:UserOwnsGamePassAsync(userId, GamePassID)
		end)
		if success and hasPass then
			limite = 5
		end
	end

	CancionesPorJugador[userId] = CancionesPorJugador[userId] or 0

	if CancionesPorJugador[userId] >= limite then
		if limite == 2 then
			return "Si deseas agregar más debes comprar el VIP"
		else
			return "Espera que terminen tus canciones para añadir más"
		end
	end

	local Datos = {
		ID = id,
		Nombre = ObtenerName(id),
		Por = jugador.Name,
		UserId = userId
	}

	if esAdmin then
		local lastAdminIndex = 0
		for i, song in ipairs(Playlist) do
			if table.find(AdminsSkip, song.UserId) then
				lastAdminIndex = i
			end
		end

		if lastAdminIndex > 0 then
			table.insert(Playlist, lastAdminIndex + 1, Datos)
		else
			table.insert(Playlist, 1, Datos)
		end
	else
		table.insert(Playlist, Datos)
	end

	CancionesPorJugador[userId] += 1
	DarPlaylist:FireAllClients(Playlist)

	return "Añadida con éxito!"
end

Players.PlayerRemoving:Connect(function(jugador)
	local userId = jugador.UserId
	if table.find(AdminsSkip, userId) then return end

	for i = #Playlist, 1, -1 do
		if Playlist[i].UserId == userId then
			table.remove(Playlist, i)
		end
	end
	CancionesPorJugador[userId] = nil
	DarPlaylist:FireAllClients(Playlist)
end)

Players.PlayerAdded:Connect(function(jugador)
	local esPrivado = (game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0)

	jugador.Chatted:Connect(function(msg)
		if table.find(AdminsSkip, jugador.UserId) and msg == "/s" then
			CancionSistema.TimePosition = CancionSistema.TimeLength - 2
		elseif esPrivado and msg:lower() == "skip" then
			CancionSistema.TimePosition = CancionSistema.TimeLength - 2
		end
	end)
end)

SkipMusica.OnServerEvent:Connect(function(player)
	if CancionSistema and CancionSistema.IsPlaying then
		CancionSistema.TimePosition = CancionSistema.TimeLength - 2
	end
end)

while true do
	local selectedfrom = "random"
	if #Playlist > 0 then
		selectedfrom = "queue"
		CancionElegida = table.remove(Playlist, 1)
	elseif CancionElegida == nil or CancionElegida.ID == UltimaCancionID then
		local Datos
		repeat
			local Dj = math.random(1, len(Catalogo.IDS))
			local i = 1
			for nameDj, songs in pairs(Catalogo.IDS) do
				if i == Dj then
					local ID = math.random(1, len(songs))
					local j = 1
					for IDS, Nombre in pairs(songs) do
						if j == ID then
							Datos = {ID = IDS, Nombre = Nombre, Por = "Servidor"}
							break
						end
						j += 1
					end
					break
				end
				i += 1
			end
		until Datos and tostring(Datos.ID) ~= tostring(UltimaCancionID)
		CancionElegida = Datos
	end

	local Tolerancia = 0
	if CancionElegida and tonumber(CancionElegida.ID) then
		CancionSistema.SoundId = "rbxassetid://"..CancionElegida.ID
		DarPlaylist:FireAllClients(Playlist)

		repeat task.wait(1)
			loadingsong = true
			Tolerancia += 1
		until CancionSistema.IsLoaded or Tolerancia >= 20

		if CancionSistema.IsLoaded then
			CancionSistema.TimePosition = 0
			DarCurrent:FireAllClients(CancionElegida, CancionSistema.TimeLength/2)

			local Player = game.Players:FindFirstChild(CancionElegida.Por)
			if Player then
				DarAviso:FireClient(Player, "Atención: \n Ya estamos reproduciendo tu canción.")
			end

			CancionSistema:Play()
			loadingsong = false
			UltimaCancionID = CancionElegida.ID

			if CancionElegida.UserId then
				local uid = CancionElegida.UserId
				if CancionesPorJugador[uid] and CancionesPorJugador[uid] > 0 then
					CancionesPorJugador[uid] -= 1
				end
			end

			CancionSistema.Ended:Wait()
		else
			local Player = game.Players:FindFirstChild(CancionElegida.Por)
			if Player then
				DarAviso:FireClient(Player, "Error: \n Ocurrió un error al cargar.")
			end
		end
	end
	task.wait()
end