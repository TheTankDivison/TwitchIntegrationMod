--[[
Name:Medic
Activate:true
Count:2
options_end
]]
function TIM.effectsFunctions.medic(rewardID)
	managers.player:local_player():sound():say("Play_ban_s05",true,true)
	local unit_name = Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870")
	local pos, rot
	local spawnType = false
	if TIM._settings.TwitchRewards[rewardID].effects.medic.spawnType.SelectedItem == "onPlayer" then
		spawnType = true
	elseif TIM._settings.TwitchRewards[rewardID].effects.medic.spawnType.SelectedItem == "inFront" then
		spawnType = false
	else
	
	end
	pos, rot = TIM:Spawn_position(spawnType)
	--managers.mission._fading_debug_output:script().log(tostring(TIM._settings.TwitchRewards[rewardID].effects.medic.Count),  Color.green)
	for i=1, TIM._settings.TwitchRewards[rewardID].effects.medic.Count.Value, 1 do
	--managers.mission._fading_debug_output:script().log(tostring(2),  Color.green)
		
		local unit_done = TIM:Spawn_unit(true, unit_name, pos, rot)
		--managers.mission._fading_debug_output:script().log(tostring(4),  Color.green)
		local lin = TIM:fon_function()
		--managers.mission._fading_debug_output:script().log(tostring(5),  Color.green)
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(TIM._settings.TwitchRewards[rewardID].effects.medic.immortal.Value)
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