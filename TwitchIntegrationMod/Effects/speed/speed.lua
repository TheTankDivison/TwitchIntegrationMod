--[[
Name:Low speed
Activate:true
Timers_max:20
Limit_percent:50
options_end
]]
function TIM.effectsFunctions.speed(rewardID)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM.Rewards[rewardID].speedNow ==nil then
		TIM.Rewards[rewardID].speedNow = 0
	end
	local T_speed = tweak_data.player.movement_state.standard.movement.speed
	if TIM._settings.TwitchRewards[rewardID].effects.speed.Limit_percent>0 then
		managers.player:local_player():sound():say("g09",true,true)
	else
		managers.player:local_player():sound():say("g29",true,true)
	end

	if TIM.Rewards[rewardID].speedNow == 0 then
		TIM.Rewards[rewardID].speedNow = TIM.Rewards[rewardID].speedNow + 1
		
		TIM.OldSpeed_standart = T_speed.STANDARD_MAX
		TIM.OldSpeed_running = T_speed.RUNNING_MAX
		TIM.OldSpeed_crouch = T_speed.CROUCHING_MAX 
		TIM.OldSpeed_steel = T_speed.STEELSIGHT_MAX 
		TIM.OldSpeed_inair = T_speed.INAIR_MAX 
		TIM.OldSpeed_climb = T_speed.CLIMBING_MAX
		
		local limit = (1+(TIM._settings.TwitchRewards[rewardID].effects.speed.Limit_percent/100))
		
		T_speed.STANDARD_MAX = T_speed.STANDARD_MAX*limit
		T_speed.RUNNING_MAX = T_speed.RUNNING_MAX*limit
		T_speed.CROUCHING_MAX = T_speed.CROUCHING_MAX*limit
		T_speed.STEELSIGHT_MAX = T_speed.STEELSIGHT_MAX*limit
		T_speed.INAIR_MAX = T_speed.INAIR_MAX*limit
		T_speed.CLIMBING_MAX = T_speed.CLIMBING_MAX*limit
		
		local lin = TIM:fon_function()
		--managers.mission._fading_debug_output:script().log("lin",  Color.red)
		lin:animate(function(o)
			--TIM._settings.TwitchRewards[rewardID].effects.timer_speed = TIM._settings.TwitchRewards[rewardID].effects.timer_speed + 1

			while TIM.Rewards[rewardID].speedNow>0 do

				wait(TIM._settings.TwitchRewards[rewardID].effects.speed.Timers_max)
				TIM.Rewards[rewardID].speedNow = TIM.Rewards[rewardID].speedNow - 1
			end
			T_speed.STANDARD_MAX = TIM.OldSpeed_standart
			T_speed.RUNNING_MAX = TIM.OldSpeed_running 
			T_speed.CROUCHING_MAX = TIM.OldSpeed_crouch 
			T_speed.STEELSIGHT_MAX = TIM.OldSpeed_steel  
			T_speed.INAIR_MAX = TIM.OldSpeed_inair 
			T_speed.CLIMBING_MAX = TIM.OldSpeed_climb  
			--TIM.Active_timer_speed = false
			lin:parent():remove(lin)
		end)
	else
		TIM.Rewards[rewardID].speedNow = TIM.Rewards[rewardID].speedNow + 1
	end
end