local badgeService = game:GetService("BadgeService")
local badgeId = 145052542667168

game.Players.PlayerAdded:Connect(function(player)
	delay(0.5, function()
		if not badgeService:UserHasBadgeAsync(player.UserId, badgeId) then
			badgeService:AwardBadge(player.UserId, badgeId)
		end
	end)
end)

-- Owner