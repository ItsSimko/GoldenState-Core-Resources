Citizen.CreateThread(function()
	while true do
	local playerped = PlayerPedId()
	local glasses = GetPedPropIndex(playerped, 1)
	local retval --[[ boolean ]], bulletProof --[[ boolean ]], fireProof --[[ boolean ]], explosionProof --[[ boolean ]], collisionProof --[[ boolean ]], meleeProof --[[ boolean ]], steamProof --[[ boolean ]], p7 --[[ boolean ]], drownProof --[[ boolean ]], test = GetEntityProofs(playerped)
		
		if glasses == 26 then
			SetEntityProofs(playerped, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, true)
		else
			SetEntityProofs(playerped, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, false)
		end
		Citizen.Wait(1500)
	end
end)