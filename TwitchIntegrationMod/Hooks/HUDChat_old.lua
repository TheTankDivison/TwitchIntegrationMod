if VoidUI then

else
HUDChat.list_of_files={}
Hooks:PostHook(HUDChat, "init", "init_TW", function(self)
	
end)

-----------------------------------------------------------
function HUDChat:receive_message(name, message, color, icon)
	local output_panel = self._panel:child("output_panel")
	local len = utf8.len(name) + 1
	local x = 0
	local icon_bitmap = nil
	local bool = false
	--if message:find(TIM.twitch_nickname) or message:find(TIM.twitch_nickname:lower())then
	--	bool = true
	--end
	local mess_arr = message:split(" ")
	local line_panel = output_panel:panel({
		name = "line_panel",			
		layer = 0,
		alpha=1,
		w = 300,
		h = HUDChat.line_height,
		x =0,
		y =0
	})
	if icon then
		local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data(icon)
		icon_bitmap = line_panel:bitmap({
			y = 1,
			texture = icon_texture,
			texture_rect = icon_texture_rect,
			color = color
		})
		x = icon_bitmap:right()
	end
	
	local emote_bitmap=nil
	local icon_tw = nil
	local mas = {1}
	--local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
	if name:find("0TW0") then
		name=name:gsub("0TW0", "", 1)
		icon_tw = line_panel:bitmap({
			y = 0,
			name ="twitch_icon",
			texture = "guis/textures/icons/TwitchIcon",
			w = HUDChat.line_height-5,
			h = HUDChat.line_height-5,
			blend_mode = "add",
			x = x,
			color = Color(1,1,1)
		})
		x = icon_tw:right()
		icon_tw:set_center_y(HUDChat.line_height/2)
		mas[#mas+1] = icon_tw
	end
	
	if name:find("0IsBroadcaster0") then
		name=name:gsub("0IsBroadcaster0","",1)
	
		emote_bitmap = line_panel:bitmap({
			visible = true,
			name ="twitch_icon",
			texture = "guis/textures/icons/broadcaster_1",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = HUDChat.line_height-5,
			h = HUDChat.line_height-5,
			blend_mode = "add",
			x = x,
			y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
		})
		mas[#mas+1]=emote_bitmap
		x = emote_bitmap:right()+2
		emote_bitmap:set_center_y(HUDChat.line_height/2)
		emote_bitmap=nil
	elseif name:find("0IsModerator0") then
		name=name:gsub("0IsModerator0","",1)
	
		emote_bitmap = line_panel:bitmap({
			visible = true,
			name ="twitch_icon",
			texture = "guis/textures/icons/moderator_1",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = HUDChat.line_height-5,
			h = HUDChat.line_height-5,
			blend_mode = "add",
			x = x,
			y =0--line_temp:world_y() --HUDChat.line_height-line_temp:h()
		})
		mas[#mas+1]=emote_bitmap
		emote_bitmap:set_center_y(HUDChat.line_height/2)
		x = emote_bitmap:right()+2
		emote_bitmap=nil
	end
	local temp_x = x
	local temp_y = 0
	name = name..":"
	local name_arr = name:split(" ")
	
	for i = 1, #name_arr do
		local line_words = line_panel:text({
			halign = "left",	
			name = "line_words"..i,
			vertical = "top",
			hvertical = "top",
			wrap = true,
			visible = true,
			align = "left",
			blend_mode = "normal",
			word_wrap = true,
			y = temp_y,
			layer = 0,
			text = name_arr[i].." ",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = temp_x,
			color = color
		})
		local _, _, w, h = line_words:text_rect()
		line_words:set_w(w)
		line_words:set_h(h)
		local temp_x_t = line_words:right()
		if line_words:number_of_lines()>1 or temp_x_t > 295 then
			local line_height = HUDChat.line_height
		
			line_panel:set_h(line_panel:h()+line_height)
			temp_x=0
			temp_y=temp_y+line_height
			line_panel:remove(line_panel:child("line_words"..i))	
			--line_words:parent():remove(line_words)
			line_words = line_panel:text({
				halign = "left",	
				name = "line_words",
				vertical = "top",
				hvertical = "top",
				wrap = true,
				visible = true,
				align = "left",
				blend_mode = "normal",
				word_wrap = true,
				y = temp_y,
				layer = 0,
				text = name_arr[i].." ",
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				x = 0,
				color = color
			})
			--line_panel:remove(line_panel:child(line_one_word:name()))	
		end
		
		_, _, w, h = line_words:text_rect()
		line_words:set_w(w)
		line_words:set_h(h)
		
		temp_x=line_words:right()
		--managers.hud:show_hint({text = tostring(temp_x)})
	end
	--message = name..":"
	local list_of_files_before = SystemFS:list("mods/TwitchIntegrationMod/ReadMessage/emotes")
	if  #list_of_files_before ~= #HUDChat.list_of_files then
		local ext = Idstring("texture")
		for i = 1, #list_of_files_before, 1 do
			local gs = list_of_files_before[i]:gsub(".png", "")
			--local bb = FileManager:Has(String/Idstring ext, String/Idstring path)
			FileManager:AddFileWithCheck(ext, Idstring("mods/TwitchIntegrationMod/ReadMessage/emotes/"..gs), "mods/TwitchIntegrationMod/ReadMessage/emotes/"..tostring(list_of_files_before[i]))			
			--FileManager:LoadAsset(ext, Idstring("mods\\TwitchIntegrationMod\\Bot\\ReadMessage\\emotes"..gs), "mods\\TwitchIntegrationMod\\Bot\\ReadMessage\\emotes"..list_of_files_before[i])			
			HUDChat.list_of_files[gs] = "mods/TwitchIntegrationMod/ReadMessage/emotes/"..gs
		end
	end
	
	if bool==true then
		for i = 1, #mess_arr do
			if HUDChat.list_of_files[mess_arr[i]] then
				local name_of_emote = HUDChat.list_of_files[mess_arr[i]]
				
				emote_bitmap = line_panel:bitmap({
					name = tostring(number_of_line),			
					visible = true,
					texture = name_of_emote,
					layer = 0,
					alpha=1,
					color = Color(1, 1, 1),
					w = tweak_data.menu.pd2_small_font_size,
					h = tweak_data.menu.pd2_small_font_size,
					blend_mode = "add",
					x =temp_x,
					y =temp_y
				})
				--emote_bitmap:set_top(self._input_panel:top())
				temp_x = emote_bitmap:right()
				--managers.mission._fading_debug_output:script().log(tostring(temp_x),  Color.red)
				if temp_x > 300 - (tweak_data.menu.pd2_small_font_size) then
					local line_height = HUDChat.line_height
					temp_x=0
					temp_y=temp_y+line_height
					emote_bitmap:set_y(temp_y)
					emote_bitmap:set_x(temp_x)
					temp_x = emote_bitmap:right()
					line_panel:set_h(line_panel:h()+line_height)
					--emote_bitmap:set_y(emote_bitmap:y()+line_height)
				end
				--temp_x=
				--mas[#mas+1]=emote_bitmap
				--mess_arr[i]=string_spaces
				emote_bitmap=nil
				--x = line_words:right()
			else
				
				local line_words = line_panel:text({
					halign = "left",	
					name = "line_words2"..i,
					vertical = "top",
					hvertical = "top",
					wrap = true,
					visible = true,
					align = "left",
					blend_mode = "normal",
					word_wrap = true,
					y = temp_y,
					layer = 0,
					text = mess_arr[i].." ",
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					x = temp_x,
					color = Color.white
				})
				local _, _, w, h = line_words:text_rect()
				line_words:set_w(w)
				line_words:set_h(h)
				local temp_x_t = line_words:right()
				if line_words:number_of_lines()>1 or temp_x_t > 295 then
					local line_height = HUDChat.line_height
					temp_x=0
					line_panel:set_h(line_panel:h()+line_height)
					temp_y=temp_y+line_height
					line_panel:remove(line_panel:child("line_words2"..i))	
					--line_words:parent():remove(line_words)
					line_words = line_panel:text({
						halign = "left",	
						name = "line_words",
						vertical = "top",
						hvertical = "top",
						wrap = true,
						visible = true,
						align = "left",
						blend_mode = "normal",
						word_wrap = true,
						y = temp_y,
						layer = 0,
						text = mess_arr[i].." ",
						font = tweak_data.menu.pd2_small_font,
						font_size = tweak_data.menu.pd2_small_font_size,
						x = 0,
						color = Color.white
					})
					--line_panel:remove(line_panel:child(line_one_word:name()))	
				end
				line_words:set_w(line_panel:w() - line_words:left())
				_, _, w, h = line_words:text_rect()
				line_words:set_w(w)
				line_words:set_h(h)
				temp_x=line_words:right()
				--message = message.." "..mess_arr[i]
				local low = mess_arr[i]:upper()
				local low2= TIM.twitch_nickname:upper()
				--managers.mission._fading_debug_output:script().log(tostring(low),  Color.red)
				--managers.mission._fading_debug_output:script().log(tostring(low2),  Color.red)
				if low:find(low2) then
					local tw_panel = line_panel:bitmap({
						name = tostring(1),			
						visible = true,
						--texture = name_of_emote,
						layer = -1,
						alpha=1,
						color = Color('8000ff'),
						w = line_words:w(),
						h = line_words:h(),
						blend_mode = "add",
						x =line_words:x(),
						y =line_words:y()
					})
					--line_words
				end
			end
		end
		
	else
	for i = 1, #mess_arr do
		if HUDChat.list_of_files[mess_arr[i]] then
			local name_of_emote = HUDChat.list_of_files[mess_arr[i]]
			
			emote_bitmap = line_panel:bitmap({
				name = tostring(number_of_line),			
				visible = true,
				texture = name_of_emote,
				layer = 0,
				alpha=1,
				color = Color(1, 1, 1),
				w = tweak_data.menu.pd2_small_font_size,
				h = tweak_data.menu.pd2_small_font_size,
				blend_mode = "add",
				x =temp_x,
				y =temp_y
			})
			--emote_bitmap:set_top(self._input_panel:top())
			temp_x = emote_bitmap:right()
			--managers.mission._fading_debug_output:script().log(tostring(temp_x),  Color.red)
			if temp_x > 300 - (tweak_data.menu.pd2_small_font_size) then
				local line_height = HUDChat.line_height
				temp_x=0
				temp_y=temp_y+line_height
				emote_bitmap:set_y(temp_y)
				emote_bitmap:set_x(temp_x)
				temp_x = emote_bitmap:right()
				line_panel:set_h(line_panel:h()+line_height)
				--emote_bitmap:set_y(emote_bitmap:y()+line_height)
			end
			--temp_x=
			--mas[#mas+1]=emote_bitmap
			--mess_arr[i]=string_spaces
			emote_bitmap=nil
			--x = line_words:right()
		else
			local line_words = line_panel:text({
				halign = "left",	
				name = "line_words2"..i,
				vertical = "top",
				hvertical = "top",
				wrap = true,
				visible = true,
				align = "left",
				blend_mode = "normal",
				word_wrap = true,
				y = temp_y,
				layer = 0,
				text = mess_arr[i].." ",
				font = tweak_data.menu.pd2_small_font,
				font_size = tweak_data.menu.pd2_small_font_size,
				x = temp_x,
				color = Color.white
			})
			local _, _, w, h = line_words:text_rect()
			line_words:set_w(w)
			line_words:set_h(h)
			local temp_x_t = line_words:right()
			if line_words:number_of_lines()>1 or temp_x_t > 295 then
				local line_height = HUDChat.line_height
				temp_x=0
				line_panel:set_h(line_panel:h()+line_height)
				temp_y=temp_y+line_height
				line_panel:remove(line_panel:child("line_words2"..i))	
				--line_words:parent():remove(line_words)
				line_words = line_panel:text({
					halign = "left",	
					name = "line_words",
					vertical = "top",
					hvertical = "top",
					wrap = true,
					visible = true,
					align = "left",
					blend_mode = "normal",
					word_wrap = true,
					y = temp_y,
					layer = 0,
					text = mess_arr[i].." ",
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					x = 0,
					color = Color.white
				})
				--line_panel:remove(line_panel:child(line_one_word:name()))	
			end
			line_words:set_w(line_panel:w() - line_words:left())
			_, _, w, h = line_words:text_rect()
			line_words:set_w(w)
			line_words:set_h(h)
			temp_x=line_words:right()
			--message = message.." "..mess_arr[i]
			
		end
	end
	end
	table.insert(self._lines, line_panel)
	--line:set_kern(line:kern())
	self:_layout_output_panel()

	if not self._focus then
		local output_panel = self._panel:child("output_panel")

		output_panel:stop()
		output_panel:animate(callback(self, self, "_animate_show_component"), output_panel:alpha())
		output_panel:animate(callback(self, self, "_animate_fade_output"))
	end
end

	function HUDChat:_layout_output_panel()
		local lines=0
		local output_panel = self._panel:child("output_panel")
		
		for i = #self._lines, 1, -1 do
			local line = self._lines[i]
			line:set_w(output_panel:w() - line:x())
			lines = lines + line:h()/HUDChat.line_height
		end
		
		output_panel:set_h(HUDChat.line_height * math.min(10, lines))
		
		output_panel:set_bottom(self._input_panel:top())
		local y = 0
		for i = #self._lines, 1, -1 do
			local msg = self._lines[i]
			msg:set_bottom(output_panel:h() - y)
			y = y + msg:h()
		end
		if #self._lines>15 then
		
			local line = self._lines[1]
			output_panel:remove(output_panel:child(line:name()))	
			table.remove(self._lines, 1)
			
		end
	end
end
