
function TIM.effectsFunctions.tase(rewardID)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
		TIM.Rewards[rewardID].activates =0
	end
	local maskOff =""
	if TIM._settings.TwitchRewards[rewardID].effects.tase.incasing then
		maskOff = "mask_off"
	end
	local current_state = managers.player:current_state()
	if current_state =="standard" or current_state == "tased" or current_state == maskOff then
		--TIM.Rewards[rewardID].old_state = managers.player:current_state() 
		managers.player:set_player_state("standard")
		local lin = TIM:fon_function()
		lin:animate(function(o)
			--TIM.Rewards[rewardID].taseNow = TIM._settings.TwitchRewards[rewardID].effects.jail.Timers_max.Value
			TIM.Rewards[rewardID].activates = TIM.Rewards[rewardID].activates +1
			managers.player:set_player_state("tased")
			local taseNow  = TIM._settings.TwitchRewards[rewardID].effects.tase.Timers_max.Value + Application:time()
			local t = Application:time()
			--Application:time()
			while taseNow > t do
				local dt = coroutine.yield()
				t = Application:time()
				--if managers.player:current_state() ~= "tased" then
				--	breakIt = true
				--	break
				--end
			end
			if managers.player:current_state() == "tased" and TIM.Rewards[rewardID].activates == 1 then
				managers.player:set_player_state("standard")
			end
			TIM.Rewards[rewardID].activates=TIM.Rewards[rewardID].activates -1
			--TIM.Rewards[rewardID].taseNow= nil
		end)
		--if Utils:IsInCustody() ~= true then
		
		--end
		--TIM.Rewards[rewardID].taseNow = TIM.Rewards[rewardID].taseNow + TIM._settings.TwitchRewards[rewardID].effects.tase.Timers_max.Value
	end
end
