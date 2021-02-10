--[[
Name:Ammo
Divider:Description: A reward that spawn ammo boxes for you and your crew
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.voiceline(rewardID)
	managers.player:local_player():sound():say(TIM._settings.TwitchRewards[rewardID].effects.voiceline.ListOfLines.SelectedItem,true,true)
end