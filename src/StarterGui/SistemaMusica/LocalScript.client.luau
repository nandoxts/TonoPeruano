local Replicated = game:GetService("ReplicatedStorage")
local Group = game:GetService("GroupService")
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TwSe = game:GetService("TweenService")

local SisMusica = Replicated:WaitForChild("SisMusica")

local ObtenerCatalogo = SisMusica:WaitForChild("ObtenerCatalog")
local Catalogo, DjUserId = ObtenerCatalogo:InvokeServer()
local AnadirSong = SisMusica:WaitForChild("AnadirSong")
local ObtenerPlaylist = SisMusica:WaitForChild("DarPlaylist")
local ObtenerCurrent = SisMusica:WaitForChild("DarCurrent")
local ObtenerAviso = SisMusica:WaitForChild("AvisoLocal")

local Frame = script.Parent:WaitForChild("Frame")
local Frame2 = Frame:WaitForChild("Frame")
local Explorador = Frame2:WaitForChild("Explorador")
local Propiedades = Frame2:WaitForChild("Propiedades")

local BarraIzquierda = Frame:WaitForChild("CustomId")
local CustomId = BarraIzquierda:WaitForChild("IDCusto")
local CIDBox = CustomId:WaitForChild("TextBox")
local CIDButton = CustomId:WaitForChild("TextButton")

local Notificaciones = BarraIzquierda:WaitForChild("Notificaciones")
local SampleNot = script:WaitForChild("Notificacion")

local Playlist = Frame:WaitForChild("Playlist")
local ScrollPlaylist = Playlist:WaitForChild("Play")

local Seleccionado
local previsualizando

local Icon = Replicated:WaitForChild("Modulos")
local IconM = Icon:WaitForChild("Icon")
local IconMo = require(IconM)



local IconoMusica = IconMo.new()

IconoMusica:setLabel("Musica")
IconoMusica:bindToggleItem(script.Parent.Frame)
IconoMusica:disableStateOverlay(false)
IconoMusica:setCaption("Music menu")
IconoMusica:setImage("7059338404")


--IconoMusica--

local visualpro = workspace:WaitForChild("visualpro")
local Cancion = workspace.CancionSIstema


function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local function Aminutos(segundos)
	local minutos = math.floor(segundos/60)
	local segundos = segundos%60
	if segundos < 10 then
		segundos = "0"..segundos
	end
	return minutos..":"..tostring(segundos):sub(1, 2)
end

local function Notificar(texto, Tiempo)
	for _, notifi in pairs(Notificaciones:GetChildren()) do
		if notifi then

		end
	end

	local NuevaNoti = SampleNot:Clone()
	NuevaNoti.TextLabel.Text = texto
	NuevaNoti.Parent = Notificaciones
	NuevaNoti.Position = UDim2.new(0.05, 0, 0, 0)
	NuevaNoti.Hora.Text = convertToHMS(os.clock())

	NuevaNoti.Eliminar.MouseButton1Click:Connect(function()
		NuevaNoti:Destroy()

		for _, notifi in pairs(Notificaciones:GetChildren()) do
			if notifi and notifi.Position.Y.Offset > NuevaNoti.Position.Y.Offset then
				local Anim = TwSe:Create(notifi, TweenInfo.new(0.1), {Position = notifi.Position - UDim2.new(0, 0, 0, 65)})
				Anim:Play()
			end
		end
	end)

	local duracion = Tiempo or 10
	local BarraTiempo = NuevaNoti.Tiempo.Frame
	local Anim = TwSe:Create(BarraTiempo, TweenInfo.new(duracion, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
	Anim:Play()
	Anim.Completed:Connect(function()
		NuevaNoti:Destroy()

		for _, notifi in pairs(Notificaciones:GetChildren()) do
			if notifi and notifi.Position.Y.Offset > NuevaNoti.Position.Y.Offset then
				local Anim = TwSe:Create(notifi, TweenInfo.new(0.1), {Position = notifi.Position - UDim2.new(0, 0, 0, 65)})
				Anim:Play()
			end
		end
	end)

end

local function len(t)
	local n = 0

	for _ in pairs(t) do
		n = n + 1
	end
	return n
end

local function ObtenerDuracion(id)
	local tolerancia = 0
	local Retornar = "0"

	local sonido = Instance.new("Sound")
	sonido.Parent = script.Parent
	sonido.Volume = 0
	sonido.SoundId = "rbxassetid://"..tostring(id)

	repeat task.wait(0.25)
		tolerancia = tolerancia + 1
	until sonido.TimeLength > 0 or tolerancia == 10

	if sonido.TimeLength > 0 then
		Retornar = tostring(sonido.TimeLength)
	end

	sonido:Destroy()

	return Retornar
end

local function ObtenerImagen(jugador)
	local imagen = ""
	local succ, err = pcall(function()
		imagen = Players:GetUserThumbnailAsync(jugador.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)

	return imagen
end	

for i,v in pairs(Explorador:GetChildren()) do
	if v then
		v:Destroy()
	end
end

RS.RenderStepped:Connect(function()
	local loud = Cancion.PlaybackLoudness
	visualpro.Size = Vector3.new(loud/10, loud/10, loud/10)
end)

CIDButton.MouseButton1Click:Connect(function()
	if CIDBox.Text ~= "" then
		local id = tonumber(CIDBox.Text)
		local res = AnadirSong:InvokeServer(id)
		Notificar(res)
	end
end)

ObtenerCurrent.OnClientEvent:Connect(function(array, duracion)
	Notificar("Reproduciendo: "..array["Nombre"].."\n Por: "..array["Por"], duracion )
end)

ObtenerAviso.OnClientEvent:Connect(function(mensaje)
	Notificar(mensaje)
end)

ObtenerPlaylist.OnClientEvent:Connect(function(playlist)

	for i,v in pairs(ScrollPlaylist:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end

	--ScrollPlaylist.CanvasSize = UDim2.new(0,0,0,0)

	for i,v in ipairs(playlist) do
		local sample = script.SamplePlaylist:Clone()
		sample.Dueno.Text = v.Por
		if Players:FindFirstChild(v.Por) ~= nil then
			sample.Icono.Image = ObtenerImagen(Players:FindFirstChild(v.Por))
		else
			sample.Icono.Image = "rbxassetid://"
		end

		sample.Canciones.SampleCancion.Nombre.Text = v.Nombre
		sample.Parent = ScrollPlaylist

		--sample.Position = UDim2.new(0,0,0,ScrollPlaylist.CanvasSize.Y.Offset)

		ScrollPlaylist.CanvasSize = UDim2.new(0,0,0,ScrollPlaylist.CanvasSize.Y.Offset+60)
	end
end)

Explorador.CanvasSize = UDim2.new(0,0,0,0)

for i , v in pairs(Catalogo) do
	local ArtistaNuevo = script.SampleArtista:Clone()	
	ArtistaNuevo.Position = UDim2.new(0,0,0,Explorador.CanvasSize.Y.Offset)
	ArtistaNuevo.Parent = Explorador

	local Abierto = false

	if DjUserId[i] ~= "" then
		local imagen = ""
		local succ, err = pcall(function()
			imagen = Players:GetUserThumbnailAsync(DjUserId[i], Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		end)
		if succ then
			ArtistaNuevo.Icono.Image = imagen
		else
			ArtistaNuevo.Icono.Image = "rbxassetid://15000532008"
		end
	else
		ArtistaNuevo.Icono.Image = "rbxassetid://15000532008"
	end

	local Size = 0
	local cargado = 0
	local Total = len(v)

	for id,cancion in pairs(v) do
		ArtistaNuevo.Dueno.Text = tostring(i).." / "..[[<font size="10">]].. cargado.." - "..Total..[[</font>]]
		cargado = cargado + 1
		local Song = script.SampleCancion:Clone()
		Song.Parent = ArtistaNuevo.Canciones
		Song.Position = UDim2.new(0,0,0,ArtistaNuevo.Canciones.Size.Y.Offset)
		Song.Nombre.Text = cancion

		ArtistaNuevo.Canciones.Size = UDim2.new(0.8,0,0,ArtistaNuevo.Canciones.Size.Y.Offset + 26)
		Size = Size + 26

		Song.MouseButton1Click:Connect(function()
			if Seleccionado then
				Seleccionado.BackgroundTransparency = 1
			end

			Song.BackgroundTransparency = 0.6

			for _,p in pairs(Propiedades:GetChildren()) do
				if p then
					p:Destroy()
				end
			end

			Propiedades.CanvasSize = UDim2.new(0,0,0,0)

			local Anadir = Instance.new("TextButton")
			Anadir.Text = "Reproducir"
			Anadir.Size = UDim2.new(1, 0, 0, 25)
			Anadir.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
			Anadir.BorderColor3 = Color3.fromRGB(34, 34, 34)
			Anadir.Parent = Propiedades
			Anadir.Font = Enum.Font.Gotham
			Anadir.TextSize = 14
			Anadir.TextColor3 = Color3.fromRGB(255, 255, 255)

			local Preview = Instance.new("TextButton")
			Preview.Text = "Escuchar"
			Preview.Size = UDim2.new(1, 0, 0, 25)
			Preview.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
			Preview.BorderColor3 = Color3.fromRGB(34, 34, 34)
			Preview.Parent = Propiedades
			Preview.Font = Enum.Font.Gotham
			Preview.TextSize = 14
			Preview.TextColor3 = Color3.fromRGB(255, 255, 255)
			Preview.Position = UDim2.new(0,0,0,25)

			local Nombre = script.Propiedad:Clone()
			Nombre.Parent = Propiedades
			Nombre.Propiedad.Text = "Name"
			Nombre.Valor.Text = cancion
			Nombre.Position = UDim2.new(0,0,0,50)

			Anadir.MouseButton1Click:Connect(function()
				local resultado = AnadirSong:InvokeServer(id)
				Notificar(resultado)
			end)

			Preview.MouseButton1Click:Connect(function()
				if Preview.Text == "Escuchar" then
					Preview.Text = "Parar"

					if previsualizando then
						previsualizando:Stop()
						previsualizando:Destroy()
					end

					previsualizando = Instance.new("Sound")
					previsualizando.Parent = script.Parent
					previsualizando.SoundId = "rbxassetid://"..id
					previsualizando:Play()

					previsualizando.Stopped:Connect(function()
						Preview.Text = "Escuchar"
					end)

				else
					Preview.Text = "Escuchar"

					if previsualizando then
						previsualizando:Stop()
						previsualizando:Destroy()
					end
				end
			end)

			Seleccionado = Song
		end)

		--[[
		local TiempoTotal = ObtenerDuracion(id)
		local Duracion = script.Propiedad:Clone()
		Duracion.Parent = Propiedades
		Duracion.Propiedad.Text = "Duracion"
		Duracion.Valor.Text = Aminutos(TiempoTotal)
		Duracion.Position = UDim2.new(0,0,0,75)
		if tonumber(TiempoTotal) > 0 then
			
		end
		]]
	end

	ArtistaNuevo.Dueno.Text = tostring(i)
	ArtistaNuevo.Canciones.Visible = false


	ArtistaNuevo.MouseButton1Click:Connect(function()
		if Abierto == false then
			Explorador.CanvasSize = UDim2.new(0,0,0,Explorador.CanvasSize.Y.Offset+Size)
			ArtistaNuevo.Canciones.Visible = true

			for a,b in pairs(Explorador:GetChildren()) do
				if b.Position.Y.Offset > ArtistaNuevo.Position.Y.Offset then
					b.Position = b.Position + UDim2.new(0,0,0,Size)
				end
			end

			Abierto = true
		elseif Abierto == true then
			Explorador.CanvasSize = UDim2.new(0,0,0,Explorador.CanvasSize.Y.Offset-Size)
			ArtistaNuevo.Canciones.Visible = false

			for a,b in pairs(Explorador:GetChildren()) do
				if b.Position.Y.Offset > ArtistaNuevo.Position.Y.Offset then
					b.Position = b.Position - UDim2.new(0,0,0,Size)
				end
			end


			Abierto = false
		end
	end)

	Explorador.CanvasSize = UDim2.new(0,0,0,Explorador.CanvasSize.Y.Offset + 30)

end

Notificar("Canciones cargadas!")