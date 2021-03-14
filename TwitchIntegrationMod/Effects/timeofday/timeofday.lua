
function TIM.effectsFunctions.timeofday(rewardID)
	if TIM.Rewards.default_timeofday == nil then
		TIM.Rewards.default_timeofday = managers.viewport:first_active_viewport():get_environment_path()
	end
	local timeAllTypes = {"environments/pd2_env_hox_02/pd2_env_hox_02",
	"environments/pd2_env_morning_02/pd2_env_morning_02",
	"environments/pd2_env_mid_day/pd2_env_mid_day",
	"environments/pd2_env_afternoon/pd2_env_afternoon",
	"environments/pd2_env_n2/pd2_env_n2",
	"environments/pd2_env_arm_hcm_02/pd2_env_arm_hcm_02",
	"environments/pd2_env_foggy_bright/pd2_env_foggy_bright"} 
	local toChange
	if TIM._settings.TwitchRewards[rewardID].effects.timeofday.timeType.SelectedItem =="random" then
		local genList={}
		for i =1, #timeAllTypes, 1 do
			local env = managers.viewport:first_active_viewport():get_environment_path()
			if timeAllTypes[i] ~= env then
				genList[#genList+1] = timeAllTypes[i]
			end
		end
		local n = math.random(#genList)
		toChange = genList[n]
	else
		toChange = TIM._settings.TwitchRewards[rewardID].effects.timeofday.timeType.SelectedItem
	end
	local lin = TIM:fon_function()
	lin:animate(function(o)
		managers.viewport:first_active_viewport():set_environment(toChange)
		local timeNow  = TIM._settings.TwitchRewards[rewardID].effects.timeofday.Timer.Value + Application:time()
		local t = Application:time()
		local bool = true
		while timeNow > t do
			local dt = coroutine.yield()
			t = Application:time()
			if toChange ~= managers.viewport:first_active_viewport():get_environment_path() then 
				bool = false
				break
			end
		end
		if bool==true then
			managers.viewport:first_active_viewport():set_environment(TIM.Rewards.default_timeofday)
		end
	end)
end
