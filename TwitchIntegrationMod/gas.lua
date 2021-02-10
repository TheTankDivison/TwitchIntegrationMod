--package.path = package.path..';D:/Новая папка/SteamLibrary/steamapps/common/PAYDAY 2/mods/TwitchIntegrationMod/luasocket/lua/?.lua;'
--package.cpath = package.cpath..';D:/Новая папка/SteamLibrary/steamapps/common/PAYDAY 2/mods/TwitchIntegrationMod/luasocket/socket/?.dll;D:/Новая папка/SteamLibrary/steamapps/common/PAYDAY 2/mods/TwitchIntegrationMod/luasocket/mime/?.dll;'
--local as, library= blt.load_native('mods\\TwitchIntegrationMod\\' .. "testMyMod.dll")
--local bb = library.down()
--createCustomReward(client->getClientID(), client->getAuth(), title, prompt, cost, is_enabled, background_color, is_max_per_stream_enabled, max_per_stream, is_max_per_user_per_stream_enabled, max_per_user_per_stream, is_global_cooldown_enabled, global_cooldown_seconds, should_redemptions_skip_request_queue);
--local tt = TIM.library.createRew("теееест", "мое описание", 3000, true, "#002030", false, 0, false, 0,false, 0,false)
--TIM.effectsFunctions:KK1()
	
--	managers.mission._fading_debug_output:script().log(tostring(TIM._effectFormMenu:Param("rewardID")),  Color.green)
--managers.mission._fading_debug_output:script().log(tostring(TIM._effectsForms[TIM._effectFormMenu:Param("name")].id),  Color.green)


--for k, v in pairs(TIM._settings.TwitchRewards["29e35bac-648a-4264-83e3-0d18e70bb186"].effects.tazer or {}) do
	

function TIM:editRewardFunction(rewardID, menu)
	 --edit existing reward
		--managers.mission._fading_debug_output:script().log("1-  "..tostring(rewardID),  Color.green)
		
		TIM.tempReward={}
		TIM.tempReward["rewardID"]=rewardID
		local err, title, prompt, cost, is_enabled, background_color, is_max_per_stream_enabled, max_per_stream, is_max_per_user_per_stream_enabled, max_per_user_per_stream, is_global_cooldown_enabled, global_cooldown_seconds ,should_redemptions_skip_request_queue = TIM.library.getRew(rewardID)
		TIM.tempReward["title"] = title
		TIM.tempReward["prompt"] = prompt
		TIM.tempReward["cost"] = cost
		TIM.tempReward["is_enabled"] = is_enabled
		TIM.tempReward["background_color"] = string.lower(string.sub(background_color,2))
		TIM.tempReward["is_max_per_stream_enabled"] = is_max_per_stream_enabled
		TIM.tempReward["max_per_stream"] = max_per_stream
		TIM.tempReward["is_max_per_user_per_stream_enabled"] = is_max_per_user_per_stream_enabled
		TIM.tempReward["max_per_user_per_stream"] = max_per_user_per_stream
		TIM.tempReward["is_global_cooldown_enabled"] = is_global_cooldown_enabled
		TIM.tempReward["global_cooldown_seconds"] = global_cooldown_seconds
		TIM.tempReward["should_redemptions_skip_request_queue"] = should_redemptions_skip_request_queue
		if err==true then
			if TIM._listChannelPointsRewards:GetItem(rewardID):Text():find(" - ERROR: can't load reward") then 
			
			else
				TIM._listChannelPointsRewards:GetItem(rewardID):SetText( TIM._listChannelPointsRewards:GetItem(rewardID):Text().." - ERROR: can't load reward")
			end
		else
			TIM._rewardMenu=menu
			local _dialog_reward = TIM._rewardMenu:Menu({name = "_dialog_reward", position = "Center", align_items = "grid", w = 470, visible = true,
				auto_height = true, auto_foreground = true, always_highlighting = true, reach_ignore_focus = false, scrollbar = true, max_height = 600,
				size = 20, offset = 8, accent_color = BeardLib.Options:GetValue("MenuColor"), background_color = Color('3d005e'), background_alpha = 0.99,
				align_method = "grid", border_color = Color('ffffff'), border_visible=true })
			_dialog_reward:Divider({name = "Rewards", size = 23, text_align = "center", text = "REWARD"})
			_dialog_reward:TextBox({name = "title", text = "Title", value = TIM.tempReward["title"]})
			_dialog_reward:TextBox({name = "prompt", text = "Description", value = TIM.tempReward["prompt"]})
			_dialog_reward:NumberBox({name = "cost", text = "Cost", filter="number", value=TIM.tempReward["cost"],
				on_callback = function(item)
					item:SetValue((item.value < 1) and 1 or item.value)
				end})
			_dialog_reward:Toggle({name = "is_enabled", text = "Enabled", value = TIM.tempReward["is_enabled"]})
			_dialog_reward:ColorTextBox({name = "background_color", text = "Color", value = Color(TIM.tempReward["background_color"]), use_alpha=false})			
			_dialog_reward:NumberBox({name = "max_per_stream", text = "Max per stream", filter="number", enabled=true, value=TIM.tempReward["max_per_stream"],
				on_callback = function(item)
					item:SetValue((item.value < 0) and 0 or item.value)
				end})
			_dialog_reward:NumberBox({name = "max_per_user_per_stream", text = "Max per user per stream", filter="number", enabled=true, value=TIM.tempReward["max_per_user_per_stream"],
				on_callback = function(item)
					item:SetValue((item.value < 0) and 0 or item.value)
				end})
			_dialog_reward:NumberBox({name = "global_cooldown_seconds", text = "Global cooldown (minutes)", filter="number", enabled=true, value=TIM.tempReward["global_cooldown_seconds"],
				on_callback = function(item)
					item:SetValue((item.value < 0) and 0 or item.value)
				end})
			_dialog_reward:Toggle({name = "should_redemptions_skip_request_queue", text = "Should redemptions skip request queue", value = TIM.tempReward["should_redemptions_skip_request_queue"]})
			_dialog_reward:Button({ name = "ADD NEW EFFECT", text = "ADD NEW EFFECT", text_align = "center",
				on_callback = function(item)
					TIM._listEffectsMenu:Enable()
				end})
			_dialog_reward:Group({ name = "EffectsGroup", size = 18, text = "Effects"})
			_dialog_reward:Button({ name = "OK", text = "OK", w = 150,
			on_callback = function(item) --редактирование награды на твиче
				local err, temp = false
				if TIM.tempReward["title"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value() or TIM.tempReward["prompt"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("prompt"):Value() or TIM.tempReward["cost"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("cost"):Value() or TIM.tempReward["is_enabled"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("is_enabled"):Value() or TIM.tempReward["background_color"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("background_color"):HexValue() or TIM.tempReward["max_per_stream"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_stream"):Value() or TIM.tempReward["max_per_user_per_stream"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_user_per_stream"):Value() or TIM.tempReward["global_cooldown_seconds"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("global_cooldown_seconds"):Value() or TIM.tempReward["should_redemptions_skip_request_queue"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("should_redemptions_skip_request_queue"):Value() then
					err, temp = TIM.library.editRew(TIM.tempReward["rewardID"], 
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value(),
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("prompt"):Value(),
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("cost"):Value(),
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("is_enabled"):Value(),
					"#".. TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("background_color"):HexValue():upper(),
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_stream"):Value()>0,
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_stream"):Value(),
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_user_per_stream"):Value()>0,
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_user_per_stream"):Value(),
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("global_cooldown_seconds"):Value()>0,
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("global_cooldown_seconds"):Value()*60,
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("should_redemptions_skip_request_queue"):Value())
				end
				if err==true then
					TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("Response"):SetText("Response: "..temp)
				else
					TIM._settings.TwitchRewards[TIM.tempReward["rewardID"]].effects=TIM.tempEffects.effects
					TIM.tempReward={}
					TIM._rewardMenu:Destroy()
					TIM:save_settings()
				end
			end
			})
			_dialog_reward:Button({name = "Cancel", text = "Cancel", w = 150,
				on_callback = function(item)
					TIM._rewardMenu:Destroy()
				end })
			_dialog_reward:Divider({ name="Response", text="Response: " })
			TIM.tempEffects = {}
			TIM.tempEffects.effects = TIM._settings.TwitchRewards[rewardID].effects
			for k1, v1 in pairs((TIM.tempEffects.effects) or {}) do
				local but_effect = TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("EffectsGroup"):Button({ name = k1, text = TIM._effectsForms[k1].Name, text_align = "left", 
					on_callback = function(item1)								
						MenuUI:new({
							name = item1.name,
							background_blur=true,
							layer = 550,
							create_items = callback(self, self, "CreateEffect"),
							effect_exists=true,
							rewardID=rewardID
						})
						TIM._effectFormMenu:Enable()
					end})
				but_effect:ImageButton({ name = but_effect:Name(), w=20, h=20, offset = {0,0}, texture = "guis/textures/icons/delete",
					on_callback = function(item)
						TIM.tempEffects.effects[item.name]=nil
						TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("EffectsGroup"):GetItem(item.name):Destroy()
					end
				})
			end		
			TIM._rewardMenu:Enable()
		end
	
	
end

--if TIM.tempReward["title"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value() or TIM.tempReward["prompt"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("prompt"):Value() or TIM.tempReward["cost"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("cost"):Value() or TIM.tempReward["is_enabled"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("is_enabled"):Value() or TIM.tempReward["background_color"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("background_color"):HexValue() or TIM.tempReward["max_per_stream"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_stream"):Value() or TIM.tempReward["max_per_user_per_stream"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("max_per_user_per_stream"):Value() or TIM.tempReward["global_cooldown_seconds"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("global_cooldown_seconds"):Value() or TIM.tempReward["should_redemptions_skip_request_queue"]~=TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("should_redemptions_skip_request_queue"):Value() then
--	managers.mission._fading_debug_output:script().log(tostring(TIM.tempReward["title"]).." - "..tostring(TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value()),  Color.green)			
--	managers.mission._fading_debug_output:script().log(tostring(TIM.tempReward["prompt"]).." - "..tostring(TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("prompt"):Value()),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring(type(TIM.tempReward["cost"])).." - "..tostring(type(TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("cost"):Value())),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring(TIM.tempReward["is_enabled"]).." - "..tostring(TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("is_enabled"):Value()),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring(TIM.tempReward["background_color"]).." - "..tostring(TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("background_color"):HexValue()),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring().." - "..tostring(),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring().." - "..tostring(),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring().." - "..tostring(),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring().." - "..tostring(),  Color.green)	
--	managers.mission._fading_debug_output:script().log(tostring().." - "..tostring(),  Color.green)	
--end
--end
--[[
local file = io.open("mods/TwitchIntegrationMod/Config/config.json", "r")
local js = {}
if file then
	for k, v in pairs(json.decode(file:read("*all")) or {}) do
		js[k] = v
	end
	file:close()
end
for rewardID, v in pairs(js.TwitchRewards or {}) do
	for k1, v1 in pairs(v or {}) do
		--for k2, v2 in pairs(v1 or {}) do
			--managers.mission._fading_debug_output:script().log(tostring(k1).." - "..tostring(v1),  Color.green)
		--end
	end
end]]
--for k, v in pairs(TIM.Rewards["e9ed5682-6839-4028-af40-7f644df16fc5"].effects or {}) do
--managers.player:local_player():sound():say("g09",true,true)

--[[
	local all_peer = managers.network:session():all_peers()
loading

	for _, peer in pairs(all_peer) do
]]
--managers.mission._fading_debug_output:script().log(tostring(managers.network:session():local_peer():is_streaming_complete()),  Color.green)
--managers.mission._fading_debug_output:script().log(tostring(managers.network:session():local_peer():in_lobby()),  Color.green)


--managers.mission._fading_debug_output:script().log(tostring(Network:is_server()).." - "..tostring(managers.network:session():are_peers_done_streaming()),  Color.green)
				--TIM.effectsFunctions[k](rewardID)
				--dofile("mods/TwitchIntegrationMod/Effects/".. k.id .."/".. k.id .. ".lua")
	--		end
--TIM.effectsFunctions["medic"]("e9ed5682-6839-4028-af40-7f644df16fc5")
--managers.mission._fading_debug_output:script().log(tostring(TIM.library.get_reward()),  Color.green)"e9ed5682-6839-4028-af40-7f644df16fc5"
--managers.mission._fading_debug_output:script().log(tostring(TIM._settings.TwitchRewards["e9ed5682-6839-4028-af40-7f644df16fc5"].effects.medic.Count),  Color.green)
--TIM.library.createRew()
--TIM.BotActive = true
--TIM.BotActive = true
--local s = os.execute("tasklist /fi \"name eq BotTwitc.exe\"")
--managers.chat:_receive_message(1, "1", tostring(as), Color(1,1,1))
-- Set FOV to 80 "units/pd2_dlc_overkill_pack/weapons/wpn_fps_rpg7_pts/wpn_fps_rpg7_m_rocket"
--local unit_done1 = World:spawn_unit(Idstring("units/pd2_dlc_overkill_pack/weapons/wpn_fps_rpg7_pts/wpn_fps_rpg7_m_rocket"), managers.player:local_player():position(), managers.player:local_player():rotation())
--dofile('mods/TwitchIntegrationMod/Rewards/fov.lua')
--local file, err = io.open("mods/TwitchIntegrationMod/Rewards/speed.lua", "r")
--	local line = file:read()
--	line = file:read()
--	line = tostring(line)
	
--	file:close()
	--
--local player_pos = managers.player:local_player():camera():play_shaker("whizby", 0.1)
--SoundDevice:set_rtpc("downed_state_progression", 0)
--managers.environment_controller:set_downed_value(0)
--managers.user:set_setting("fps_cap", 61)