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
	--managers.mission._fading_debug_output:script().log(tostring(k)..tostring(v),  Color.green)
	--managers.mission._fading_debug_output:script().log(tostring(Utils:IsInGameState()),  Color.green)
	managers.user:set_setting("fps_cap", 60)
	
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