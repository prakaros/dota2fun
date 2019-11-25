StateChart = {};
function StateChart:new ()
     local obj = {stateEntry = {currState=0, nextState=0, stateEvent=0, stateAction = 0}, stateIndex = 0,  presentState = 0};
     setmetatable(obj, self);
     self.__index = self;
	 print("New StateChart Object");
     return obj;
end

function StateChart:addTransition(currentState, nextState, transitionOn, doAction)
	self.stateIndex = self.stateIndex +1;
	self.stateEntry[self.stateIndex] = {currState=currentState, nextState=nextState, stateEvent=transitionOn, stateAction = doAction};
	print("Add State tranisition ", currentState, nextState, transitionOn, doAction);
end

function StateChart:init(initState)
	if self.presentState == 0 then
		self.presentState  = initState;
		print("Initial State ", initState);
	end
end

function StateChart:getCurrentState()
	return self.presentState;
end

function StateChart:triggerAction(onEvent)
	for i, v in ipairs(self.stateEntry) do
		local currentStateEntry = v;
		if(currentStateEntry.currState == self.presentState and currentStateEntry.stateEvent == onEvent) then	
			print("Valid State tranisition ", currentStateEntry.currState, currentStateEntry.nextState);
			self.presentState = currentStateEntry.nextState;
			currentStateEntry:stateAction();
			return;
		end
	end
	return;
end
