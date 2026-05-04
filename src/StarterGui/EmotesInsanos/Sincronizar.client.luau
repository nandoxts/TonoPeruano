--[[ SERVICES ]]--
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

--[[ REMOTES ]]--
local Remotes = ReplicatedStorage:WaitForChild("RemotesSync")
local syncremote = Remotes:WaitForChild("Sync")
local HugEvents = ReplicatedStorage:WaitForChild("Events2"):WaitForChild("HugEvents")
local HugAsk = ReplicatedStorage:WaitForChild("Events2"):WaitForChild("HugAsk")

--[[ LOCALS ]]--
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- UI Elements
local Syncronisar = script.Parent:WaitForChild("Syncronisar")
local FrameInfo = Syncronisar:WaitForChild("Info")
local Buttos = Syncronisar:WaitForChild("ScrollingFrame"):WaitForChild("Buttos")
local Syncro = Buttos:WaitForChild("Sync")
local Abrazo = Buttos:WaitForChild("Abrazo")
local ImagenUser = FrameInfo:WaitForChild("ImagenUser")
local NombreUserGod = FrameInfo:WaitForChild("Name")
local Visualizacion = FrameInfo:WaitForChild("visualización")
local CerrarSync = Syncronisar:WaitForChild("Close")

-- Variables
local Target = nil
local debounce = false
local panelAbierto = false
local isHugging = false 

local NotifySound = SoundService:FindFirstChild("MainSounds") and SoundService.MainSounds:FindFirstChild("Notify")

local originalSize = Syncronisar.Size
local originalPosition = Syncronisar.Position

-- FUNCIONES --------------------------

local function actualizarTextoAbrazo()
	if isHugging then
		Abrazo.Text = "Dejar de abrazar"
	else
		Abrazo.Text = "Abrazo"
	end
end

local function AbrirPanel(jugador)
	if not jugador then return end
	Target = jugador

	NombreUserGod.Text = "@" .. jugador.Name

	if jugador.DisplayName and jugador.DisplayName ~= jugador.Name then
		Visualizacion.Text = jugador.DisplayName
	else
		Visualizacion.Text = jugador.Name
	end

	ImagenUser.Image = Players:GetUserThumbnailAsync(jugador.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)

	if Player.Character:FindFirstChild("SyncOnOff") and Player.Character.SyncOnOff.Value then
		Syncro.Text = "Dejar de Sincronizar"
	else
		Syncro.Text = "Sincronizar"
	end

	Syncronisar.AnchorPoint = Vector2.new(0.5, 0.5)
	Syncronisar.Position = UDim2.new(
		originalPosition.X.Scale + (originalSize.X.Scale / 2),
		originalPosition.X.Offset + (originalSize.X.Offset / 2),
		originalPosition.Y.Scale + (originalSize.Y.Scale / 2),
		originalPosition.Y.Offset + (originalSize.Y.Offset / 2)
	)

	Syncronisar.Size = UDim2.new(0, 0, 0, 0)
	Syncronisar.Visible = true

	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
	local tween = TweenService:Create(Syncronisar, tweenInfo, { Size = originalSize })
	tween:Play()

	panelAbierto = true

	actualizarTextoAbrazo()
end

local function CerrarPanel()
	if not panelAbierto then return end
	panelAbierto = false

	local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	local tween = TweenService:Create(Syncronisar, tweenInfo, { Size = UDim2.new(0, 0, 0, 0) })
	tween:Play()
	tween.Completed:Wait()

	Syncronisar.Visible = false
	Target = nil
end

Mouse.Button1Down:Connect(function()
	local objetivo = Mouse.Target
	if objetivo then
		local humanoid = objetivo.Parent:FindFirstChild("Humanoid") or objetivo.Parent.Parent:FindFirstChild("Humanoid")
		if humanoid then
			local jugador = Players:GetPlayerFromCharacter(humanoid.Parent)
			if jugador and jugador ~= Player then
				if panelAbierto and Target == jugador then
					CerrarPanel()
				else
					AbrirPanel(jugador)
				end
			end
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed or not panelAbierto then return end

	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local mouseLocation = UserInputService:GetMouseLocation()
		local guiInset = game:GetService("GuiService"):GetGuiInset()

		local mouseX = mouseLocation.X
		local mouseY = mouseLocation.Y - guiInset.Y

		local frameAbsPos = Syncronisar.AbsolutePosition
		local frameAbsSize = Syncronisar.AbsoluteSize

		local dentroDelFrame =
			mouseX >= frameAbsPos.X and mouseX <= frameAbsPos.X + frameAbsSize.X and
			mouseY >= frameAbsPos.Y and mouseY <= frameAbsPos.Y + frameAbsSize.Y

		if not dentroDelFrame then
			CerrarPanel()
		end
	end
end)

CerrarSync.MouseButton1Click:Connect(function()
	CerrarPanel()
end)

Syncro.MouseButton1Click:Connect(function()
	if not Target or debounce then return end
	debounce = true

	if Player.Character:FindFirstChild("SyncOnOff") and Player.Character.SyncOnOff.Value then
		syncremote:FireServer("unsync")
		Syncro.Text = "Sincronizar"
	else
		syncremote:FireServer("sync", Target)
		Syncro.Text = "Dejar de Sincronizar"
	end

	task.wait(0.5)
	debounce = false
end)

local tiempoEsperaAbrazo = 4
local ultimoEnvioAbrazo = 0

Abrazo.MouseButton1Click:Connect(function()
	if not Target then return end

	local tiempoActual = tick()
	local tiempoRestante = tiempoEsperaAbrazo - (tiempoActual - ultimoEnvioAbrazo)

	if tiempoRestante > 0 and not isHugging then
		StarterGui:SetCore("SendNotification", {
			Title = "Espera...",
			Text = string.format("Debes esperar %.1f segundos para volver a pedir un abrazo.", tiempoRestante),
			Duration = 2,
			Icon = "http://www.roblox.com/asset/?id=3944670656"
		})
		if NotifySound then NotifySound:Play() end
		return
	end

	if isHugging then
		HugEvents:FireServer("Stop", Player)
	else
		HugEvents:FireServer("Ask", Target)
		ultimoEnvioAbrazo = tiempoActual
	end
end)

Syncronisar.Visible = false

local function agregarClickDetectorsAPartes(char)
	for _, parte in ipairs(char:GetDescendants()) do
		if parte:IsA("BasePart") and not parte:FindFirstChildOfClass("ClickDetector") then
			local detector = Instance.new("ClickDetector")
			detector.Name = "AutoClick"
			detector.MaxActivationDistance = 25
			detector.Parent = parte
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		task.wait(1)
		agregarClickDetectorsAPartes(char)
	end)
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player ~= Player then
		if player.Character then
			agregarClickDetectorsAPartes(player.Character)
		end
		player.CharacterAdded:Connect(function(char)
			task.wait(1)
			agregarClickDetectorsAPartes(char)
		end)
	end
end

HugAsk.OnClientEvent:Connect(function(fromPlayer)
	local bindable = Instance.new("BindableFunction")

	StarterGui:SetCore("SendNotification", {
		Title = "Abrazo 🫂",
		Text = fromPlayer.Name .. " quiere abrazarte",
		Icon = "http://www.roblox.com/asset/?id=3944670656",
		Duration = 5,
		Button1 = "Aceptar",
		Button2 = "Rechazar",
		Callback = bindable
	})

	if NotifySound then NotifySound:Play() end

	function bindable.OnInvoke(response)
		if response == "Aceptar" then
			HugEvents:FireServer("Hug", fromPlayer)
		end
	end
end)

HugEvents.OnClientEvent:Connect(function(enable)
	local Controls = require(Player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
	if enable == true then
		Controls:Enable()
		isHugging = false
	else
		Controls:Disable()
		isHugging = true

		StarterGui:SetCore("SendNotification", {
			Title = "Notificacion",
			Text = "Para dejar de abrazar al jugador, dale click y presiona el botón que dice 'Dejar de abrazar'.",
			Duration = 10,
			Icon = "http://www.roblox.com/asset/?id=3944670656"
		})

		if NotifySound then NotifySound:Play() end
	end
	actualizarTextoAbrazo()
end)
