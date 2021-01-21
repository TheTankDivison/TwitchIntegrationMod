--[[
Name:Flash grenade
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.flash(rewardID)
	for i=1,TIM._settings.TwitchRewards[rewardID].effects.flash.Count, 1 do
		local duration =tweak_data.group_ai.flash_grenade_lifetime
		local interact_TIMect = managers.player:player_unit():movement():current_state():get_interaction()
		local lin = TIM:fon_function()
		if interact_TIMect then
			lin:animate(function(o)
				while interact_TIMect == "corpse_alarm_pager" do
					wait(1)
					interact_TIMect = managers.player:player_unit():movement():current_state():get_interaction()
					if interact_TIMect == nil then
						break
					end
				end
				duration = tweak_data.group_ai.flash_grenade_lifetime
				managers.groupai:state():detonate_smoke_grenade(managers.player:local_player():position(), managers.player:local_player():position(), duration, true)
				managers.player:local_player():sound():say("l2n_d02",true,true)
				lin:parent():remove(lin)
			end)
		else
			duration = tweak_data.group_ai.flash_grenade_lifetime
			managers.groupai:state():detonate_smoke_grenade(managers.player:local_player():position(), managers.player:local_player():position(), duration, true)
			managers.player:local_player():sound():say("l2n_d02",true,true)
		end
	end
end