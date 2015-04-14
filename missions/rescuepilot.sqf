/*
	File: rescuepilot.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Mission script. Creates task, creates pilot, makes him a hostage,
		spawns some enemy infantry, waits until pilot is rescued and
		sets task to succeeded. If the pilot is killed, the task is
		marked as failed.

	Parameter(s):
	-

	Returns:
	-
*/

private ["_markerArray", "_missionStyle", "_vecSpawnMarker", "_reinfMarkers", "_spawnMarkers", "_marker", "_centerPos", "_taskID", "_reinfCount"];

_markerArray = ["all"] call lkr_fnc_getMissionLocation;

_spawnMarkers = _markerArray select 1;

// MARKER
_marker = _markerArray select 0;
[[_marker, 1], "lkr_fnc_changeMarker", true, true] spawn BIS_fnc_MP;

_centerPos = getMarkerPos _marker;

// CREATE TASK
_taskID = "rescuepilot";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_RESCUEPILOT_DESCRIPTION", localize "STR_ANI_RESCUEPILOT", localize "STR_ANI_CSAR"], // description, title, marker
_centerPos, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE Pilot
_crashPos = [_centerPos, random 360, (random 200), 0, [0, 200], [100,lkr_chopper_C]] call SHK_pos;

// spawn downed chopper
_chopper = lkr_chopper_C createVehicle _crashPos;
_chopper setDamage 0.85;
_chopper setFuel (random 0.3);
_chopper setVehicleAmmo (random 0.5);

_pilotGrp = createGroup west;
lkr_pilot = _pilotGrp createUnit [lkr_pilot_C, _crashPos, [], 0, "FORM"];
// do not cache the pilot
_pilotGrp setVariable ["f_cacheExcl", true, true];
// move him to random house position
_pilotPos = [lkr_pilot, (getPos lkr_pilot), 30] call lkr_fnc_moveInRandomHouse;

// make the pilot a hostage
lkr_pilot call lkr_fnc_makeHostage;

// spawn two guards
[_pilotPos, lkr_enemy_side, [lkr_hvt_guard_C, lkr_hvt_guard_C], [], [], lkr_enemy_skill_range] call BIS_fnc_spawnGroup;

// LOGIC
_base = getPos lkr_flag;
lkr_pilot_killed = false;
lkr_pilot_rescued = false;
["lkr_pilot", "lkr_pilot_killed"] call lkr_fnc_triggerOnObjectDestroyed;
//[_pilotPos, "STATE:", ["(!alive lkr_pilot) and (!lkr_pilot_rescued)", "lkr_pilot_killed=true", ""]] call CBA_fnc_createTrigger;
_trigger = [_base, "AREA:", [30, 30, 0, false], "ACT:", ["VEHICLE", "PRESENT", false],
					 "STATE:", ["this and (alive lkr_pilot)", "lkr_pilot_rescued = true", ""]] call CBA_fnc_createTrigger;
_trigger = _trigger select 0;
_trigger triggerAttachVehicle [lkr_pilot];

[_crashPos, _crashPos, [0,0], [3,5]] call lkr_fnc_spawnOccupation;

waitUntil{sleep 1; lkr_pilot_killed or lkr_pilot_rescued};
if(lkr_pilot_killed) then {
	[_taskID, "Failed"] call BIS_fnc_taskSetState;
} else {
	[_taskID, "Succeeded"] call BIS_fnc_taskSetState;

	[lkr_pilot] join grpNull;
	if(vehicle lkr_pilot != lkr_pilot) then {
		lkr_pilot leaveVehicle (vehicle lkr_pilot);
	};
	lkr_pilot move _base;
};
