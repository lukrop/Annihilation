/*
	File: cache.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Mission script. Creates task, creates cache, creates the trigger,
		spawns some enemy infantry, waits until cache is destroyed and
		sets task to succeeded.

	Parameter(s):
	-

	Returns:
	-
*/

private ["_markerArray", "_spawnMarkers", "_marker", "_centerPos", "_taskID", "_cachePos"];

_markerArray = ["city"] call lkr_fnc_getMissionLocation;

// MARKER
_marker = _markerArray select 0;
_centerPos = getMarkerPos _marker;

_spawnMarkers = _markerArray select 1;

// CREATE TASK
_taskID = "cacheSearch";
[
	west, // who gets the task
	_taskID, // task id
	[localize "STR_ANI_CACHE_DESCRIPTION", localize "STR_ANI_CACHE", localize "STR_ANI_SAD"], // description, title, marker
	_centerPos, // destination
	"Assigned", // set as current / state
	9 // priority
] call BIS_fnc_taskCreate;

// spawn the weapon cache
_cachePos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);
lkr_wepcache = "O_supplyCrate_F" createVehicle _cachePos;
lkr_wepcache setDir (random 360);
clearWeaponCargo lkr_wepcache;
clearMagazineCargo lkr_wepcache;
clearItemCargo lkr_wepcache;

// LOGIC
lkr_wepCacheDestroyed = false;
["lkr_wepcache", "lkr_wepCacheDestroyed"] call lkr_fnc_triggerOnObjectDestroyed;

if(lkr_hc_present && isMultiplayer) then {
    [[_cachePos, _cachePos, [1,2], [3,4]], "lkr_fnc_spawnOccupation", lkr_hc_id] call BIS_fnc_MP;
} else {
    [_cachePos, _cachePos, [1,2], [3,4]] call lkr_fnc_spawnOccupation;
};
// wait until the cache is destroyed
waitUntil{sleep 1; lkr_wepCacheDestroyed};
// set the task as succeeded
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
// add to garbage collector queue
lkr_wepcache call lkr_fnc_gcAdd;
