--[[
Name:Less FOV
Activate:true
Timers_max:20
Max_low: 60
options_end
]]
function TIM.effectsFunctions.fov(rewardID)

	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	managers.player:local_player():sound():say("g60",true,true)
	local old = managers.user:get_setting("fov_multiplier")*65 --managers.player:player_unit():camera()._camera_object:fov() managers.user:get_setting(
	if TIM.Rewards[rewardID].fovNow ==nil then
		TIM.Rewards[rewardID].fovNow = TIM._settings.TwitchRewards[rewardID].effects.fov.Timers_max.Value
		local lin = TIM:fon_function()
		lin:animate(function(o)
			local fov_temp = managers.player:player_unit():camera()._camera_object:fov()
			local fov_to = TIM._settings.TwitchRewards[rewardID].effects.fov.Max_low.Value
			--[[if (fov_temp + (fov_temp* /100))>=175 then
				fov_to = 174 
			else
				fov_to= fov_temp + (fov_temp* TIM._settings.TwitchRewards[rewardID].effects.fov.Max_low.Value/100)
			end]]
			over(1, function(p)
				if not _setFOV then
					_setFOV = Camera.set_fov 
				end
				function Camera:set_fov( new_fov )
					return _setFOV(self,  math.lerp(managers.player:player_unit():camera()._camera_object:fov(), fov_to , p))
				end
				managers.player:player_unit():camera()._camera_object:set_fov()
			end)
			local bool = true
			while TIM.Rewards[rewardID].fovNow>0 do
				TIM.Rewards[rewardID].fovNow=TIM.Rewards[rewardID].fovNow-1
				wait(1)
				if math.ceil(managers.player:player_unit():camera()._camera_object:fov()) ~= fov_to then
					bool=false
					break
				end
			end
			TIM.Rewards[rewardID].fovNow =nil
			if Utils:IsInCustody() ~= true then
				if bool == true then
					over(1, function(p)
						if not _setFOV then
							_setFOV = Camera.set_fov 
						end
						function Camera:set_fov( new_fov )
							return _setFOV(self,  math.lerp(managers.player:player_unit():camera()._camera_object:fov(), old, p))
						end
						managers.player:player_unit():camera()._camera_object:set_fov()
					end)
				end
			end
			if bool ==true then 
				if not _setFOV then _setFOV = Camera.set_fov end
				function Camera:set_fov( new_fov )
					return _setFOV(self, new_fov)
				end
			end
			lin:parent():remove(lin)
		end)
	else
		TIM.Rewards[rewardID].fovNow=TIM.Rewards[rewardID].fovNow+TIM._settings.TwitchRewards[rewardID].effects.fov.Timers_max.Value
	end	
end