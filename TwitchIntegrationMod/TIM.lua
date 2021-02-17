TIM = TIM or class()
TIM.save_path = SavePath .. "TwitchConfig.json"
TIM.mod_path = 'mods\\TwitchIntegrationMod\\'
function TIM:Init()
	TIM.InLobby = false
	 MenuUI:new({
        offset = 6,
        toggle_key = TIM.Options:GetValue("TWToggleKey"),
        toggle_clbk = callback(self, self, "ShowMainMenu"),
		create_items = callback(self, self, "CreateMainMenu"),
		use_default_close_key = true     
    })	
	
	TIM.LoadComplete=false
	TIM.Rewards={}
	TIM._settings={}
	TIM.effectsFunctions={}
	TIM.Values = {}
	TIM.Chat_option = true
	local _, library = blt.load_native('mods\\TwitchBotDLL\\TwitchBot.dll')
	TIM.library = library
	TIM.BotChatActive=TIM.library.get_on_IRC()
	TIM.BotPointsActive=TIM.library.get_on_Pubsub()
	local file = io.open(TIM.save_path, "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			TIM._settings[k] = v
		end
		file:close()
	else
		file = io.open(TIM.save_path, "w")
		if file then
			file:write("{\"OAUTH\":\"\",\"startBotOnStart\":false, \"Nickname\":\"\", \"UserID\":\"\", \"TwitchRewards\":{}, \"enableChat\":true, \"enableChannelPoints\":true}")
			file:close()
		end
		TIM:load_settings()
	end
	TIM.library.prepareAPI(TIM._settings.Nickname, TIM._settings.OAUTH, TIM._settings.enableChat, TIM._settings.enableChannelPoints, TIM._settings.UserID)

	if TIM._settings.startBotOnStart == true and TIM.BotChatActive == false and TIM.BotPointsActive == false then
		TIM.library.start_bot(TIM._settings.Nickname, TIM._settings.OAUTH, TIM._settings.enableChat, TIM._settings.enableChannelPoints, TIM._settings.UserID)
		TIM.BotChatActive = TIM.library.get_on_IRC()
		TIM.BotPointsActive=TIM.library.get_on_Pubsub()
	end
	
	TIM._effectsForms={}
	local rewards_files = SystemFS:list(TIM.mod_path .. 'Effects', true)
	for i = 1, #rewards_files, 1 do
		local folder_name = rewards_files[i]
		local dataJSON = io.open(TIM.mod_path .. 'Effects\\'..folder_name..'\\data.json', "r")
		if dataJSON then
			TIM._effectsForms[folder_name]={}
			for k, v in pairs(json.decode(dataJSON:read("*all")) or {}) do
				TIM._effectsForms[folder_name][k] = v
			end
			dataJSON:close()
			dofile(TIM.mod_path .. 'Effects\\'..folder_name..'\\'..folder_name..'.lua')
		end
	end
	local somethingChanged = false
	for rewardID, rewardValue in pairs(TIM._settings.TwitchRewards or {}) do
		for effectID, effectValue in pairs(TIM._settings.TwitchRewards[rewardID].effects or {}) do
			for parametrID, parametrValue in pairs(TIM._effectsForms[effectID].TIM or {}) do
				if TIM._settings.TwitchRewards[rewardID].effects[effectID][parametrID] ==nil then
					TIM._settings.TwitchRewards[rewardID].effects[effectID][parametrID]={}
					if TIM._effectsForms[effectID].TIM[parametrID].Type=="ComboBox" then
						TIM._settings.TwitchRewards[rewardID].effects[effectID][parametrID].SelectedItem = TIM._effectsForms[effectID].TIM[parametrID].Items[1].name
					end
					TIM._settings.TwitchRewards[rewardID].effects[effectID][parametrID].Value = TIM._effectsForms[effectID].TIM[parametrID].defaultValue
					somethingChanged = true
				end
			end
		end
	end
	if somethingChanged == true then
		TIM:save_settings()
	end
	MenuUI:new({
		name = "ListOfEffects",
		background_blur=true,
		layer = 550,
		create_items = callback(self, self, "CreateListOfEffects"),
	})
end

function TIM:newRewardFunction(menu)
	
	TIM._rewardMenu=menu
	TIM.tempEffects={}
	TIM.tempEffects.effects={}
	local _dialog_reward = TIM._rewardMenu:Menu({name = "_dialog_reward", position = "Center", align_items = "grid", w = 470, visible = true,
		auto_height = true, auto_foreground = true, always_highlighting = true, reach_ignore_focus = false, scrollbar = true, max_height = 600,
		size = 20, offset = 8, accent_color = BeardLib.Options:GetValue("MenuColor"), background_color = Color('3d005e'), background_alpha = 0.99,
		align_method = "grid", border_color = Color('ffffff'), border_visible=true })
	_dialog_reward:Divider({name = "Rewards", size = 23, text_align = "center", text = "REWARD"})
	_dialog_reward:TextBox({name = "title", text = "Title"})
	_dialog_reward:TextBox({name = "prompt", text = "Description"})
	_dialog_reward:NumberBox({name = "cost", text = "Cost", filter="number", value=1,
		on_callback = function(item)
			item:SetValue((item.value < 1) and 1 or item.value)
		end})
	_dialog_reward:Toggle({name = "is_enabled", text = "Enabled", value = true})
	_dialog_reward:ColorTextBox({name = "background_color", text = "Color", value = Color(1,1,1), use_alpha=false})			
	_dialog_reward:NumberBox({name = "max_per_stream", text = "Max per stream", filter="number", enabled=true, value=0,
		on_callback = function(item)
			item:SetValue((item.value < 0) and 0 or item.value)
		end})
	_dialog_reward:NumberBox({name = "max_per_user_per_stream", text = "Max per user per stream", filter="number", enabled=true, value=0,
		on_callback = function(item)
			item:SetValue((item.value < 0) and 0 or item.value)
		end})
	_dialog_reward:NumberBox({name = "global_cooldown_seconds", text = "Global cooldown (minutes)", filter="number", enabled=true, value=0,
		on_callback = function(item)
			item:SetValue((item.value < 0) and 0 or item.value)
		end})
	_dialog_reward:Toggle({name = "should_redemptions_skip_request_queue", text = "Should redemptions skip request queue", value = false})
	_dialog_reward:Button({ name = "ADD NEW EFFECT", text = "ADD NEW EFFECT", text_align = "center",
		on_callback = function(item)
			TIM._listEffectsMenu:Enable()
		end})
	_dialog_reward:Group({ name = "EffectsGroup", size = 18, text = "Effects"})
	_dialog_reward:Divider({ name="Response", text="Response: " })
	_dialog_reward:Button({ name = "OK", text = "OK", w = 150,
		on_callback = function(item) --создание награды на твиче
			local err, rewardIDtemp = TIM.library.createRew(TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value(),
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
			--managers.mission._fading_debug_output:script().log("1-  "..tostring(temp),  Color.green)
			if err==true then
				TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("Response"):SetText("Response: "..rewardIDtemp)
			else
				local but = TIM._listChannelPointsRewards:Button({ name = tostring(rewardIDtemp), text = TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value(), text_align = "left", 
				on_callback = function(item2) --создание подгрузки данных с твича 
					MenuUI:new({
						name = "Reward",
						layer=500,
						background_blur=true, --(o, base_callback_class, base_callback_func_name, base_callback_param)
						create_items = callback(self, self, "editRewardFunction", item2.name)
					})
					--TIM._rewardMenu:Enable()
				end })
				but:ImageButton({name = but:Name(), w=20, h=20, offset = {0,0}, texture = "guis/textures/icons/delete",
					on_callback = function(item)
						TIM.library.deleteRew(item.name)
						TIM._listChannelPointsRewards:GetItem(item.name):Destroy()
						TIM._settings.TwitchRewards[item.name]=nil
						TIM:save_settings()
					end})
				TIM._settings.TwitchRewards[rewardIDtemp] ={}
				TIM._settings.TwitchRewards[rewardIDtemp].title = TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value()
				TIM._settings.TwitchRewards[rewardIDtemp].effects=TIM.tempEffects.effects
				TIM._rewardMenu:Destroy()
			end
			
			TIM:save_settings()
		end
	})
	_dialog_reward:Button({name = "Cancel", text = "Cancel", w = 150,
		on_callback = function(item)
			TIM._rewardMenu:Destroy()
		end })
	TIM._rewardMenu:Enable()
	
end

function TIM:editRewardFunction(rewardID, menu)
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
	TIM.tempReward["global_cooldown_seconds"] = global_cooldown_seconds/60
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
				TIM._settings.TwitchRewards[TIM.tempReward["rewardID"]].title = TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value()
				TIM._settings.TwitchRewards[TIM.tempReward["rewardID"]].effects=TIM.tempEffects.effects
				TIM._listChannelPointsRewards:GetItem(TIM.tempReward["rewardID"]):SetText(TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("title"):Value())
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

function TIM:CreateMainMenu(menu) --главное боковое меню
    TIM._menu = menu
    local accent = Color(1, 1, 1)
    TIM._holder = TIM._menu:DivGroup({
        name = "Twitch Integration Mod",
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
		align_method = "grid"
    })
	
	TIM._dialog = TIM._menu:Menu({
        name = "dialog",
        position = "Center",
        align_items = "grid",
        w = 320,
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
	
	TIM._dialog:Divider({ name = "Divider", text_align = "center", text = "Warning!" })
	TIM._dialog:Divider({ name = "Divider", text = "Before entering the OAUTH code, make sure that no one can see it. Are you sure you want to enter?" })
	TIM._dialog:Button({ name = "Yes", text = "Yes", text_align = "center", w=150,
		on_callback = function(item)
			TIM._dialog:SetVisible(false)
			TIM._dialog_OAUTH:SetVisible(true)
		end })
	TIM._dialog:Button({ name = "NO", text = "NO", text_align = "center", w=150,
		on_callback = function(item)
			TIM._dialog:SetVisible(false)
		end })
	
	TIM._dialog_OAUTH = TIM._menu:Menu({
        name = "dialog_OAUTH",
        position = "Center",
        align_items = "grid",
        w = 400,
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
	
	TIM._dialog_OAUTH:Divider({ name = "Divider", text_align = "center", text = "OAUTH code" })
	TIM._dialog_OAUTH:TextBox({ name = "dialog_OAUTH_text",  text = "Your OAUTH code:", w=400, value = TIM._settings.OAUTH, })
	TIM._dialog_OAUTH:Button({ name = "Yes", text = "Enter", text_align = "center", w=190,
		on_callback = function(item)
			TIM._settings.OAUTH = TIM._dialog_OAUTH:GetItem("dialog_OAUTH_text"):Value()
			TIM._dialog_OAUTH:SetVisible(false)
		end })
	TIM._dialog_OAUTH:Button({ name = "NO", text = "Cancel", text_align = "center", w=190,
		on_callback = function(item)
			TIM._dialog_OAUTH:SetVisible(false)
		end })
	TIM._holder:Image({ name = "MyImageButton", texture = "guis/textures/icons/twch", w=80, h=80 })
	
	local pann = TIM._holder:DivGroup({ name = "2ndMenu", text = "Settings", w=300, align_method = "grid" })
	pann:TextBox({ name = "twitch_nickname", w=280, text = "Twitch login", value = "",
		on_callback = function(item)
			TIM._settings.Nickname = item:Value()
		end })
	TIM._holder:Toggle({ name = "ActivateChat", text = "Twitch Chat in game", value=false, w=190,
		on_callback = function(item)
			TIM._settings.enableChat = item:Value()
		end })
	
	TIM._holder:Toggle({ name = "Rewards", text = "Channel Points", value = false, w=190,
		on_callback = function(item)
			TIM._settings.enableChannelPoints = item:Value()
		end })
	pann:Toggle({ name = "startBotOnStart", text = "Launch bot on game start", value=false, w=294,
		on_callback = function(item)
			TIM._settings.startBotOnStart = item:Value()
		end })
	TIM._holder:Button({ name = "MyButton", text = "SET OAUTH KEY", text_align = "center", w=124,
		on_callback = function(item)
			TIM._dialog:SetVisible(true)
		end })
	TIM._holder:Button({ name = "launchBotButton", text = "LAUNCH BOT", text_align = "center", w=124,
		on_callback = function(item)
			if (TIM._holder:GetItem("Rewards"):Value() or TIM._holder:GetItem("ActivateChat"):Value()) and pann:GetItem("twitch_nickname"):Value() ~= "" then
				TIM.BotChatActive=TIM.library.get_on_IRC()
				TIM.BotPointsActive=TIM.library.get_on_Pubsub()
				if TIM.BotChatActive == true or TIM.BotPointsActive == true then
					TIM.library.stop_Bot()
					TIM._holder:GetItem("launchBotButton"):SetText("LAUNCH BOT")
					TIM.BotChatActive=TIM.library.get_on_IRC()
					TIM.BotPointsActive=TIM.library.get_on_Pubsub()
				else
					TIM._holder:GetItem("launchBotButton"):SetText("STOP BOT")
					TIM:save_settings()
					TIM.library.start_bot(string.lower(TIM._settings.Nickname), TIM._settings.OAUTH, TIM._settings.enableChat, TIM._settings.enableChannelPoints, TIM._settings.UserID)
					TIM.BotChatActive = TIM.library.get_on_IRC()
					TIM.BotPointsActive = TIM.library.get_on_Pubsub()
				end
			end
		end
	})
	if TIM.BotChatActive == true or TIM.BotPointsActive == true then
		TIM._holder:GetItem("launchBotButton"):SetText("STOP BOT")
	end
	TIM._holder:Button({ name = "MyButton", text = "SAVE SETTINGS", text_align = "center", w=124,
		on_callback = function(item)
			TIM:save_settings()
		end })	
	TIM._CreateRewardButton = TIM._holder:Button({ name = "MyButton", text = "CREATE NEW REWARD", text_align = "center", 
		on_callback = function(item)
			MenuUI:new({
				name = "Reward",
				layer=500,
				background_blur=true,
				create_items = callback(self, self, "newRewardFunction")
			})
		end })
	TIM._listChannelPointsRewards = TIM._holder:Group({ name = "Rewards", size = 18, text = "Channel Points Rewards"})
	for RewardID, value in pairs((TIM._settings.TwitchRewards) or {}) do --подгрузка наград из файла config и добавление их в группу
		local but = TIM._listChannelPointsRewards:Button({ name = RewardID, text = value.title, text_align = "left", 
			on_callback = function(item)
					MenuUI:new({
						name = "Reward",
						layer=500,
						background_blur=true,
						create_items = callback(self, self, "editRewardFunction", item.name)
					})
					
				--end
			end})
		but:ImageButton({
			name = but:Name(),
			--position=,
			w=20,
			h=20,
			offset = {0,0},
			texture = "guis/textures/icons/delete",
			on_callback = function(item)
				TIM.library.deleteRew(item.name)
				TIM._listChannelPointsRewards:GetItem(item.name):Destroy()
				TIM._settings.TwitchRewards[item.name]=nil
				TIM:save_settings()
			end
		})
	end
end

function TIM:CreateEffect(menu) --окошко редактирования эффекта
	TIM._effectFormMenu = menu
	local effectMenu = TIM._effectFormMenu:Menu({name = "effectMenu", position = "Center", align_items = "grid", w = 300, visible = true, auto_height = true, auto_foreground = true, always_highlighting = true,
		reach_ignore_focus = false,
		scrollbar = false,
		max_height = 500,
		size = 20,
		offset = 8,
		accent_color = BeardLib.Options:GetValue("MenuColor"),
		background_color = Color('3d005e'),
		background_alpha = 0.99,
		align_method = "grid",
		border_color = Color('ffffff'),
		border_visible=true,
	})
	effectMenu:Divider({name = "Name", label="effect", size = 18, text_align = "center", text = TIM._effectsForms[TIM._effectFormMenu:Param("name")].Name})
	effectMenu:Divider({name = "Description",  label="effect", size = 18, text_align = "left", text = TIM._effectsForms[TIM._effectFormMenu:Param("name")].Description})
	if TIM._effectFormMenu:Param("effect_exists")==true then
		for k, v in pairs(TIM._effectsForms[TIM._effectFormMenu:Param("name")].TIM or {}) do
			local val = v.defaultValue
			if v.Type=="NumberBox" then
				local fun
				if v.LessThanZero==false then
					if v.maxValue ~= nil then
						fun = function(item)
							if item.value < 0 then
								item:SetValue(0)
							end
							if item.value> item.maxValue then
								item:SetValue(item.maxValue)
							end
						end
					else
						fun = function(item)
							if item.value < 0 then
								item:SetValue(0)
							end						
						end
					end
				else
					if v.maxValue ~= nil then
						fun = function(item)
							if math.abs(item.value)> math.abs(item.maxValue) then
								item:SetValue(item.maxValue*TIM:sign(item.value))
							end
						end
					else
						fun = function(item)
					
						end
					end
				end
				
				if TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][k] then
					val = TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][k].Value
				end
				effectMenu:NumberBox({name = k, text = v.Name, filter="number", value=val,maxValue=v.maxValue, on_callback = fun})	------------------подгрузка значений			
			elseif v.Type=="ComboBox" then
				--local val = v.defaultValue
				if TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][k] then
					val = TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][k].Value
				end
				effectMenu:ComboBox({
					name = k,
					text = v.Name,
					items = v.Items,
					value = val,
					free_typing = false
				})
			elseif v.Type=="Toggle" then
				--local val = v.defaultValue
				if TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][k] then
					val = TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][k].Value
				end
				effectMenu:Toggle({
					name = k,
					text = v.Name,
					value = val
				})
			else
			
			end
		end
	else
		for k, v in pairs(TIM._effectsForms[TIM._effectFormMenu:Param("name")].TIM or {}) do
			if v.Type=="NumberBox" then
				local fun
				if v.LessThanZero==false then
					if v.maxValue ~= nil then
						fun = function(item)
							if item.value < 0 then
								item:SetValue(0)
							end
							if item.value> item.maxValue then
								item:SetValue(item.maxValue)
							end
						end
					else
						fun = function(item)
							if item.value < 0 then
								item:SetValue(0)
							end						
						end
					end
				else
					if v.maxValue ~= nil then
						fun = function(item)
							if math.abs(item.value)> math.abs(item.maxValue) then
								item:SetValue(item.maxValue*TIM:sign(item.value))
							end
						end
					else
						fun = function(item)
					
						end
					end
				end
				effectMenu:NumberBox({name = k, text = v.Name, filter="number", value=v.defaultValue, maxValue=v.maxValue, on_callback = fun})								
			elseif v.Type=="ComboBox" then
				effectMenu:ComboBox({
					name = k,
					text = v.Name,
					items = v.Items,
					value = v.defaultValue,
					free_typing = false,
					on_callback = function(item)
						--item:SetValue(item:Value())
						--managers.mission._fading_debug_output:script().log(tostring(item:SelectedItem().name),  Color.green)
						--managers.mission._fading_debug_output:script().log(tostring(item:Value()),  Color.green)
						--log("Selected item", tostring(item:SelectedItem()))
						--log("Index", tostring(item:Value()))
					end
				})
			elseif v.Type=="Toggle" then
				effectMenu:Toggle({
					name = k,
					text = v.Name,
					value = v.defaultValue
				})
			else
			
			end
		end
	end
	
	effectMenu:Button({ name = "OK", text = "OK", w = 140,
		on_callback = function(item)
			TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id]={}
			for k, v in pairs(TIM._effectFormMenu:GetMenu("effectMenu"):Items() or {}) do				
				TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][v:Name()]={}
				if TIM._effectFormMenu:GetMenu("effectMenu"):GetItemWithType(v:Name(), "ComboBox") then
					TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][v:Name()].SelectedItem=v:SelectedItem().name
				end
				TIM.tempEffects.effects[TIM._effectsForms[TIM._effectFormMenu:Param("name")].id][v:Name()].Value=v:Value()
			
			end
			if TIM._effectFormMenu:Param("effect_exists")==false then
				local but = TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("EffectsGroup"):Button({name = TIM._effectsForms[TIM._effectFormMenu:Param("name")].id, size = 18, text_align = "left", text = TIM._effectsForms[TIM._effectFormMenu:Param("name")].Name,
					on_callback = function(item1)
						MenuUI:new({
							name = item1.name,
							background_blur=true,
							layer = 550,
							create_items = callback(self, self, "CreateEffect"),
							effect_exists=true
						})
						TIM._effectFormMenu:Enable()
					end	})
				but:ImageButton({
					name = but:Name(),
					w=20,
					h=20,
					offset = {0,0},
					texture = "guis/textures/icons/delete",
					on_callback = function(item)
						TIM.tempEffects.effects[item.name]=nil
						TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("EffectsGroup"):GetItem(item.name):Destroy()
					end
				})
			end
			TIM._effectFormMenu:Destroy()
		end})
	effectMenu:Button({ name = "Cancel", text = "Cancel", w = 140,
		on_callback = function(item)		
			TIM._effectFormMenu:Destroy()
		end})
end

function TIM:CreateListOfEffects(menu) --список всех эффектов
	TIM._listEffectsMenu=menu
	local _dialogListEffects = TIM._listEffectsMenu:Menu({
		name = "_dialog_List_Effects",
		position = "Center",
		align_items = "grid",
		w = 300,
		h = 500,
		visible = true,
		auto_height = false,
		auto_foreground = true,
		always_highlighting = true,
		reach_ignore_focus = false,
		scrollbar = false,
		max_height = 500,
		size = 20,
		offset = 8,
		accent_color = BeardLib.Options:GetValue("MenuColor"),
		background_color = Color('000000'),
		background_alpha = 0.99,
		align_method = "grid",
		border_color = Color('ffffff'),
		border_visible=true,
	})
	
	_dialogListEffects:ImageButton({
        name = "CloseButton",
		w=20,
		h=20,
		offset = {270,6},
        texture = "guis/textures/icons/close",
        on_callback = function(item)
            TIM._listEffectsMenu:Disable()
        end
    })
	local _dialogList = _dialogListEffects:Menu({
		name = "_dialog_List_Effects",
		position = "Center",
		align_items = "grid",
		w = 300,
		visible = true,
		auto_height = false,
		auto_foreground = true,
		always_highlighting = true,
		reach_ignore_focus = false,
		scrollbar = true,
		h = 500,
		size = 20,
		offset = 8,
		accent_color = BeardLib.Options:GetValue("MenuColor"),
		background_color = Color('000000'),
		background_alpha = 0.99,
		align_method = "grid",
		border_color = Color('ffffff'),
		border_visible=true,
	})
	for k, v in pairs(TIM._effectsForms or {}) do
		_dialogList:Button({
			name = TIM._effectsForms[k].id,
			text = TIM._effectsForms[k].Name,
			on_callback = function(item)
				if TIM._rewardMenu:GetItem("_dialog_reward"):GetItem("EffectsGroup"):GetItem(item.name) == nil then
					TIM._listEffectsMenu:Disable()
					MenuUI:new({
						name = item.name,
						background_blur=true,
						layer = 550,
						create_items = callback(self, self, "CreateEffect"),
						effect_exists=false
					})
					TIM._effectFormMenu:Enable()
				end
			end
		})
	end
end


function TIM:ShowMainMenu(menu, opened)
	if opened then
		local pann = TIM._holder:GetItem("2ndMenu")
		if managers.player:player_unit() then
			game_state_machine:current_state():set_controller_enabled(false)
		end
		pann:GetItem("startBotOnStart"):SetValue(TIM._settings.startBotOnStart)
		pann:GetItem("twitch_nickname"):SetValue(TIM._settings.Nickname)
		TIM._holder:GetItem("ActivateChat"):SetValue(TIM._settings.enableChat)
		TIM._holder:GetItem("Rewards"):SetValue(TIM._settings.enableChannelPoints)
		
    else
		game_state_machine:current_state():set_controller_enabled(true)
        TIM._menu:disable()
    end
end

function TIM:Game_setup()
	if managers.hud ~= nil then 
		TIM.hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
		TIM.player = managers.player:local_player()
		TIM.M_groupAI = managers.groupai
		TIM.AIState = TIM.M_groupAI:state()
		TIM.Active_safe=false
	end
end

function TIM:Spawn_position(onPlayer) 
	local player_pos = managers.player:local_player():position()
	
	--local unit_done
	if onPlayer == false then
		local Aim_Pos = Utils:GetPlayerAimPos(managers.player:local_player(), 10000)
		if tostring(Aim_Pos):find("Vector3") then
			local summ_x = player_pos.x  - Aim_Pos.x
			local summ_x_abs = math.abs(summ_x)
			local summ_y = player_pos.y - Aim_Pos.y
			local summ_y_abs = math.abs(summ_y)
			local sign_x = TIM:sign(summ_x)*-1	
			local sign_y = TIM:sign(summ_y)*-1
			local summ_c = math.sqrt(summ_x^2 +summ_y^2)		
			summ_c = summ_c > 300 and 300 or summ_c-30
			
			local tang = math.atan(summ_x_abs/summ_y_abs)
			summ_x_abs=summ_c*math.sin(tang)
			summ_y_abs=summ_c*math.cos(tang)
			player_pos = player_pos + Vector3(summ_x_abs*sign_x, summ_y_abs*sign_y, 0)	
			player_rot = Rotation(managers.player:local_player():camera():rotation():yaw()-180, 0, 0)
		end
	end
	--unit_done = World:spawn_unit( unit_name, player_pos, Rotation(managers.player:local_player():camera():rotation():yaw()-180, 0, 0) )
		
	--if enemy == true then
		--local team_id = tweak_data.levels:get_default_team_ID( unit_done:base():char_tweak().access == "gangster" and "gangster" or "combatant" )
		--unit_done:movement():set_team( TIM.AIState:team_data( team_id ) )		
	--end
	return player_pos, player_rot--, unit_done
end
function TIM:Spawn_unit(enemy, unit_name, pos, rot) 
	local unit_done = World:spawn_unit( unit_name, pos, rot, 0, 0) 
	if enemy == true then
		local team_id = tweak_data.levels:get_default_team_ID( unit_done:base():char_tweak().access == "gangster" and "gangster" or "combatant" )
		unit_done:movement():set_team( TIM.AIState:team_data( team_id ) )
	end
	return unit_done
end
function TIM:save_settings()
	local file = io.open(TIM.save_path, "w+")
	if file then
		file:write(json.encode(TIM._settings))
		file:close()
	end
end

function TIM:load_settings()
	local file = io.open(TIM.save_path, "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			TIM._settings[k] = v
		end
		file:close()
	end
end

function TIM:Post(clss, func, after_orig)
	Hooks:PostHook(clss, func, "TIM_"..func, after_orig)
end


function TIM:Take_word_from_file()
	if TIM.Active_safe == false and managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2).panel:child("point_of_no_return_panel"):visible()==false and TIM.BotPointsActive == true then		
		local rew_temp = TIM.library.get_reward()
		
		if rew_temp ~= "NULL" then
			TIM:Redeem_reward(rew_temp)
		end
	end
end

function TIM:fon_function()	
	local lin = TIM.hud.panel:bitmap({ name = "lin_bitmap", visible = false, layer = 0, color = Color(1, 1, 1), w = 1, h = 1, x =0, y =0 })
	return lin
end

function TIM:sign(x)
  return x>0 and 1 or x<0 and -1 or 0
end

function TIM:Redeem_reward(rewardID)
	if Network:is_server() then
		while not Utils:IsInHeist() == true do
			wait(3)
		end
		while not Utils:IsInCustody() == false do
			wait(3)
		end
		
		if TIM._settings.TwitchRewards[rewardID] ~= nil then
			for k, v in pairs(TIM._settings.TwitchRewards[rewardID].effects or {}) do
				TIM.effectsFunctions[k](rewardID)
			end
		end		
	end
end

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
	local numbers = {}
	for i=0, tableCellsCount-1, 1 do
		local num = find_number(summ_all_points, points)
		local num_s = find_number(summ_all_boosts, stat_boosts_points)
		table.insert(numbers, {num, num_s})		
		
		
		
		cell_pan:set_bottom(window_bitmap:bottom())
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
	end
	---------------------------------------------------------------
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
			if math.floor(cell_pan:left()%111) == 0 then
				local p = managers.menu_component._main_panel
				local name = "sound tick_sound"  
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
			window_bitmap:set_alpha(math.lerp(window_bitmap:alpha(), 0 ,p))
			text_line:set_alpha(math.lerp(text_line:alpha(), 0 ,p))
		end
	end)
    
	c1x = cell_pan:world_x()
	
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
	end)		
end