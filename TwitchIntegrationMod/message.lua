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
--managers.mission._fading_debug_output:script().log(tostring(temp),  Color.green)

if managers.network:session():local_peer():is_streaming_complete() or Utils:IsInGameState()==nil then
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