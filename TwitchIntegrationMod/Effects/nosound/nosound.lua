--[[
Name:No sound
Activate:true
Timers_max:20
options_end
]]
function TIM.effectsFunctions.nosound(rewardID)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	managers.player:local_player():sound():say("g60",true,true)
	if TIM.Rewards[rewardID].nosoundNow ==nil then		
		local lin1 = TIM:fon_function()
		lin1:animate(function(o)
			TIM.Rewards[rewardID].nosoundNow = TIM._settings.TwitchRewards[rewardID].effects.nosound.Timers_max.Value
			SoundDevice:set_rtpc("downed_state_progression", TIM._settings.TwitchRewards[rewardID].effects.nosound.SoundLevel.Value)
			while TIM.Rewards[rewardID].nosoundNow>0 do			
				TIM.Rewards[rewardID].nosoundNow = TIM.Rewards[rewardID].nosoundNow - 1 	
				wait(1)	
						
			end
			SoundDevice:set_rtpc("downed_state_progression", 0)
			TIM.Rewards[rewardID].nosoundNow =nil
			lin1:parent():remove(lin1)
		end)
	else
		TIM.Rewards[rewardID].nosoundNow = TIM.Rewards[rewardID].nosoundNow + TIM._settings.TwitchRewards[rewardID].effects.nosound.Timers_max.Value
	end	
end