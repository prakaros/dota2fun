require("utilities/dota_utilities")
require("utilities/dota_data_strings")
require("utilities/state_chart")

WayPointNavigator = {};
function WayPointNavigator:new()
	local obj = {mPathToTravel = {}, mStateMachine = {}, mNPCBot = {}, mTeamId = 0, mStartPoint = 1, mPathLength = 0};
	obj.mStateMachine = StateChart:new();
	setmetatable(obj, self);
	self.__index = self;
	return obj;
end

function WayPointNavigator:onInit()
	self:initStateMachine();
end

function WayPointNavigator:onStart()
	self.mStateMachine:init("STATE_IDLE");
	self.mStateMachine:triggerAction("EVENT_START");
end

function WayPointNavigator:actionStart()
	self.mPathToTravel = getDefaultPath();
	self.mPathLength = getTableSize(self.mPathToTravel);
	self.mNPCBot = GetBot();
	self.mTeamId = self.mNPCBot:GetTeam();
	print("actionStart:: Bot, TmId, PthToTrvl, SrtPnt, PathLen", self.mNPCBot, self.mTeamId, self.mPathToTravel, self.mStartPoint, self.mPathLength);
end

function WayPointNavigator:actionMoving()
	print("MOVING TO ", getLocationNameFromMap(self.mPathToTravel[self.mStartPoint][1], self.mPathToTravel[self.mStartPoint][2]));
	self.mNPCBot:Action_MoveToLocation(getLocationCoord(self.mTeamId, self.mPathToTravel[self.mStartPoint][1], self.mPathToTravel[self.mStartPoint][2]));
end

function WayPointNavigator:actionReached()
		print("REACHED wayPoint ", self.mStartPoint, getLocationNameFromMap(self.mPathToTravel[self.mStartPoint][1], self.mPathToTravel[self.mStartPoint][2]));
		if self.mStartPoint < self.mPathLength then
			self.mStartPoint = self.mStartPoint +1;
		else
			self.mStartPoint = 1;
			print("PATH FINISHED STARTING AGAIN ");
		end
end

function WayPointNavigator:onEnd()
	self.mStateMachine:triggerAction("EVENT_END");
end

function WayPointNavigator:actionEnd()
	print("DOING END");
end

function WayPointNavigator:initStateMachine()
	
	self.mStateMachine:addTransition("STATE_IDLE",    "STATE_PREPARE", "EVENT_START",   function() self:actionStart() end);
	self.mStateMachine:addTransition("STATE_PREPARE", "STATE_MOVING",  "EVENT_MOVING",  function() self:actionMoving() end);
	self.mStateMachine:addTransition("STATE_MOVING",  "STATE_REACHED", "EVENT_REACHED", function() self:actionReached() end);
	self.mStateMachine:addTransition("STATE_REACHED", "STATE_MOVING",  "EVENT_MOVING",  function() self:actionMoving() end);
	self.mStateMachine:addTransition("STATE_MOVING",  "STATE_IDLE",    "EVENT_END",     function() self:actionEnd() end);
	self.mStateMachine:addTransition("STATE_REACHED", "STATE_IDLE",    "EVENT_END",     function() self:actionEnd() end);
	return true;
end

function WayPointNavigator:onThink()
	if (GetGameState() == GAME_STATE_GAME_IN_PROGRESS) then
		self.mStateMachine:triggerAction("EVENT_MOVING");
	end
	
	if vectorEqual(self.mNPCBot:GetLocation(), getLocationCoord(self.mTeamId, self.mPathToTravel[self.mStartPoint][1], self.mPathToTravel[self.mStartPoint][2]), getTolerance(self.mPathToTravel[self.mStartPoint][1], self.mPathToTravel[self.mStartPoint][2])) then
		self.mStateMachine:triggerAction("EVENT_REACHED");
	end
	
	if(self.mStateMachine:getCurrentState() == "STATE_REACHED") then
		self.mStateMachine:triggerAction("EVENT_MOVING");
	end
end
