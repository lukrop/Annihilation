/*
	File: fn_mmRunMission.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		executes/runs a mission file.

	Parameter(s):
		0: STRING
			name of the mission which should be run
	Returns:
	-
*/
// get paramter
_mission = [_this, 0, "", [""]] call BIS_fnc_param;
// create path to mission file - a mission file should be
// in missions\missionName.sqf
_filePath = format ["missions\%1.sqf", _mission];
// call it - as soon as the mission script is
// completed the next mission script will load
call compile preprocessFileLineNumbers _filePath;
