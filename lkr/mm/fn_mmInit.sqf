/*
	File: fn_mmInit.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Initializes the mission manager and starts the main loop.
		Automatically run postInit.

	Parameter(s):
	-
	Returns:
	-
*/

// the mission manager (ergo creation of missions/units) is only
// executed on the server since it would be a mess otherwise.
if(!isServer) exitWith {};
// wait until config is loaded and paramters are set
waitUntil{!isNil "lkr_config_loaded"};

// current mission array
//lkr_current_mission = [];
// time between missions in seconds
lkr_time_between_missions = 120;
// mission pool
lkr_available_missions = ["cache", "killhvt", "killhvtstatic", "uav", "rescuepilot"];
//lkr_available_missions = ["rescuepilot"];

// start the main loop
call lkr_fnc_mmLoop;
