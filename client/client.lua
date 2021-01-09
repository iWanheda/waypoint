local enableWaypoints, blipClr = true, nil

Citizen.CreateThread( function()
	blipClr = Config.MarkerColor

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
					blipClr[1], blipClr[2], blipClr[3], -- Color
				155, false, false, 2, false, false, false, false )

				DrawMarker( 5, coords.x, coords.y, coords.z + blipHeight + 2.0, 0, 0, 0, 0, 0, 0, 
					11.0, 11.0, 11.0, -- Size
					blipClr[1], blipClr[2], blipClr[3], -- Color
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

RegisterCommand( 'wcolor', function( source, args, raw )
	if ( args[1] ~= nil ) then
		setBlipColor( args[1] )
	else
		TriggerEvent( 'chat:addMessage', {
			color = { 255, 0, 0 },
			multiline = false,
			args = { '^*Waypoints: ', 'Correct usage is ^1/wcolor <color>' }
		} )
	end
end, false )

function setBlipColor( clr )
	if ( tostring( clr ) == 'red' ) then
		blipClr = { 255, 0, 0 }
	elseif ( tostring( clr ) == 'green' ) then
		blipClr = { 0, 255, 0 }
	elseif ( tostring( clr ) == 'blue' ) then
		blipClr = { 0, 0, 255 }
	elseif ( tostring( clr ) == 'pink' ) then
		blipClr = Config.MarkerColor
	elseif ( tostring( clr ) == 'default' ) then
		blipClr = Config.MarkerColor
	else
		TriggerEvent( 'chat:addMessage', {
			color = { 255, 0, 0 },
			multiline = false,
			args = { '^*Waypoints: ', 'Invalid Color!' }
		} )
	end
end