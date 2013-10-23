/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission script. Creates task, creates cache, creates the trigger,
  spawns some enemy infantry, waits until cache is destroyed and sets task to succeeded.

	Parameters:
        ARRAY: position markers array
              [center marker name, vec spawn marker, [reinforcment pos markers], [spawn pos markers]]
        NUMBER: mission style. 0=city, 1=land

	Returns: -

*/
private ["_posArray", "_missionStyle", "_vecSpawnMarker", "_reinfMarkers", "_spawnMarkers", "_marker", "_aocenter", "_taskID", "_reinfCount", "_reinfSpawn"];

_posArray = _this select 0;
_missionStyle = _this select 1;

_vecSpawnMarker = _posArray select 1;
_reinfMarkers = _posArray select 2;
_spawnMarkers = _posArray select 3;


// MARKER
_marker = _posArray select 0;
// [[_marker, 1, "ColorRed"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 1, "ColorRed"] call ani_changeMarker;

{
  //_x setMarkerType "hd_unknown"
   [[_x, 1, "Default", "hd_unknown"], "ani_changeMarker", false, true] spawn BIS_fnc_MP;
  //[_x, 1, "Default", "hd_unknown"] call ani_changeMarker;
} forEach _spawnMarkers;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "cacheSearch";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_CACHE_DESCRIPTION", localize "STR_ANI_CACHE", localize "STR_ANI_SAD"], // description, title, marker
_aocenter, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE CACHE
//_cachePos = [_aocenter, random 360, 30 max (random 100)] call SHK_pos;
_cachePos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);
ani_cache = ani_cacheClass createVehicle _cachePos;
ani_cache setDir (random 360);
clearWeaponCargo ani_cache;
clearMagazineCargo ani_cache;

// LOGIC
ani_cacheDestroyed = false;
[_cachePos, "STATE:", ["!alive ani_cache", "ani_cacheDestroyed=true", ""]] call CBA_fnc_createTrigger;

// spawn enemies and reinforcements
[_missionStyle, _marker, _reinfMarkers, ani_cache] call ani_spawnEnemies;

waitUntil{sleep 0.1; ani_cacheDestroyed};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;

// [[_marker, 0.3, "ColorGreen"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 0.3, "ColorGreen"] call ani_changeMarker;

sleep 60;
while{not ([ani_cache, 200] call CBA_fnc_nearPlayer)} do {sleep 30};
deleteVehicle ani_cache;

/*
{
  //_x setMarkerAlpha 0
  // [[_x, 0], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
  [_x, 0] call ani_changeMarker;
} forEach _spawnMarkers;
*/