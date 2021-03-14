--[[
if managers.network:session() then
	if TIM.LoadComplete==true or managers.network:session():local_peer():in_lobby()==true then
		if TIM.BotChatActive == true or TIM.BotPointsActive==true then
			local name, color, message, badges = TIM.library.get_message()
			if name ~= "NULL" then 
				managers.chat:_receive_message_twitch(1, name, message, Color(color:sub(2)), badges)		
			end
		end
	end
end
]]
TIM:Reward_co_resume()
TIM:Chat_co_resume()