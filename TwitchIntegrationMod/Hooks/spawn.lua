
TIM:Post(IngameWaitingForPlayersState, "start_game_intro", function(self)
	TIM:Game_setup()
	--TIM:Chat()
end)
--TIM:Post(ChatGui, "init", function(self)
	--TIM.LoadComplete=true
	--TIM:Chat()
--end)
--TIM:Post(HUDChat, "init", function(self)
	--TIM.LoadComplete=true
	--TIM:Chat()
--end)
TIM:Post(HUDHeistTimer, "set_time", function(self, time)
	 
	--TIM:Take_word_from_file()
end)

Hooks:Add("NetworkManagerOnPeerAdded", "NetworkManagerOnPeerAdded_TW", function(peer, peer_id)
	if TIM.BotChatActive == true or TIM.BotPointsActive == true then
		if Network:is_server() then
			
			DelayedCalls:Add("DelayedTWAnnounce" .. tostring(peer_id), 2, function()

				local message = "Hello! I have 'Twitch Integration Mod'. In this lobby my viewers can actually break my game. So be careful ;)"
				
				local peer2 = managers.network:session() and managers.network:session():peer(peer_id)
				if peer2 then
					peer2:send("send_chat_message", ChatManager.GAME, message)
				end
			end)
		end
	end
end)



