--[[
local temp
if Utils:IsInGameState()==nil and Utils:IsInLoadingState()==nil then
	temp=true
elseif Utils:IsInGameState()~=nil then
	temp = true
else
	temp = false
end
]]
--managers.user:set_setting("fps_cap", 60)
--managers.mission._fading_debug_output:script().log(tostring(temp),  Color.green)
if managers.network:session() then
	if TIM.LoadComplete==true or managers.network:session():local_peer():in_lobby()==true then
		--managers.network:session():local_peer():set_streaming_status(0)
		if TIM.BotChatActive == true or TIM.BotPointsActive==true then
			--if (TIM.BotChatActive == true or TIM.BotPointsActive==true) then
				--managers.mission._fading_debug_output:script().log(tostring(((Utils:IsInGameState()==nil and Utils:IsInLoadingState()==nil) or Utils:IsInGameState()~=nil)),  Color.green)
				local name, color, message, badges = TIM.library.get_message()
				if name ~= "NULL" then 
					--local n1 = str:find("@")
					--local n2 = str:find("@", n1+1)
					--local nickname = str:sub(0, n1-1)
					--name = "0TW0" .. name
					--local col=str:sub(n1+2, n2-1)
					--local messag=str:sub(n2+1)
					managers.chat:_receive_message_twitch(1, name, message, Color(color:sub(2)), badges)		
				end
			--end
		end
	end
end
--[[
if (Utils:IsInGameState()==nil and Utils:IsInLoadingState()==nil) or Utils:IsInGameState()~=nil then
	if TIM.BotChatActive == true or TIM.BotPointsActive==true then
		--if (TIM.BotChatActive == true or TIM.BotPointsActive==true) then
			--managers.mission._fading_debug_output:script().log(tostring(((Utils:IsInGameState()==nil and Utils:IsInLoadingState()==nil) or Utils:IsInGameState()~=nil)),  Color.green)
			local str = TIM.library.get_message()
			if str ~= "NULL" then 
				local n1 = str:find("@")
				local n2 = str:find("@", n1+1)
				local nickname = str:sub(0, n1-1)
				nickname = "0TW0" .. nickname
				local col=str:sub(n1+2, n2-1)
				local messag=str:sub(n2+1)
				managers.chat:_receive_message(1, nickname, messag, Color(col))		
			end
		--end
	end
else
	DelayedCalls:Add("TIM_Message", TIM.MessageQueue, function()
		TIM.MessageQueue=TIM.MessageQueue+1
		if TIM.BotChatActive == true or TIM.BotPointsActive==true then
			--if (TIM.BotChatActive == true or TIM.BotPointsActive==true) then
				--managers.mission._fading_debug_output:script().log(tostring(((Utils:IsInGameState()==nil and Utils:IsInLoadingState()==nil) or Utils:IsInGameState()~=nil)),  Color.green)
				local str = TIM.library.get_message()
				if str ~= "NULL" then 
					local n1 = str:find("@")
					local n2 = str:find("@", n1+1)
					local nickname = str:sub(0, n1-1)
					nickname = "0TW0" .. nickname
					local col=str:sub(n1+2, n2-1)
					local messag=str:sub(n2+1)
					managers.chat:_receive_message(1, nickname, messag, Color(col))
					TIM.MessageQueue=TIM.MessageQueue-1					
				end
			--end
		end
	end)
end]]
--[[
	DelayedCalls:Add("TIM_Message", 3, function()
        if (TIM.BotChatActive == true or TIM.BotPointsActive==true) then
			local str = TIM.library.get_message()
			if str ~= "NULL" then 
				local n1 = str:find("@")
				local n2 = str:find("@", n1+1)
				local nickname = str:sub(0, n1-1)
				nickname = "0TW0" .. nickname
				local col=str:sub(n1+2, n2-1)
				local messag=str:sub(n2+1)
				managers.chat:_receive_message(1, nickname, messag, Color(col))
			end	
		
		end
		TIM.LoadComplete=false
    end)
	]]
--else
--[[
	if (TIM.BotChatActive == true or TIM.BotPointsActive==true) then
		local str = TIM.library.get_message()
		if str ~= "NULL" then 
			local n1 = str:find("@")
			local n2 = str:find("@", n1+1)
			local nickname = str:sub(0, n1-1)
			nickname = "0TW0" .. nickname
			local col=str:sub(n1+2, n2-1)
			local messag=str:sub(n2+1)
			managers.chat:_receive_message(1, nickname, messag, Color(col))		
		end
	end]]
--end