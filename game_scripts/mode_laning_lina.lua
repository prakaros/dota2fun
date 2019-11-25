local utilities = require("utilities/dota_utilities")
require("utilities/dota_data_strings")
require("utilities/state_chart")
require("utilities/dota_features")

_G._savedEnv = getfenv()
module( "mode_generic_laning", package.seeall )

local wayPointNav = nil;	

----------------------------------------------------------------------------------------------------

function OnStart()
	if wayPointNav == nil then
		wayPointNav = WayPointNavigator:new();
		wayPointNav:onInit();
	end
	wayPointNav:onStart();
end

----------------------------------------------------------------------------------------------------

function OnEnd()
	wayPointNav:onEnd();
end

function Think()
	if wayPointNav == nil then
		wayPointNav = WayPointNavigator:new();
		wayPointNav:onInit();
		wayPointNav:onStart();
	end
	wayPointNav:onThink();
end

for k,v in pairs( mode_generic_laning ) do	_G._savedEnv[k] = v end
