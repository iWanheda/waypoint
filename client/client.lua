Citizen.CreateThread( function()
	while true do
		Citizen.Wait( 4 )
		local waypointFound = GetFirstBlipInfoId( 8 )

		if DoesBlipExist( waypointFound ) then
			local coords = GetBlipCoords( waypointFound )

		    DrawMarker( 1, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, 
				6.0, 6.0, 1000.0, -- Size
				Config.MarkerColor[1], Config.MarkerColor[2], Config.MarkerColor[3], -- Color
			155, false, false, 2, false, false, false, false )
		end
	end
end )