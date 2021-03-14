--[[
Name:Heal
Activate:true
Percentage:20
options_end
]]
function TIM.effectsFunctions.heal(rewardID)
	local player_unit = managers.player:player_unit()
	--player:sound():play("pickup_ammo_health_boost", nil, true)
	--local unit_name
	--unit_name = Idstring("units/pickups/ammo/ammo_pickup")
	--local unit_done = World:spawn_unit( unit_name, player:position(), player:rotation())
	--player_unit:character_damage():_regenerate_armor()
	local sound
	local texture_name
	if TIM._settings.TwitchRewards[rewardID].effects.heal.Percentage.Value >= 0 then
		player_unit:character_damage():restore_health(TIM._settings.TwitchRewards[rewardID].effects.heal.Percentage.Value/100)
		sound="sounds/heal_sound"
		texture_name="guis/textures/icons/heal"
	else
		player_unit:character_damage():restore_health(player_unit:character_damage():health_ratio()*(TIM._settings.TwitchRewards[rewardID].effects.heal.Percentage.Value/100))
		sound="sounds/damage_sound"
		texture_name="guis/textures/icons/damage"
	end
	--while(hud.panel:child("gggg")) do
	--	hud.panel:remove(hud.panel:child("gggg"))
	--end
	
	local p = managers.menu_component._main_panel
	local name = "sound"..sound
	if alive(p:child(name)) then
		managers.menu_component._main_panel:remove(p:child(name))
	end
	local volume = managers.user:get_setting("sfx_volume")
	local percentage = (volume - tweak_data.menu.MIN_SFX_VOLUME) / (tweak_data.menu.MAX_SFX_VOLUME - tweak_data.menu.MIN_SFX_VOLUME)
	managers.menu_component._main_panel:video({
		name = name,
		video = sound,
		visible = false,
		loop = false,
	}):set_volume_gain(percentage+0.10)
	local line_one_word1 = TIM.hud.panel:bitmap({
		name = "gggg",			
		visible = true,
		texture = texture_name,
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1),
		w = 80,
		h = 80,
		blend_mode = "add",
		x =0,
		y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
	})
	local line_one_word2 = TIM.hud.panel:bitmap({
		name = "gggg",			
		visible = true,
		texture = texture_name,
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1),
		w = 80,
		h = 80,
		blend_mode = "add",
		x =0,
		y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
	})
	local line_one_word3 = TIM.hud.panel:bitmap({
		name = "gggg",			
		visible = true,
		texture = texture_name,
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1),
		w = 80,
		h = 80,
		blend_mode = "add",
		x =0,
		y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
	})
	local line_one_word4 = TIM.hud.panel:bitmap({
		name = "gggg",			
		visible = true,
		texture = texture_name,
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1),
		w = 80,
		h = 80,
		blend_mode = "add",
		x =0,
		y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
	})
	local line_one_word5 = TIM.hud.panel:bitmap({
		name = "gggg",			
		visible = true,
		texture = texture_name,
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1),
		w = 80,
		h = 80,
		blend_mode = "add",
		x =0,
		y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
	})
	line_one_word1:set_top(TIM.hud.panel:bottom()+math.random (-100,100))
	line_one_word2:set_top(TIM.hud.panel:bottom()+math.random (-100,100))
	line_one_word3:set_top(TIM.hud.panel:bottom()+math.random (-100,100))
	line_one_word4:set_top(TIM.hud.panel:bottom()+math.random (-100,100))
	line_one_word5:set_top(TIM.hud.panel:bottom()+math.random (-100,100))
	line_one_word5:set_center_x((TIM.hud.panel:center_x()+math.random (-100,100)))
	line_one_word1:set_center_x((TIM.hud.panel:center_x()+250+math.random (-100,100)))
	line_one_word2:set_center_x((TIM.hud.panel:center_x()-250+math.random (-100,100)))
	line_one_word3:set_center_x((TIM.hud.panel:center_x()+450+math.random (-100,100)))
	line_one_word4:set_center_x((TIM.hud.panel:center_x()-450+math.random (-100,100)))
	--local dt = coroutine.yield()
	--local speed = 2
		--line_one_word:move(0, (1+speed*dt))
	--	i=i+coroutine.yield()
	line_one_word1:animate(function(o)
	over(25, function(p)
		line_one_word1:set_y(math.lerp(line_one_word1:y(), TIM.hud.panel:center_y(), p))
		line_one_word2:set_y(math.lerp(line_one_word2:y(), TIM.hud.panel:center_y(), p))
		line_one_word3:set_y(math.lerp(line_one_word3:y(), TIM.hud.panel:center_y(), p))
		line_one_word4:set_y(math.lerp(line_one_word4:y(), TIM.hud.panel:center_y(), p))
		line_one_word5:set_y(math.lerp(line_one_word5:y(), TIM.hud.panel:center_y(), p))
		--line_one_word1:set_alpha(math.lerp(line_one_word1:alpha(), 1,p))
		end)
	end)

	line_one_word1:animate(function(o)
	over(10, function(p)
		line_one_word1:set_alpha(math.lerp(line_one_word1:alpha(), 0, p))
		line_one_word2:set_alpha(math.lerp(line_one_word2:alpha(), 0, p))
		line_one_word3:set_alpha(math.lerp(line_one_word3:alpha(), 0, p))
		line_one_word4:set_alpha(math.lerp(line_one_word4:alpha(), 0, p))
		line_one_word5:set_alpha(math.lerp(line_one_word5:alpha(), 0, p))
		end)
	wait(2)
	line_one_word1:parent():remove(line_one_word1)
	line_one_word2:parent():remove(line_one_word2)
	line_one_word3:parent():remove(line_one_word3)
	line_one_word4:parent():remove(line_one_word4)
	line_one_word5:parent():remove(line_one_word5)
	end)
end