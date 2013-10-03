/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission script. Creates task, creates cache, creates the trigger,
  spawns some enemy infantry, waits until cache is destroyed and sets task to succeeded.
	
	Parameters:
        ARRAY: position markers array
              [center marker name, vec spawn marker, [reinforcment pos markers], [spawn pos markers]]
        NUMBER: mission type. 0=city, 1=land
	
	Returns: -
  
*/

_posArray = _this select 0;
_missionType = _this select 1;

_vecSpawnMarker = _posArray select 1;
_reinfMarkers = _posArray select 2;
_spawnMarkers = _posArray select 3;


// MARKER
_marker = _posArray select 0;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

{_x setMarkerType "hd_unknown"} forEach _spawnMarkers;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "cacheSearch";
[
west, // who gets the task
_taskID, // task id
["We got intel on a weapon cache in the AO. You need to find it and destroy it.","SAD Cache","SAD"], // description, title, marker
_aocenter, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE CACHE
_cacheClass = "Box_East_Ammo_F";
//_cachePos = [_aocenter, random 360, 30 max (random 100)] call SHK_pos;
_cachePos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);
ani_cache = _cacheClass createVehicle _cachePos;
ani_cache setDir (random 360);

// LOGIC
ani_cacheDestroyed = false;
[_cachePos, "STATE:", ["!alive ani_cache", "ani_cacheDestroyed=true", ""]] call CBA_fnc_createTrigger;

// SPAWN ENEMIES
// 1-2 patrols with 2-4 man
[_marker,[ani_enemySide,ani_enemyFaction,20],[_marker, 100],[[1,3],[3,4]],[[0,2],1,false],[],[],["patrol_gc", 100]] spawn SLP_spawn;
sleep 5 + (random 5);
[_marker,[ani_enemySide,ani_enemyFaction,20],[ani_cache, 10],[1,[4,6]],[],[],[],["defend_gc", 30]] spawn SLP_spawn;


// REINFORCEMENTS
sleep 5 + (random 5);
_reinfSpawn = _reinfMarkers call BIS_fnc_selectRandom;
// 1 squad 10 man
[_marker,[ani_enemySide,ani_enemyFaction,20],[_reinfSpawn, 20],[1,[6,10]],[],[],[],["reinforcement_o_gc", ani_cache]] spawn SLP_spawn;

waitUntil{sleep 0.1; ani_cacheDestroyed};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
_marker setMarkerColor "ColorGreen";
_marker setMarkerAlpha 0.3;
{_x setMarkerAlpha 0} forEach _spawnMarkers;
