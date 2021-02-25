if _G.WolfHUD then
	function ChatManager:_receive_message_twitch(channel_id, name, message, color, badges)
		if not self._receivers[channel_id] then
			return
		end

		for i, receiver in ipairs(self._receivers[channel_id]) do
			receiver:receive_message(name, message, color)
		end
	end
elseif VoidUI then
	function ChatManager:_receive_message_twitch(channel_id, name, message, color, badges)
		if not self._receivers[channel_id] then
			return
		end

		for i, receiver in ipairs(self._receivers[channel_id]) do
			receiver:receive_message(name, message, color)
		end
	end
elseif _G.MUIChat then
	function ChatManager:_receive_message_twitch(channel_id, name, message, color, badges)
		if not self._receivers[channel_id] then
			return
		end

		for i, receiver in ipairs(self._receivers[channel_id]) do
			receiver:receive_message(name, message, color)
		end
	end
else

function ChatGui:receive_message_twitch(name, message, color, badges)
	if not alive(self._panel) or not managers.network:session() then
		return
	end

	local output_panel = self._panel:child("output_panel")
	local scroll_panel = output_panel:child("scroll_panel")
	local local_peer = managers.network:session():local_peer()
	local peers = managers.network:session():peers()
	
	local x = 0
	local icon_bitmap = nil
	local emote_bitmap = nil
	local icon_bitmap1 = nil
	local mas ={1,1,1, 1}

	if icon then
		local icon_texture, icon_texture_rect = tweak_data.hud_icons:get_icon_data(icon)
		icon_bitmap = scroll_panel:bitmap({
			y = 1,
			texture = icon_texture,
			texture_rect = icon_texture_rect,
			color = color
		})
		x = icon_bitmap:right()
	end
	
			icon_bitmap1 = scroll_panel:bitmap({
			y = 6,
			name ="twitch_icon",
			texture = "guis/textures/icons/TwitchIcon",
			w = ChatGui.line_height-6,
			h = ChatGui.line_height-6, 
			x= 0,
			color = Color(1,1,1)
			})
		x = icon_bitmap1:right()

	if badges:find("broadcaster/1") then
	
	
	emote_bitmap = scroll_panel:bitmap({
			visible = true,
			name ="twitch_icon",
			texture = "guis/textures/icons/broadcaster_1",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = ChatGui.line_height-6,
			h = ChatGui.line_height-6,
			blend_mode = "add",
			x = x+4,
			y =6--line_temp:world_y() --ChatGui.line_height-line_temp:h()
		})
		mas[#mas+1]=emote_bitmap
		x = emote_bitmap:right()+2
		emote_bitmap=nil
	elseif badges:find("moderator/1") then
	
	emote_bitmap = scroll_panel:bitmap({
			visible = true,
			name ="twitch_icon",
			texture = "guis/textures/icons/moderator_1",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = ChatGui.line_height-6,
			h = ChatGui.line_height-6,
			blend_mode = "add",
			x = x+4,
			y =6--line_temp:world_y() --ChatGui.line_height-line_temp:h()
		})
		mas[#mas+1]=emote_bitmap
		x = emote_bitmap:right()+2
		emote_bitmap=nil
	end
	local len = utf8.len(name) + 1
	local number_of_spaces = 0
	local string_spaces = " "
	local mess_arr = message:split(" ")
	message=""
	local space_word = self._panel:text({
		halign = "left",	
		name = "space_word",
		vertical = "top",
		hvertical = "top",
		wrap = true,
		visible = false,
		align = "left",
		blend_mode = "normal",
		word_wrap = true,
		y = 0,
		layer = 0,
		text = " ",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = x,
		color = color
	})
				
	local _, _, space_ww, _ = space_word:text_rect()
	self._panel:remove(self._panel:child("space_word"))
	
	number_of_spaces = math.ceil((ChatGui.line_height-6)/space_ww)
	string_spaces = string_spaces:rep(number_of_spaces)
	--local full_message=name..": "..message
	
	local numbers = {}
	--local numbers2={}
	local all_numbers= {}

	--local list_of_files	= table.concat(SystemFS:list("mods\\TwitchIntegrationMod\\assets\\guis\\textures\\Emotes"), "#")
	--list_of_files=list_of_files:gsub(".texture", "")
	--list_of_files="#"..list_of_files.."#"
		local line_one_word = self._panel:text({
		halign = "left",	
		name = "line_one_word",
		vertical = "top",
		hvertical = "top",
		wrap = true,
		visible = false,
		align = "left",
		blend_mode = "normal",
		word_wrap = true,
		y = 0,
		layer = 0,
		text = name..": ",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = x,
		color = color
	})
	local _, _, dlina, _ = line_one_word:text_rect()
	self._panel:remove(self._panel:child(line_one_word:name()))
	line_one_word = nil
	local list_of_files_before = SystemFS:list("assets/mod_overrides/Twitch Integration Mod emotes")
	if  #list_of_files_before ~= #ChatGui.list_of_files then
		local ext = Idstring("texture")
		for i = 1, #list_of_files_before, 1 do
			local gs = list_of_files_before[i]:gsub(".png", "")
			--local bb = FileManager:Has(String/Idstring ext, String/Idstring path)
			FileManager:AddFileWithCheck(ext, Idstring("assets/mod_overrides/Twitch Integration Mod emotes/"..gs), "assets/mod_overrides/Twitch Integration Mod emotes/"..tostring(list_of_files_before[i]))			
			--FileManager:LoadAsset(ext, Idstring("mods\\TwitchIntegrationMod\\Bot\\ReadMessage\\emotes"..gs), "mods\\TwitchIntegrationMod\\Bot\\ReadMessage\\emotes"..list_of_files_before[i])			
			ChatGui.list_of_files[gs] = "assets/mod_overrides/Twitch Integration Mod emotes/"..gs
		end
	end

    local number_of_line = 1
----------------------------------------------------------------------------------for
	for i = 1, #mess_arr do
		
		if ChatGui.list_of_files[mess_arr[i]] then
			local name_of_emote = ChatGui.list_of_files[mess_arr[i]]
			
			emote_bitmap = scroll_panel:bitmap({
				name = tostring(number_of_line),			
				visible = true,
				texture = name_of_emote,
				layer = 0,
				alpha=1,
				color = Color(1, 1, 1),
				w = ChatGui.line_height-4,
				h = ChatGui.line_height-4,
				blend_mode = "add",
				x =x+dlina,
				y =0--line_temp:world_y() --ChatGui.line_height-line_temp:h()
			})
			emote_bitmap:set_top(self._input_panel:top())
		
			mas[#mas+1]=emote_bitmap
		--self._panel:remove(self._panel:child(line_temp:name()))
			emote_bitmap=nil
		
			mess_arr[i]=string_spaces
		end
		
		message=message.." "..mess_arr[i]
		line_one_word = self._panel:text({
			halign = "left",	
			name = "line_one_word1",
			vertical = "top",
			hvertical = "top",
			wrap = true,
			visible = false,
			align = "left",
			blend_mode = "normal",
			word_wrap = true,
			y = 0,
			layer = 0,
			text =" ".. mess_arr[i],
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = x,
			color = color
		})
		local _, _, part_mess_ww, _ = line_one_word:text_rect()	
		line_one_word:set_kern(line_one_word:kern())
		
		line_one_word:set_w(scroll_panel:w() - line_one_word:left())
		local _, _, part_mess_ww1, _ = line_one_word:text_rect()
		line_one_word:set_h(part_mess_ww1)	
		self._panel:remove(self._panel:child(line_one_word:name()))
		
		dlina = dlina + part_mess_ww
			
		if dlina > scroll_panel:w()- x then
			number_of_line=number_of_line+1
			while part_mess_ww > part_mess_ww1 do
				part_mess_ww = part_mess_ww - part_mess_ww1
				number_of_line=number_of_line+1
				
				
			end
			dlina = part_mess_ww
		end
		if dlina > scroll_panel:w() - x - (number_of_spaces*space_ww) then
			local dl = dlina - (scroll_panel:w() - x) --+ (#string_spaces*space_ww)
			dl = math.ceil(dl/space_ww)
			dlina = 0-- dlina - (scroll_panel:w() - x)-- (#string_spaces*space_ww)
			number_of_line = number_of_line + 1
			local str = " "
			str = str:rep(dl)
			message = message..str
		end

	end
	local line = scroll_panel:text({
		halign = "left",
		vertical = "top",
		hvertical = "top",
		wrap = true,
		align = "left",
		blend_mode = "normal",
		word_wrap = true,
		y = 0,
		layer = 0,
		text = name .. ":" .. message,
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = x,
		w = scroll_panel:w() - x,
		color = color
	})
	local total_len = utf8.len(line:text())

	line:set_range_color(0, len, color)
	line:set_range_color(len, total_len, Color.white)

	local _, _, w, h = line:text_rect()

	line:set_h(h)

	local line_bg = scroll_panel:rect({
		hvertical = "top",
		halign = "left",
		layer = -1,
		color = Color.black:with_alpha(0.5)
	})

	mas[1]=line
	if icon_bitmap then
		mas[3]=icon_bitmap
	end
	if icon_bitmap1 then
		mas[4]=icon_bitmap1
	end
	mas[2]=line_bg
	line_bg:set_h(h)
	line:set_kern(line:kern())
	table.insert(self._lines, mas)
	
	self:_layout_output_panel()

	if not self._focus then
		output_panel:stop()
		output_panel:animate(callback(self, self, "_animate_show_component"), output_panel:alpha())
		output_panel:animate(callback(self, self, "_animate_fade_output"))
		self:start_notify_new_message()
	end


end



function ChatGui:_layout_output_panel(force_update_scroll_indicators)
	local output_panel = self._panel:child("output_panel")
	local scroll_panel = output_panel:child("scroll_panel")

	scroll_panel:set_w(self._output_width)
	output_panel:set_w(self._output_width)

	local line_height = ChatGui.line_height
	local max_lines = self._max_lines
	local lines = 0

	for i = #self._lines, 1, -1 do
		local line = self._lines[i][1]
		local line_bg = self._lines[i][2]
		local icon = self._lines[i][3]

		line:set_w(scroll_panel:w() - line:left())

		local _, _, w, h = line:text_rect()

		line:set_h(h)
		line_bg:set_w(w + line:left() + 2)
		line_bg:set_h(line_height * line:number_of_lines())

		lines = lines + line:number_of_lines()
	end

	local scroll_at_bottom = scroll_panel:bottom() == output_panel:h()

	output_panel:set_h(math.round(line_height * math.min(max_lines, lines)))
	scroll_panel:set_h(math.round(line_height * lines))

	local y = 0

	for i = #self._lines, 1, -1 do
		local line = self._lines[i][1]
		local line_bg = self._lines[i][2]
		local icon = self._lines[i][3]
		local _, _, w, h = line:text_rect()

		line:set_bottom(scroll_panel:h() - y)
		line_bg:set_bottom(line:bottom())
		
		if icon and icon ~= 1 then
			icon:set_left(icon:left())
			icon:set_top(line:top() + 1)
			line:set_left(icon:right())
		else
			line:set_left(line:left())
		end
		if #self._lines[i]>3 then
			for j=4, #self._lines[i], 1 do
				local Emote = self._lines[i][j]
				if Emote and Emote ~=1 then
					if tostring(Emote:name())=="twitch_icon" then
						Emote:set_top(line:top() + 2.5)
					else
				
						local n = tonumber(Emote:name())
						Emote:set_top(line:top() + (ChatGui.line_height-1)*(n-1))
					end
				end
			end
		end
		y = y + line_height * line:number_of_lines()
	end

	output_panel:set_bottom(math.round(self._input_panel:top()))

	if lines <= max_lines or scroll_at_bottom then
		scroll_panel:set_bottom(output_panel:h())
	end

	self:set_scroll_indicators(force_update_scroll_indicators)
end



--[[
Hooks:PostHook(ChatGui, "receive_message", "receive_message_TW", function(self)
	if name:find("0TW0") then
		name=name:gsub("0TW0", "", 1)
			icon_bitmap1 = scroll_panel:bitmap({
			y = 0,
			texture = "guis/textures/Emotes/TwitchIcon",
			w = 18,
			h = 18, 
			x= 0,
			color = Color(1,1,1)
			})
		x = icon_bitmap1:right()
	end
	if name:find("0IsBroadcaster0") then
	name=name:gsub("0IsBroadcaster0","",1)
	
	emote_bitmap = scroll_panel:bitmap({
			visible = true,
			name ="twitch_icon",
			texture = "guis/textures/Emotes/broadcaster_1",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = ChatGui.line_height-6,
			h = ChatGui.line_height-6,
			blend_mode = "add",
			x = x+4,
			y =0--line_temp:world_y() --ChatGui.line_height-line_temp:h()
		})
		mas[#mas+1]=emote_bitmap
		x = emote_bitmap:right()+2
		emote_bitmap=nil
	end
	
	if name:find("0IsModerator0") then
	name=name:gsub("0IsModerator0","",1)
	
	emote_bitmap = scroll_panel:bitmap({
			visible = true,
			name ="twitch_icon",
			texture = "guis/textures/Emotes/moderator_1",
			layer = 0,
			alpha=1,
			color = Color(1, 1, 1),
			w = ChatGui.line_height-6,
			h = ChatGui.line_height-6,
			blend_mode = "add",
			x = x+4,
			y =6--line_temp:world_y() --ChatGui.line_height-line_temp:h()
		})
		mas[#mas+1]=emote_bitmap
		x = emote_bitmap:right()+2
		emote_bitmap=nil
	end
	local len = utf8.len(name) + 1
	local number_of_spaces = 0
	local string_spaces = " "
	local mess_arr = message:split(" ")
	message=""
	local space_word = self._panel:text({
		halign = "left",	
		name = "space_word",
		vertical = "top",
		hvertical = "top",
		wrap = true,
		visible = false,
		align = "left",
		blend_mode = "normal",
		word_wrap = true,
		y = 0,
		layer = 0,
		text = " ",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = x,
		color = color
	})
				
	local _, _, space_ww, _ = space_word:text_rect()
	self._panel:remove(self._panel:child("space_word"))
	
	number_of_spaces = math.ceil((ChatGui.line_height-6)/space_ww)
	string_spaces = string_spaces:rep(number_of_spaces)
	--local full_message=name..": "..message
	
	local numbers = {}
	--local numbers2={}
	local all_numbers= {}

	local list_of_files	= table.concat(SystemFS:list("mods\\TwitchIntegrationMod\\assets\\guis\\textures\\Emotes"), "#")
	list_of_files=list_of_files:gsub(".texture", "")
	list_of_files="#"..list_of_files.."#"
		local line_one_word = self._panel:text({
		halign = "left",	
		name = "line_one_word",
		vertical = "top",
		hvertical = "top",
		wrap = true,
		visible = false,
		align = "left",
		blend_mode = "normal",
		word_wrap = true,
		y = 0,
		layer = 0,
		text = name..": ",
		font = tweak_data.menu.pd2_small_font,
		font_size = tweak_data.menu.pd2_small_font_size,
		x = x,
		color = color
	})
	local _, _, dlina, _ = line_one_word:text_rect()
	self._panel:remove(self._panel:child(line_one_word:name()))
	line_one_word = nil
	

    local number_of_line = 1
----------------------------------------------------------------------------------for
	for i = 1, #mess_arr do
		if not mess_arr[i]:find("%p") then
		if list_of_files:find("#"..mess_arr[i].."#") then
			local name_of_emote = mess_arr[i]
			
			emote_bitmap = scroll_panel:bitmap({
				name = tostring(number_of_line),			
				visible = true,
				texture = "guis/textures/Emotes/"..name_of_emote,
				layer = 0,
				alpha=1,
				color = Color(1, 1, 1),
				w = ChatGui.line_height-4,
				h = ChatGui.line_height-4,
				blend_mode = "add",
				x =x+dlina,
				y =0--line_temp:world_y() --ChatGui.line_height-line_temp:h()
			})
			emote_bitmap:set_top(self._input_panel:top())
		
			mas[#mas+1]=emote_bitmap
		--self._panel:remove(self._panel:child(line_temp:name()))
			emote_bitmap=nil
		
			mess_arr[i]=string_spaces
		end
		end
		message=message.." "..mess_arr[i]
		line_one_word = self._panel:text({
			halign = "left",	
			name = "line_one_word1",
			vertical = "top",
			hvertical = "top",
			wrap = true,
			visible = false,
			align = "left",
			blend_mode = "normal",
			word_wrap = true,
			y = 0,
			layer = 0,
			text =" ".. mess_arr[i],
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = x,
			color = color
		})
		local _, _, part_mess_ww, _ = line_one_word:text_rect()	
		line_one_word:set_kern(line_one_word:kern())
		
		line_one_word:set_w(scroll_panel:w() - line_one_word:left())
		local _, _, part_mess_ww1, _ = line_one_word:text_rect()
		line_one_word:set_h(part_mess_ww1)	
		self._panel:remove(self._panel:child(line_one_word:name()))
		
		dlina = dlina + part_mess_ww
			
		if dlina > scroll_panel:w()- x then
			number_of_line=number_of_line+1
			while part_mess_ww > part_mess_ww1 do
				part_mess_ww = part_mess_ww - part_mess_ww1
				number_of_line=number_of_line+1
				
				
			end
			dlina = part_mess_ww
		end
		if dlina > scroll_panel:w() - x - (number_of_spaces*space_ww) then
			local dl = dlina - (scroll_panel:w() - x) --+ (#string_spaces*space_ww)
			dl = math.ceil(dl/space_ww)
			dlina = 0-- dlina - (scroll_panel:w() - x)-- (#string_spaces*space_ww)
			number_of_line = number_of_line + 1
			local str = " "
			str = str:rep(dl)
			message = message..str
		end

	end
	
	
	line:set_range_color(0, len, color)
	line:set_range_color(len, total_len, Color.white)

	local _, _, w, h = line:text_rect()

	line:set_h(h)

	mas[1]=line
	if icon_bitmap then
		mas[3]=icon_bitmap
	end
	if icon_bitmap1 then
		mas[4]=icon_bitmap1
	end
	mas[2]=line_bg
	line_bg:set_h(h)
	line:set_kern(line:kern())
	table.insert(self._lines, mas)
	
	
end)
]]
Hooks:PostHook(ChatGui, "init", "init_TW", function(self)
	--TIM:chat()
	TIM.InLobby = true
	--local list_of_files_before = SystemFS:list("mods\\TwitchIntegrationMod\\assets\\guis\\textures\\Emotes")
	
	--for i = 1, #list_of_files_before, 1 do
	--	local gs = list_of_files_before[i]:gsub(".texture", "")
	--	ChatGui.list_of_files[gs] = gs
	--end
end)
ChatGui._emotions={}
ChatGui.list_of_files={}
	function ChatManager:_receive_message_twitch(channel_id, name, message, color, badges)
		if not self._receivers[channel_id] then
			return
		end

		for i, receiver in ipairs(self._receivers[channel_id]) do
			receiver:receive_message_twitch(name, message, color, badges)
		end
	end

end
