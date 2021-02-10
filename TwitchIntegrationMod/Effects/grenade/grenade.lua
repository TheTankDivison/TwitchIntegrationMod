--[[
Name:Frag grenade
Activate:true
Count:1
options_end
]]
function TIM.effectsFunctions.grenade(rewardID)
	for i=1, tonumber(TIM._settings.TwitchRewards[rewardID].effects.grenade.Count.Value), 1 do
		local unit_done1 = World:spawn_unit(Idstring("units/payday2/weapons/wpn_frag_grenade/wpn_frag_grenade"), managers.player:local_player():position(), managers.player:local_player():rotation())
		managers.player:local_player():sound():say("play_pln_gen_dir_07",true,true)
	end
end