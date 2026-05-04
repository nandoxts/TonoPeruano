local MinSize = 0.05

-------------------------- DON'T CHANGE ANYTHING UNDER HERE --------------------------
for i, v in pairs(workspace:GetDescendants()) do
	if v:HasTag("Visualize") then
		task.spawn(function()
			local Soundbar = v.SurfaceGui.Main.Visualizer
			local Sound = workspace:WaitForChild("CancionSIstema")
			local Set = nil

			local Bars = {}
			for i, v in next, Soundbar:children() do
				if v:IsA'Frame' then
					table.insert(Bars, v)
					v.Size = UDim2.new(v.Size.X.Scale, v.Size.X.Offset, MinSize, 0)
				end
			end

			local nBars, Tweens = #Bars - 1, {}
			local MaxHeight = 1

			-- 🌈 Función de color arcoíris sincronizado
			local function getGlobalRainbowColor()
				local t = tick() % 5
				local section = math.floor(t)
				local progress = (t - section) * 255
				local r, g, b = 250, 250, 250

				if section == 0 then
					r, g, b = 255, progress, 0
				elseif section == 1 then
					r, g, b = 255 - progress, 255, 0
				elseif section == 2 then
					r, g, b = 0, 255, progress
				elseif section == 3 then
					r, g, b = 0, 255 - progress, 255
				elseif section == 4 then
					r, g, b = progress, 0, 255
				end

				return Color3.fromRGB(r, g, b)
			end

			local function quadIn(t, b, c, d) t = t / d; return c * t * t + b; end
			local function quadOut(t, b, c, d) t = t / d; return -c * t * (t - 2) + b; end

			local function Quad(obj, val, ease, d)
				local t, f, con, nt, st, sd = tick(), nil, nil, nil, obj.Size.Y.Scale, val - obj.Size.Y.Scale
				f = ease == 'In' and quadIn or quadOut
				con = game:GetService'RunService'.RenderStepped:Connect(function()
					nt = tick() - t
					if Tweens[obj] ~= t then
						con:Disconnect()
						return
					end
					local nv = math.max(MinSize, f(math.min(d, nt), st, sd, d))
					obj.Size = UDim2.new(obj.Size.X.Scale, obj.Size.X.Offset, math.min(nv, MaxHeight), 0)

					-- 🎨 Todos los colores sincronizados
					obj.BackgroundColor3 = getGlobalRainbowColor()

					if nt > d then
						con:Disconnect()
						if ease ~= 'In' then
							Quad(obj, MinSize, 'In', 0.3)
						end
					end
				end)
				Tweens[obj] = t
			end

			local function CheckSet(N, S, D)
				local nS = Soundbar[tostring(N)].Size.Y.Scale
				if S > nS then
					Set(N, nS + (S - nS) / 3, D)
				end
			end

			Set = function(N, S, D)
				Quad(Soundbar[tostring(N)], S * MaxHeight, 'Out', 0.1)
				if N > 0 and D ~= 1 then
					CheckSet(N - 1, S, -1)
				end
				if N < nBars and D ~= -1 then
					CheckSet(N + 1, S, 1)
				end
			end

			local MPL, PL, curr = 0, 0, Sound.SoundId

			game:GetService'RunService'.RenderStepped:Connect(function()
				PL = Sound.PlaybackLoudness

				if Sound.IsPlaying and PL == PL then
					if curr ~= Sound.SoundId then
						MPL = 0
						curr = Sound.SoundId
					end
					MPL = math.max(PL, MPL)
					PL = PL / MPL
					if PL == PL then
						Set(math.floor(PL * nBars), PL)
					end
				end
			end)
		end)
	end
end
