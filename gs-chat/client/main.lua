Citizen.CreateThread(function()

	TriggerEvent('chat:addSuggestion', '/ooc', 'Out Of Character chat Message. (Global Chat)', {
		{ name="Message", help="Put your questions or help request."}
	})

	TriggerEvent('chat:addSuggestion', '/twt', 'Send a Twitter in game. (Global Chat)', {
		{ name="Message", help="Twitter Message."}
	})

end)