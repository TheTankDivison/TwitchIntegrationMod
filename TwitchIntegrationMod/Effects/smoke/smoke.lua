--[[
Name:Smoke grenade
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.smoke(rewardID)
	local spawnType
	if TIM._settings.TwitchRewards[rewardID].effects.smoke.spawnType.SelectedItem == "onPlayer" then
		spawnType = true
	elseif TIM._settings.TwitchRewards[rewardID].effects.smoke.spawnType.SelectedItem == "inFront" then
		spawnType = false
	else
	
	end
	local pos, rot = TIM:Spawn_position(spawnType)
	for i=1, TIM._settings.TwitchRewards[rewardID].effects.smoke.Count.Value, 1 do
		local duration = TIM._settings.TwitchRewards[rewardID].effects.smoke.Duration.Value--tweak_data.group_ai.smoke_grenade_lifetime
		managers.groupai:state():detonate_smoke_grenade(pos, pos, duration, false)
		managers.player:local_player():sound():say("l2n_d01",true,true)
	end
end