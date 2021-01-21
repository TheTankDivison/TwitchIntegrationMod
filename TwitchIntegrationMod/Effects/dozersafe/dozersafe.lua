--[[
Name:Dozer Safe
Activate:true
options_end
]]
function TIM.effectsFunctions.dozersafe(rewardID)
	managers.player:local_player():sound():say("Play_ban_s02_a",true,true)	
	local dozers_points = {110,110,100,50,10,5}
	local dozers = {"Green Dozer", "Black Dozer", "Skull Dozer", "Medic Dozer", "Minigun Dozer", "Headless Dozer"}
	local dozers_names = {"units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1", "units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2", "units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3", "units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic", "units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun", "units/pd2_dlc_help/characters/ene_zeal_bulldozer_halloween/ene_zeal_bulldozer_halloween"}
	local stat_boosts_points= {300, 50, 50, 50, 25}
	local dozers_paths={"dozer_safe/Green Dozer","dozer_safe/Black Dozer","dozer_safe/Skull Dozer","dozer_safe/Medic Dozer","dozer_safe/Minigun Dozer","dozer_safe/Headless Dozer"}
	local stat_boosts = {"none", "+50% HEALTH", "+50% DAMAGE", "x3 ACCURACY", "20 SECONDS IMMORTAL"}
	local stat_boost_functions = {}
	stat_boost_functions[1]=function()
	end
	stat_boost_functions[2]=function(unit)
		unit:character_damage():set_health(unit:character_damage():get_health()*1.5)
	end
	stat_boost_functions[3]=function(unit)
		unit:base():add_buff("base_damage", 0.5)
	end
	stat_boost_functions[4]=function(unit)
		unit:character_damage():set_accuracy_multiplier(3)
	end
	stat_boost_functions[5]=function(unit)
		local lin = TIM.fon_function()
		lin:animate(function(o)
			unit:character_damage():set_immortal(true)
			unit:character_damage():set_invulnerable(true)
			wait(20)
			unit:character_damage():set_immortal(false)
			unit:character_damage():set_invulnerable(false)
		end)	
	end
	local elements_rarity = {"common", "common","uncommon","rare","epic","legendary"}
	local after_function = function (num_spawn, num_boost,effect_params)
		if num_spawn>=5 then
			managers.player:local_player():sound():say("v21",true,true)
		end
		local unit_name = Idstring(dozers_names[num_spawn])	
		local pos, unit_done = TIM:Spawn_unit(unit_name, true)

		if num_boost ~= 5 then
			local lin = TIM:fon_function()
			lin:animate(function(o)
				unit_done:character_damage():set_invulnerable(true)
				unit_done:character_damage():set_immortal(true)
				wait(TIM._settings.TwitchRewards[rewardID].effects.dozersafe.immortal)
				unit_done:character_damage():set_invulnerable(false)
				unit_done:character_damage():set_immortal(false)
				lin:parent():remove(lin)
			end)
		end
		stat_boost_functions[num_boost](unit_done)
		managers.explosion:play_sound_and_effects(
			pos,
			Rotation(0, 0,0),
			1,
			effect_params
		)
	end
	TIM:CreateSafe("Dozer safe",dozers_points, dozers, elements_rarity, dozers_paths, stat_boosts_points, stat_boosts, after_function)
end