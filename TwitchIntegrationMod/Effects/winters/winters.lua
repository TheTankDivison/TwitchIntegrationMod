--[[
Name:Winters
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.winters(rewardID)
	managers.player:local_player():sound():say("cpw_a01",true,true)
	local unit_name = Idstring("units/pd2_dlc_vip/characters/ene_vip_1/ene_vip_1")
	local pos, rot
	local spawnType = false
	if TIM._settings.TwitchRewards[rewardID].effects.winters.spawnType.SelectedItem == "onPlayer" then
		spawnType = true
	elseif TIM._settings.TwitchRewards[rewardID].effects.winters.spawnType.SelectedItem == "inFront" then
		spawnType = false
	else
	
	end
	pos, rot = TIM:Spawn_position(spawnType)
	for i=1,TIM._settings.TwitchRewards[rewardID].effects.winters.Count.Value, 1 do
		
		local unit_done = TIM:Spawn_unit(true, unit_name, pos, rot)
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