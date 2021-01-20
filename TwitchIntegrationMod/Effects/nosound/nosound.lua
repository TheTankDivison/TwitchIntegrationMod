--[[
Name:No sound
Activate:true
Timers_max:20
options_end
]]
function TIM.effectsFunctions.nosound(rewardID)
	managers.player:local_player():sound():say("g60",true,true)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM.Rewards[rewardID].nosoundNow ==nil then
		TIM.Rewards[rewardID].nosoundNow = 0
	end
	if TIM.Rewards[rewardID].nosoundNow == 0 then
		
		local lin1 = TIM:fon_function()
		lin1:animate(function(o)
			TIM.Rewards[rewardID].nosoundNow=TIM.Rewards[rewardID].nosoundNow+1
			SoundDevice:set_rtpc("downed_state_progression", 60)
			while TIM.Rewards[rewardID].nosoundNow>0 do
									
				wait(TIM._settings.TwitchRewards[rewardID].effects.nosound.Timers_max)	
				TIM.Rewards[rewardID].nosoundNow = TIM.Rewards[rewardID].nosoundNow - 1 			
			end
			SoundDevice:set_rtpc("downed_state_progression", 0)
			
			lin1:parent():remove(lin1)
		end)
	else
		TIM.Rewards[rewardID].nosoundNow = TIM.Rewards[rewardID].nosoundNow + 1
	end	
end