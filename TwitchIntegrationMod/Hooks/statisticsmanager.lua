--function GamePlayCentralManager:stop_the_game() function StatisticsManager:stop_session(data)
TIM:Post(StatisticsManager, "stop_session", function(data) --ElementAiGlobalEvent:on_executed(instigator)
	--if TIM.policeCallOneTime == true then
		--TIM.policeCallOneTime=false
		--managers.mission._fading_debug_output:script().log(tostring(true),  Color.green)
		TIM:EnableTacticReward(false, 3)
		TIM:EnableTacticReward(false, 2)
		TIM:EnableTacticReward(false, 1)
		--managers.mission._fading_debug_output:script().log(tostring(false),  Color.green)
	--end
end)