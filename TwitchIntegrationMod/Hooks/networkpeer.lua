function NetworkPeer:is_streaming_complete()
	if self._streaming_status == 100 then
		TIM.LoadComplete=true
	end
	return self._streaming_status == 100
end