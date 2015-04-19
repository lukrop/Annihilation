/*
	File: killhvt.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Mission script. Creates task, creates hvt and waits
		until the hvt is killed. Then it sets the task as succeeded.
		Patrolling hvt version.

	Parameter(s):
	-

	Returns:
	-
*/

private ["_markerArray", "_spawnMarkers", "_marker", "_centerPos", "_taskID", "_hvtPos"];

_markerArray = ["city"] call lkr_fnc_getMissionLocation;

// MARKER
_marker = _markerArray select 0;
_centerPos = getMarkerPos _marker;

_spawnMarkers = _markerArray select 1;

// CREATE TASK
_taskID = "killhvt";
[
	lkr_friendly_side, // who gets the task
	_taskID, // task id
	[localize "STR_ANI_KILLHVT_DESCRIPTION", localize "STR_ANI_KILLHVT", localize "STR_ANI_HVT"], // description, title, marker
	_centerPos, // destination
	"Assigned", // set as current / state
	9 // priority
] call BIS_fnc_taskCreate;

// CREATE HVT
_hvtPos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);

_hvtGrp = createGroup lkr_enemy_side;

// spawn first guard
_hvtGrp createUnit [lkr_hvt_guard_C, _hvtPos, [], 0, "FORM"];
// spawn hvt
lkr_hvt = _hvtGrp createUnit [lkr_hvt_C, _hvtPos, [], 0, "FORM"];


lkr_hvt allowDamage false;
[] spawn {
    sleep 60;
    lkr_hvt allowDamage true;
};


// randomly add one or two gurads
if((round random 5) >= 1) then {
	_hvtGrp createUnit [lkr_hvt_guard_C, _hvtPos, [], 0, "FORM"];
};
if((round random 5) >= 3) then {
	_hvtGrp createUnit [lkr_hvt_guard_C, _hvtPos, [], 0, "FORM"];
};

// do not cache the hvt group
_hvtGrp setVariable ["f_cacheExcl", true, true];

// let hvt group patrol
[_hvtGrp, _hvtGrp, 50, 6, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN"] call CBA_fnc_taskPatrol;

lkr_hvt_killed = false;
["lkr_hvt", "lkr_hvt_killed"] call lkr_fnc_triggerOnObjectDestroyed;

if(lkr_hc_present && isMultiplayer) then {
    [[_hvtPos, _hvtPos, [1,2], [3,4]], "lkr_fnc_spawnOccupation", lkr_hc_id] call BIS_fnc_MP;
} else {
    [_hvtPos, _hvtPos, [1,2], [3,4]] call lkr_fnc_spawnOccupation;
};

waitUntil{sleep 2 + (random 2); lkr_hvt_killed};
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
// add to garbage collector queue
lkr_hvt call lkr_fnc_gcAdd;
