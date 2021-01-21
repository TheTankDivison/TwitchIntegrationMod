--[[
Name:Spin display
Activate:true
options_end
]]
function TIM.effectsFunctions.spin(rewardID)
	if TIM.Active_spin == nil then
		TIM.Active_spin = false
	end
	local lin = TIM:fon_function()
	local player = managers.player:player_unit()
	local camera = player:camera()
	lin:animate(function(o)
		while TIM.Active_spin==true do
			wait(1)
		end
		managers.player:local_player():sound():say("g29",true,true)
		TIM.Active_spin = true
		camera:camera_unit():base():set_target_tilt(-360*TIM._settings.TwitchRewards[rewardID].effects.spin.Count)
		wait(1.25*TIM._settings.TwitchRewards[rewardID].effects.spin.Count)
		camera:camera_unit():base():set_target_tilt(0)
		wait(1.25*TIM._settings.TwitchRewards[rewardID].effects.spin.Count)
		TIM.Active_spin=false
		lin:parent():remove(lin)
	end)
end