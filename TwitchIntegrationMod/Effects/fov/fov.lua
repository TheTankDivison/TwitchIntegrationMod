--[[
Name:Less FOV
Activate:true
Timers_max:20
Max_low: 60
options_end
]]
function TIM.effectsFunctions.fov(rewardID)
	managers.player:local_player():sound():say("g60",true,true)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM.Rewards[rewardID].fovNow ==nil then
		TIM.Rewards[rewardID].fovNow = 0
	end
	--local old = managers.user:get_setting("fov_multiplier")
	local old = managers.player:player_unit():camera()._camera_object:fov()
	--managers.mission._fading_debug_output:script().log(tostring(TIM._settings.TwitchRewards[rewardID].effects.fov.Now),  Color.red)
	if TIM.Rewards[rewardID].fovNow == 0 then
		TIM.Rewards[rewardID].fovNow =TIM.Rewards[rewardID].fovNow+1
		local lin = TIM:fon_function()
		lin:animate(function(o)

		
		local fov_temp=managers.player:player_unit():camera()._camera_object:fov()
		local fov_to
		if (fov_temp + (fov_temp* TIM._settings.TwitchRewards[rewardID].effects.fov.Max_low/100))>=175 then
			fov_to = 174 
		else
			fov_to= fov_temp + (fov_temp* TIM._settings.TwitchRewards[rewardID].effects.fov.Max_low/100)
		end
		over(1, function(p)
			if not _setFOV then
				_setFOV = Camera.set_fov 
			end
			function Camera:set_fov( new_fov )
				return _setFOV(self,  math.lerp(managers.player:player_unit():camera()._camera_object:fov(), fov_to+1 , p))
			end
			managers.player:player_unit():camera()._camera_object:set_fov()
			--managers.user:set_setting("fov_multiplier", math.lerp(managers.user:get_setting("fov_multiplier"), 1, p))
			--if alive(managers.player:player_unit()) then
				--managers.player:player_unit():movement():current_state():update_fov_external()
			--end
		end)
			
			while TIM.Rewards[rewardID].fovNow>0 do
				
				
				wait(TIM._settings.TwitchRewards[rewardID].effects.fov.Timers_max)
				TIM.Rewards[rewardID].fovNow=TIM.Rewards[rewardID].fovNow-1
			end
			
			over(1, function(p)
				if not _setFOV then
					_setFOV = Camera.set_fov 
				end
				function Camera:set_fov( new_fov )
					return _setFOV(self,  math.lerp(managers.player:player_unit():camera()._camera_object:fov(), old, p))
				end
				managers.player:player_unit():camera()._camera_object:set_fov()
				--managers.user:set_setting("fov_multiplier", math.lerp(managers.user:get_setting("fov_multiplier"), old, p))
				--if alive(managers.player:player_unit()) then
					--managers.player:player_unit():movement():current_state():update_fov_external()
				--end
			end)
			if not _setFOV then _setFOV = Camera.set_fov end
			function Camera:set_fov( new_fov )
				return _setFOV(self, new_fov)
			end
			--managers.player:player_unit():camera()._camera_object:set_fov(old)
			--TIM.Active_timer_fov=false
			lin:parent():remove(lin)
		end)
	else
		TIM.Rewards[rewardID].fovNow=TIM.Rewards[rewardID].fovNow+1
	end	
end