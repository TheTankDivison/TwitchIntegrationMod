TIM:Post(GroupAIStateBase, "on_police_called", function(called_reason) --ElementAiGlobalEvent:on_executed(instigator)
	if TIM.policeCallOneTime == true then
		TIM.policeCallOneTime=false
		--managers.mission._fading_debug_output:script().log(tostring(true),  Color.green)
		TIM:EnableTacticReward(true, 2)
		TIM:EnableTacticReward(false, 1)
		--managers.mission._fading_debug_output:script().log(tostring(false),  Color.green)
	end
end)
