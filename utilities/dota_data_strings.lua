local RuneLocationName = {[0]= "RUNE_POWERUP_1", "RUNE_POWERUP_2", "RUNE_BOUNTY_1", "RUNE_BOUNTY_2", "RUNE_BOUNTY_3", "RUNE_BOUNTY_4"};
local ShopLocationName = {[0] = "SHOP_HOME", "SHOP_SIDE", "SHOP_SECRET", "SHOP_SIDE2", "SHOP_SECRET2"};
local ShrineLocationName = {[0] = "SHRINE_BASE_1", "SHRINE_BASE_2", "SHRINE_BASE_3", "SHRINE_BASE_4", "SHRINE_BASE_5", "SHRINE_JUNGLE_1", "SHRINE_JUNGLE_2"};
local LaneLocationName = {[0] = "LANE_NONE", "LANE_TOP", "LANE_MID", "LANE_BOT"};
local BarracksLocationName = {[0] = "BARRACKS_TOP_MELEE", "BARRACKS_TOP_RANGED", "BARRACKS_MID_MELEE", "BARRACKS_MID_RANGED", "BARRACKS_BOT_MELEE", "BARRACKS_BOT_RANGED"};
local TowerLocationName = {[0] = "TOWER_TOP_1", "TOWER_TOP_2", "TOWER_TOP_3", "TOWER_MID_1", "TOWER_MID_2", "TOWER_MID_3", "TOWER_BOT_1", "TOWER_BOT_3", "TOWER_BASE_1", "TOWER_BASE_2"};
	
local validLocations = {["rune"]=true, ["shop"]=true, ["shrine"]=true, ["lane"]=true, ["barracks"]=true, ["tower"]=true};
local locationIdNameMap = {["rune"]=RuneLocationName, ["shop"]=ShopLocationName, ["shrine"]=ShrineLocationName, ["lane"]=LaneLocationName, ["barracks"]=BarracksLocationName, ["tower"]=TowerLocationName};

function isValidLocationType(locationType)
	return validLocations[locationType];
end
function getLocationNameFromMap(locationId, locationType)
	locationName = nil;
	if isValidLocationType(locationType) then
		locationName = locationIdNameMap[locationType][locationId];
		print("Location name ", locationId, locationName, locationType);
	else
		print("InValid Location Type");
	end
	return locationName;
end

