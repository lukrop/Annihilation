/*
	File: uav.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Mission script. Creates task, creates uav, creates the trigger,
		spawns some enemy infantry, waits until uav is destroyed and
		sets task to succeeded.

	Parameter(s):
	-

	Returns:
	-
*/

private ["_markerArray", "_scoutMarker", "_centerPos", "_uavPos"];

_markerArray = ["land"] call lkr_fnc_getMissionLocation;

_scoutMarker = _markerArray select 1;

// MARKER
_marker = _markerArray select 0;
[[_marker, 0.3], "lkr_fnc_changeMarker", true, true] spawn BIS_fnc_MP;

_centerPos = getMarkerPos _marker;

// CREATE TASK
_taskID = "uavSearch";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_UAV_DESCRIPTION", localize "STR_ANI_UAV", localize "STR_ANI_SAD"], // description, title, marker
_centerPos, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE UAV
lkr_uav = lkr_uav_C createVehicle _centerPos;
// find a random position with enough place for the uav
_uavPos = [_centerPos, random 360, 30 max (random 300), 0, [0, 200], lkr_uav] call SHK_pos;
lkr_uav setPos _uavPos;
lkr_uav setDir (random 360);

// LOGIC
lkr_uav_destroyed = false;
["lkr_uav", "lkr_uav_destroyed"] call lkr_fnc_triggerOnObjectDestroyed;

if(lkr_hc_present && isMultiplayer) then {
    [[_uavPos, _uavPos, [1,1], [3,4]], "lkr_fnc_spawnOccupation", lkr_hc_id] call BIS_fnc_MP;
} else {
    [_uavPos, _uavPos, [1,1], [3,4]] call lkr_fnc_spawnOccupation;
};

waitUntil{sleep 2; lkr_uav_destroyed};
// set mission success
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
// add to garbage collector queue
lkr_uav call lkr_fnc_gcAdd;
