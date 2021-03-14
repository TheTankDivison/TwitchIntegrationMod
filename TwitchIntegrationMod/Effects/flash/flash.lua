--[[
Name:Flash grenade
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.flash(rewardID)
	local spawnType
	if TIM._settings.TwitchRewards[rewardID].effects.flash.spawnType.SelectedItem == "onPlayer" then
		spawnType = true
	elseif TIM._settings.TwitchRewards[rewardID].effects.flash.spawnType.SelectedItem == "inFront" then
		spawnType = false
	else
	
	end
	local pos, rot = TIM:Spawn_position(spawnType)
	if TIM._settings.TwitchRewards[rewardID].effects.flash.instantly then
		local flashbang_unit = "units/payday2/weapons/wpn_frag_flashbang/wpn_frag_flashbang"
		local rotation = Rotation(math.random() * 360, 0, 0)
		local flash_grenade = World:spawn_unit(Idstring(flashbang_unit), pos, rot)

		flash_grenade:base():make_flash(pos, 1000, nil)
		flash_grenade:base():destroy_unit()
	else
		
		for i=1,TIM._settings.TwitchRewards[rewardID].effects.flash.Count.Value, 1 do
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
					managers.groupai:state():detonate_smoke_grenade(pos, pos, duration, true)
					managers.player:local_player():sound():say("l2n_d02",true,true)
					lin:parent():remove(lin)
				end)
			else
				duration = tweak_data.group_ai.flash_grenade_lifetime
				managers.groupai:state():detonate_smoke_grenade(pos, pos, duration, true)
				managers.player:local_player():sound():say("l2n_d02",true,true)
			end
		end
	end
end