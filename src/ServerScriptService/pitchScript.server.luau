local sound = game.Workspace.CancionSIstema
local model = require(game.ServerScriptService.Pitch.Pichs)
local asset = "rbxassetid://"

function localication()
	for _, v in pairs(model.ids) do
		local expectedSoundId = asset .. v.id

		if sound.SoundId == expectedSoundId then
			local pitchValue = tonumber(v.pitch)

			if pitchValue then
				sound.PlaybackSpeed = pitchValue
			else
				sound.PlaybackSpeed = 1
			end

			return
		end
	end

	sound.PlaybackSpeed = 1
end

localication()

sound:GetPropertyChangedSignal("SoundId"):Connect(function()
	wait(0.05)
	localication()
end)
