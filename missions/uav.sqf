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
_missionType = _this select 1;

_reinfMarkers = _posArray select 1;

// MARKER
_marker = _posArray select 0;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;


_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "uavSearch";
[
west, // who gets the task
_taskID, // task id
["We lost contact to one of our drones. You need to search and destroy it","SAD UAV","SAD"], // description, title, marker
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

// SPAWN ENEMIES
// 1-2 patrols with 2-4 man
[_marker,[ani_enemySide,ani_enemyFaction,20],[_marker, 200],[[2,3],[3,4]],[[1,2],1,false],[],[],["patrol_gc", 250]] spawn SLP_spawn;


// REINFORCEMENTS
sleep 5 + (random 5);
_reinfSpawn1 = _reinfMarkers call BIS_fnc_selectRandom;
_reinfMarkers = _reinfMarkers - [_reinfSpawn1];
_reinfSpawn2 = _reinfMarkers call BIS_fnc_selectRandom;
// 2 squad 10 man
[_marker,[ani_enemySide,ani_enemyFaction,20],[_reinfSpawn1, 10],[1,[6,8]],[],[],[],["reinforcement_o_gc", ani_uav]] spawn SLP_spawn;
sleep 5 + (random 5);
[_marker,[ani_enemySide,ani_enemyFaction,20],[_reinfSpawn2, 10],[1,[6,8]],[],[],[],["reinforcement_o_gc", ani_uav]] spawn SLP_spawn;

waitUntil{sleep 0.1; ani_uavDestroyed};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
_marker setMarkerColor "ColorGreen";
_marker setMarkerAlpha 0.3;
