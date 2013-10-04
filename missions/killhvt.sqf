/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission script. Creates task, creates hvt + guards, creates the trigger,
  spawns some enemy infantry, waits until hvt is dead and sets task to succeeded.
	
	Parameters:
        ARRAY: position markers array
              [center marker name, vec spawn marker, [reinforcment pos markers], [spawn pos markers]]
        NUMBER: mission type. 0=city, 1=land
	
	Returns: -
  
*/

private ["_posArray", "_missionStyle", "_vecSpawnMarker", "_reinfMarkers", "_spawnMarkers", "_marker", "_aocenter", "_taskID", "_reinfCount"];

_posArray = _this select 0;
_missionStyle = _this select 1;

_vecSpawnMarker = _posArray select 1;
_reinfMarkers = _posArray select 2;
_spawnMarkers = _posArray select 3;


// MARKER
_marker = _posArray select 0;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "killhvt";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_KILLHVT_DESCRIPTION", localize "STR_ANI_KILLHVT", localize "STR_ANI_HVT"], // description, title, marker
_aocenter, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE HVT

_hvtPos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);

_guardClass = ani_hvtGuardClass;
_hvtClass = ani_hvtClass;
_hvtGrp = createGroup east;

_hvtGrp createUnit [_guardClass, _hvtPos, [], 0, "FORM"];
ani_hvt = _hvtGrp createUnit [_hvtClass, _hvtPos, [], 0, "FORM"];
if((round random 5) >= 1) then {
  _hvtGrp createUnit [_guardClass, _hvtPos, [], 0, "FORM"];
};
if((round random 5) >= 3) then {
  _hvtGrp createUnit [_guardClass, _hvtPos, [], 0, "FORM"];
};

[_hvtGrp, _hvtGrp, 50, 6, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN"] call CBA_fnc_taskPatrol;

// spawn enemies and reinforcements
[_missionStyle, _marker, _reinfMarkers, ani_hvt] call ani_spawnEnemies;

// LOGIC
ani_hvtKilled = false;
[_hvtPos, "STATE:", ["!alive ani_hvt", "ani_hvtKilled=true", ""]] call CBA_fnc_createTrigger;

waitUntil{sleep 0.1;ani_hvtKilled};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
_marker setMarkerColor "ColorGreen";
_marker setMarkerAlpha 0.3;
