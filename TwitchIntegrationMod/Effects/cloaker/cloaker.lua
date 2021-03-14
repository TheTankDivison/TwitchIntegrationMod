--[[
Name:Cloaker
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.cloaker(rewardID)
	managers.player:local_player():sound():say("Play_ban_s04",true,true)	
	local unit_name = Idstring("units/payday2/characters/ene_spook_1/ene_spook_1")
	
	local pos, rot
	local spawnType = false
	if TIM._settings.TwitchRewards[rewardID].effects.cloaker.spawnType.SelectedItem == "onPlayer" then
		spawnType = true
	elseif TIM._settings.TwitchRewards[rewardID].effects.cloaker.spawnType.SelectedItem == "inFront" then
		spawnType = false
	else
	
	end
	pos, rot = TIM:Spawn_position(spawnType)
	for i=1, TIM._settings.TwitchRewards[rewardID].effects.cloaker.Count.Value, 1 do
		

		local unit_done = TIM:Spawn_unit(true, unit_name, pos, rot)
		if TIM._settings.TwitchRewards[rewardID].effects.cloaker.headless then
			unit_done:damage():run_sequence_simple("dismember_head")
		end
		local lin = TIM:fon_function()
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(TIM._settings.TwitchRewards[rewardID].effects.cloaker.immortal.Value)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
	end
	--[[
	local effect_params = {
		sound_event = "grenade_explode",
		effect = "effects/particles/explosions/explosion_flash_grenade",
		camera_shake_max_mul = 0,
		sound_muffle_effect = false,
		feedback_range = 5* 2
	}
	managers.explosion:play_sound_and_effects(
		pos,
		Rotation(0, 0,0),
		1,
		effect_params
	)
	]]
end