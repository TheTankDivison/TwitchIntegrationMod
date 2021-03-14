TIM:Post(GroupAIStateBesiege, "_upd_assault_task", function()
	--managers.mission._fading_debug_output:script().log(tostring(managers.groupai:state():whisper_mode() == false),  Color.green)
	if managers.groupai:state():whisper_mode() == false and TIM.policeCallOneTime == true then 
		TIM.policeCallOneTime=false
		--managers.mission._fading_debug_output:script().log(tostring(true),  Color.green)
		TIM:EnableTacticReward(true, 2)
		TIM:EnableTacticReward(false, 1)
		--managers.mission._fading_debug_output:script().log(tostring(false),  Color.green)
	end
end)