--[[
Name:Blur
Activate:true
Timers_max:20
options_end
]]
function TIM.effectsFunctions.blur(rewardID)
	managers.player:local_player():sound():say("g60",true,true)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM.Rewards[rewardID].blurNow ==nil then
		TIM.Rewards[rewardID].blurNow = 0
	end
	if TIM.Rewards[rewardID].blurNow == 0 then

		local lin1 = TIM:fon_function()
		lin1:animate(function(o)
			TIM.Rewards[rewardID].blurNow=TIM.Rewards[rewardID].blurNow+1
			managers.environment_controller:set_downed_value(50)
			while TIM.Rewards[rewardID].blurNow>0 do
								
				wait(TIM._settings.TwitchRewards[rewardID].effects.blur.Timers_max)
				TIM.Rewards[rewardID].blurNow = TIM.Rewards[rewardID].blurNow - 1 	
			end
			managers.environment_controller:set_downed_value(0)
			
			lin1:parent():remove(lin1)
		end)
	else
		TIM.Rewards[rewardID].blurNow = TIM.Rewards[rewardID].blurNow + 1
	end		
end
