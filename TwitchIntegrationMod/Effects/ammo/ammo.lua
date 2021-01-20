--[[
Name:Ammo
Divider:Description: A reward that spawn ammo boxes for you and your crew
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.ammo(rewardID)
	local line_one_word1 = TIM.hud.panel:bitmap({ name = "sssss", visible = true, texture = "guis/textures/icons/ammo", layer = 0, alpha=0, color = Color(1, 1, 1), w = 130, h = 130, blend_mode = "add", x =0, y =0})
	line_one_word1:set_top(TIM.hud.panel:bottom()+100)
	line_one_word1:set_left((TIM.hud.panel:right()))
	local co1 = coroutine.create(function ()
		 line_one_word1:animate(function(o)
			over(0.5, function(p)
			line_one_word1:set_alpha(math.lerp(line_one_word1:alpha(), 1, p))
		end)  
	end)
		coroutine.yield()
		  line_one_word1:animate(function(o)
			over(8, function(p)
			line_one_word1:set_alpha(math.lerp(line_one_word1:alpha(), 0, p))
		end)
	end)
	end)
		  
	local co2 = coroutine.create(function ()
	line_one_word1:animate(function(o)
		over(4, function(p)
			line_one_word1:set_center_y(math.lerp(line_one_word1:center_y(), TIM.hud.panel:center_y(), p))
			line_one_word1:set_center_x(math.lerp(line_one_word1:center_x(), TIM.hud.panel:center_x(), p))
		end)  
	end)
	coroutine.yield()
	line_one_word1:animate(function(o)
		 over(3, function(p)
			line_one_word1:set_left(math.lerp(line_one_word1:left(), TIM.hud.panel:right(), p))
			line_one_word1:set_top(math.lerp(line_one_word1:top(), TIM.hud.panel:bottom(), p))
		end)
		wait(4)
		line_one_word1:parent():remove(line_one_word1)
	end)
	end)
	line_one_word1:animate(function(o)
		coroutine.resume(co2)
		coroutine.resume(co1)
		wait(1)
		--coroutine.resume(co2)
		coroutine.resume(co1)		
	end)
	--local player_unit = managers.player:player_unit()
	--player:sound():play("pickup_ammo_health_boost", nil, true)

	local all_peer = managers.network:session():all_peers()


	for _, peer in pairs(all_peer) do
		local pp = peer:unit()	
		if pp then
			for i=1, TIM._settings.TwitchRewards[rewardID].effects.ammo.count, 1 do
				local unit_done = World:spawn_unit(Idstring("units/pickups/ammo/ammo_pickup"), pp:position(), pp:rotation())
			end
		end
	end

	local sound="sounds/ammo_sound"
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
	}):set_volume_gain(percentage+0.20)
	--player_unit:character_damage():_regenerate_armor()
	--player_unit:character_damage():restore_health(0.05)
	--local unit_done1 = World:spawn_unit(Idstring("units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade"), player:position(), player:rotation())
	--managers.player:local_player():sound():say("g29",true,true)
	--managers.player:set_player_state("arrested")
	--player:player_unit():movement():on_non_lethal_electrocution()
	--managers.rumble:play("electric_shock")
end