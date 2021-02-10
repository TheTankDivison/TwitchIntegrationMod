--[[
Name:Jail
Activate:true
Timers_max:20
options_end
]]
function TIM.effectsFunctions.jail(rewardID)
	managers.player:local_player():sound():say("g29",true,true)
	if TIM.Rewards[rewardID]== nil then
		TIM.Rewards[rewardID]={}
	end
	if TIM.Rewards[rewardID].jailNow ==nil then
		TIM.Active_timer_jail = true
		local unit_name = Idstring("units/payday2/architecture/bnk/bnk_int_fence_wall")
		local unit_done1 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 100, 0), Rotation(0,0,0))
		local unit_done2 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(-100, -100, 0), Rotation(180,0,0))
		local unit_done3 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 100, 0), Rotation(90,0,0))
		local unit_done4 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(-100, -100, 0), Rotation(270,0,0))
		local unit_done5 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 150, 0), Rotation(0,90,0))
		local unit_done6 = World:spawn_unit( unit_name, managers.player:local_player():position()+Vector3(100, 150, 300), Rotation(0,90,0))
		local lin = TIM:fon_function()
		lin:animate(function(o)
		TIM.Rewards[rewardID].jailNow = TIM._settings.TwitchRewards[rewardID].effects.jail.Timers_max.Value
		while TIM.Rewards[rewardID].jailNow>0 do
			TIM.Rewards[rewardID].jailNow = TIM.Rewards[rewardID].jailNow - 1
			wait(1)
			
		end
		TIM.Rewards[rewardID].jailNow =nil
		managers.player:local_player():sound():say("g13",true,true)
		unit_done1:set_slot(0)
		unit_done2:set_slot(0)
		unit_done3:set_slot(0)
		unit_done4:set_slot(0)	
		unit_done5:set_slot(0)	
		unit_done6:set_slot(0)	
		lin:parent():remove(lin)
	end)						
	else
		TIM.Rewards[rewardID].jailNow = TIM.Rewards[rewardID].jailNow + TIM._settings.TwitchRewards[rewardID].effects.jail.Timers_max.Value
	end	
end