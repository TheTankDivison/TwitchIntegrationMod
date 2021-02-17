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
			local lin1 = TIM:fon_function()
			lin1:animate(function(o)
				TIM.Rewards[rewardID].blurNow= TIM._settings.TwitchRewards[rewardID].effects.blur.Timers_max.Value
				managers.environment_controller:set_downed_value(TIM._settings.TwitchRewards[rewardID].effects.blur.BlurMax.Value)
				while TIM.Rewards[rewardID].blurNow>0 do
					TIM.Rewards[rewardID].blurNow = TIM.Rewards[rewardID].blurNow - 1 
					wait(1)
						
				end
				if Utils:IsInCustody() == true then
					managers.environment_controller:set_downed_value(0)
				end
				TIM.Rewards[rewardID].blurNow =nil
				lin1:parent():remove(lin1)
			end)
	else
		TIM.Rewards[rewardID].blurNow = TIM.Rewards[rewardID].blurNow + TIM._settings.TwitchRewards[rewardID].effects.blur.Timers_max.Value
	end		
end
