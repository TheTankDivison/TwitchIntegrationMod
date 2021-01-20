--[[
Name:Winters
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.winters(rewardID)
	managers.player:local_player():sound():say("cpw_a01",true,true)
	local pos
	for i=1,TIM._settings.TwitchRewards[rewardID].effects.winters.Count, 1 do
		local unit_name = Idstring("units/pd2_dlc_vip/characters/ene_vip_1/ene_vip_1")
		pos = TIM:Spawn_unit(unit_name, true)
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