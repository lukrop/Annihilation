/*
	File: fn_mmChooseMission.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Selects a random mission from the mission array and
		removes it from the array so it won't be executed
		again until the array is reset.

	Parameter(s):
	-
	Returns:
		STRING
			chosen mission
*/

private ["_mission"];

// select random mission
_mission = lkr_available_missions call BIS_fnc_selectRandom;
// remove mission from available ones
lkr_available_missions = lkr_available_missions - [_mission];
// return mission
_mission
