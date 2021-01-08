local enableWaypoints = true

Citizen.CreateThread( function()
	while true do
		Citizen.Wait( 4 )
		
		if ( enableWaypoints ) then
			local waypointFound = GetFirstBlipInfoId( 8 )

			if DoesBlipExist( waypointFound ) then
				local coords = GetBlipCoords( waypointFound )
				local blipHeight = Config.ScaleWithScreen and ( #( GetEntityCoords( PlayerPedId() ) - coords ) ) * 0.5 or 100

				if ( blipHeight <= 30 ) then
					blipHeight = 30
				end

				DrawMarker( 1, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 
					8.0, 8.0, blipHeight, -- Size
					Config.MarkerColor[1], Config.MarkerColor[2], Config.MarkerColor[3], -- Color
				155, false, false, 2, false, false, false, false )

				DrawMarker( 5, coords.x, coords.y, coords.z + blipHeight + 2.0, 0, 0, 0, 0, 0, 0, 
					11.0, 11.0, 11.0, -- Size
					Config.MarkerColor[1], Config.MarkerColor[2], Config.MarkerColor[3], -- Color
				155, false, true, 2, false, false, false, false )
			end
		end
	end
end )

RegisterCommand( 'waypoint', function()
	enableWaypoints = not enableWaypoints

	TriggerEvent( 'chat:addMessage', {
		color = { 255, 0, 0 },
		multiline = false,
		args = { '^*Waypoints: ', 'You have ' .. ( enableWaypoints and '^2enabled' or '^1disabled' ) .. ' ^7Waypoints!' }
	} )
end, false )