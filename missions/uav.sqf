/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission script. Creates task, creates uav, creates the trigger,
  spawns some enemy infantry, waits until uav is destroyed and sets task to succeeded.

	Parameters:
        ARRAY: position markers array
              [center marker name, [reinforcment pos markers]]
        NUMBER: mission type. 0=city, 1=land

	Returns: -

*/

_posArray = _this select 0;
_missionStyle = _this select 1;

_reinfMarkers = _posArray select 1;

// MARKER
_marker = _posArray select 0;
// [[_marker, 1, "ColorRed"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 1, "ColorRed"] call ani_changeMarker;


_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "uavSearch";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_UAV_DESCRIPTION", localize "STR_ANI_UAV", localize "STR_ANI_SAD"], // description, title, marker
_aocenter, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE UAV
_uavPos = [_aocenter, random 360, 50 max (random 300)] call SHK_pos;
//_uavPos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);
ani_uav = ani_uavClass createVehicle _uavPos;
ani_uav setDir (random 360);

// LOGIC
ani_uavDestroyed = false;
[_uavPos, "STATE:", ["!alive ani_uav", "ani_uavDestroyed=true", ""]] call CBA_fnc_createTrigger;

// spawn enemies and reinforcements
[_missionStyle, _marker, _reinfMarkers, ani_uav] call ani_spawnEnemies;

waitUntil{sleep 0.1; ani_uavDestroyed};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
// [[_marker, 0.3, "ColorGreen"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 0.3, "ColorGreen"] call ani_changeMarker;
sleep 60;
while{not [ani_uav, 200] CBA_fnc_nearPlayer} do {sleep 30};
deleteVehicle ani_uav;
