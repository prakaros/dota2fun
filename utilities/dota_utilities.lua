require("utilities/dota_data_strings")

function vectorEqual(actualLocation, targetLocation, tolerance)
	local nearBy = (math.abs(actualLocation[1]-targetLocation[1]) < tolerance and
	                 math.abs(actualLocation[2]-targetLocation[2]) < tolerance and
					 math.abs(actualLocation[3]-targetLocation[3]) < tolerance);
	return nearBy;
end
						
function getTolerance(locationId, locationType)
	distanceTol = 0;
	if (locationType == "rune") then
		distanceTol = 1e2;
	elseif (locationType == "shop") then
		distanceTol = 250;
	else
		distanceTol = 200;
	end
	
	return distanceTol;
end

function getLocationCoord(teamId, locationId, locationType)
	locationVector = {0,0,0};
	if (locationType == "rune") then
		locationVector = GetRuneSpawnLocation(locationId);
	elseif (locationType == "shop") then
		locationVector =  GetShopLocation(teamId, locationId);
	else
		locationVector = {100,100,100};
	end
	
	return locationVector;
end


function getDefaultPath()
	location1 = {RUNE_POWERUP_1, "rune"};
	location2 = {SHOP_HOME, "shop"};
    location3 = {RUNE_POWERUP_2, "rune"};
	location4 = {SHOP_SIDE, "shop"};
	location5 = {RUNE_BOUNTY_1, "rune"};
	location6 = {SHOP_SECRET, "shop"};
    location7 = {RUNE_BOUNTY_2, "rune"};
	location8 = {SHOP_SIDE2, "shop"};
	location9 = {RUNE_BOUNTY_3, "rune"};
	location10 = {SHOP_SECRET2, "shop"};
	location11 = {RUNE_BOUNTY_4, "rune"};
	return {location1, location2, location3, location4, location5, location6, location7, location8, location9, location10, location11};
end

function getTableSize(path)
	count = 0;
	for _ in pairs(path) do
		count = count +1;
	end
	return count;
end



	