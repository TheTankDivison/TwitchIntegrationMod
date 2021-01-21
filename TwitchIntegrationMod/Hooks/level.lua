function LevelLoadingScreenGuiScript:set_visible(visible)
	if visible then
		self._ws:show()
		TIM.InLobby = false
	else
		self._ws:hide()
		TIM.InLobby = true
	end
end