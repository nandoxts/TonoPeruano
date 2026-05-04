-- DECLARAR PRINCIPAL PARA BOTON --

local frame = script.Parent.Frame

-- CREACION DE BOTON SERVICIO --

local Icon = game:GetService("ReplicatedStorage").Modulos:WaitForChild("Icon")
local Icon2 = require(Icon)
local Players = game:GetService("Players")
local Play = Players.LocalPlayer

-- CREACION EN INTERFAZ --

local Icono = Icon2.new()
Icono:setRight()
Icono:setLabel("Menu / Tienda")
Icono:setImage("14134158045")
Icono:bindToggleItem(frame)
Icono:disableStateOverlay(false)

-- SERVICIOS DE BOTONES --

local info = script.Parent.Frame.Info
local botoninfo = info.Parent.Guia

local infopases = script.Parent.Frame.Pases2
local botonpases = info.Parent.Pases

local infoajustes = script.Parent.Frame.Ajustes2
local botonajustes = info.Parent.Ajustes

info.Visible = true
infopases.Visible = false
infoajustes.Visible = false

botoninfo.MouseButton1Click:Connect(function()
	if info.Visible == false then
		info.Visible = true
		infopases.Visible = false
		infoajustes.Visible = false
	end
end)

botonpases.MouseButton1Click:Connect(function()
	if infopases.Visible == false then
		infopases.Visible = true
		infoajustes.Visible = false
		info.Visible = false
	end
end)

botonajustes.MouseButton1Click:Connect(function()
	if infoajustes.Visible == false then		
		infoajustes.Visible = true
		info.Visible = false
		infopases.Visible = false
	end
end)

