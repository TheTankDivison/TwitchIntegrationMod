--[[
Name:Tunnel vision
Activate:true
Timers_max:20
options_end
]]
function TIM.effectsFunctions.black(rewardID)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM.Rewards[rewardID].blackNow ==nil then
		TIM.Rewards[rewardID].blackNow = 0
	end
	local black_screen = TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "guis/textures/black",
			layer = TIM.hud.panel:layer()+15,
			alpha=0,
			color = Color(1, 1, 1),
			w = TIM.hud.panel:w()*5,
			h = TIM.hud.panel:h()*5,
			--blend_mode = "add",
			x =0,
			y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
	})
		
	black_screen:animate(function(o)
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
					if math.abs(black_screen:w()-TIM.hud.panel:w())<0.1 then
						break
					end
				else
					if math.abs(black_screen:w()-TIM.hud.panel:w()*5)<0.1 then
						break
					end
				end
			end
			f(1, seconds)
		end
			
		if TIM.Rewards[rewardID].blackNow == 0 then
			TIM.Rewards[rewardID].blackNow = TIM.Rewards[rewardID].blackNow+1
			over1(200, true, function(p)
				black_screen:set_center_x(TIM.hud.panel:center_x())
				black_screen:set_center_y(TIM.hud.panel:center_y())
				black_screen:set_w(math.lerp(black_screen:w(),TIM.hud.panel:w(),p))
				black_screen:set_h(math.lerp(black_screen:h(),TIM.hud.panel:h(),p))
				black_screen:set_alpha(math.lerp(black_screen:alpha(), 1, p))
			end)
			while TIM.Rewards[rewardID].blackNow>0 do
				
				wait(TIM._settings.TwitchRewards[rewardID].effects.black.Timers_max)
				TIM.Rewards[rewardID].blackNow = TIM.Rewards[rewardID].blackNow - 1
			end
			over1(200, false, function(p)
				black_screen:set_center_x(TIM.hud.panel:center_x())
				black_screen:set_center_y(TIM.hud.panel:center_y())
				black_screen:set_w(math.lerp(black_screen:w(),TIM.hud.panel:w()*5,p))
				black_screen:set_h(math.lerp(black_screen:h(),TIM.hud.panel:h()*5,p))
				black_screen:set_alpha(math.lerp(black_screen:alpha(), 0, p))
			end)
			
				black_screen:parent():remove(black_screen)
		else
			TIM.Rewards[rewardID].blackNow = TIM.Rewards[rewardID].blackNow + 1
		end
	end)
end