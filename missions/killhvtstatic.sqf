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

_aoArray = _this select 0;
_missionType = _this select 1;

_vecSpawnMarker = _aoArray select 1;
_reinfMarkers = _aoArray select 2;
_spawnMarkers = _aoArray select 3;


// MARKER
_marker = _aoArray select 0;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "killhvtstatic";
[
west, // who gets the task
_taskID, // task id
["We got intel that a high-ranking enemy officer is in the AO. Find him and eliminate him.","Kill HVT","HVT"], // description, title, marker
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

[_hvtGrp, _hvtGrp, 50] call CBA_fnc_taskDefend;

// SPAWN ENEMIES
// 2-3 patrols with 2-4 man 1 defend with 4-6 man
[_marker,[ani_enemySide,ani_enemyFaction,20],[_marker, 100],[2,[3,4]],[[0,1],1,false],[],[],["patrol_gc", 100]] spawn SLP_spawn;
sleep 5 + (random 5);
[_marker,[ani_enemySide,ani_enemyFaction,20],[ani_hvt, 10],[1,[4,6]],[],[],[],["defend_gc", 50]] spawn SLP_spawn;


// REINFORCEMENTS
sleep 5 + (random 5);
_reinfSpawn = _reinfMarkers call BIS_fnc_selectRandom;
_reinfMarkers = _reinfMarkers - [_reinfSpawn];
_reinfSpawn2 = _reinfMarkers call BIS_fnc_selectRandom;
// 1 squad 10 man
[_marker,[ani_enemySide,ani_enemyFaction,10],[_reinfSpawn, 10],[1,[6,8]],[],[],[],["reinforcement_o_gc", ani_hvt]] spawn SLP_spawn;
sleep 5 + (random 5);
[_marker,[ani_enemySide,ani_enemyFaction,10],[_reinfSpawn2, 10],[1,[6,8]],[],[],[],["reinforcement_o_gc", ani_hvt]] spawn SLP_spawn;
// LOGIC
ani_hvtKilled = false;
[_hvtPos, "STATE:", ["!alive ani_hvt", "ani_hvtKilled=true", ""]] call CBA_fnc_createTrigger;

waitUntil{sleep 0.1;ani_hvtKilled};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
_marker setMarkerColor "ColorGreen";
_marker setMarkerAlpha 0.3;
