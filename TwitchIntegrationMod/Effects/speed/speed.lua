--[[
Name:Low speed
Activate:true
Timers_max:20
Limit_percent:50
options_end
]]
function TIM.effectsFunctions.speed(rewardID)
	local T_speed = tweak_data.player.movement_state.standard.movement.speed
	if TIM._settings.TwitchRewards[rewardID].effects.speed.Limit_percent.Value>0 then
		managers.player:local_player():sound():say("g09",true,true)
	else
		managers.player:local_player():sound():say("g29",true,true)
	end
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM.Rewards[rewardID].speedNow == nil then
		TIM.Rewards[rewardID].speedNow = TIM._settings.TwitchRewards[rewardID].effects.speed.Timers_max.Value
		local limit = (1+(TIM._settings.TwitchRewards[rewardID].effects.speed.Limit_percent.Value/100))
		if limit==0 then
			limit=0.0001
		end
		T_speed.STANDARD_MAX	=	T_speed.STANDARD_MAX	* limit
		T_speed.RUNNING_MAX		=	T_speed.RUNNING_MAX		* limit
		T_speed.CROUCHING_MAX	=	T_speed.CROUCHING_MAX	* limit
		T_speed.STEELSIGHT_MAX	=	T_speed.STEELSIGHT_MAX	* limit
		T_speed.INAIR_MAX		=	T_speed.INAIR_MAX		* limit
		T_speed.CLIMBING_MAX 	=	T_speed.CLIMBING_MAX	* limit
		
		local lin = TIM:fon_function()
		lin:animate(function(o)
			while TIM.Rewards[rewardID].speedNow>0 do
				TIM.Rewards[rewardID].speedNow = TIM.Rewards[rewardID].speedNow - 1
				wait(1)
				
			end
			TIM.Rewards[rewardID].speedNow = nil
			T_speed.STANDARD_MAX 	=	T_speed.STANDARD_MAX	/ limit
			T_speed.RUNNING_MAX 	=	T_speed.RUNNING_MAX		/ limit
			T_speed.CROUCHING_MAX	=	T_speed.CROUCHING_MAX	/ limit
			T_speed.STEELSIGHT_MAX	=	T_speed.STEELSIGHT_MAX	/ limit
			T_speed.INAIR_MAX		=	T_speed.INAIR_MAX		/ limit
			T_speed.CLIMBING_MAX 	=	T_speed.CLIMBING_MAX	/ limit
			
			lin:parent():remove(lin)
		end)
	else
		TIM.Rewards[rewardID].speedNow = TIM.Rewards[rewardID].speedNow + TIM._settings.TwitchRewards[rewardID].effects.speed.Timers_max.Value
	end
end