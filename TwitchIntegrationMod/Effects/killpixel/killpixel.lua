
function TIM.effectsFunctions.killpixel(rewardID)
	if TIM.pixelCount == nil then
		TIM.pixelCount = {}
	end
	if TIM._settings.TwitchRewards[rewardID].effects.killpixel.kill then
		local count = TIM._settings.TwitchRewards[rewardID].effects.killpixel.Count.Value
		if #TIM.pixelCount < TIM._settings.TwitchRewards[rewardID].effects.killpixel.Count.Value then
			count = #TIM.pixelCount
		end
		for i=1, count, 1 do
			local n = math.random(#TIM.pixelCount)
			TIM.pixelCount[n]:parent():remove(TIM.pixelCount[n])
			table.remove (TIM.pixelCount, n)
		end
	else
		managers.mission._fading_debug_output:script().log(tostring(1),  Color.green)
		for i=1, TIM._settings.TwitchRewards[rewardID].effects.killpixel.Count.Value, 1 do
			TIM.pixelCount[#TIM.pixelCount+1] = TIM.hud.panel:bitmap({ name = "sssss", visible = true, layer = 10000, alpha=1, color = Color(0, 0, 0), w = 2, h = 2, blend_mode = "normal", x = math.random(1279), y = math.random(719)})
		end
	end
end
