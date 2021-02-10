--[[
Name:Low FPS
Activate:true
Timers_max:20
Max_low:30
options_end
]]
function TIM.effectsFunctions.fps_30(rewardID)
	managers.player:local_player():sound():say("g60",true,true)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if  TIM.Rewards[rewardID].fps_30Now ==nil then
		local old = managers.user:get_setting("fps_cap")
		local lin1 = TIM:fon_function()
		lin1:animate(function(o)
			TIM.Rewards[rewardID].fps_30Now = TIM._settings.TwitchRewards[rewardID].effects.fps_30.Timers_max.Value
			managers.user:set_setting("fps_cap", TIM._settings.TwitchRewards[rewardID].effects.fps_30.Max_low.Value)
			while  TIM.Rewards[rewardID].fps_30Now>0  do
				TIM.Rewards[rewardID].fps_30Now =  TIM.Rewards[rewardID].fps_30Now  - 1 
				wait(1)	
								
			end
			managers.user:set_setting("fps_cap", old)
			TIM.Rewards[rewardID].fps_30Now = nil
			lin1:parent():remove(lin1)
		end)
	else
		 TIM.Rewards[rewardID].fps_30Now  =  TIM.Rewards[rewardID].fps_30Now  + TIM._settings.TwitchRewards[rewardID].effects.fps_30.Timers_max.Value
	end	
end