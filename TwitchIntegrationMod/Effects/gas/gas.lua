--[[
Name:Gas grenade
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.gas(rewardID)
	--for i=1, TIM._settings.TwitchRewards[rewardID].effects.gas.Count, 1 do
	local spawnType
	if TIM._settings.TwitchRewards[rewardID].effects.gas.spawnType.SelectedItem == "onPlayer" then
		spawnType = true
	elseif TIM._settings.TwitchRewards[rewardID].effects.gas.spawnType.SelectedItem == "inFront" then
		spawnType = false
	else
	
	end
	local pos, rot = TIM:Spawn_position(spawnType)
	local unit_name = Idstring("units/pd2_dlc_drm/weapons/smoke_grenade_tear_gas/smoke_grenade_tear_gas")
	managers.player:local_player():sound():say("g42x_any",true,true)
	local grenade = World:spawn_unit(unit_name, pos, rot)
		grenade:base():set_properties({
		radius =  TIM._settings.TwitchRewards[rewardID].effects.gas.radius.Value*100, --400
		damage =  TIM._settings.TwitchRewards[rewardID].effects.gas.damage.Value/10, --2
		duration = TIM._settings.TwitchRewards[rewardID].effects.gas.duration.Value --20
	})
	grenade:base():detonate()
	--end
end