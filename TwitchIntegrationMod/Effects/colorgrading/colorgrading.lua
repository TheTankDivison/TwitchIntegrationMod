--[[
Name:Winters
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.colorgrading(rewardID)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM._settings.TwitchRewards[rewardID].effects.colorgrading.ListOfGradings.SelectedItem =="random" then
		
		if TIM.Rewards[rewardID].colorgradingNow ==nil then
			local old = managers.user:get_setting('video_color_grading')
			local lin1 = TIM:fon_function()
			TIM.Rewards[rewardID].colorgradingNow = TIM._settings.TwitchRewards[rewardID].effects.colorgrading.Timers_max.Value
			local gradingsList = {}
			local n=1
			for id, data in ipairs(tweak_data.color_grading) do
				if old ~= data.value then
					gradingsList[n]=data.value
					n=n+1
				end
			end
			lin1:animate(function(o)
				managers.environment_controller:set_default_color_grading(gradingsList[math.random(1,n)], true)
				managers.environment_controller:refresh_render_settings()
				while TIM.Rewards[rewardID].colorgradingNow>0 do
					TIM.Rewards[rewardID].colorgradingNow =  TIM.Rewards[rewardID].colorgradingNow  - 1
					wait(1)	
				end
				managers.environment_controller:set_default_color_grading(old, true)
				managers.environment_controller:refresh_render_settings()
				TIM.Rewards[rewardID].colorgradingNow = nil
				lin1:parent():remove(lin1)
			end)
		else
			local colorNow = managers.environment_controller:default_color_grading()
			local gradingsList = {}
			local n=1
			for id, data in ipairs(tweak_data.color_grading) do
				if colorNow ~= data.value then
					gradingsList[n]=data.value
					n=n+1
				end
			end
			managers.environment_controller:set_default_color_grading(gradingsList[math.random(1,n)], true)
			managers.environment_controller:refresh_render_settings()	
			TIM.Rewards[rewardID].colorgradingNow = TIM._settings.TwitchRewards[rewardID].effects.colorgrading.Timers_max.Value
		end
	else
		if TIM.Rewards[rewardID].colorgradingNow ==nil then
			local old = managers.user:get_setting('video_color_grading')
			local lin1 = TIM:fon_function()
			lin1:animate(function(o)
				TIM.Rewards[rewardID].colorgradingNow = TIM._settings.TwitchRewards[rewardID].effects.colorgrading.Timers_max.Value
				
					managers.environment_controller:set_default_color_grading(TIM._settings.TwitchRewards[rewardID].effects.colorgrading.ListOfGradings.SelectedItem, true)
					managers.environment_controller:refresh_render_settings()
					while TIM.Rewards[rewardID].colorgradingNow>0 do
						TIM.Rewards[rewardID].colorgradingNow =  TIM.Rewards[rewardID].colorgradingNow  - 1
						wait(1)	
					end
					managers.environment_controller:set_default_color_grading(old, true)
					managers.environment_controller:refresh_render_settings()
					TIM.Rewards[rewardID].colorgradingNow = nil
					lin1:parent():remove(lin1)
				
			end)
		else
			TIM.Rewards[rewardID].colorgradingNow  =  TIM.Rewards[rewardID].colorgradingNow  + TIM._settings.TwitchRewards[rewardID].effects.colorgrading.Timers_max.Value
		end	
	end
end
