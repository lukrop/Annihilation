/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission script. Creates task, creates mortars and lets them fire at ani_target, 
  creates the trigger, spawns some enemy infantry, waits until mortar gunners are dead and 
  sets task to succeeded.
	
	Parameters:
        ARRAY: position markers array
              [center marker name, [reinforcment pos markers]]
        NUMBER: mission type. 0=city, 1=land
	
	Returns: -
  
*/

_aoArray = _this select 0;
_missionType = _this select 1;

_reinfMarkers = _aoArray select 1;

// MARKER
_marker = _aoArray select 0;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "mortar";
[
west, // who gets the task
_taskID, // task id
["Our troops are taking mortar fire from the AO. Find the mortar emplacement and destroy it.","SAD mortar","SAD"], // description, title, marker
_aocenter, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE mortar
_mortarClass = ani_mortarClass;
_gunnerClass = ani_mortarGunnerClass;

_mortarPos = [_aocenter, random 360, 50 max (random 300)] call SHK_pos;
//_mortarPos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);
_mortarGrp =  createGroup east;

_dir = (random 360);
ani_mortar1 = _mortarClass createVehicle _mortarPos;
ani_mortar1 setDir _dir;
ani_gunner1 = _mortarGrp createUnit [_gunnerClass, _mortarPos, [], 10, "NONE"];
ani_gunner1 moveInGunner ani_mortar1;

ani_mortar2 = _mortarClass createVehicle ([_mortarPos, random 360, 10] call SHK_pos);
ani_mortar2 setDir _dir;
ani_gunner2 = _mortarGrp createUnit [_gunnerClass, _mortarPos, [], 10, "NONE"];
ani_gunner2 moveInGunner ani_mortar2;

ani_mortar3 = _mortarClass createVehicle ([_mortarPos, random 360, 10] call SHK_pos);
ani_mortar3 setDir _dir;
ani_gunner3 = _mortarGrp createUnit [_gunnerClass, _mortarPos, [], 10, "NONE"];
ani_gunner3 moveInGunner ani_mortar3;

// LOGIC
ani_mortarDestroyed = false;
[_mortarPos, "STATE:", ["!alive ani_gunner1 and !alive ani_gunner2 and !alive ani_gunner3", "ani_mortarDestroyed=true", ""]] call CBA_fnc_createTrigger;

// BEHAVIOUR
[] spawn {
while {!ani_mortarDestroyed} do {
  {
    _x doWatch ani_target;
    _xpos = getPos ani_target select 0;
    _ypos = getPos ani_target select 1;
    _x commandArtilleryFire [[_xpos, _ypos, 0], "8Rnd_82mm_Mo_shells", 3];
    sleep (random 3);
  } forEach [ani_gunner1, ani_gunner2, ani_gunner3];
  {
    _x setVehicleAmmo 1;
  } forEach [ani_mortar1, ani_mortar2, ani_mortar3];
  sleep 30 + (random 30);
}
};

// SPAWN ENEMIES
[_marker,[ani_enemySide,ani_enemyFaction,20],[_marker, 200],[[1,3],[4,5]],[[0,2],1,false],[],[],["patrol_gc", 250]] spawn SLP_spawn;
sleep 5 + (random 5);
[_marker,[ani_enemySide,ani_enemyFaction,20],[ani_mortar1, 10],[1,[4,6]],[],[],[],["defend_gc", 50]] spawn SLP_spawn;


// REINFORCEMENTS
sleep 5 + (random 5);
_reinfSpawn1 = _reinfMarkers call BIS_fnc_selectRandom;
_reinfMarkers = _reinfMarkers - [_reinfSpawn1];
_reinfSpawn2 = _reinfMarkers call BIS_fnc_selectRandom;
[_marker,[ani_enemySide,ani_enemyFaction,10],[_reinfSpawn1, 10],[1,[6,8]],[],[],[],["reinforcement_o_gc", ani_mortar1]] spawn SLP_spawn;

waitUntil{sleep 0.1; ani_mortarDestroyed};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
_marker setMarkerColor "ColorGreen";
_marker setMarkerAlpha 0.3;
