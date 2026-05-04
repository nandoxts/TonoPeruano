local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Tienda = game:GetService("MarketplaceService")
local RS = game:GetService("RunService")
local Replicado = game:GetService("ReplicatedStorage")

local Remotos = Replicado:WaitForChild("EventosEmote")
local ObtenerFavs = Remotos:WaitForChild("ObtenerFavs")
local AnadirFav = Remotos:WaitForChild("AnadirFav")
local Trending = Remotos:WaitForChild("Trending")
local ObtenerTrending = Remotos:WaitForChild("ObtenerTrending")
local ObtenerVipL = Replicado:WaitForChild("Vippro")

local Samples = script:WaitForChild("Samples")
local Fav = Samples:WaitForChild("Favorito")
local Fuego = Samples:WaitForChild("Fuego")
local Normal = Samples:WaitForChild("Normal")
local Vip = Samples:WaitForChild("Vip")
local RPremium = Samples:WaitForChild("RPremium")
local Animaciones = Replicado:WaitForChild("Modulos"):WaitForChild("Animaciones")
local Slider = require(Replicado:WaitForChild("Modulos"):WaitForChild("Slider"))

local Frame = script.Parent:WaitForChild("Frame")
local Scroll = Frame:WaitForChild("ScrollingFrame")

--[[ REMOTES Dances]]--
local Remotes = game:GetService("ReplicatedStorage").RemotesSync
local PlayAnimationRemote = Remotes.PlayAnimation
local StopAnimationRemote = Remotes.StopAnimation


local Jugador = Players.LocalPlayer
local Char = Jugador.Character or Jugador.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local Animator = Hum:WaitForChild("Animator")

local Modulos = Replicado:WaitForChild("Modulos")
local MIcon = Modulos:WaitForChild("Icon")
local Icon = require(MIcon)


local Icono = Icon.new()
Icono:setOrder(2)
Icono:setLabel("Bailes")
Icono:setImage("110748588642372")
Icono:bindToggleItem(Frame)
Icono:disableStateOverlay(false)







local Modulo = require(Animaciones)
local ConexionAnim --No la borres, si tiene utilidad uwuw
local Estado = nil
local UltimaAnim
local Velocidad = 1
local Temporizador = 1
local Termino = false
local Visualizando = 0
local max = 10
local ConexionTween
local AnimOtro
local EsVip = false
local DanceActivated

local EmotesTrending = ObtenerTrending:InvokeServer()
local EmotesFavs = ObtenerFavs:InvokeServer()

ObtenerVipL.OnClientEvent:Connect(function(modo)
	if modo == true then
		EsVip = true
	end
end)

local TiposNoti = {
	["Aviso"] = {
		["Color1"] = Color3.fromHex("#e6eff8"),
		["Color2"] = Color3.fromHex("#c6d4e2")
	},
	["Warn"] = {
		["Color1"] = Color3.fromHex("#fef7ea"),
		["Color2"] = Color3.fromHex("#f4eada")
	},
	["Bien"] = {
		["Color1"] = Color3.fromHex("#ebf6ee"),
		["Color2"] = Color3.fromHex("#e2f1e7")
	}
}

local Twenear = function(parte, duracion, tabla)
	local info = TweenInfo.new(duracion, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local Anim = TweenService:Create(parte, info, tabla)
	Anim:Play()
	return Anim
end

local PercentageBar

--[[ SPEEDBAR FUNCTION ]]--

local function sliderCreate()
	local sliderFrame = Frame.BG
	local moveInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad)

	PercentageBar = Slider.new(
		sliderFrame, 
		{Start = 0, End = 1, Increment = 0.1, DefaultValue = 0.5}, 
		moveInfo,
		"X"
	)
	local oldPercentage = -1
	PercentageBar.Changed:Connect(function(Percentage)
		if Percentage ~= oldPercentage and oldPercentage ~= -1 then
			if Percentage == 0 then
				PlayAnimationRemote:FireServer("speed", 0.01)
			elseif Percentage == 0.1 then
				PlayAnimationRemote:FireServer("speed", 0.05)
			elseif Percentage == 0.2 then
				PlayAnimationRemote:FireServer("speed", 0.3)
			elseif Percentage == 0.3 then
				PlayAnimationRemote:FireServer("speed", 0.5)
			elseif Percentage == 0.4 then
				PlayAnimationRemote:FireServer("speed", 0.7)
			elseif Percentage == 0.5 then
				PlayAnimationRemote:FireServer("speed", 1)
			elseif Percentage == 0.6 then
				PlayAnimationRemote:FireServer("speed", 1.3)
			elseif Percentage == 0.7 then
				PlayAnimationRemote:FireServer("speed", 1.6)
			elseif Percentage == 0.8 then
				PlayAnimationRemote:FireServer("speed", 1.9)
			elseif Percentage == 0.9 then
				PlayAnimationRemote:FireServer("speed", 2.2)
			elseif Percentage == 1.0 then
				PlayAnimationRemote:FireServer("speed", 2.5)
			end
		end
		oldPercentage = Percentage
	end)

	PercentageBar:Track()
end

sliderCreate()

local Notificacion = function(mensaje, modo, tiempo)
	print(mensaje)
	if TiposNoti[modo] then
		local Notificacion = Instance.new("ScreenGui")
		local Frame = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")


		--// Propiedades

		Notificacion.Name = "Notificacion"
		Notificacion.Parent = Jugador:WaitForChild("PlayerGui")
		Notificacion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		Frame.Name = "Frame"
		Frame.Parent = Notificacion
		Frame.BackgroundColor3 = Color3.fromRGB(254, 247, 234)
		Frame.Position = UDim2.new(0.484621823, 0, -0.1, 0)
		Frame.Size = UDim2.new(0, 35, 0, 35)
		Frame.Font = Enum.Font.Gotham
		Frame.Text = "Notificacion"
		Frame.TextColor3 = Color3.fromHex("#545d60")
		Frame.TextSize = 16.000
		Frame.TextWrapped = true

		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = Frame

		UIStroke.Thickness = 2
		UIStroke.Color = Color3.fromRGB(244, 234, 218)
		UIStroke.Parent = Frame
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

		local ciclo = coroutine.wrap(function()
			print("Encontrado")
			Frame.Text = mensaje

			Frame.BackgroundColor3 = TiposNoti[modo].Color1
			UIStroke.Color = TiposNoti[modo].Color2


			local Animacion = Twenear(Frame, 0.5, {Position = UDim2.new(0.485, 0,0.01, 0)})
			Animacion.Completed:Wait()
			local ANimacion2 = Twenear(Frame, 0.5, {Size = UDim2.new(0.3,0, 0, 35), Position = UDim2.new(0.35, 0, 0.01, 0)})
			ANimacion2.Completed:Wait()

			wait(tiempo)
			local AnimFinal = Twenear(Frame, 0.5, {Size = UDim2.new(0, 35, 0, 35), Position = UDim2.new(0.484621823, 0, 0.01, 0)})
			AnimFinal.Completed:Wait()

			local pepeetesech = Twenear(Frame, 0.5, {Position = UDim2.new(0.484621823, 0, -0.1, 0)})
			pepeetesech.Completed:Connect(function()
				Notificacion:Destroy()    
			end)
		end)
		ciclo()
		return Frame
	end

end


local ObtenerName = function(id)
	local succ, res = pcall(function()
		return Tienda:GetProductInfo(id, Enum.InfoType.Asset)
	end)

	if succ == true and res then
		return res.Name
	end

	return "Dance"
end

local CrearAnim = function(id)
	local Anim = Instance.new("Animation")
	Anim.AnimationId = "rbxassetid://"..id

	return Anim
end

local EncontrarNombre = function(BaileId)
	for i,v in pairs(Modulo.VIP) do
		if v.ID == BaileId then
			return v.Nombre
		end
	end

	for i,v in pairs(Modulo.RobloxPremium) do
		if v.ID == BaileId then
			return v.Nombre
		end
	end

	for i,v in pairs(Modulo.Ids) do
		if v.ID == BaileId then
			return v.Nombre
		end
	end

	return "Dance"
end

local FuncionBoton = function(boton, id, nombre, vip, premium)
	local ReproducioAnim = false
	local Bailando = false

	boton.MouseButton1Click:Connect(function()


		if premium and premium == true then
			if Jugador.MembershipType ~= Enum.MembershipType.Premium then
				Tienda:PromptPremiumPurchase(Jugador)
				Notificacion("Necesitas Roblox Premium para usar este emote", "Warn", 5)
				return
			end
		end

		if ReproducioAnim == false then
			ReproducioAnim = true
			if vip and premium then
			else
				--Trending:FireServer(id)
			end
		end

		if ConexionAnim then
			ConexionAnim:Stop()
		end
		if DanceActivated == boton.Parent.Nombre.Text then
			DanceActivated = nil
			StopAnimationRemote:FireServer()
		else
			DanceActivated = boton.Parent.Nombre.Text
			PlayAnimationRemote:FireServer("playAnim",boton.Parent.Nombre.Text)
		end
--[[
			local Anim = CrearAnim(id)

			ConexionAnim = Animator:LoadAnimation(Anim)
			ConexionAnim.Priority= Enum.AnimationPriority.Action
			ConexionAnim:Play()
			ConexionAnim:AdjustSpeed(Velocidad)
			Anim:Destroy()
]]--
		if Bailando == false then
			Bailando = true
		elseif Bailando == true then
			Bailando = false
			if ConexionAnim then
				ConexionAnim:Stop()
			end
		end


		if boton.Name == "Favorito" then
			local Estatus = AnadirFav:InvokeServer(id)
			if Estatus == "Anadido" then
				Notificacion(nombre.." añadido a favoritos", "Bien", 4)
			elseif Estatus == "Eliminada" then
				Notificacion(nombre.." eliminado de favoritos", "Aviso", 4)
			elseif Estatus == false then
				Notificacion("Ocurrio un error, intenta de nuevo", "Warn", 4)
			end

			EmotesFavs = ObtenerFavs:InvokeServer()
			Temporizador = 50
		end
	end)
end

local CrearIntermediario = function(texto, off)
	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(0.9, 0, 0, 12)
	text.Position = off
	text.Text = texto
	text.Font = Enum.Font.GothamMedium
	text.TextColor3 = Color3.fromRGB(206, 206, 206)
	text.TextXAlignment = Enum.TextXAlignment.Center
	text.Parent = Scroll
	text.BackgroundTransparency = 1
	text.TextScaled = true
	Scroll.CanvasSize = UDim2.new(0,0,0, Scroll.CanvasSize.Y.Offset + 12)
	return text
end

local Actualizar = function(scroll, tabla)
	for i,v in pairs(scroll:GetChildren()) do
		if v then
			v:Destroy()
		end
	end

	scroll.CanvasSize = UDim2.new(0,0,0,0)

	EmotesTrending = ObtenerTrending:InvokeServer()

	if #EmotesFavs > 0 then
		for i,v in pairs(EmotesFavs) do
			if i == 1 then
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)
			end

			local Nombre = EncontrarNombre(v)

			local Clon = Fav:Clone()
			Clon.Position = UDim2.new(0.05,0,-0.004, scroll.CanvasSize.Y.Offset)
			Clon.Nombre.Text = Nombre 
			Clon.Parent = scroll
			Clon.Name = Nombre

			FuncionBoton(Clon.Reproducir, v, Nombre)
			FuncionBoton(Clon.Favorito, v, Nombre)

			scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 39)

		end
	end

	if #EmotesTrending > 0 then
		for i,v in pairs(EmotesTrending) do
			if i == 1 then
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)
				CrearIntermediario("", UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset))
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)			
			end
			if not table.find(EmotesFavs, v) then
				local Nombre = EncontrarNombre(v)

				local Clon = Fuego:Clone()
				Clon.Position = UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset)
				Clon.Nombre.Text = Nombre
				Clon.Parent = scroll
				Clon.Name = Nombre

				FuncionBoton(Clon.Reproducir, v, Nombre)
				FuncionBoton(Clon.Favorito, v, Nombre)

				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 39)
			end
		end
	end

	if #Modulo.VIP > 0 then
		for i,v in pairs(Modulo.VIP) do
			if i == 1 then
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)
				CrearIntermediario("", UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset))
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)				
			end
			--if not table.find(EmotesTrending, v.ID) and not table.find(EmotesFavs, v.ID) then
			local Nombre = v.Nombre

			local Clon = Vip:Clone()
			Clon.Position = UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset)
			Clon.Nombre.Text = Nombre
			Clon.Parent = scroll
			Clon.Name = Nombre

			FuncionBoton(Clon.Reproducir, v.ID, Nombre, true)
			--FuncionBoton(Clon.Favorito, v.ID, Nombre)

			scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 39)
			--end
		end
	end

	if #Modulo.RobloxPremium > 0 then
		for i,v in pairs(Modulo.RobloxPremium) do
			if i == 1 then
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)
				CrearIntermediario("", UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset))
				scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)				
			end
			--if not table.find(EmotesTrending, v.ID) and not table.find(EmotesFavs, v.ID) and not table.find(Modulo.VIP, v.ID) then
			local Nombre = v.Nombre
			local Clon = RPremium:Clone()
			Clon.Position = UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset)
			Clon.Nombre.Text = Nombre
			Clon.Parent = scroll
			Clon.Name = Nombre

			FuncionBoton(Clon.Reproducir, v.ID, Nombre,false,true)
			--FuncionBoton(Clon.Favorito, v.ID, Nombre)

			scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 39)
			--end
		end
	end
	for i,v in pairs(tabla) do
		if i == 1 then
			scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)
			CrearIntermediario("", UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset))
			scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 12)		end

		local Nombre = v.Nombre
		if not table.find(EmotesTrending, v.ID) and not table.find(EmotesFavs, v.ID) and not table.find(Modulo.VIP, v.ID) and not table.find(Modulo.RobloxPremium, v.ID) then
			local Clon = Normal:Clone()
			Clon.Position = UDim2.new(0.05,0,0, scroll.CanvasSize.Y.Offset)
			Clon.Nombre.Text = Nombre
			Clon.Parent = scroll
			Clon.Name = Nombre

			FuncionBoton(Clon.Reproducir, v.ID, Nombre)
			FuncionBoton(Clon.Favorito, v.ID, Nombre)

			scroll.CanvasSize = UDim2.new(0, 0, 0, scroll.CanvasSize.Y.Offset + 39)
		end

	end
end

local RedondearDecial = function(valor, decimales)
	return math.floor(valor * 10^decimales + 0.5) / 10^decimales
end

local ObtenerNumero = function(str)
	local numero = ""
	for i = 1, #str do
		local letra = str:sub(i,i)
		if tonumber(letra) then
			numero = numero..letra
		end
	end
	return tonumber(numero)
end

local BuscarJugador = function(str)
	local Jugagod = Players:FindFirstChild(str)
	if Jugagod then
		return Jugagod
	end

	for i,v in pairs(Players:GetPlayers()) do
		if v.Name:lower():find(str:lower()) then
			return v
		end
	end

	return false
end

local comparar = function(Animator)
	local Animaciones = Animator:GetPlayingAnimationTracks()
	local Baile = Animaciones[#Animaciones]
	local ElBaileExiste = false

	if UltimaAnim ~= Baile.Animation then
		for _,bailee in pairs(Modulo.Ids) do
			if bailee.ID == ObtenerNumero(Baile.Animation.AnimationId) then
				ElBaileExiste = true
				break
			end
		end
		if #Modulo.VIP > 0 then
			for _,bailee in pairs(Modulo.VIP) do
				if bailee.ID == ObtenerNumero(Baile.Animation.AnimationId) then
					ElBaileExiste = true
					break
				end
			end
		end

		for _,bailee in pairs(Modulo.RobloxPremium) do
			if bailee.ID == ObtenerNumero(Baile.Animation.AnimationId) then
				ElBaileExiste = true
				break
			end
		end

		if ElBaileExiste == true then
			print(Baile.Animation.AnimationId)
			print("Existe")
			UltimaAnim = Baile.Animation
			return true
		end
		--return false
	end

	return false
end

local sincronisar = function(Animator, OtroAniamator)
	local Animaciones = Animator:GetPlayingAnimationTracks()
	local Baile = Animaciones[#Animaciones]

	local Existegod = false
	repeat wait()
		for _,bailee in pairs(Modulo.Ids) do
			if bailee.ID == ObtenerNumero(Baile.Animation.AnimationId) then
				Existegod = true
				break
			end
		end

		if #Modulo.VIP > 0 then
			for _,bailee in pairs(Modulo.VIP) do
				if bailee.ID == ObtenerNumero(Baile.Animation.AnimationId) then
					Existegod = true
					break
				end
			end
		end

		for _,bailee in pairs(Modulo.RobloxPremium) do
			if bailee.ID == ObtenerNumero(Baile.Animation.AnimationId) then
				Existegod = true
				break
			end
		end

		if Existegod == false then
			Baile = Animaciones[#Animaciones - 1]
		end
		--Y si ya no se puede retroceder mas, syncronizamos con #Animaciones
		if Baile == nil then
			Baile = Animaciones[#Animaciones]
		end
	until Baile == nil or Existegod == true

	if ConexionAnim then
		ConexionAnim:Stop()
	end

	UltimaAnim = Baile.Animation

	ConexionAnim = OtroAniamator:LoadAnimation(Baile.Animation)
	ConexionAnim.Priority= Enum.AnimationPriority.Action
	ConexionAnim:Play()
	ConexionAnim.TimePosition = Baile.TimePosition
	ConexionAnim:AdjustSpeed(Baile.Speed)

end

local ObtenerResultado = function(Animator)
	local Animaciones = Animator:GetPlayingAnimationTracks()
	local Baile = Animaciones[#Animaciones]

	return Baile
end

local ObtenerImagen = function(jugador)
	local imagen = "rbxthumb://type=AvatarHeadShot&id="..jugador.UserId.."&w=420&h=420"
	return imagen
end


Jugador.Chatted:Connect(function(mensaje)
	if mensaje:sub(1,5) == "/sync" then
		local Solicitud = mensaje:sub(7, #mensaje)
		local jugador = BuscarJugador(Solicitud)

		if jugador then
			Notificacion("Sincronizando con: "..jugador.Name, "Aviso", 5)
			Estado = jugador
			Termino = false
		end

		if jugador == false then
			Notificacion("El usuario no existe", "Warn", 5)
		end
	end

	if mensaje:sub(1,7) == "/unsync" then
		if Estado ~= nil then
			Estado = nil
			Notificacion("Ya no estas sincronizado", "Aviso", 4)
		else
			Notificacion("No te has sincronizado con nadie", "Warn", 4)
		end
	end
end)


Actualizar(Scroll, Modulo.Ids)


RS.RenderStepped:Connect(function()
	if Estado ~= nil then
		local OtroChar = Estado.Character
		local OtroHum = OtroChar:FindFirstChild("Humanoid")

		if OtroHum then
			local OtroAnimator = OtroHum:FindFirstChild("Animator")

			if OtroAnimator then
				local Comparativa = comparar(OtroAnimator)

				if Comparativa == true then
					sincronisar(OtroAnimator, Animator)
				end
			end
		end
	elseif Estado == nil then
		if Termino == false then
			Termino = true
			if ConexionAnim then
				ConexionAnim:Stop()
			end
		end
	end
end)