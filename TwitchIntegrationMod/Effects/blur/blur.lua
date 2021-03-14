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
			local function over1(seconds, bool, f,  fixed_dt)
				local t = 0
				while true do
					local dt = coroutine.yield()
					t = t + (fixed_dt and 0.03333333333333333 or dt)
					if seconds <= t then
						break
					end
					--
					f(t / seconds, t)
					if bool ==true then
						if math.abs(managers.environment_controller:get_downed_value()-TIM._settings.TwitchRewards[rewardID].effects.blur.BlurMax.Value)<0.1 then
							break
						end
					else
						if math.abs(managers.environment_controller:get_downed_value())<0.1 then
							break
						end
					end
				end
				f(1, seconds)
			end
			local lin1 = TIM:fon_function()
			lin1:animate(function(o)
				TIM.Rewards[rewardID].blurNow= TIM._settings.TwitchRewards[rewardID].effects.blur.Timers_max.Value
				over1(200, true, function(p)
					--black_screen:set_w(math.lerp(black_screen:w(),TIM.hud.panel:w(),p))
					managers.environment_controller:set_downed_value(math.lerp(managers.environment_controller:get_downed_value(),TIM._settings.TwitchRewards[rewardID].effects.blur.BlurMax.Value,p))
				end)
				
				while TIM.Rewards[rewardID].blurNow>0 do
					TIM.Rewards[rewardID].blurNow = TIM.Rewards[rewardID].blurNow - 1 
					wait(1)
						
				end
				if Utils:IsInCustody() ~= true then
					over1(200, false, function(p)
						--black_screen:set_w(math.lerp(black_screen:w(),TIM.hud.panel:w(),p))
						managers.environment_controller:set_downed_value(math.lerp(managers.environment_controller:get_downed_value(),0,p))
					end)
					--managers.environment_controller:set_downed_value(0)
				end
				TIM.Rewards[rewardID].blurNow =nil
				lin1:parent():remove(lin1)
			end)
	else
		TIM.Rewards[rewardID].blurNow = TIM.Rewards[rewardID].blurNow + TIM._settings.TwitchRewards[rewardID].effects.blur.Timers_max.Value
	end		
end
