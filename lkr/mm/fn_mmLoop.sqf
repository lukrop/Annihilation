/*
	File: fn_mmLoop.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Mission manager main loop. Starts a mission, waits for it's
		completion and starts the next mission.

	Parameter(s):
	-
	Returns:
	-
*/

objNull spawn {
	// loop until there are no missions left
	while {count lkr_available_missions > 0} do {
		// wait time between missions
		//sleep lkr_time_between_missions;
		waitUntil{sleep 1; lkr_request_mission};
        // choose a random mission
		_mission = call lkr_fnc_mmChooseMission;
		// run the mission - blocking call
		_mission call lkr_fnc_mmRunMission;
        lkr_request_mission = false;
        publicVariable "lkr_request_mission";
	};

	/*
	if(endless mode) then {
		// start over
		objNull spawn lkr_fnc_mmInit;
	};*/
};
