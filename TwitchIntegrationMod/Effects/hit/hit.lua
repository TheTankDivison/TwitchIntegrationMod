--[[
Name:No Hitmarker
Activate:true
Timers_max:20
options_end
]]
function TIM.effectsFunctions.hit(rewardID)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	managers.player:local_player():sound():say("g60",true,true)
	--managers.mission._fading_debug_output:script().log(tostring(TIM._settings.TwitchRewards[rewardID].effects.hit.Now),  Color.red)
	if TIM.Rewards[rewardID].hitNow ==nil then
		--TIM.Active_timer_hit=true
		TIM.Rewards[rewardID].hitNow = 1
		local lin1 = TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "guis/textures/icons/ammo",
			layer = 0,
			alpha=0,
			color = Color(1, 1, 1),
			w = 130,
			h = 130,
			blend_mode = "add",
			x =0,
			y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
		})
		lin1:animate(function(o)
			
			managers.user:set_setting("hit_indicator", false)
			while TIM.Rewards[rewardID].hitNow>0 do
									
				wait(TIM._settings.TwitchRewards[rewardID].effects.hit.Timers_max)	
				TIM.Rewards[rewardID].hitNow= TIM.Rewards[rewardID].hitNow - 1 			
			end
			TIM.Rewards[rewardID].hitNow = nil
			managers.user:set_setting("hit_indicator", true)
			--TIM.Active_timer_hit = false
			lin1:parent():remove(lin1)
		end)
	else
		TIM.Rewards[rewardID].hitNow = TIM.Rewards[rewardID].hitNow + 1
	end	
end