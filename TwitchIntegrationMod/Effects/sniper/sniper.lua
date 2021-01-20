--[[
Name:Zeal sniper
Activate:true
Number of spawn:Count:2
options_end
]]
function TIM.effectsFunctions.sniper(rewardID)
	managers.player:local_player():sound():say("play_pln_gen_snip_01",true,true)
	local pos
	for i=1, TIM._settings.TwitchRewards[rewardID].effects.sniper.Count, 1 do
		local unit_name = Idstring("units/pd2_dlc_drm/characters/ene_zeal_swat_heavy_sniper/ene_zeal_swat_heavy_sniper")
		local unit_done
		pos, unit_done = TIM:Spawn_unit(unit_name, true)
		local lin = TIM:fon_function()
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(TIM._settings.TwitchRewards[rewardID].effects.sniper.immortal)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
	end
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
end