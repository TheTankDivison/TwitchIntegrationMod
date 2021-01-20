function PlayerStandard:get_interaction()
	--managers.chat:_receive_message(1, "ddd", tostring(123), Color('1565c0'))	
	if self._interact_params then
		return self._interact_params.tweak_data
	end
	return nil
end