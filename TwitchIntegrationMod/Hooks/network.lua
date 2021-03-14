TIM:Post(BaseNetworkSession, "spawn_players", function(is_drop_in) --HUDBlackScreen:init(hud) lib\network\base function BaseNetworkSession:spawn_players(is_drop_in)
	--TIM:Reward_co_create()
	--managers.mission._fading_debug_output:script().log(tostring("whisper_mode"),  Color.green)
	
	if managers.groupai:state():whisper_mode() == true then
		--TIM.policeCallOneTime=false
	--	managers.mission._fading_debug_output:script().log(tostring("whisper_mode true"),  Color.green)
		TIM:EnableTacticReward(true, 1)
		TIM:EnableTacticReward(true, 3)
		TIM:EnableTacticReward(false, 2)
		--managers.mission._fading_debug_output:script().log(tostring(false),  Color.green)
	else
		--TIM.policeCallOneTime=false
		--managers.mission._fading_debug_output:script().log(tostring("whisper_mode false"),  Color.green)
		TIM:EnableTacticReward(true, 2)
		TIM:EnableTacticReward(true, 3)
		TIM:EnableTacticReward(false, 1)
		--managers.mission._fading_debug_output:script().log(tostring(false),  Color.green)
	end
	--TIM:Take_word_from_file()
end)