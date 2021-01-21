--[[
Name:Cuffs
Activate:false
options_end
]]
function TIM.effectsFunctions.cuffs(rewardID)
	managers.player:local_player():sound():say("g29",true,true)
	managers.player:set_player_state("arrested")
end