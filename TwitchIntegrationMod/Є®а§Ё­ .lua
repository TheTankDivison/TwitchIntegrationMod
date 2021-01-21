local num_spawn = 1
local num_boost = 1
local window_panel = TIM.hud.panel:panel({
	name = "window_safe",			
	visible = false,
	layer = 0,
	alpha=1,
	color = Color(1, 1, 1, 1),
	w = 500,
	h = 84,
	x =0,
	y =100
})
window_panel:set_center_x(TIM.hud.panel:center_x())
local window1 = window_panel:bitmap({
	name = "sssss",			
	visible = true,
	texture = "line",
	layer = 3,
	alpha=1,
	color = Color(1, 1, 1, 1),
	w = 500,
	h = 84,
	x =0,
	y =0
})
local text_line = window_panel:text({
	y = 0,
	name = "say1",
	align = "left",
	blend_mode = "normal",
	alpha = 0,
	x = 3,
	layer = 4,
	text = "Opening Dozer Safe",
	font = tweak_data.menu.pd2_small_font,
	font_size = 15,
	color = Color.black
})
local tableCellsCount = math.random(40,50)
local right = 0
local tableCells={}

end_anim=true
local gif = {}
for i = 1, 45, 1 do
	local image = TIM.hud.panel:bitmap({
		name = "sssss",			
		visible = false,
		texture = "animation/Cadr "..tostring(i),
		layer = 5,
		alpha=1,
		color = Color(1, 1, 1),
		w = 245,
		h = 150,
		x =0,
		y =0
	})
	table.insert(gif, image)
end
for i=1, tableCellsCount, 1 do
	
	local summ_d = 0	
	local summ_prev_d = 0
	local num = 1
	local dn = math.random(summ_all_dozers)
	for i=1, #dozers_points do
		summ_prev_d = summ_d
		summ_d=summ_d+dozers_points[i]
		if dn<=summ_d and dn>summ_prev_d then
			num = i
			break
		end
	end
	local summ_s = 0	
	local summ_prev_s = 0
	local num_s = 1
	local sn = math.random(summ_all_boosts)
	for i=1, #stat_boosts_points do
		summ_prev_s = summ_s
		summ_s=summ_s+stat_boosts_points[i]
		if sn<=summ_s and sn>summ_prev_s then
			num_s = i
			break
		end
	end

	if i==tableCellsCount-3 then
		num_spawn=num
		num_boost=num_s
	end
	local cell_pan = window_panel:panel({
		name = "sssss",			
		visible = true,
		texture = dozers[num],
		layer = 1,
		alpha=1,
		color = Color(1, 1, 1),
		w = 111,
		h = 68,
		x =0,
		y =0
	})
	
	cell_pan:set_bottom(window1:bottom())
	local cell = cell_pan:bitmap({
		name = "sssss",			
		visible = true,
		texture = dozers[num],
		layer = 1,
		alpha=1,
		color = Color(1, 1, 1),
		w = 111,
		h = 68,
		x =0,
		y =0
	})
	cell_pan:set_left(right)
	if num_s > 1 then
		local cell_boost = cell_pan:bitmap({
			name = "sssss",			
			visible = true,
			texture = "safe/boosticon",
			layer = 3,
			alpha=1,
			color = Color(1, 1, 1),
			w = 17,
			h = 17,
			x =0,
			y =0
		})
		cell_boost:set_bottom(cell:bottom())
		cell_boost:set_right(cell:right())
	end
	local text = cell_pan:text({
		y = 0,
		name = "say1",
		align = "left",
		blend_mode = "normal",
		halign = "left",
		x = 3,
		layer = 3,
		text = dozers[num],
		font = tweak_data.menu.pd2_small_font,
		font_size = 15,
		color = Color.white
	})
	text:set_top(cell_pan:bottom()-31)
	
	right=cell_pan:right()
	local avc = {cell_pan, true}
	table.insert(tableCells, avc)						
end
local razbros = math.random(-54,54)
local way = (tableCellsCount-6)*111-30+razbros
local bul =true
local cent_x = window1:world_x()
local cent_y1 = window1:world_center_y()
local text_xcent = text_line:world_x()
local text_ycent = text_line:world_y()
local cent_y = window_panel:center_y()
window_panel:set_w(0)
local c1x = tableCells[1][1]:world_x()
local c1y = tableCells[1][1]:world_y()
local c2x = tableCells[2][1]:world_x()
local c2y = tableCells[2][1]:world_y()
local c3x = tableCells[3][1]:world_x()
local c3y = tableCells[3][1]:world_y()
local c4x = tableCells[4][1]:world_x()
local c4y = tableCells[4][1]:world_y()
local c5x = tableCells[5][1]:world_x()
local c5y = tableCells[5][1]:world_y()
window1:animate(function(o)
TIM.Active_safe=true
window_panel:set_visible(true)
	over(0.5, function(p)
		window_panel:set_w(math.lerp(0, 500, p))
		window_panel:set_h(math.lerp(0, 84, p))
		window_panel:set_center_x(TIM.hud.panel:center_x())
		window_panel:set_center_y(cent_y)
		tableCells[1][1]:set_world_x(c1x)
		tableCells[1][1]:set_world_y(c1y)
		tableCells[2][1]:set_world_x(c2x)
		tableCells[2][1]:set_world_y(c2y)
		tableCells[3][1]:set_world_x(c3x)
		tableCells[3][1]:set_world_y(c3y)
		tableCells[4][1]:set_world_x(c4x)
		tableCells[4][1]:set_world_y(c4y)
		tableCells[5][1]:set_world_x(c5x)
		tableCells[5][1]:set_world_y(c5y)
		window1:set_world_center_y(cent_y1)
		window1:set_world_center_x(window_panel:center_x())
	end)
	window1:set_x(0)
	text_line:set_x(3)
	over(0.5,function(p)
		text_line:set_alpha(math.lerp(0,1,p))
	end)
	local timerand = math.random(800,900)
	local temp=way 
	
	local function over1(seconds, f,  fixed_dt)
		local t = 0
		while true do
			local dt = coroutine.yield()
			t = t + (fixed_dt and 0.03333333333333333 or dt)
		
			if seconds <= t then
				break
			end
				--
			f(t / seconds, t)
			if math.abs(-1*way-tableCells[1][1]:center_x())<0.1 then
				
				break
			end
		end
		f(1, seconds)
	end
over1(timerand,  function(p)
	tableCells[1][1]:set_center_x(math.lerp(tableCells[1][1]:center_x(),-1*way, p))
	for i=2, tableCellsCount, 1 do
		tableCells[i][1]:set_left(tableCells[i-1][1]:right())
		if tableCells[i][1]:left()<window1:center_x() and tableCells[i][2]==true then
			tableCells[i][2]=false
			local sound="sound"
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
			}):set_volume_gain(percentage+0.40)
		end
	end
end)

for i = 1, 45, 1 do
	gif[i]:set_color(colors[num_spawn])
	gif[i]:set_world_center_x(tableCells[#tableCells-3][1]:world_center_x())
	gif[i]:set_world_center_y(tableCells[#tableCells-3][1]:world_center_y())
	
end
local jj ={}
jj[1] =1
local function over4(seconds, f,  fixed_dt)
		local t = 0
		while true do
			local dt = coroutine.yield()
			t = t + (fixed_dt and 0.03333333333333333 or dt)
		
			if seconds <= t then
				break
			end
				--
			f(t / seconds, t)
			if jj[1]==45 then
				
				break
			end
		end
		f(1, seconds)
	end
if num_spawn>=5 then
	managers.player:local_player():sound():say("v21",true,true)
end

over4(2, function(p)
	if jj[1] <45 then
		gif[jj[1]]:set_visible(true)
		jj[1]=jj[1]+1
		gif[jj[1]]:set_visible(true)
		gif[jj[1]-1]:set_visible(false)
		gif[jj[1]-1]:parent():remove(gif[jj[1]-1]) 
		tableCells[tableCellsCount][1]:set_alpha(math.lerp(tableCells[tableCellsCount][1]:alpha(), 0 ,p))
		
		tableCells[tableCellsCount-1][1]:set_alpha(math.lerp(tableCells[tableCellsCount-1][1]:alpha(), 0 ,p))
		
		tableCells[tableCellsCount-2][1]:set_alpha(math.lerp(tableCells[tableCellsCount-2][1]:alpha(), 0 ,p))
		
		tableCells[tableCellsCount-5][1]:set_alpha(math.lerp(tableCells[tableCellsCount-5][1]:alpha(), 0 ,p))
		tableCells[tableCellsCount-6][1]:set_alpha(math.lerp(tableCells[tableCellsCount-6][1]:alpha(), 0 ,p))
		
		tableCells[tableCellsCount-4][1]:set_alpha(math.lerp(tableCells[tableCellsCount-4][1]:alpha(), 0 ,p))
		window1:set_alpha(math.lerp(window1:alpha(), 0 ,p))
		text_line:set_alpha(math.lerp(text_line:alpha(), 0 ,p))
	end
end)

c1x = tableCells[tableCellsCount][1]:world_x()
c1y = tableCells[tableCellsCount][1]:world_y()
c2x = tableCells[tableCellsCount-1][1]:world_x()
c2y = tableCells[tableCellsCount-1][1]:world_y()
c3x = tableCells[tableCellsCount-2][1]:world_x()
c3y = tableCells[tableCellsCount-2][1]:world_y()
c4x = tableCells[tableCellsCount-3][1]:world_x()
c4y = tableCells[tableCellsCount-3][1]:world_y()
c5x = tableCells[tableCellsCount-4][1]:world_x()
c5y = tableCells[tableCellsCount-4][1]:world_y()
local c6x = tableCells[tableCellsCount-5][1]:world_x()
local c6y = tableCells[tableCellsCount-5][1]:world_y()

local sound=sounds_safe[num_spawn]
local p = managers.menu_component._main_panel
local name = "sound"..sound
if alive(p:child(name)) then
	managers.menu_component._main_panel:remove(p:child(name))
end
local volume = managers.user:get_setting("sfx_volume")
local percentage = (volume - tweak_data.menu.MIN_SFX_VOLUME) / (tweak_data.menu.MAX_SFX_VOLUME - tweak_data.menu.MIN_SFX_VOLUME)
local vid = window_panel:video({
	name = name,
	video = sound,
	visible = false,
	loop = false,
}):set_volume_gain(percentage+0.15)
local old_vol = managers.user:get_setting("music_volume")
local old_vol2 = managers.user:get_setting("sfx_volume")
if num_boost>1 then
	local st1=TIM.hud.panel:bitmap({
		name = "sssss",			
		visible = true,
		texture = "safe/statboost1",
		layer = 3,
		alpha=1,
		color = Color(1, 1, 1),
		w = 1,
		h = 1,
		x =0,
		y =200
	})
	local st2=TIM.hud.panel:bitmap({
		name = "sssss",			
		visible = true,
		texture = "safe/statboost2",
		layer = 2,
		alpha=1,
		color = Color(1, 1, 1),
		w = 1,
		h = 1,
		x =0,
		y =200
	})
	local st3=TIM.hud.panel:bitmap({
		name = "sssss",			
		visible = false,
		texture = "safe/statboost3",
		layer = 1,
		alpha=1,
		color = Color(1, 1, 1),
		w = 100,
		h = 100,
		x =0,
		y =200
	})
	local st4=TIM.hud.panel:bitmap({
		name = "sssss",			
		visible = false,
		texture = "safe/statboost4",
		layer = 1,
		alpha=1,
		color = Color(1, 1, 1),
		w = 100,
		h = 100,
		x =0,
		y =200
	})
	local st5=TIM.hud.panel:bitmap({
		name = "sssss",			
		visible = false,
		texture = "safe/statboost5",
		layer = 1,
		alpha=1,
		color = Color(1, 1, 1),
		w = 100,
		h = 100,
		x =0,
		y =200
	})
	local text_b1=TIM.hud.panel:panel({
		name = "sssss",			
		visible = true,
		texture = "safe/statboost5",
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1),
		w = 500,
		h = 200,
		x =0,
		y =200
	})
	local text_b2=TIM.hud.panel:panel({
		name = "sssss",			
		visible = true,
		texture = "safe/statboost5",
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1),
		w = 500,
		h = 200,
		x =0,
		y =200
	})
	--managers.chat:_receive_message(1, "ddd", tostring(1), Color('1565c0'))	
	st1:set_center_x(TIM.hud.panel:center_x())
	st2:set_center_x(TIM.hud.panel:center_x())
	st3:set_center_x(TIM.hud.panel:center_x())
	st4:set_center_x(TIM.hud.panel:center_x())
	st5:set_center_x(TIM.hud.panel:center_x())
	over(0.3, function(p)				
		
		st2:set_w(math.lerp(st2:w(), 100, p))
		st2:set_h(math.lerp(st2:h(), 100, p))
		st2:set_center_x(TIM.hud.panel:center_x())
		st2:set_center_y(250)
	end)
	over(0.3, function(p)
		
		st1:set_w(math.lerp(st1:w(), 100, p))		
		st1:set_h(math.lerp(st1:h(), 100, p))	
		st1:set_center_x(TIM.hud.panel:center_x())
		st1:set_center_y(250)				
	end)
	st3:set_center_y(0)		
	st4:set_center_y(500)	
	st5:set_center_y(500)				
	over(0.3, function(p)
		st3:set_center_x(TIM.hud.panel:center_x())
		st4:set_center_x(math.lerp(TIM.hud.panel:center_x()-100,TIM.hud.panel:center_x(),p))
		st5:set_center_x(math.lerp(TIM.hud.panel:center_x()+100,TIM.hud.panel:center_x(),p))
		st3:set_center_y(math.lerp(0,250,p))
		st4:set_center_y(math.lerp(500,250,p))
		st5:set_center_y(math.lerp(500,250,p))
		st3:set_alpha(math.lerp(0,1,p))
		st4:set_alpha(math.lerp(0,1,p))
		st5:set_alpha(math.lerp(0,1,p))
		st3:set_visible(true)
		st4:set_visible(true)
		st5:set_visible(true)
	end)
	text_b1:set_world_right(st1:world_left()+10)
	text_b2:set_world_left(st1:world_right()-10)
	local tt1 = text_b1:text({
		y = 25,
		name = "say1",
		align = "right",
		blend_mode = "normal",
		alpha = 1,
		x = 210,
		layer = 4,
		text = "STAT BOOST",
		font = tweak_data.menu.pd2_large_font,
		font_size = 40,
		color = Color.white
	})
	local tt2 = text_b2:text({
		y = 25,
		name = "say1",
		align = "left",
		blend_mode = "normal",
		alpha = 1,
		x = -210,
		layer = 4,
		text = stat_boosts[num_boost],
		font = tweak_data.menu.pd2_large_font,
		font_size = 40,
		color = Color.white
	})
	over(0.5, function(p)
		tt1:set_x(math.lerp(210,-10,p))
		tt2:set_x(math.lerp(-210,10,p))
	end)
	wait(1)
	over(0.3, function(p)
		st1:set_alpha(math.lerp(1,0,p))
		st2:set_alpha(math.lerp(1,0,p))
		st3:set_alpha(math.lerp(1,0,p))
		st4:set_alpha(math.lerp(1,0,p))
		st5:set_alpha(math.lerp(1,0,p))
		tt1:set_alpha(math.lerp(1,0,p))
		tt2:set_alpha(math.lerp(1,0,p))
	end)
	st1:parent():remove(st1)
	st2:parent():remove(st2)
	st3:parent():remove(st3)
	st4:parent():remove(st4)
	st5:parent():remove(st5)
	text_b1:parent():remove(text_b1)
	text_b2:parent():remove(text_b2)
end		--package.cpath = "D:\\Steam\\steamapps\\common\\PAYDAY 2\\mods\\TwitchIntegrationMod\\filesystem\\lfs.dll"
--require("lfs") -- http://files.luaforge.net/releases/luafilesystem/luafilesystem/luafilesystem-1.4.2/luafilesystem-1.4...

TIM = TIM or class()

function TIM:Init()
	 MenuUI:new({
        offset = 6,
        toggle_key = TIM.Options:GetValue("TWToggleKey"),
        toggle_clbk = callback(self, self, "ShowMenu"),
		create_items = callback(self, self, "CreateItems"),
		use_default_close_key = true,
       
    })
	TIM.RewardNames={"Spin display","Supress","Low speed","Cloaker","Dozer safe","Tazer","Medic","Winters shield","Captain Winters","Headless Dozer","Gas grenade","Flash grenade","Smoke grenade","Frag grenade","Cuffs","Jail","Less FOV","No Hitmarker","Heal","Ammo","Zeal sniper","No sound","Blur", "30 FPS"}
	TIM.Reward_Ids={"spin","black","speed","cloaker","dozer","tazer","medic","shield","winters","headlessdozer","gas","flash","smoke","grenade","cuf","jail","fov","hit","heal","ammo","sniper","nosound","blur", "fps_30"}
	TIM.Reward_names = {}

	TIM.Timers_max = {}
	local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config_parametres.txt", "r")
	local line = file:read()
	line = tostring(line)
	local arr = line:split("#")
	line = file:read()
	line = tostring(line)
	local arr2 = line:split("#")
	TIM.Reward_names["spin"] = arr2[1]
	TIM.Reward_names["black"] =  arr2[2]
	TIM.Reward_names["speed"] =  arr2[3]
	TIM.Reward_names["cloaker"] =  arr2[4]
	TIM.Reward_names["dozer"]=  arr2[5]
	TIM.Reward_names["tazer"]=  arr2[6]
	TIM.Reward_names["medic"]=  arr2[7]
	TIM.Reward_names["shield"]=  arr2[8]
	TIM.Reward_names["winters"]=  arr2[9]
	TIM.Reward_names["headlessdozer"]=  arr2[10]
	TIM.Reward_names["gas"]=  arr2[11]
	TIM.Reward_names["flash"]=  arr2[12]
	TIM.Reward_names["smoke"]=  arr2[13]
	TIM.Reward_names["grenade"]=  arr2[14]
	TIM.Reward_names["cuf"]=  arr2[15]
	TIM.Reward_names["jail"]=  arr2[16]
	TIM.Reward_names["fov"]=  arr2[17]
	TIM.Reward_names["hit"]=  arr2[18]
	TIM.Reward_names["heal"]=  arr2[19]
	TIM.Reward_names["ammo"]=  arr2[20]
	TIM.Reward_names["sniper"]=  arr2[21]
	TIM.Reward_names["nosound"]=  arr2[22]
	TIM.Reward_names["blur"]=  arr2[23]
	TIM.Reward_names["fps_30"]=  arr2[24]
	file:close()
	
	
	TIM.Timers_max.timer_jail =  tonumber(arr[1])
	TIM.Timers_max.timer_hit = tonumber(arr[2])
	TIM.Timers_max.timer_fov = tonumber(arr[3])
	TIM.Timers_max.timer_speed = tonumber(arr[4])
	TIM.Timers_max.timer_black = tonumber(arr[5])
	TIM.Timers_max.timer_nosound = tonumber(arr[6])
	TIM.Timers_max.timer_blur = tonumber(arr[7])
	TIM.Timers_max.timer_fps = tonumber(arr[8])
	TIM.Heal_perc = tonumber(arr[9])
	--TIM:Chat()
	--twitch=false
	
	local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/user.txt", "r")
		local line1 = file:read()
		TIM.twitch_nickname = tostring(line1)
		file:close()
end

function TIM:Post(clss, func, after_orig)
	Hooks:PostHook(clss, func, "TIM_"..func, after_orig)
end
function TIM:Chat()
	--local fon = TIM:fon_function()
	--fon:animate(function(o)
		while(true) do
			local file, err = io.open("mods/TwitchIntegrationMod/Bot/ReadMessage/mess.txt", "r")
			if file then
				local line = file:read()
				local new_mes = tostring(line)
				if new_mes:find("1") then
					line = file:read()
					local nickname = tostring(line)
					nickname = "0TW0" .. nickname
					line = file:read()
					local col = tostring(line)
					col = col:sub(2)
					line = file:read()
					local messag = tostring(line)			
					managers.chat:_receive_message(1, nickname, messag, Color(col))			
					file:close()
					file = io.open("mods/TwitchIntegrationMod/Bot/ReadMessage/mess.txt", "w")
					file:write("")
					file:close()			
				else
					file:close()		
				end
			end
			wait(0.1)
		end
	--end)
end
function TIM:CreateItems(menu)
    TIM._menu = menu
    local accent = Color(1, 1, 1)
    TIM._holder = TIM._menu:DivGroup({
        name = "None",
        w = 400,
        auto_height = false,
        size = 20,
        background_visible = true,
        border_bottom = true,
        border_center_as_title = true,
        border_position_below_title = true,
        private = {text_align = "center"},
        border_lock_height = true,
        accent_color = accent,
        border_width = 200,
        background_color = Color('3d005e'),
		background_alpha = 0.7,
		align_method = "grid",
		--x=1280/2
    })
	TIM._dialog = TIM._menu:Menu({
        name = "dialog",
        position = "Center",
        align_items = "grid",
        w = 220,
        visible = false,
        auto_height = true,
        auto_foreground = true,
        always_highlighting = true,
        reach_ignore_focus = true,
        scrollbar = false,
        max_height = 700,
        size = 20,
        offset = 8,
        accent_color = BeardLib.Options:GetValue("MenuColor"),
        background_color = Color('3d005e'),
		background_alpha = 0.7,
		align_method = "grid"
    })
	
	
	
end

function TIM:ShowMenu(menu, opened)
	TIM._holder:ClearItems()
	TIM._dialog:ClearItems()
	TIM._dialog:SetVisible(false)
	--TIM._holder:SetPosition("Center")

	if opened then
		if managers.player:player_unit() then
			game_state_machine:current_state():set_controller_enabled(false)
		end
		local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/user.txt", "r")
		local line1 = file:read()
		local twitch_nickname = tostring(line1)
		file:close()
		
		file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/settings.txt", "r")
		line1 = file:read()
		
		local chat_enable = tostring(line1)
		line1 = file:read()
		local points_comm = tostring(line1)
		
		file:close()
        TIM._holder:SetText("Twitch Integration Mod")

		TIM._dialog:Divider({
			name = "Divider",
			text_align = "center",
			text = "Warning!"
		})
		TIM._dialog:Divider({
			name = "Divider",
			text = "Twitch bot is working right now. To apply the settings you need to restart the bot. Restart?"
		})
		TIM._dialog:Button({
			name = "Yes",
			text = "OK",
			text_align = "center",
			w=100,
			on_callback = function(item)
				TIM._dialog:SetVisible(false)
				--TIM._dialog:ClearItems()
			end
		})
		TIM._dialog:Button({
			name = "NO",
			text = "Cancel",
			text_align = "center",
			w=100,
			on_callback = function(item)
				TIM._dialog:SetVisible(false)
				--TIM._dialog:ClearItems()
			end
		})
		
       --[[ TIM._holder:Button({
            name = "Reset",
            on_callback = function()
                managers.chat:_receive_message(1, "ddd", tostring(1), Color('1565c0'))
            end
        })
		]]
		TIM._holder:Image({
			name = "MyImageButton",
			texture = "guis/textures/icons/twch",
			w=80,
			h=80
		})
		
		local pann = TIM._holder:DivGroup({
			name = "2ndMenu",
			text = "Settings",
			w=290,
			--text_align = "center",
			align_method = "grid" 
		})
		pann:TextBox({
			name = "MyTextBox",
			w=280,
			text = "Twitch Nickname",
			value = twitch_nickname,
			on_callback = function(item)
				managers.chat:_receive_message(1, "ddd", tostring(2	), Color('1565c0'))
			end
		})
		pann:Toggle({
			name = "ActivateChat",
			text = "Twitch Chat in game",
			value=true,
			w=280
		})
	
		pann:Toggle({
			name = "Rewards",
			text = "Channel Points",
			value = true,
			w=120,
			on_callback = function(item)
				if pann:GetItem("Rewards"):Value()==false then
					pann:GetItem("Commands"):SetValue(true)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Commands")
					--TIM._holder:RemoveItem("Rewards/Commands")
				else
					pann:GetItem("Commands"):SetValue(false)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Channel Points Rewards")
				end
			end
		})
		
		pann:Toggle({
			name = "Commands",
			text = "Chat Commands",
			value = false,
			w=120,
			on_callback = function(item)
				if pann:GetItem("Commands"):Value()==false then
					pann:GetItem("Rewards"):SetValue(true)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Channel Points Rewards")
				else
					pann:GetItem("Rewards"):SetValue(false)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Commands")
				end
			end
		})
	
		
		if chat_enable=="false" then
			pann:GetItem("ActivateChat"):SetValue(false)
		end
		
		if points_comm=="true" then
			pann:GetItem("Commands"):SetValue(false)
			pann:GetItem("Rewards"):SetValue(true)
		else
			pann:GetItem("Commands"):SetValue(true)
			pann:GetItem("Rewards"):SetValue(false)
		end
		TIM._holder:Button({
			name = "MyButton",
			text = "START / RESTART BOT",
			text_align = "center",
			w=150,
			on_callback = function(item)
				--
				--dofile("mods/TwitchIntegrationMod/Bot/BotTwitch.exe")
				os.execute("taskkill /IM BotTwitch.exe /F")
				os.execute("start mods/TwitchIntegrationMod/Bot/BotTwitch.exe")
				bot_working = true
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /TOP")
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /MAX")
			end
		})
		TIM._holder:Button({
			name = "MyButton",
			text = "SAVE SETTINGS",
			text_align = "center",
			w=150,
			on_callback = function(item)
				--
				if bot_working == true then
					TIM._dialog:SetVisible(true)
				end
				local lines_all = { }
				for i=1, #TIM._panel_Toggles, 1 do
					if TIM._panel_Toggles[i]:Value() == true then
						local obj = TIM._holder:GetItem(TIM._panel_Toggles[i]:Name().."_gr")
						lines_all[#lines_all+1] = obj:GetItem("Reward_name_on_Twitch"):Value().."|#"..TIM._panel_Toggles[i]:Name()
						--local timers = { }
						
						
						if obj:Name() == "jail_gr" or obj:Name() == "black_gr" or obj:Name() == "speed_gr" or obj:Name() == "fov_gr" or obj:Name() == "hit_gr" then							
							TIM.Timers_max["timer_"..TIM._panel_Toggles[i]:Name()]= obj:GetItem("MyNumberBox"):Value()
						elseif obj:Name() == "heal_gr" then
							TIM.Heal_perc = obj:GetItem("MyNumberBox"):Value()
						else
							local ob = obj:GetItem("MyNumberBox")
							
							if ob then
								local numb = ob:Value()
								for j = 1, numb, 1 do
									lines_all[#lines_all] = lines_all[#lines_all].."#"..TIM._panel_Toggles[i]:Name()
								end
							end
						end
						
						local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config.txt", "w")
						file:write(table.concat(lines_all, "\n"))
						file:close()
						
						file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config_parametres.txt", "w")
						file:write(TIM.Timers_max.timer_jail.."#"..TIM.Timers_max.timer_hit.."#"..TIM.Timers_max.timer_fov.."#"..TIM.Timers_max.timer_speed.."#"..TIM.Timers_max.timer_black.."#"..TIM.Heal_perc)
						file:close()
					end
				end
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /TOP")
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /MAX")
			end
		})
		TIM._panel = TIM._holder:Group({
			name = "Rewards/Commands",
			text = "Channel Points Rewards",
			color = TIM._holder.accent_color, 
			size = 18, 
			align_method = "grid" 
			--inherit_values = {text_align = "center"}	
		})
		TIM._panel_Toggles = {}
		for i = 1, #TIM.RewardNames, 1 do
			TIM._panel_Toggles[#TIM._panel_Toggles+1] = TIM._panel:Toggle({
				name = TIM.Reward_Ids[i],
				text = TIM.RewardNames[i],
				value = false,
				w=120,
				on_callback = function(item)
					--local tt = text
					--local name_temp = name
					
					if TIM._panel:GetItem(item:Name()):Value()==true then
						local gr = TIM._holder:Group({
							name = item:Name().."_gr",
							text = item:Text(),
							color = TIM._holder.accent_color, 
							size = 18, 
							align_method = "grid",
							closed = true
							--inherit_values = {text_align = "center"}	
						})
							gr:TextBox({
								name = "Reward_name_on_Twitch",
								text = "Reward name on Twitch:",
								value = "",
								focus_mode = true
							})
						if item:Text() == "Jail" or item:Text() == "Supress" or item:Text() == "Low speed" or item:Text() == "Less FOV" or item:Text() == "No Hitmarker" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that works for a given time"
							})
							
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Time(seconds):",
								value = "10",
								w=230,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Cloaker" or item:Text() == "Medic" or item:Text() == "Headless Dozer" or item:Text() == "Tazer" or item:Text() == "Captain Winters" or item:Text() == "Zeal sniper" or item:Text() == "Winters shield" then
							--Number of spawn
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spawn special units"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Number of spawn:",
								value = "1",
								w=280,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Smoke grenade" or item:Text() == "Frag grenade" or item:Text() == "Gas grenade" or item:Text() == "Flash grenade" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spawn grenades"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Number of spawn:",
								value = "1",
								w=280,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Heal" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that heals you for a certain percentage"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Percentage(%):",
								value = "1",
								w=250,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Spin display" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spin your display"
							})
						elseif item:Text() == "Ammo" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spawn ammo boxes for you and your crew"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Number of spawn:",
								value = "1",
								w=280,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Cuffs" then	
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that handcuffs you for 60 seconds"
							})
						elseif item:Text() == "Dozer safe" then	
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that launches roulette from dozers of various rarities, with a chance of a stat boost"
							})
						end
					else
						TIM._holder:RemoveItem(TIM._holder:GetItem(item:Name().."_gr"))
					end
				end
			})
		end
		
		--[[
		for key, val in pairs(TIM.Reward_names) do
			if val==1 then
				TIM._panel:GetItem(key):SetValue(true)
			else
				TIM._panel:GetItem(key):SetValue(false)
			end
		end
		local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config.txt", "r")
		for line3 in file:lines() do
			line3 = tostring(line3)
			local index = line3:find("|")
			local name_of_reward=line3:sub(1,index-1)
			index = line3:find("#")
			local index2 = line3:find("#", index+1)
			local reward_id = line3:sub(index+1, index2-1)
			local gr = TIM._holder:GetItem(reward_id.._gr)
			
		end
		
		file:close()
		]]
    else
		game_state_machine:current_state():set_controller_enabled(true)
        TIM._menu:disable()
    end
end

function TIM:Game_setup()

	TIM.hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	TIM.player = managers.player:local_player()
	TIM.M_groupAI = managers.groupai
	TIM.AIState = TIM.M_groupAI:state()
	
	TIM.OldSpeed_standart = 0
	TIM.OldSpeed_running = 0
	TIM.OldSpeed_crouch = 0
	TIM.OldSpeed_steel = 0
	TIM.OldSpeed_inair = 0
	TIM.OldSpeed_climb = 0
	
	TIM.Active_spin = false
	TIM.Active_black = false
	TIM.Active_safe = false
	TIM.Active_timer_jail = false
	TIM.Active_timer_hit = false
	TIM.Active_timer_fov = false
	TIM.Active_timer_speed = false
	TIM.Active_timer_nosound = false
	TIM.Active_timer_blur = false
	TIM.Active_timer_fps = false
	
	TIM.Timers = {}
	TIM.Timers_max = {}
	
	local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config_parametres.txt", "r")
	local line = file:read()
	local arr = line:split("#")
	file:close()
		
	TIM.Timers_max.timer_jail =  tonumber(arr[1])
	TIM.Timers_max.timer_hit = tonumber(arr[2])
	TIM.Timers_max.timer_fov = tonumber(arr[3])
	TIM.Timers_max.timer_speed = tonumber(arr[4])
	TIM.Timers_max.timer_black = tonumber(arr[5])
	TIM.Timers_max.timer_nosound = tonumber(arr[6])
	TIM.Timers_max.timer_blur = tonumber(arr[7])
	TIM.Timers_max.timer_fps = tonumber(arr[8])
	TIM.Heal_perc = tonumber(arr[9])
	
	TIM.Timers.timer_jail = 0
	TIM.Timers.timer_hit = 0
	TIM.Timers.timer_fov = 0
	TIM.Timers.timer_speed = 0
	TIM.Timers.timer_black = 0
	TIM.Timers.timer_blur = 0
	TIM.Timers.timer_nosound = 0
	TIM.Timers.timer_fps = 0
	TIM.Reward_functions = {}
	
	TIM.Reward_functions["spin"] = function (x)
		
		local lin = TIM:fon_function()
		local player = managers.player:player_unit()
		local camera = player:camera()
		lin:animate(function(o)
			while TIM.Active_spin==true do
				wait(1)
			end
			managers.player:local_player():sound():say("g29",true,true)
			TIM.Active_spin = true
			camera:camera_unit():base():set_target_tilt(-720)
			wait(2.5)
			camera:camera_unit():base():set_target_tilt(0)
			wait(2.5)
			TIM.Active_spin=false
			lin:parent():remove(lin)
		end)
		
	end
	
	TIM.Reward_functions["black"] = function (x)
	local black_screen = TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "black",
			layer = TIM.hud.panel:layer()+15,
			alpha=0,
			color = Color(1, 1, 1),
			w = TIM.hud.panel:w()*5,
			h = TIM.hud.panel:h()*5,
			--blend_mode = "add",
			x =0,
			y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
		})
		
		black_screen:animate(function(o)
		local function over1(seconds, bool, f,  fixed_dt)
				local t = 0
				while true do
					local dt = coroutine.yield()
					t = t + (fixed_dt and 0.03333333333333333 or dt)
				
					if seconds <= t then
						break
					end
						--
					f(t / seconds, t)
					if bool ==true then
						if math.abs(black_screen:w()-TIM.hud.panel:w())<0.1 then
							
							break
						end
					else
						if math.abs(black_screen:w()-TIM.hud.panel:w()*5)<0.1 then
							
							break
						end
					end
				end
				f(1, seconds)
			end
		
		if TIM.Active_black == false then
			TIM.Active_black = true
			TIM.Timers.timer_black = TIM.Timers.timer_black + 1
			over1(200, true, function(p)
					black_screen:set_center_x(TIM.hud.panel:center_x())
					black_screen:set_center_y(TIM.hud.panel:center_y())
					black_screen:set_w(math.lerp(black_screen:w(),TIM.hud.panel:w(),p))
					black_screen:set_h(math.lerp(black_screen:h(),TIM.hud.panel:h(),p))
					black_screen:set_alpha(math.lerp(black_screen:alpha(), 1, p))
				end)
			while TIM.Timers.timer_black>0 do
				TIM.Timers.timer_black = TIM.Timers.timer_black - 1
			
				
				--wait(1.5)
				
				wait(TIM.Timers_max.timer_black)
			end
			over1(200, false, function(p)
					black_screen:set_center_x(TIM.hud.panel:center_x())
					black_screen:set_center_y(TIM.hud.panel:center_y())
					black_screen:set_w(math.lerp(black_screen:w(),TIM.hud.panel:w()*5,p))
					black_screen:set_h(math.lerp(black_screen:h(),TIM.hud.panel:h()*5,p))
					black_screen:set_alpha(math.lerp(black_screen:alpha(), 0, p))
				end)
			TIM.Active_black = false
			black_screen:parent():remove(black_screen)
		else
			TIM.Timers.timer_black = TIM.Timers.timer_black + 1
		end
	end)
	end
	
	TIM.Reward_functions["speed"] = function (x)
		local T_speed = tweak_data.player.movement_state.standard.movement.speed
		managers.player:local_player():sound():say("g29",true,true)
		if TIM.Active_timer_speed == false then
			TIM.Active_timer_speed = true
			TIM.OldSpeed_standart = T_speed.STANDARD_MAX
			TIM.OldSpeed_running = T_speed.RUNNING_MAX
			TIM.OldSpeed_crouch = T_speed.CROUCHING_MAX 
			TIM.OldSpeed_steel = T_speed.STEELSIGHT_MAX 
			TIM.OldSpeed_inair = T_speed.INAIR_MAX 
			TIM.OldSpeed_climb = T_speed.CLIMBING_MAX
			
			T_speed.STANDARD_MAX = T_speed.STANDARD_MAX/3
			T_speed.RUNNING_MAX = T_speed.RUNNING_MAX/3
			T_speed.CROUCHING_MAX = T_speed.CROUCHING_MAX/3
			T_speed.STEELSIGHT_MAX = T_speed.STEELSIGHT_MAX/3
			T_speed.INAIR_MAX = T_speed.INAIR_MAX/3
			T_speed.CLIMBING_MAX = T_speed.CLIMBING_MAX/3
			
			local lin = TIM:fon_function()
			lin:animate(function(o)
				TIM.Timers.timer_speed = TIM.Timers.timer_speed + 1
				while TIM.Timers.timer_speed>0 do
					TIM.Timers.timer_speed = TIM.Timers.timer_speed - 1
					wait(TIM.Timers_max.timer_speed)
				end
				T_speed.STANDARD_MAX = TIM.OldSpeed_standart
				T_speed.RUNNING_MAX = TIM.OldSpeed_running 
				T_speed.CROUCHING_MAX = TIM.OldSpeed_crouch 
				T_speed.STEELSIGHT_MAX = TIM.OldSpeed_steel  
				T_speed.INAIR_MAX = TIM.OldSpeed_inair 
				T_speed.CLIMBING_MAX = TIM.OldSpeed_climb  
				TIM.Active_timer_speed = false
				lin:parent():remove(lin)
			end)
		else
			TIM.Timers.timer_speed = TIM.Timers.timer_speed + 1
		end
	end
	
	TIM.Reward_functions["cloaker"] = function (x)
	
		local unit_name = Idstring("units/payday2/characters/ene_spook_1/ene_spook_1")
		local pos = TIM:Spawn_unit(unit_name, true)
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
		managers.player:local_player():sound():say("Play_ban_s04",true,true)	
	end
	
	TIM.Reward_functions["dozer"]=function (x)
		local dozers_points = {110,110,100,50,10,5}
		local summ_all_dozers = dozers_points[1]+dozers_points[2]+dozers_points[3]+dozers_points[4]+dozers_points[5]+dozers_points[6]
		local souns_safe = {"common-1", "common-1","uncommon-1","rare-1","epic-1","legend-1"}
		local colors = {Color(0,0.32,0.63),Color(0,0.32,0.63),Color(0.55,0.18,0.49),Color(1,0.01,0.42),Color(0.74,0.13,0.08),Color(0.95,0.64,0)}
		local dozers = {"Green Dozer", "Black Dozer", "Skull Dozer", "Medic Dozer", "Minigun Dozer", "Headless Dozer"}
		local dozers_names = {"units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1", "units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2", "units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3", "units/pd2_dlc_drm/characters/ene_bulldozer_medic/ene_bulldozer_medic", "units/pd2_dlc_drm/characters/ene_bulldozer_minigun/ene_bulldozer_minigun", "units/pd2_dlc_help/characters/ene_zeal_bulldozer_halloween/ene_zeal_bulldozer_halloween"}
		local stat_boosts_points= {300, 50, 50, 50, 25}
		local summ_all_boosts = stat_boosts_points[1] + stat_boosts_points[2]+stat_boosts_points[3]+stat_boosts_points[4]+stat_boosts_points[5]
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
		local num_spawn = 1
		local num_boost = 1
		local window_panel = TIM.hud.panel:panel({
			name = "window_safe",			
			visible = false,
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1, 1),
			w = 500,
			h = 84,
			x =0,
			y =100
		})
		window_panel:set_center_x(TIM.hud.panel:center_x())
		local window1 = window_panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "line",
			layer = 3,
			alpha=1,
			color = Color(1, 1, 1, 1),
			w = 500,
			h = 84,
			x =0,
			y =0
		})
		local text_line = window_panel:text({
			y = 0,
			name = "say1",
			align = "left",
			blend_mode = "normal",
			alpha = 0,
			x = 3,
			layer = 4,
			text = "Opening Dozer Safe",
			font = tweak_data.menu.pd2_small_font,
			font_size = 15,
			color = Color.black
		})
		local tableCellsCount = math.random(40,50)
		local right = 0
		local tableCells={}
		
		end_anim=true
		local gif = {}
		for i = 1, 45, 1 do
			local image = TIM.hud.panel:bitmap({
				name = "sssss",			
				visible = false,
				texture = "animation/Cadr "..tostring(i),
				layer = 5,
				alpha=1,
				color = Color(1, 1, 1),
				w = 245,
				h = 150,
				x =0,
				y =0
			})
			table.insert(gif, image)
		end
		for i=1, tableCellsCount, 1 do
			
			local summ_d = 0	
			local summ_prev_d = 0
			local num = 1
			local dn = math.random(summ_all_dozers)
			for i=1, #dozers_points do
				summ_prev_d = summ_d
				summ_d=summ_d+dozers_points[i]
				if dn<=summ_d and dn>summ_prev_d then
					num = i
					break
				end
			end
			local summ_s = 0	
			local summ_prev_s = 0
			local num_s = 1
			local sn = math.random(summ_all_boosts)
			for i=1, #stat_boosts_points do
				summ_prev_s = summ_s
				summ_s=summ_s+stat_boosts_points[i]
				if sn<=summ_s and sn>summ_prev_s then
					num_s = i
					break
				end
			end
	
			if i==tableCellsCount-3 then
				num_spawn=num
				num_boost=num_s
			end
			local cell_pan = window_panel:panel({
				name = "sssss",			
				visible = true,
				texture = dozers[num],
				layer = 1,
				alpha=1,
				color = Color(1, 1, 1),
				w = 111,
				h = 68,
				x =0,
				y =0
			})
			
			cell_pan:set_bottom(window1:bottom())
			local cell = cell_pan:bitmap({
				name = "sssss",			
				visible = true,
				texture = dozers[num],
				layer = 1,
				alpha=1,
				color = Color(1, 1, 1),
				w = 111,
				h = 68,
				x =0,
				y =0
			})
			cell_pan:set_left(right)
			if num_s > 1 then
				local cell_boost = cell_pan:bitmap({
					name = "sssss",			
					visible = true,
					texture = "safe/boosticon",
					layer = 3,
					alpha=1,
					color = Color(1, 1, 1),
					w = 17,
					h = 17,
					x =0,
					y =0
				})
				cell_boost:set_bottom(cell:bottom())
				cell_boost:set_right(cell:right())
			end
			local text = cell_pan:text({
				y = 0,
				name = "say1",
				align = "left",
				blend_mode = "normal",
				halign = "left",
				x = 3,
				layer = 3,
				text = dozers[num],
				font = tweak_data.menu.pd2_small_font,
				font_size = 15,
				color = Color.white
			})
			text:set_top(cell_pan:bottom()-31)
			
			right=cell_pan:right()
			local avc = {cell_pan, true}
			table.insert(tableCells, avc)						
		end
		local razbros = math.random(-54,54)
		local way = (tableCellsCount-6)*111-30+razbros
		local bul =true
		local cent_x = window1:world_x()
		local cent_y1 = window1:world_center_y()
		local text_xcent = text_line:world_x()
		local text_ycent = text_line:world_y()
		local cent_y = window_panel:center_y()
		window_panel:set_w(0)
		local c1x = tableCells[1][1]:world_x()
		local c1y = tableCells[1][1]:world_y()
		local c2x = tableCells[2][1]:world_x()
		local c2y = tableCells[2][1]:world_y()
		local c3x = tableCells[3][1]:world_x()
		local c3y = tableCells[3][1]:world_y()
		local c4x = tableCells[4][1]:world_x()
		local c4y = tableCells[4][1]:world_y()
		local c5x = tableCells[5][1]:world_x()
		local c5y = tableCells[5][1]:world_y()
		window1:animate(function(o)
		TIM.Active_safe=true
		window_panel:set_visible(true)
			over(0.5, function(p)
				window_panel:set_w(math.lerp(0, 500, p))
				window_panel:set_h(math.lerp(0, 84, p))
				window_panel:set_center_x(TIM.hud.panel:center_x())
				window_panel:set_center_y(cent_y)
				tableCells[1][1]:set_world_x(c1x)
				tableCells[1][1]:set_world_y(c1y)
				tableCells[2][1]:set_world_x(c2x)
				tableCells[2][1]:set_world_y(c2y)
				tableCells[3][1]:set_world_x(c3x)
				tableCells[3][1]:set_world_y(c3y)
				tableCells[4][1]:set_world_x(c4x)
				tableCells[4][1]:set_world_y(c4y)
				tableCells[5][1]:set_world_x(c5x)
				tableCells[5][1]:set_world_y(c5y)
				window1:set_world_center_y(cent_y1)
				window1:set_world_center_x(window_panel:center_x())
			end)
			window1:set_x(0)
			text_line:set_x(3)
			over(0.5,function(p)
				text_line:set_alpha(math.lerp(0,1,p))
			end)
			local timerand = math.random(800,900)
			local temp=way 
			
			local function over1(seconds, f,  fixed_dt)
				local t = 0
				while true do
					local dt = coroutine.yield()
					t = t + (fixed_dt and 0.03333333333333333 or dt)
				
					if seconds <= t then
						break
					end
						--
					f(t / seconds, t)
					if math.abs(-1*way-tableCells[1][1]:center_x())<0.1 then
						
						break
					end
				end
				f(1, seconds)
			end
		over1(timerand,  function(p)
			tableCells[1][1]:set_center_x(math.lerp(tableCells[1][1]:center_x(),-1*way, p))
			for i=2, tableCellsCount, 1 do
				tableCells[i][1]:set_left(tableCells[i-1][1]:right())
				if tableCells[i][1]:left()<window1:center_x() and tableCells[i][2]==true then
					tableCells[i][2]=false
					local sound="sound"
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
					}):set_volume_gain(percentage+0.40)
				end
			end
		end)
		
		for i = 1, 45, 1 do
			gif[i]:set_color(colors[num_spawn])
			gif[i]:set_world_center_x(tableCells[#tableCells-3][1]:world_center_x())
			gif[i]:set_world_center_y(tableCells[#tableCells-3][1]:world_center_y())
			
		end
		local jj ={}
		jj[1] =1
		local function over4(seconds, f,  fixed_dt)
				local t = 0
				while true do
					local dt = coroutine.yield()
					t = t + (fixed_dt and 0.03333333333333333 or dt)
				
					if seconds <= t then
						break
					end
						--
					f(t / seconds, t)
					if jj[1]==45 then
						
						break
					end
				end
				f(1, seconds)
			end
		if num_spawn>=5 then
			managers.player:local_player():sound():say("v21",true,true)
		end
		
		over4(2, function(p)
			if jj[1] <45 then
				gif[jj[1]]:set_visible(true)
				jj[1]=jj[1]+1
				gif[jj[1]]:set_visible(true)
				gif[jj[1]-1]:set_visible(false)
				gif[jj[1]-1]:parent():remove(gif[jj[1]-1]) 
				tableCells[tableCellsCount][1]:set_alpha(math.lerp(tableCells[tableCellsCount][1]:alpha(), 0 ,p))
				
				tableCells[tableCellsCount-1][1]:set_alpha(math.lerp(tableCells[tableCellsCount-1][1]:alpha(), 0 ,p))
				
				tableCells[tableCellsCount-2][1]:set_alpha(math.lerp(tableCells[tableCellsCount-2][1]:alpha(), 0 ,p))
				
				tableCells[tableCellsCount-5][1]:set_alpha(math.lerp(tableCells[tableCellsCount-5][1]:alpha(), 0 ,p))
				tableCells[tableCellsCount-6][1]:set_alpha(math.lerp(tableCells[tableCellsCount-6][1]:alpha(), 0 ,p))
				
				tableCells[tableCellsCount-4][1]:set_alpha(math.lerp(tableCells[tableCellsCount-4][1]:alpha(), 0 ,p))
				window1:set_alpha(math.lerp(window1:alpha(), 0 ,p))
				text_line:set_alpha(math.lerp(text_line:alpha(), 0 ,p))
			end
		end)

		c1x = tableCells[tableCellsCount][1]:world_x()
		c1y = tableCells[tableCellsCount][1]:world_y()
		c2x = tableCells[tableCellsCount-1][1]:world_x()
		c2y = tableCells[tableCellsCount-1][1]:world_y()
		c3x = tableCells[tableCellsCount-2][1]:world_x()
		c3y = tableCells[tableCellsCount-2][1]:world_y()
		c4x = tableCells[tableCellsCount-3][1]:world_x()
		c4y = tableCells[tableCellsCount-3][1]:world_y()
		c5x = tableCells[tableCellsCount-4][1]:world_x()
		c5y = tableCells[tableCellsCount-4][1]:world_y()
		local c6x = tableCells[tableCellsCount-5][1]:world_x()
		local c6y = tableCells[tableCellsCount-5][1]:world_y()
		
		local sound=souns_safe[num_spawn]
		local p = managers.menu_component._main_panel
		local name = "sound"..sound
		if alive(p:child(name)) then
			managers.menu_component._main_panel:remove(p:child(name))
		end
		local volume = managers.user:get_setting("sfx_volume")
		local percentage = (volume - tweak_data.menu.MIN_SFX_VOLUME) / (tweak_data.menu.MAX_SFX_VOLUME - tweak_data.menu.MIN_SFX_VOLUME)
		local vid = window_panel:video({
			name = name,
			video = sound,
			visible = false,
			loop = false,
		}):set_volume_gain(percentage+0.15)
		local old_vol = managers.user:get_setting("music_volume")
		local old_vol2 = managers.user:get_setting("sfx_volume")
		if num_boost>1 then
			local st1=TIM.hud.panel:bitmap({
				name = "sssss",			
				visible = true,
				texture = "safe/statboost1",
				layer = 3,
				alpha=1,
				color = Color(1, 1, 1),
				w = 1,
				h = 1,
				x =0,
				y =200
			})
			local st2=TIM.hud.panel:bitmap({
				name = "sssss",			
				visible = true,
				texture = "safe/statboost2",
				layer = 2,
				alpha=1,
				color = Color(1, 1, 1),
				w = 1,
				h = 1,
				x =0,
				y =200
			})
			local st3=TIM.hud.panel:bitmap({
				name = "sssss",			
				visible = false,
				texture = "safe/statboost3",
				layer = 1,
				alpha=1,
				color = Color(1, 1, 1),
				w = 100,
				h = 100,
				x =0,
				y =200
			})
			local st4=TIM.hud.panel:bitmap({
				name = "sssss",			
				visible = false,
				texture = "safe/statboost4",
				layer = 1,
				alpha=1,
				color = Color(1, 1, 1),
				w = 100,
				h = 100,
				x =0,
				y =200
			})
			local st5=TIM.hud.panel:bitmap({
				name = "sssss",			
				visible = false,
				texture = "safe/statboost5",
				layer = 1,
				alpha=1,
				color = Color(1, 1, 1),
				w = 100,
				h = 100,
				x =0,
				y =200
			})
			local text_b1=TIM.hud.panel:panel({
				name = "sssss",			
				visible = true,
				texture = "safe/statboost5",
				layer = 0,
				alpha=1,
				color = Color(1, 1, 1),
				w = 500,
				h = 200,
				x =0,
				y =200
			})
			local text_b2=TIM.hud.panel:panel({
				name = "sssss",			
				visible = true,
				texture = "safe/statboost5",
				layer = 0,
				alpha=1,
				color = Color(1, 1, 1),
				w = 500,
				h = 200,
				x =0,
				y =200
			})
			--managers.chat:_receive_message(1, "ddd", tostring(1), Color('1565c0'))	
			st1:set_center_x(TIM.hud.panel:center_x())
			st2:set_center_x(TIM.hud.panel:center_x())
			st3:set_center_x(TIM.hud.panel:center_x())
			st4:set_center_x(TIM.hud.panel:center_x())
			st5:set_center_x(TIM.hud.panel:center_x())
			over(0.3, function(p)				
				
				st2:set_w(math.lerp(st2:w(), 100, p))
				st2:set_h(math.lerp(st2:h(), 100, p))
				st2:set_center_x(TIM.hud.panel:center_x())
				st2:set_center_y(250)
			end)
			over(0.3, function(p)
				
				st1:set_w(math.lerp(st1:w(), 100, p))		
				st1:set_h(math.lerp(st1:h(), 100, p))	
				st1:set_center_x(TIM.hud.panel:center_x())
				st1:set_center_y(250)				
			end)
			st3:set_center_y(0)		
			st4:set_center_y(500)	
			st5:set_center_y(500)				
			over(0.3, function(p)
				st3:set_center_x(TIM.hud.panel:center_x())
				st4:set_center_x(math.lerp(TIM.hud.panel:center_x()-100,TIM.hud.panel:center_x(),p))
				st5:set_center_x(math.lerp(TIM.hud.panel:center_x()+100,TIM.hud.panel:center_x(),p))
				st3:set_center_y(math.lerp(0,250,p))
				st4:set_center_y(math.lerp(500,250,p))
				st5:set_center_y(math.lerp(500,250,p))
				st3:set_alpha(math.lerp(0,1,p))
				st4:set_alpha(math.lerp(0,1,p))
				st5:set_alpha(math.lerp(0,1,p))
				st3:set_visible(true)
				st4:set_visible(true)
				st5:set_visible(true)
			end)
			text_b1:set_world_right(st1:world_left()+10)
			text_b2:set_world_left(st1:world_right()-10)
			local tt1 = text_b1:text({
				y = 25,
				name = "say1",
				align = "right",
				blend_mode = "normal",
				alpha = 1,
				x = 210,
				layer = 4,
				text = "STAT BOOST",
				font = tweak_data.menu.pd2_large_font,
				font_size = 40,
				color = Color.white
			})
			local tt2 = text_b2:text({
				y = 25,
				name = "say1",
				align = "left",
				blend_mode = "normal",
				alpha = 1,
				x = -210,
				layer = 4,
				text = stat_boosts[num_boost],
				font = tweak_data.menu.pd2_large_font,
				font_size = 40,
				color = Color.white
			})
			over(0.5, function(p)
				tt1:set_x(math.lerp(210,-10,p))
				tt2:set_x(math.lerp(-210,10,p))
			end)
			wait(1)
			over(0.3, function(p)
				st1:set_alpha(math.lerp(1,0,p))
				st2:set_alpha(math.lerp(1,0,p))
				st3:set_alpha(math.lerp(1,0,p))
				st4:set_alpha(math.lerp(1,0,p))
				st5:set_alpha(math.lerp(1,0,p))
				tt1:set_alpha(math.lerp(1,0,p))
				tt2:set_alpha(math.lerp(1,0,p))
			end)
			st1:parent():remove(st1)
			st2:parent():remove(st2)
			st3:parent():remove(st3)
			st4:parent():remove(st4)
			st5:parent():remove(st5)
			text_b1:parent():remove(text_b1)
			text_b2:parent():remove(text_b2)
		end		
		
		local unit_name = Idstring(dozers_names[num_spawn])	
		local pos, unit_done = TIM:Spawn_unit(unit_name, true)
		local lin = TIM:fon_function()
		if num_boost ~= 5 then
			lin:animate(function(o)
				unit_done:character_damage():set_invulnerable(true)
				unit_done:character_damage():set_immortal(true)
				wait(4)
				unit_done:character_damage():set_invulnerable(false)
				unit_done:character_damage():set_immortal(false)
				lin:parent():remove(lin)
			end)
		end
		stat_boost_functions[num_boost](unit_done)
		local effect_params = {
			sound_event = "hlp_poof_small",
			effect = "safe/"..souns_safe[num_spawn],
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
			over(1, function(p)
				gif[45]:set_alpha(math.lerp(1,0,p))
				tableCells[tableCellsCount-3][1]:set_alpha(math.lerp(1, 0 ,p))
			end)
			gif[45]:parent():remove(gif[45]) 
		over(1, function(p)
			managers.user:set_setting("music_volume", math.lerp(managers.user:get_setting("music_volume"), old_vol/3,p))
			managers.user:set_setting("sfx_volume", math.lerp(managers.user:get_setting("sfx_volume"), old_vol2/3,p))
		end)
		TIM.Active_safe=false
		
		wait(14)
		over(1, function(p)
			managers.user:set_setting("music_volume", math.lerp(managers.user:get_setting("music_volume"), old_vol,p))
			managers.user:set_setting("sfx_volume", math.lerp(managers.user:get_setting("sfx_volume"), old_vol2,p))
			
		end)
			TIM.hud.panel:remove(TIM.hud.panel:child("window_safe"))
		end)		
		managers.player:local_player():sound():say("Play_ban_s02_a",true,true)		
	end
	
	TIM.Reward_functions["tazer"]=function (x)
		local unit_name = Idstring("units/payday2/characters/ene_tazer_1/ene_tazer_1")
		local pos, unit_done = TIM:Spawn_unit(unit_name, true)
		local lin = TIM:fon_function()
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(2)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
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
		managers.player:local_player():sound():say("Play_ban_s01_a",true,true)
	end
	
	TIM.Reward_functions["medic"]=function (x)
		local unit_name = Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870")
		local pos, unit_done = TIM:Spawn_unit(unit_name, true)
		local lin = TIM:fon_function()
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(2)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
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
		managers.player:local_player():sound():say("Play_ban_s05",true,true)
	end
	
	TIM.Reward_functions["shield"]=function (x)
		local unit_name = Idstring("units/pd2_dlc_vip/characters/ene_phalanx_1/ene_phalanx_1")
		local pos, unit_done = TIM:Spawn_unit(unit_name, true)
		local lin = TIM:fon_function()
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(2)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
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
		managers.player:local_player():sound():say("Play_ban_s03_a",true,true)
	end
	TIM.Reward_functions["winters"]=function (x)
		local unit_name = Idstring("units/pd2_dlc_vip/characters/ene_vip_1/ene_vip_1")
		local pos = TIM:Spawn_unit(unit_name, true)
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
		managers.player:local_player():sound():say("cpw_a01",true,true)
	end
	TIM.Reward_functions["headlessdozer"]=function (x)
		managers.player:local_player():sound():say("Play_ban_s02_a",true,true)
		local unit_name = Idstring("units/pd2_dlc_help/characters/ene_zeal_bulldozer_halloween/ene_zeal_bulldozer_halloween")
		local pos, unit_done = TIM:Spawn_unit(unit_name, true)
		local lin = TIM:fon_function()
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(2)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
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
	
	
	TIM.Reward_functions["gas"]=function (x)
		local unit_name = Idstring("units/pd2_dlc_drm/weapons/smoke_grenade_tear_gas/smoke_grenade_tear_gas")
		managers.player:local_player():sound():say("g42x_any",true,true)
		local grenade = World:spawn_unit(unit_name, managers.player:local_player():position(), managers.player:local_player():rotation())
							grenade:base():set_properties({
							radius =  400,
							damage =  2,
							duration = 20
						})
		grenade:base():detonate()
		--TIM:Spawn_unit(unit_name, false)
	end
	
	TIM.Reward_functions["flash"]=function (x)
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

	TIM.Reward_functions["smoke"]=function (x)
		local duration =tweak_data.group_ai.smoke_grenade_lifetime
		managers.groupai:state():detonate_smoke_grenade(managers.player:local_player():position(), managers.player:local_player():position(), duration, false)
		managers.player:local_player():sound():say("l2n_d01",true,true)
	end
	TIM.Reward_functions["grenade"]=function (x)
		local unit_done1 = World:spawn_unit(Idstring("units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade"), managers.player:local_player():position(), managers.player:local_player():rotation())
		managers.player:local_player():sound():say("play_pln_gen_dir_07",true,true)
	end
	TIM.Reward_functions["cuf"]=function (x)
		managers.player:local_player():sound():say("g29",true,true)
		managers.player:set_player_state("arrested")
	end
		
	TIM.Reward_functions["jail"]=function (x)
		managers.player:local_player():sound():say("g29",true,true)

		if TIM.Active_timer_jail == false then
			TIM.Active_timer_jail = true
			local unit_name = Idstring("units/payday2/architecture/bnk/bnk_int_fence_wall")
			local unit_done1 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 100, 0), Rotation(0,0,0))
			local unit_done2 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(-100, -100, 0), Rotation(180,0,0))
			local unit_done3 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 100, 0), Rotation(90,0,0))
			local unit_done4 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(-100, -100, 0), Rotation(270,0,0))
			local unit_done5 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 150, 0), Rotation(0,90,0))
			local unit_done6 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 150, 300), Rotation(0,90,0))
			local lin = TIM:fon_function()
			lin:animate(function(o)
			TIM.Timers.timer_jail = TIM.Timers.timer_jail + 1
			while TIM.Timers.timer_jail>0 do
				TIM.Timers.timer_jail = TIM.Timers.timer_jail - 1
				wait(TIM.Timers_max.timer_jail)
			end
			
			TIM.Active_timer_jail= false
			managers.player:local_player():sound():say("g13",true,true)
			unit_done1:set_slot(0)
			unit_done2:set_slot(0)
			unit_done3:set_slot(0)
			unit_done4:set_slot(0)	
			unit_done5:set_slot(0)	
			unit_done6:set_slot(0)	
			lin:parent():remove(lin)
		end)						
		else
			TIM.Timers.timer_jail = TIM.Timers.timer_jail + 1
		end	
	end
	
	TIM.Reward_functions["fov"]=function (x)
		managers.player:local_player():sound():say("g60",true,true)
		local old = managers.user:get_setting("fov_multiplier")
		if TIM.Active_timer_fov ==false then
			TIM.Active_timer_fov =true
			local lin = TIM:fon_function()
			lin:animate(function(o)
				
				 over(1, function(p)
					managers.user:set_setting("fov_multiplier", math.lerp(managers.user:get_setting("fov_multiplier"), 1, p))
					if alive(managers.player:player_unit()) then
						managers.player:player_unit():movement():current_state():update_fov_external()
					end
				end)
				TIM.Timers.timer_fov =TIM.Timers.timer_fov+1
				while TIM.Timers.timer_fov>0 do
					TIM.Timers.timer_fov=TIM.Timers.timer_fov-1
					wait(TIM.Timers_max.timer_fov)
				end
				over(1, function(p)
					managers.user:set_setting("fov_multiplier", math.lerp(managers.user:get_setting("fov_multiplier"), old, p))
					if alive(managers.player:player_unit()) then
						managers.player:player_unit():movement():current_state():update_fov_external()
					end
				end)
				TIM.Active_timer_fov=false
				lin:parent():remove(lin)
			end)
		else
			TIM.Timers.timer_fov=TIM.Timers.timer_fov+1
		end	
	end
	TIM.Reward_functions["hit"]=function (x)
		managers.player:local_player():sound():say("g60",true,true)
		
		if TIM.Active_timer_hit ==false then
			TIM.Active_timer_hit=true
			local lin1 = TIM.hud.panel:bitmap({
				name = "sssss",			
				visible = false,
				texture = "guis/textures/icons/ammo",
				layer = 0,
				alpha=0,
				color = Color(1, 1, 1),
				w = 130,
				h = 130,
				blend_mode = "add",
				x =0,
				y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
			})
			lin1:animate(function(o)
				TIM.Timers.timer_hit=TIM.Timers.timer_hit+1
				managers.user:set_setting("hit_indicator", false)
				while TIM.Timers.timer_hit>0 do
					TIM.Timers.timer_hit = TIM.Timers.timer_hit - 1 					
					wait(TIM.Timers_max.timer_hit)					
				end
				managers.user:set_setting("hit_indicator", true)
				TIM.Active_timer_hit = false
				lin1:parent():remove(lin1)
			end)
		else
			TIM.Timers.timer_hit = TIM.Timers.timer_hit + 1
		end	
	end
	TIM.Reward_functions["heal"]=function (x)
		local player_unit = managers.player:player_unit()
		--player:sound():play("pickup_ammo_health_boost", nil, true)
		--local unit_name
		--unit_name = Idstring("units/pickups/ammo/ammo_pickup")
		--local unit_done = World:spawn_unit( unit_name, player:position(), player:rotation())
		--player_unit:character_damage():_regenerate_armor()
		player_unit:character_damage():restore_health(0.03)
		
		--while(hud.panel:child("gggg")) do
		--	hud.panel:remove(hud.panel:child("gggg"))
		--end
		local sound="heal_sound"
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
			texture = "guis/textures/icons/heal",
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
			texture = "guis/textures/icons/heal",
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
			texture = "guis/textures/icons/heal",
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
			texture = "guis/textures/icons/heal",
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
			texture = "guis/textures/icons/heal",
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
	TIM.Reward_functions["ammo"]=function (x)
		local line_one_word1 = TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "guis/textures/icons/ammo",
			layer = 0,
			alpha=0,
			color = Color(1, 1, 1),
			w = 130,
			h = 130,
			blend_mode = "add",
			x =0,
			y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
		})
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
			--local tema = managers.player:player_unit(peer)
			--managers.chat:_receive_message(1, "ddd", tostring(peer:ip()), Color('1565c0'))
			--pp:character_damage():restore_health(10, true)	
			if pp then
				local unit_done = World:spawn_unit(Idstring("units/pickups/ammo/ammo_pickup"), pp:position(), pp:rotation())
			end
		end
		
		--local unit_name11
		--unit_name11 = Idstring("units/pickups/ammo/ammo_pickup")
		--local unit_done = World:spawn_unit( unit_name11, managers.player:local_player():position(), managers.player:local_player():rotation())
		
		
		local sound="ammo_sound"
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
	TIM.Reward_functions["sniper"]=function (x)
		local unit_name = Idstring("units/pd2_dlc_drm/characters/ene_zeal_swat_heavy_sniper/ene_zeal_swat_heavy_sniper")
		local pos, unit_done = TIM:Spawn_unit(unit_name, true)
		local lin = TIM:fon_function()
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(2)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
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
		managers.player:local_player():sound():say("play_pln_gen_snip_01",true,true)
	end
	
	TIM.Reward_functions["nosound"]=function (x)
		managers.player:local_player():sound():say("g60",true,true)
		
		if TIM.Active_timer_nosound == false then
			TIM.Active_timer_nosound=true
			local lin1 = TIM:fon_function()
			lin1:animate(function(o)
				TIM.Timers.timer_nosound=TIM.Timers.timer_nosound+1
				SoundDevice:set_rtpc("downed_state_progression", 60)
				while TIM.Timers.timer_nosound>0 do
					TIM.Timers.timer_nosound = TIM.Timers.timer_nosound - 1 					
					wait(TIM.Timers_max.timer_nosound)					
				end
				SoundDevice:set_rtpc("downed_state_progression", 0)
				TIM.Active_timer_nosound = false
				lin1:parent():remove(lin1)
			end)
		else
			TIM.Timers.timer_nosound = TIM.Timers.timer_nosound + 1
		end	
		
	end
	
	TIM.Reward_functions["blur"]=function (x)
		managers.player:local_player():sound():say("g60",true,true)
		
		if TIM.Active_timer_blur == false then
			TIM.Active_timer_blur=true
			local lin1 = TIM:fon_function()
			lin1:animate(function(o)
				TIM.Timers.timer_blur=TIM.Timers.timer_blur+1
				managers.environment_controller:set_downed_value(50)
				while TIM.Timers.timer_blur>0 do
					TIM.Timers.timer_blur = TIM.Timers.timer_blur - 1 					
					wait(TIM.Timers_max.timer_blur)					
				end
				managers.environment_controller:set_downed_value(0)
				TIM.Active_timer_blur = false
				lin1:parent():remove(lin1)
			end)
		else
			TIM.Timers.timer_blur = TIM.Timers.timer_blur + 1
		end	
		
		
	end
	
	TIM.Reward_functions["fps_30"]=function (x)
		managers.player:local_player():sound():say("g60",true,true)
		
		if TIM.Active_timer_fps == false then
			TIM.Active_timer_fps=true
			local lin1 = TIM:fon_function()
			lin1:animate(function(o)
				TIM.Timers.timer_fps=TIM.Timers.timer_fps+1
				managers.user:set_setting("fps_cap", 30)
				while TIM.Timers.timer_fps>0 do
					TIM.Timers.timer_fps = TIM.Timers.timer_fps - 1 					
					wait(TIM.Timers_max.timer_fps)					
				end
				managers.user:set_setting("fps_cap", 60)
				TIM.Active_timer_fps = false
				lin1:parent():remove(lin1)
			end)
		else
			TIM.Timers.timer_fps = TIM.Timers.timer_fps + 1
		end	
		
	end
	
	TIM.Reward_functions["effectsafe"]=function (x)
	
	end
	--local file, err = io.open("mods/TwitchIntegrationMod/Bot/Spawn/mes1.txt", "w")
	--file:write("fuck3")
	--file:close()

end

function TIM:Spawn_unit(unit_name, bool) -- true - enemy, false - TIMect 
	local player_pos = managers.player:local_player():position()
	local unit_done
	local Aim_Pos = Utils:GetPlayerAimPos(managers.player:local_player(), 10000)
	if bool == true then
	if tostring(Aim_Pos):find("Vector3") then
		local Aim_x = Aim_Pos.x
		local Aim_y = Aim_Pos.y
		local player_z = managers.player:local_player():position().z
		local player_x = managers.player:local_player():position().x 
		local player_y = managers.player:local_player():position().y
		local summ = 1.01
		
		if(player_x > Aim_x) then
			summ = player_x - Aim_x
	
			if( summ > 300) then	
				player_pos = player_pos + Vector3(-300, 0, 0)
			else
				summ = (summ - 30) * -1
				player_pos = player_pos + Vector3(summ, 0, 0)
			end
		else
			summ = Aim_x - player_x
			if(summ > 300) then	
				player_pos = player_pos + Vector3(300, 0, 0)
			else
				summ = summ - 30
				player_pos = player_pos + Vector3(summ, 0, 0)
			end
		end
	
		if(player_y > Aim_y) then
			summ = player_y - Aim_y
			if(summ > 300) then	
				player_pos = player_pos + Vector3(0, -300, 0)
			else
				summ = (summ - 30) * -1
				player_pos = player_pos + Vector3(0, summ, 0)
			end
		else
			summ = Aim_y - player_y
			if(summ > 300) then	
				player_pos = player_pos + Vector3(0, 300, 0)
			else
				summ = summ - 30
				player_pos = player_pos + Vector3(0, summ, 0)
			end
		end
		unit_done = World:spawn_unit( unit_name, player_pos, Rotation(managers.player:local_player():camera():rotation():yaw()-180, 0, 0) )
		local team_id = tweak_data.levels:get_default_team_ID( unit_done:base():char_tweak().access == "gangster" and "gangster" or "combatant" )
		unit_done:movement():set_team( TIM.AIState:team_data( team_id ) )	
	else
		player_pos = managers.player:local_player():position()
		unit_done = World:spawn_unit( unit_name, player_pos, Rotation(managers.player:local_player():camera():rotation():yaw()-180, 0, 0) )
		local team_id = tweak_data.levels:get_default_team_ID( unit_done:base():char_tweak().access == "gangster" and "gangster" or "combatant" )
		unit_done:movement():set_team( TIM.AIState:team_data( team_id ) )
	end
	else
		player_pos = managers.player:local_player():position()
		unit_done = World:spawn_unit( unit_name, player_pos, Rotation(managers.player:local_player():camera():rotation():yaw()-180, 0, 0) )
		--local team_id = tweak_data.levels:get_default_team_ID( unit_done:base():char_tweak().access == "gangster" and "gangster" or "combatant" )
		--unit_done:movement():set_team( AIState:team_data( team_id ) )
	end
	return player_pos, unit_done
end



function TIM:Take_word_from_file()

	if TIM.Active_safe == false and managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("point_of_no_return_panel"):visible()==false then
		local lines_all = {"1"}
		--local i = 1
		local file, err = io.open("mods/TwitchIntegrationMod/Bot/Spawn/mess.txt", "r")
		local line1 = file:read()
		line1=tostring(line1)
		
		file:close()
		if line1~="nil" then
		
			for line in io.lines("mods/TwitchIntegrationMod/Bot/Spawn/mess.txt") do
				lines_all[#lines_all+1] = tostring(line)
			end
			--managers.chat:_receive_message(1, "ddd", tostring(lines_all[2]).." readed1", Color('1565c0'))
			local file1, err = io.open("mods/TwitchIntegrationMod/Bot/Spawn/mess.txt", "w")
			--for i=3, #lines_all, 1 do
			while file1 == nil do
				file1, err = io.open("mods/TwitchIntegrationMod/Bot/Spawn/mess.txt", "w")
			end
				file1:write(table.concat(lines_all, "\n",3))
			--end
			file1:close()
			--return 
			TIM:Redeem_reward(tostring(lines_all[2]))
		end
	end
end

function TIM:fon_function()
	local lin = TIM.hud.panel:bitmap({
		name = "sssss",			
		visible = false,
		texture = "guis/textures/icons/ammo",
		layer = 0,
		alpha=0,
		color = Color(1, 1, 1),
		w = 130,
		h = 130,
		blend_mode = "add",
		x =0,
		y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
	})
	return lin
end

function TIM:Redeem_reward(word)
	while not Utils:IsInHeist() == true do
		wait(3)
	end
	while not Utils:IsInCustody() == false do
		wait(3)
	end
	--managers.chat:_receive_message(1, "ddd", "1", Color('1565c0'))
	--managers.chat:_receive_message(1, "ddd", tostring(word), Color('1565c0'))
	if  TIM.Reward_names[word] == "1" then
		--managers.chat:_receive_message(1, "ddd", "2", Color('1565c0'))
		
		--managers.chat:_receive_message(1, "ddd", "3", Color('1565c0'))
		TIM.Reward_functions[word]()
--		managers.chat:_receive_message(1, "ddd", "4", Color('1565c0'))
	end
	
	
end

function TIM:CreateSafe(points, names, names_paths, stat_boosts_points, stat_boosts_names, stat_boost_functions)
	local num_spawn = 1
	local num_boost = 1
	local window_panel = TIM.hud.panel:panel({
		name = "window_safe",			
		visible = false,
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1, 1),
		w = 500,
		h = 84,
		x =0,
		y =100
	})
	window_panel:set_center_x(TIM.hud.panel:center_x())
	local window1 = window_panel:bitmap({
		name = "sssss",			
		visible = true,
		texture = "line",
		layer = 3,
		alpha=1,
		color = Color(1, 1, 1, 1),
		w = 500,
		h = 84,
		x =0,
		y =0
	})
	local text_line = window_panel:text({
		y = 0,
		name = "say1",
		align = "left",
		blend_mode = "normal",
		alpha = 0,
		x = 3,
		layer = 4,
		text = "Opening Dozer Safe",
		font = tweak_data.menu.pd2_small_font,
		font_size = 15,
		color = Color.black
	})
	local tableCellsCount = math.random(40,50)
	local right = 0
	local tableCells={}
	
	local gif = {}
	for i = 1, 45, 1 do
		local image = TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "animation/Cadr "..tostring(i),
			layer = 5,
			alpha=1,
			color = Color(1, 1, 1),
			w = 245,
			h = 150,
			x =0,
			y =0
		})
		table.insert(gif, image)
	end
	for i=1, tableCellsCount, 1 do
		
		local summ_d = 0	
		local summ_prev_d = 0
		local num = 1
		local dn = math.random(summ_all_dozers)
		for i=1, #dozers_points do
			summ_prev_d = summ_d
			summ_d=summ_d+dozers_points[i]
			if dn<=summ_d and dn>summ_prev_d then
				num = i
				break
			end
		end
		local summ_s = 0	
		local summ_prev_s = 0
		local num_s = 1
		local sn = math.random(summ_all_boosts)
		for i=1, #stat_boosts_points do
			summ_prev_s = summ_s
			summ_s=summ_s+stat_boosts_points[i]
			if sn<=summ_s and sn>summ_prev_s then
				num_s = i
				break
			end
		end
	
		if i==tableCellsCount-3 then
			num_spawn=num
			num_boost=num_s
		end
		local cell_pan = window_panel:panel({
			name = "sssss",			
			visible = true,
			texture = dozers[num],
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 111,
			h = 68,
			x =0,
			y =0
		})
		
		cell_pan:set_bottom(window1:bottom())
		local cell = cell_pan:bitmap({
			name = "sssss",			
			visible = true,
			texture = dozers[num],
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 111,
			h = 68,
			x =0,
			y =0
		})
		cell_pan:set_left(right)
		if num_s > 1 then
			local cell_boost = cell_pan:bitmap({
				name = "sssss",			
				visible = true,
				texture = "safe/boosticon",
				layer = 3,
				alpha=1,
				color = Color(1, 1, 1),
				w = 17,
				h = 17,
				x =0,
				y =0
			})
			cell_boost:set_bottom(cell:bottom())
			cell_boost:set_right(cell:right())
		end
		local text = cell_pan:text({
			y = 0,
			name = "say1",
			align = "left",
			blend_mode = "normal",
			halign = "left",
			x = 3,
			layer = 3,
			text = dozers[num],
			font = tweak_data.menu.pd2_small_font,
			font_size = 15,
			color = Color.white
		})
		text:set_top(cell_pan:bottom()-31)
		
		right=cell_pan:right()
		local avc = {cell_pan, true}
		table.insert(tableCells, avc)						
	end
	local razbros = math.random(-54,54)
	local way = (tableCellsCount-6)*111-30+razbros
	local bul =true
	local cent_x = window1:world_x()
	local cent_y1 = window1:world_center_y()
	
	local cent_y = window_panel:center_y()
	window_panel:set_w(0)
	local c1x = tableCells[1][1]:world_x()
	local c1y = tableCells[1][1]:world_y()
	local c2x = tableCells[2][1]:world_x()
	local c2y = tableCells[2][1]:world_y()
	local c3x = tableCells[3][1]:world_x()
	local c3y = tableCells[3][1]:world_y()
	local c4x = tableCells[4][1]:world_x()
	local c4y = tableCells[4][1]:world_y()
	local c5x = tableCells[5][1]:world_x()
	local c5y = tableCells[5][1]:world_y()
	window1:animate(function(o)
	TIM.Active_safe=true
	window_panel:set_visible(true)
		over(0.5, function(p)
			window_panel:set_w(math.lerp(0, 500, p))
			window_panel:set_h(math.lerp(0, 84, p))
			window_panel:set_center_x(TIM.hud.panel:center_x())
			window_panel:set_center_y(cent_y)
			tableCells[1][1]:set_world_x(c1x)
			tableCells[1][1]:set_world_y(c1y)
			tableCells[2][1]:set_world_x(c2x)
			tableCells[2][1]:set_world_y(c2y)
			tableCells[3][1]:set_world_x(c3x)
			tableCells[3][1]:set_world_y(c3y)
			tableCells[4][1]:set_world_x(c4x)
			tableCells[4][1]:set_world_y(c4y)
			tableCells[5][1]:set_world_x(c5x)
			tableCells[5][1]:set_world_y(c5y)
			window1:set_world_center_y(cent_y1)
			window1:set_world_center_x(window_panel:center_x())
		end)
		window1:set_x(0)
		text_line:set_x(3)
		over(0.5,function(p)
			text_line:set_alpha(math.lerp(0,1,p))
		end)
		local timerand = math.random(800,900)
		local temp=way 
		
		local function over1(seconds, f,  fixed_dt)
			local t = 0
			while true do
				local dt = coroutine.yield()
				t = t + (fixed_dt and 0.03333333333333333 or dt)
			
				if seconds <= t then
					break
				end
					--
				f(t / seconds, t)
				if math.abs(-1*way-tableCells[1][1]:center_x())<0.1 then
					
					break
				end
			end
			f(1, seconds)
		end
	over1(timerand,  function(p)
		tableCells[1][1]:set_center_x(math.lerp(tableCells[1][1]:center_x(),-1*way, p))
		for i=2, tableCellsCount, 1 do
			tableCells[i][1]:set_left(tableCells[i-1][1]:right())
			if tableCells[i][1]:left()<window1:center_x() and tableCells[i][2]==true then
				tableCells[i][2]=false
				local sound="sound"
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
				}):set_volume_gain(percentage+0.40)
			end
		end
	end)
	
	for i = 1, 45, 1 do
		gif[i]:set_color(colors[num_spawn])
		gif[i]:set_world_center_x(tableCells[#tableCells-3][1]:world_center_x())
		gif[i]:set_world_center_y(tableCells[#tableCells-3][1]:world_center_y())
		
	end
	local jj ={}
	jj[1] =1
	local function over4(seconds, f,  fixed_dt)
			local t = 0
			while true do
				local dt = coroutine.yield()
				t = t + (fixed_dt and 0.03333333333333333 or dt)
			
				if seconds <= t then
					break
				end
					--
				f(t / seconds, t)
				if jj[1]==45 then
					
					break
				end
			end
			f(1, seconds)
		end
	if num_spawn>=5 then
		managers.player:local_player():sound():say("v21",true,true)
	end
	
	over4(2, function(p)
		if jj[1] <45 then
			gif[jj[1]]:set_visible(true)
			jj[1]=jj[1]+1
			gif[jj[1]]:set_visible(true)
			gif[jj[1]-1]:set_visible(false)
			gif[jj[1]-1]:parent():remove(gif[jj[1]-1]) 
			tableCells[tableCellsCount][1]:set_alpha(math.lerp(tableCells[tableCellsCount][1]:alpha(), 0 ,p))
			
			tableCells[tableCellsCount-1][1]:set_alpha(math.lerp(tableCells[tableCellsCount-1][1]:alpha(), 0 ,p))
			
			tableCells[tableCellsCount-2][1]:set_alpha(math.lerp(tableCells[tableCellsCount-2][1]:alpha(), 0 ,p))
			
			tableCells[tableCellsCount-5][1]:set_alpha(math.lerp(tableCells[tableCellsCount-5][1]:alpha(), 0 ,p))
			tableCells[tableCellsCount-6][1]:set_alpha(math.lerp(tableCells[tableCellsCount-6][1]:alpha(), 0 ,p))
			
			tableCells[tableCellsCount-4][1]:set_alpha(math.lerp(tableCells[tableCellsCount-4][1]:alpha(), 0 ,p))
			window1:set_alpha(math.lerp(window1:alpha(), 0 ,p))
			text_line:set_alpha(math.lerp(text_line:alpha(), 0 ,p))
		end
	end)
    
	c1x = tableCells[tableCellsCount][1]:world_x()
	c1y = tableCells[tableCellsCount][1]:world_y()
	c2x = tableCells[tableCellsCount-1][1]:world_x()
	c2y = tableCells[tableCellsCount-1][1]:world_y()
	c3x = tableCells[tableCellsCount-2][1]:world_x()
	c3y = tableCells[tableCellsCount-2][1]:world_y()
	c4x = tableCells[tableCellsCount-3][1]:world_x()
	c4y = tableCells[tableCellsCount-3][1]:world_y()
	c5x = tableCells[tableCellsCount-4][1]:world_x()
	c5y = tableCells[tableCellsCount-4][1]:world_y()
	local c6x = tableCells[tableCellsCount-5][1]:world_x()
	local c6y = tableCells[tableCellsCount-5][1]:world_y()
	
	local sound=souns_safe[num_spawn]
	local p = managers.menu_component._main_panel
	local name = "sound"..sound
	if alive(p:child(name)) then
		managers.menu_component._main_panel:remove(p:child(name))
	end
	local volume = managers.user:get_setting("sfx_volume")
	local percentage = (volume - tweak_data.menu.MIN_SFX_VOLUME) / (tweak_data.menu.MAX_SFX_VOLUME - tweak_data.menu.MIN_SFX_VOLUME)
	local vid = window_panel:video({
		name = name,
		video = sound,
		visible = false,
		loop = false,
	}):set_volume_gain(percentage+0.15)
	local old_vol = managers.user:get_setting("music_volume")
	local old_vol2 = managers.user:get_setting("sfx_volume")
	if num_boost>1 then
		local st1=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "safe/statboost1",
			layer = 3,
			alpha=1,
			color = Color(1, 1, 1),
			w = 1,
			h = 1,
			x =0,
			y =200
		})
		local st2=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "safe/statboost2",
			layer = 2,
			alpha=1,
			color = Color(1, 1, 1),
			w = 1,
			h = 1,
			x =0,
			y =200
		})
		local st3=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "safe/statboost3",
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 100,
			h = 100,
			x =0,
			y =200
		})
		local st4=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "safe/statboost4",
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 100,
			h = 100,
			x =0,
			y =200
		})
		local st5=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "safe/statboost5",
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 100,
			h = 100,
			x =0,
			y =200
		})
		local text_b1=TIM.hud.panel:panel({
			name = "sssss",			
			visible = true,
			texture = "safe/statboost5",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = 500,
			h = 200,
			x =0,
			y =200
		})
		local text_b2=TIM.hud.panel:panel({
			name = "sssss",			
			visible = true,
			texture = "safe/statboost5",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = 500,
			h = 200,
			x =0,
			y =200
		})
		--managers.chat:_receive_message(1, "ddd", tostring(1), Color('1565c0'))	
		st1:set_center_x(TIM.hud.panel:center_x())
		st2:set_center_x(TIM.hud.panel:center_x())
		st3:set_center_x(TIM.hud.panel:center_x())
		st4:set_center_x(TIM.hud.panel:center_x())
		st5:set_center_x(TIM.hud.panel:center_x())
		over(0.3, function(p)				
			
			st2:set_w(math.lerp(st2:w(), 100, p))
			st2:set_h(math.lerp(st2:h(), 100, p))
			st2:set_center_x(TIM.hud.panel:center_x())
			st2:set_center_y(250)
		end)
		over(0.3, function(p)
			
			st1:set_w(math.lerp(st1:w(), 100, p))		
			st1:set_h(math.lerp(st1:h(), 100, p))	
			st1:set_center_x(TIM.hud.panel:center_x())
			st1:set_center_y(250)				
		end)
		st3:set_center_y(0)		
		st4:set_center_y(500)	
		st5:set_center_y(500)				
		over(0.3, function(p)
			st3:set_center_x(TIM.hud.panel:center_x())
			st4:set_center_x(math.lerp(TIM.hud.panel:center_x()-100,TIM.hud.panel:center_x(),p))
			st5:set_center_x(math.lerp(TIM.hud.panel:center_x()+100,TIM.hud.panel:center_x(),p))
			st3:set_center_y(math.lerp(0,250,p))
			st4:set_center_y(math.lerp(500,250,p))
			st5:set_center_y(math.lerp(500,250,p))
			st3:set_alpha(math.lerp(0,1,p))
			st4:set_alpha(math.lerp(0,1,p))
			st5:set_alpha(math.lerp(0,1,p))
			st3:set_visible(true)
			st4:set_visible(true)
			st5:set_visible(true)
		end)
		text_b1:set_world_right(st1:world_left()+10)
		text_b2:set_world_left(st1:world_right()-10)
		local tt1 = text_b1:text({
			y = 25,
			name = "say1",
			align = "right",
			blend_mode = "normal",
			alpha = 1,
			x = 210,
			layer = 4,
			text = "STAT BOOST",
			font = tweak_data.menu.pd2_large_font,
			font_size = 40,
			color = Color.white
		})
		local tt2 = text_b2:text({
			y = 25,
			name = "say1",
			align = "left",
			blend_mode = "normal",
			alpha = 1,
			x = -210,
			layer = 4,
			text = stat_boosts[num_boost],
			font = tweak_data.menu.pd2_large_font,
			font_size = 40,
			color = Color.white
		})
		over(0.5, function(p)
			tt1:set_x(math.lerp(210,-10,p))
			tt2:set_x(math.lerp(-210,10,p))
		end)
		wait(1)
		over(0.3, function(p)
			st1:set_alpha(math.lerp(1,0,p))
			st2:set_alpha(math.lerp(1,0,p))
			st3:set_alpha(math.lerp(1,0,p))
			st4:set_alpha(math.lerp(1,0,p))
			st5:set_alpha(math.lerp(1,0,p))
			tt1:set_alpha(math.lerp(1,0,p))
			tt2:set_alpha(math.lerp(1,0,p))
		end)
		st1:parent():remove(st1)
		st2:parent():remove(st2)
		st3:parent():remove(st3)
		st4:parent():remove(st4)
		st5:parent():remove(st5)
		text_b1:parent():remove(text_b1)
		text_b2:parent():remove(text_b2)
	end		
	
	local unit_name = Idstring(dozers_names[num_spawn])	
	local pos, unit_done = TIM:Spawn_unit(unit_name, true)
	local lin = TIM:fon_function()
	if num_boost ~= 5 then
		lin:animate(function(o)
			unit_done:character_damage():set_invulnerable(true)
			unit_done:character_damage():set_immortal(true)
			wait(4)
			unit_done:character_damage():set_invulnerable(false)
			unit_done:character_damage():set_immortal(false)
			lin:parent():remove(lin)
		end)
	end
	stat_boost_functions[num_boost](unit_done)
	local effect_params = {
		sound_event = "hlp_poof_small",
		effect = "safe/"..souns_safe[num_spawn],
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
		over(1, function(p)
			gif[45]:set_alpha(math.lerp(1,0,p))
			tableCells[tableCellsCount-3][1]:set_alpha(math.lerp(1, 0 ,p))
		end)
		gif[45]:parent():remove(gif[45]) 
	over(1, function(p)
		managers.user:set_setting("music_volume", math.lerp(managers.user:get_setting("music_volume"), old_vol/3,p))
		managers.user:set_setting("sfx_volume", math.lerp(managers.user:get_setting("sfx_volume"), old_vol2/3,p))
	end)
	TIM.Active_safe=false
	
	wait(14)
	over(1, function(p)
		managers.user:set_setting("music_volume", math.lerp(managers.user:get_setting("music_volume"), old_vol,p))
		managers.user:set_setting("sfx_volume", math.lerp(managers.user:get_setting("sfx_volume"), old_vol2,p))
		
	end)
		TIM.hud.panel:remove(TIM.hud.panel:child("window_safe"))
	end)		
	managers.player:local_player():sound():say("Play_ban_s02_a",true,true)		
	
	
	
	

end


function TIM:ShowMenu(menu, opened)
	TIM._holder:ClearItems()
	TIM._dialog:ClearItems()
	TIM._dialog:SetVisible(false)
	--TIM._holder:SetPosition("Center")

	if opened then
		if managers.player:player_unit() then
			game_state_machine:current_state():set_controller_enabled(false)
		end
		local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/user.txt", "r")
		local line1 = file:read()
		local twitch_nickname = tostring(line1)
		file:close()
		
		file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/settings.txt", "r")
		line1 = file:read()
		
		local chat_enable = tostring(line1)
		line1 = file:read()
		local points_comm = tostring(line1)
		
		file:close()
        TIM._holder:SetText("Twitch Integration Mod")

		TIM._dialog:Divider({
			name = "Divider",
			text_align = "center",
			text = "Warning!"
		})
		TIM._dialog:Divider({
			name = "Divider",
			text = "Twitch bot is working right now. To apply the settings you need to restart the bot. Restart?"
		})
		TIM._dialog:Button({
			name = "Yes",
			text = "OK",
			text_align = "center",
			w=100,
			on_callback = function(item)
				TIM._dialog:SetVisible(false)
				--TIM._dialog:ClearItems()
			end
		})
		TIM._dialog:Button({
			name = "NO",
			text = "Cancel",
			text_align = "center",
			w=100,
			on_callback = function(item)
				TIM._dialog:SetVisible(false)
				--TIM._dialog:ClearItems()
			end
		})
		
       --[[ TIM._holder:Button({
            name = "Reset",
            on_callback = function()
                managers.chat:_receive_message(1, "ddd", tostring(1), Color('1565c0'))
            end
        })
		]]
		TIM._holder:Image({
			name = "MyImageButton",
			texture = "guis/textures/icons/twch",
			w=80,
			h=80
		})
		
		local pann = TIM._holder:DivGroup({
			name = "2ndMenu",
			text = "Settings",
			w=290,
			--text_align = "center",
			align_method = "grid" 
		})
		pann:TextBox({
			name = "MyTextBox",
			w=280,
			text = "Twitch Nickname",
			value = twitch_nickname,
			on_callback = function(item)
				managers.chat:_receive_message(1, "ddd", tostring(2	), Color('1565c0'))
			end
		})
		pann:Toggle({
			name = "ActivateChat",
			text = "Twitch Chat in game",
			value=true,
			w=280
		})
	
		pann:Toggle({
			name = "Rewards",
			text = "Channel Points",
			value = true,
			w=120,
			on_callback = function(item)
				if pann:GetItem("Rewards"):Value()==false then
					pann:GetItem("Commands"):SetValue(true)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Commands")
					--TIM._holder:RemoveItem("Rewards/Commands")
				else
					pann:GetItem("Commands"):SetValue(false)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Channel Points Rewards")
				end
			end
		})
		
		pann:Toggle({
			name = "Commands",
			text = "Chat Commands",
			value = false,
			w=120,
			on_callback = function(item)
				if pann:GetItem("Commands"):Value()==false then
					pann:GetItem("Rewards"):SetValue(true)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Channel Points Rewards")
				else
					pann:GetItem("Rewards"):SetValue(false)
					TIM._holder:GetItem("Rewards/Commands"):SetText("Commands")
				end
			end
		})
	
		
		if chat_enable=="false" then
			pann:GetItem("ActivateChat"):SetValue(false)
		end
		
		if points_comm=="true" then
			pann:GetItem("Commands"):SetValue(false)
			pann:GetItem("Rewards"):SetValue(true)
		else
			pann:GetItem("Commands"):SetValue(true)
			pann:GetItem("Rewards"):SetValue(false)
		end
		TIM._holder:Button({
			name = "MyButton",
			text = "START / RESTART BOT",
			text_align = "center",
			w=150,
			on_callback = function(item)
				--
				--dofile("mods/TwitchIntegrationMod/Bot/BotTwitch.exe")
				os.execute("taskkill /IM BotTwitch.exe /F")
				os.execute("start mods/TwitchIntegrationMod/Bot/BotTwitch.exe")
				bot_working = true
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /TOP")
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /MAX")
			end
		})
		TIM._holder:Button({
			name = "MyButton",
			text = "SAVE SETTINGS",
			text_align = "center",
			w=150,
			on_callback = function(item)
				--
				if bot_working == true then
					TIM._dialog:SetVisible(true)
				end
				local lines_all = { }
				for i=1, #TIM._panel_Toggles, 1 do
					if TIM._panel_Toggles[i]:Value() == true then
						local obj = TIM._holder:GetItem(TIM._panel_Toggles[i]:Name().."_gr")
						lines_all[#lines_all+1] = obj:GetItem("Reward_name_on_Twitch"):Value().."|#"..TIM._panel_Toggles[i]:Name()
						--local timers = { }
						
						
						if obj:Name() == "jail_gr" or obj:Name() == "black_gr" or obj:Name() == "speed_gr" or obj:Name() == "fov_gr" or obj:Name() == "hit_gr" then							
							TIM.Timers_max["timer_"..TIM._panel_Toggles[i]:Name()]= obj:GetItem("MyNumberBox"):Value()
						elseif obj:Name() == "heal_gr" then
							TIM.Heal_perc = obj:GetItem("MyNumberBox"):Value()
						else
							local ob = obj:GetItem("MyNumberBox")
							
							if ob then
								local numb = ob:Value()
								for j = 1, numb, 1 do
									lines_all[#lines_all] = lines_all[#lines_all].."#"..TIM._panel_Toggles[i]:Name()
								end
							end
						end
						
						local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config.txt", "w")
						file:write(table.concat(lines_all, "\n"))
						file:close()
						
						file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config_parametres.txt", "w")
						file:write(TIM.Timers_max.timer_jail.."#"..TIM.Timers_max.timer_hit.."#"..TIM.Timers_max.timer_fov.."#"..TIM.Timers_max.timer_speed.."#"..TIM.Timers_max.timer_black.."#"..TIM.Heal_perc)
						file:close()
					end
				end
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /TOP")
				--os.execute("cmdow.exe payday2_win32_release.exe /ACT /MAX")
			end
		})
		TIM._panel = TIM._holder:Group({
			name = "Rewards/Commands",
			text = "Channel Points Rewards",
			color = TIM._holder.accent_color, 
			size = 18, 
			align_method = "grid" 
			--inherit_values = {text_align = "center"}	
		})
		TIM._panel_Toggles = {}
		for i = 1, #TIM.RewardNames, 1 do
			TIM._panel_Toggles[#TIM._panel_Toggles+1] = TIM._panel:Toggle({
				name = TIM.Reward_Ids[i],
				text = TIM.RewardNames[i],
				value = false,
				w=120,
				on_callback = function(item)
					--local tt = text
					--local name_temp = name
					
					if TIM._panel:GetItem(item:Name()):Value()==true then
						local gr = TIM._holder:Group({
							name = item:Name().."_gr",
							text = item:Text(),
							color = TIM._holder.accent_color, 
							size = 18, 
							align_method = "grid",
							closed = true
							--inherit_values = {text_align = "center"}	
						})
							gr:TextBox({
								name = "Reward_name_on_Twitch",
								text = "Reward name on Twitch:",
								value = "",
								focus_mode = true
							})
						if item:Text() == "Jail" or item:Text() == "Supress" or item:Text() == "Low speed" or item:Text() == "Less FOV" or item:Text() == "No Hitmarker" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that works for a given time"
							})
							
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Time(seconds):",
								value = "10",
								w=230,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Cloaker" or item:Text() == "Medic" or item:Text() == "Headless Dozer" or item:Text() == "Tazer" or item:Text() == "Captain Winters" or item:Text() == "Zeal sniper" or item:Text() == "Winters shield" then
							--Number of spawn
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spawn special units"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Number of spawn:",
								value = "1",
								w=280,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Smoke grenade" or item:Text() == "Frag grenade" or item:Text() == "Gas grenade" or item:Text() == "Flash grenade" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spawn grenades"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Number of spawn:",
								value = "1",
								w=280,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Heal" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that heals you for a certain percentage"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Percentage(%):",
								value = "1",
								w=250,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Spin display" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spin your display"
							})
						elseif item:Text() == "Ammo" then
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that spawn ammo boxes for you and your crew"
							})
							gr:NumberBox({
								name = "MyNumberBox",
								text = "Number of spawn:",
								value = "1",
								w=280,
								no_slide = true,
								floats = false,
								focus_mode = true
							})
						elseif item:Text() == "Cuffs" then	
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that handcuffs you for 60 seconds"
							})
						elseif item:Text() == "Dozer safe" then	
							gr:Divider({
								name = "Divider",
								text = "Description: A reward that launches roulette from dozers of various rarities, with a chance of a stat boost"
							})
						end
					else
						TIM._holder:RemoveItem(TIM._holder:GetItem(item:Name().."_gr"))
					end
				end
			})
		end
		
		--[[
		for key, val in pairs(TIM.Reward_names) do
			if val==1 then
				TIM._panel:GetItem(key):SetValue(true)
			else
				TIM._panel:GetItem(key):SetValue(false)
			end
		end
		local file, err = io.open("mods/TwitchIntegrationMod/Bot/Config/config.txt", "r")
		for line3 in file:lines() do
			line3 = tostring(line3)
			local index = line3:find("|")
			local name_of_reward=line3:sub(1,index-1)
			index = line3:find("#")
			local index2 = line3:find("#", index+1)
			local reward_id = line3:sub(index+1, index2-1)
			local gr = TIM._holder:GetItem(reward_id.._gr)
			
		end
		
		file:close()
		]]
    else
		game_state_machine:current_state():set_controller_enabled(true)
        TIM._menu:disable()
    end
end

--[[
setmetatable(TIM, self)
    TIM.__index = self; return TIM
end]]

function TIM:CreateSafe(safe_name,  points, elements_names, elements_rarity, names_paths, stat_boosts_points, stat_boosts_names, after_function)
	local num_spawn = 1
	local num_boost = 1
	local rarity = {common = "safe_data/common_frame", uncommon = "safe_data/uncommon_frame", rare = "safe_data/rare_frame", epic = "safe_data/epic_frame", legendary = "safe_data/legendary_frame"}
	local sounds_effects_rarity = {common = "safe_data/common-1", uncommon = "safe_data/uncommon-1", rare = "safe_data/rare-1", epic = "safe_data/epic-1", legendary = "safe_data/legend-1"}
	local colors_rarity = {common = Color(0,0.32,0.63), uncommon = Color(0.55,0.18,0.49), rare = Color(1,0.01,0.42), epic = Color(0.74,0.13,0.08), legendary = Color(0.95,0.64,0)}
	local window_panel = TIM.hud.panel:panel({
		name = "window_panel",			
		visible = false,
		layer = 0,
		alpha=1,
		color = Color(1, 1, 1, 1),
		w = 500,
		h = 84,
		x =0,
		y =100
	})
	window_panel:set_center_x(TIM.hud.panel:center_x())
	local window_bitmap = window_panel:bitmap({
		name = "window_bitmap",			
		visible = true,
		texture = "safe_data/line",
		layer = 4,
		alpha=1,
		w = 500,
		h = 84,
		x =0,
		y =0
	})
	local text_line = window_panel:text({
		y = 0,
		name = "text_line",
		align = "left",
		blend_mode = "normal",
		alpha = 0,
		x = 3,
		layer = 5,
		text = "Opening "..safe_name,
		font = tweak_data.menu.pd2_small_font,
		font_size = 15,
		color = Color.black
	})
	local tableCellsCount = math.random(40,50)
	local right = 0
	local tableCells={}
	
	local gif = {}
	for i = 1, 45, 1 do
		local image = TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "safe_data/animation/Cadr "..tostring(i),
			layer = 6,
			alpha=1,
			color = Color(1, 1, 1),
			w = 245,
			h = 150,
			x =0,
			y =0
		})
		table.insert(gif, image)
	end
	
	local summ_all_points = 0
	for i=1, #points, 1 do
		summ_all_points = summ_all_points + points[i]
	end
	
	local summ_all_boosts = 0
	for i=1, #stat_boosts_points, 1 do
		summ_all_boosts = summ_all_boosts + stat_boosts_points[i]
	end
	
	local function find_number(summ_all_weights, array)
		
		local rnd = math.random(summ_all_weights)
		for i=1, #array, 1 do
			if rnd < array[i] then 
				return i
			end
			rnd = rnd - array[i]
		end
		return #array
	end
------------------------------------------------------------------------------	
	local cell_pan = window_panel:panel({
		name = "cell_pan",			
		visible = true,
		layer = 1,
		alpha=1,
		color = Color(1, 1, 1),
		w = 111*tableCellsCount,
		h = 68,
		x =0,
		y =0
	})
	cell_pan:set_bottom(window_bitmap:bottom())
	local numbers = {}
	for i=0, tableCellsCount-4, 1 do
		local num = find_number(summ_all_points, points)
		local num_s = find_number(summ_all_boosts, stat_boosts_points)
		table.insert(numbers, {num, num_s})		
		
		
		
		
		local cell = cell_pan:bitmap({
			name = "cell",			
			visible = true,
			texture = rarity[elements_rarity[num]],
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 111,
			h = 68,
			x =i*111,
			y =0
		})
		local cell_image = cell_pan:bitmap({
			name = "cell_image",			
			visible = true,
			texture = names_paths[num],
			layer = 2,
			alpha=1,
			color = Color(1, 1, 1),
			w = 111,
			h = 68,
			x =i*111,
			y =0
		})
		
		--cell_pan:set_left(right)
		if num_s > 1 then
			local cell_boost = cell_pan:bitmap({
				name = "cell_boost",			
				visible = true,
				texture = "safe_data/boosticon",
				layer = 3,
				alpha=1,
				color = Color(1, 1, 1),
				w = 17,
				h = 17,
				x =i*111,
				y =0
			})
			cell_boost:set_bottom(cell:bottom())
			cell_boost:set_right(cell:right())
		end
		local text = cell_pan:text({
			y = 0,
			name = "say1",
			align = "left",
			blend_mode = "normal",
			halign = "left",
			x = i*111+3,
			layer = 3,
			text = elements_names[num],
			font = tweak_data.menu.pd2_small_font,
			font_size = 15,
			color = Color.white
		})
		text:set_top(cell_pan:bottom()-31)
		
		right=cell_pan:right()
		local avc = {cell_pan, true}
		--table.insert(tableCells, avc)						
	end
	---------------------------------------------------------------
		local num1 = find_number(summ_all_points, points)
		local num_s1 = find_number(summ_all_boosts, stat_boosts_points)
		table.insert(numbers, {num1, num_s1})		
		
		
		
		--cell_pan:set_bottom(window_bitmap:bottom())
		local cell_reward = cell_pan:bitmap({
			name = "cell",			
			visible = true,
			texture = rarity[elements_rarity[num1]],
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 111,
			h = 68,
			x =i*111,
			y =0
		})
		local cell_image = cell_pan:bitmap({
			name = "cell_image",			
			visible = true,
			texture = names_paths[num1],
			layer = 2,
			alpha=1,
			color = Color(1, 1, 1),
			w = 111,
			h = 68,
			x =i*111,
			y =0
		})
		
		--cell_pan:set_left(right)
		if num_s1 > 1 then
			local cell_boost = cell_pan:bitmap({
				name = "cell_boost",			
				visible = true,
				texture = "safe_data/boosticon",
				layer = 3,
				alpha=1,
				color = Color(1, 1, 1),
				w = 17,
				h = 17,
				x =i*111,
				y =0
			})
			cell_boost:set_bottom(cell_reward:bottom())
			cell_boost:set_right(cell_reward:right())
		end
		local text = cell_pan:text({
			y = 0,
			name = "say1",
			align = "left",
			blend_mode = "normal",
			halign = "left",
			x = i*111+3,
			layer = 3,
			text = elements_names[num],
			font = tweak_data.menu.pd2_small_font,
			font_size = 15,
			color = Color.white
		})
		text:set_top(cell_pan:bottom()-31)
		
		
	num_spawn=numbers[#numbers-3][1]
	num_boost=numbers[#numbers-3][2]
	numbers=nil
	local way = (tableCellsCount-6)*111+ math.random(-54,54)
	local cent_x = window_bitmap:world_x()
	local cent_y1 = window_bitmap:world_center_y()
	
	local cent_y = window_panel:center_y()
	window_panel:set_w(0)
	local c1x = cell_pan:world_x()
	local c1y = cell_pan:world_y()
	--local c2x = tableCells[2][1]:world_x()
	--local c2y = tableCells[2][1]:world_y()
	--local c3x = tableCells[3][1]:world_x()
	--local c3y = tableCells[3][1]:world_y()
	--local c4x = tableCells[4][1]:world_x()
	--local c4y = tableCells[4][1]:world_y()
	--local c5x = tableCells[5][1]:world_x()
	--local c5y = tableCells[5][1]:world_y()
	window_bitmap:animate(function(o)
	TIM.Active_safe=true
	window_panel:set_visible(true)
		over(0.5, function(p)
			window_panel:set_w(math.lerp(0, 500, p))
			window_panel:set_h(math.lerp(0, 84, p))
			window_panel:set_center_x(TIM.hud.panel:center_x())
			window_panel:set_center_y(cent_y)
			cell_pan:set_world_x(c1x)
			cell_pan:set_world_y(c1y)
			--tableCells[2][1]:set_world_x(c2x)
			--tableCells[2][1]:set_world_y(c2y)
			--tableCells[3][1]:set_world_x(c3x)
			--tableCells[3][1]:set_world_y(c3y)
			--tableCells[4][1]:set_world_x(c4x)
			--tableCells[4][1]:set_world_y(c4y)
			--tableCells[5][1]:set_world_x(c5x)
			--tableCells[5][1]:set_world_y(c5y)
			window_bitmap:set_world_center_y(cent_y1)
			window_bitmap:set_world_center_x(window_panel:center_x())
		end)
		window_bitmap:set_x(0)
		text_line:set_x(3)
		over(0.5,function(p)
			text_line:set_alpha(math.lerp(0,1,p))
		end)
		local timerand = math.random(800,900)
		local temp=way 
		
		local function over1(seconds, f,  fixed_dt)
			local t = 0
			while true do
				local dt = coroutine.yield()
				t = t + (fixed_dt and 0.03333333333333333 or dt)
			
				if seconds <= t then
					break
				end
					--
				f(t / seconds, t)
				if math.abs(-1*way-cell_pan:left())<0.1 then
					
					break
				end
			end
			f(1, seconds)
		end
	over1(timerand,  function(p)
		cell_pan:set_left(math.lerp(cell_pan:left(),-1*way, p))
		
			--cell_pan:set_left(tableCells[i-1][1]:right())
			if math.floor(cell_pan:left()%111) == 0 then
				--tableCells[i][2]=false
				
				local p = managers.menu_component._main_panel
				local name = "sound tick_sound"  --sounds_effects_rarity[elements_rarity[num_spawn]]
				if alive(p:child(name)) then
					managers.menu_component._main_panel:remove(p:child(name))
				end
				local volume = managers.user:get_setting("sfx_volume")
				local percentage = (volume - tweak_data.menu.MIN_SFX_VOLUME) / (tweak_data.menu.MAX_SFX_VOLUME - tweak_data.menu.MIN_SFX_VOLUME)
				managers.menu_component._main_panel:video({
					name = name,
					video = "safe_data/tick_sound",
					visible = false,
					loop = false,
				}):set_volume_gain(percentage+0.40)
			end
		
	end)
	
	for i = 1, 45, 1 do
		gif[i]:set_color(colors_rarity[elements_rarity[num_spawn]])
		gif[i]:set_world_right(cell_pan:world_right()-(67*4))
		gif[i]:set_world_center_y(cell_pan:world_center_y())
		
	end
	local jj ={}
	jj[1] =1
	local function over4(seconds, f,  fixed_dt)
			local t = 0
			while true do
				local dt = coroutine.yield()
				t = t + (fixed_dt and 0.03333333333333333 or dt)
			
				if seconds <= t then
					break
				end
					--
				f(t / seconds, t)
				if jj[1]==45 then
					
					break
				end
			end
			f(1, seconds)
		end
	
	
	over4(2, function(p)
		if jj[1] <45 then
			gif[jj[1]]:set_visible(true)
			jj[1]=jj[1]+1
			gif[jj[1]]:set_visible(true)
			gif[jj[1]-1]:parent():remove(gif[jj[1]-1]) 
			cell_pan:set_alpha(math.lerp(cell_pan:alpha(), 0 ,p))
			
			--tableCells[tableCellsCount-1][1]:set_alpha(math.lerp(tableCells[tableCellsCount-1][1]:alpha(), 0 ,p))
			
			--tableCells[tableCellsCount-2][1]:set_alpha(math.lerp(tableCells[tableCellsCount-2][1]:alpha(), 0 ,p))
			
			--tableCells[tableCellsCount-5][1]:set_alpha(math.lerp(tableCells[tableCellsCount-5][1]:alpha(), 0 ,p))
			--tableCells[tableCellsCount-6][1]:set_alpha(math.lerp(tableCells[tableCellsCount-6][1]:alpha(), 0 ,p))
			
			--tableCells[tableCellsCount-4][1]:set_alpha(math.lerp(tableCells[tableCellsCount-4][1]:alpha(), 0 ,p))
			window_bitmap:set_alpha(math.lerp(window_bitmap:alpha(), 0 ,p))
			text_line:set_alpha(math.lerp(text_line:alpha(), 0 ,p))
		end
	end)
    
	c1x = cell_pan:world_x()
	--c1y = tableCells[tableCellsCount][1]:world_y()
	--c2x = tableCells[tableCellsCount-1][1]:world_x()
	--c2y = tableCells[tableCellsCount-1][1]:world_y()
	--c3x = tableCells[tableCellsCount-2][1]:world_x()
	--c3y = tableCells[tableCellsCount-2][1]:world_y()
	--c4x = tableCells[tableCellsCount-3][1]:world_x()
	--c4y = tableCells[tableCellsCount-3][1]:world_y()
	--c5x = tableCells[tableCellsCount-4][1]:world_x()
	--c5y = tableCells[tableCellsCount-4][1]:world_y()
	--local c6x = tableCells[tableCellsCount-5][1]:world_x()
	--local c6y = tableCells[tableCellsCount-5][1]:world_y()
	
	local sound=sounds_effects_rarity[elements_rarity[num_spawn]]
	local p = managers.menu_component._main_panel
	local name = "sound"..sound
	if alive(p:child(name)) then
		managers.menu_component._main_panel:remove(p:child(name))
	end
	local volume = managers.user:get_setting("sfx_volume")
	local percentage = (volume - tweak_data.menu.MIN_SFX_VOLUME) / (tweak_data.menu.MAX_SFX_VOLUME - tweak_data.menu.MIN_SFX_VOLUME)
	local vid = window_panel:video({
		name = name,
		video = sound,
		visible = false,
		loop = false,
	}):set_volume_gain(percentage+0.15)
	local old_vol = managers.user:get_setting("music_volume")
	local old_vol2 = managers.user:get_setting("sfx_volume")
	if num_boost>1 then
		local st1=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "safe_data/statboost1",
			layer = 3,
			alpha=1,
			color = Color(1, 1, 1),
			w = 1,
			h = 1,
			x =0,
			y =200
		})
		local st2=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = true,
			texture = "safe_data/statboost2",
			layer = 2,
			alpha=1,
			color = Color(1, 1, 1),
			w = 1,
			h = 1,
			x =0,
			y =200
		})
		local st3=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "safe_data/statboost3",
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 100,
			h = 100,
			x =0,
			y =200
		})
		local st4=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "safe_data/statboost4",
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 100,
			h = 100,
			x =0,
			y =200
		})
		local st5=TIM.hud.panel:bitmap({
			name = "sssss",			
			visible = false,
			texture = "safe_data/statboost5",
			layer = 1,
			alpha=1,
			color = Color(1, 1, 1),
			w = 100,
			h = 100,
			x =0,
			y =200
		})
		local text_b1=TIM.hud.panel:panel({
			name = "sssss",			
			visible = true,
			texture = "safe_data/statboost5",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = 500,
			h = 200,
			x =0,
			y =200
		})
		local text_b2=TIM.hud.panel:panel({
			name = "sssss",			
			visible = true,
			texture = "safe_data/statboost5",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = 500,
			h = 200,
			x =0,
			y =200
		})
		--managers.chat:_receive_message(1, "ddd", tostring(1), Color('1565c0'))	
		st1:set_center_x(TIM.hud.panel:center_x())
		st2:set_center_x(TIM.hud.panel:center_x())
		st3:set_center_x(TIM.hud.panel:center_x())
		st4:set_center_x(TIM.hud.panel:center_x())
		st5:set_center_x(TIM.hud.panel:center_x())
		over(0.3, function(p)				
			
			st2:set_w(math.lerp(st2:w(), 100, p))
			st2:set_h(math.lerp(st2:h(), 100, p))
			st2:set_center_x(TIM.hud.panel:center_x())
			st2:set_center_y(250)
		end)
		over(0.3, function(p)
			
			st1:set_w(math.lerp(st1:w(), 100, p))		
			st1:set_h(math.lerp(st1:h(), 100, p))	
			st1:set_center_x(TIM.hud.panel:center_x())
			st1:set_center_y(250)				
		end)
		st3:set_center_y(0)		
		st4:set_center_y(500)	
		st5:set_center_y(500)				
		over(0.3, function(p)
			st3:set_center_x(TIM.hud.panel:center_x())
			st4:set_center_x(math.lerp(TIM.hud.panel:center_x()-100,TIM.hud.panel:center_x(),p))
			st5:set_center_x(math.lerp(TIM.hud.panel:center_x()+100,TIM.hud.panel:center_x(),p))
			st3:set_center_y(math.lerp(0,250,p))
			st4:set_center_y(math.lerp(500,250,p))
			st5:set_center_y(math.lerp(500,250,p))
			st3:set_alpha(math.lerp(0,1,p))
			st4:set_alpha(math.lerp(0,1,p))
			st5:set_alpha(math.lerp(0,1,p))
			st3:set_visible(true)
			st4:set_visible(true)
			st5:set_visible(true)
		end)
		text_b1:set_world_right(st1:world_left()+10)
		text_b2:set_world_left(st1:world_right()-10)
		local tt1 = text_b1:text({
			y = 25,
			name = "say1",
			align = "right",
			blend_mode = "normal",
			alpha = 1,
			x = 210,
			layer = 4,
			text = "STAT BOOST",
			font = tweak_data.menu.pd2_large_font,
			font_size = 40,
			color = Color.white
		})
		local tt2 = text_b2:text({
			y = 25,
			name = "say1",
			align = "left",
			blend_mode = "normal",
			alpha = 1,
			x = -210,
			layer = 4,
			text = stat_boosts_names[num_boost],
			font = tweak_data.menu.pd2_large_font,
			font_size = 40,
			color = Color.white
		})
		over(0.5, function(p)
			tt1:set_x(math.lerp(210,-10,p))
			tt2:set_x(math.lerp(-210,10,p))
		end)
		wait(1)
		over(0.3, function(p)
			st1:set_alpha(math.lerp(1,0,p))
			st2:set_alpha(math.lerp(1,0,p))
			st3:set_alpha(math.lerp(1,0,p))
			st4:set_alpha(math.lerp(1,0,p))
			st5:set_alpha(math.lerp(1,0,p))
			tt1:set_alpha(math.lerp(1,0,p))
			tt2:set_alpha(math.lerp(1,0,p))
		end)
		st1:parent():remove(st1)
		st2:parent():remove(st2)
		st3:parent():remove(st3)
		st4:parent():remove(st4)
		st5:parent():remove(st5)
		text_b1:parent():remove(text_b1)
		text_b2:parent():remove(text_b2)
	end		
	--managers.mission._fading_debug_output:script().log(tostring(sounds_effects_rarity[elements_rarity[num_spawn]]),  Color.red)
	local effect_params = {
		sound_event = "hlp_poof_small",
		effect = sounds_effects_rarity[elements_rarity[num_spawn]],
		camera_shake_max_mul = 0,
		sound_muffle_effect = false,
		feedback_range = 5* 2
	}
	after_function(num_spawn, num_boost, effect_params)
	over(1, function(p)
			gif[45]:set_alpha(math.lerp(1,0,p))
			cell_pan:set_alpha(math.lerp(1, 0 ,p))
		end)
		gif[45]:parent():remove(gif[45]) 
		
	over(1, function(p)
		managers.user:set_setting("music_volume", math.lerp(managers.user:get_setting("music_volume"), old_vol/3,p))
		managers.user:set_setting("sfx_volume", math.lerp(managers.user:get_setting("sfx_volume"), old_vol2/3,p))
	end)
	TIM.Active_safe=false
	
	wait(14)
	over(1, function(p)
		managers.user:set_setting("music_volume", math.lerp(managers.user:get_setting("music_volume"), old_vol,p))
		managers.user:set_setting("sfx_volume", math.lerp(managers.user:get_setting("sfx_volume"), old_vol2,p))
		
	end)
		TIM.hud.panel:remove(TIM.hud.panel:child("window_panel"))
		--after_function()
	end)		
	--return num_spawn, num_boost, effect_params
end
