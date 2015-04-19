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
private ["_aoArray", "_missionStyle", "_reinfMarkers", "_marker", "_aocenter"]
_aoArray = _this select 0;
_missionStyle = _this select 1;

_reinfMarkers = _aoArray select 1;

// MARKER
_marker = _aoArray select 0;
[[_marker, 1], "ani_changeMarker", true, true] spawn BIS_fnc_MP;
//[_marker, 1, "ColorRed"] call ani_changeMarker;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "mortar";
[
lkr_friendly_side, // who gets the task
_taskID, // task id
[localize "STR_ANI_MORTAR_DESCRIPTION", localize "STR_ANI_MORTAR", localize "STR_ANI_SAD"], // description, title, marker
_aocenter, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE mortar
_mortarClass = lkr_mortarClass;
_gunnerClass = lkr_mortarGunnerClass;

_mortarPos = [_aocenter, random 360, 20 max (random 200)] call SHK_pos;
//_mortarPos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);
_mortarGrp =  createGroup lkr_enemy_side;

_dir = (random 360);
lkr_mortar1 = _mortarClass createVehicle _mortarPos;
lkr_mortar1 setDir _dir;
lkr_gunner1 = _mortarGrp createUnit [_gunnerClass, _mortarPos, [], 10, "NONE"];
lkr_gunner1 moveInGunner lkr_mortar1;
// do not cache the gunner
lkr_gunner1 setVariable ["cacheObject", false, true];

lkr_mortar2 = _mortarClass createVehicle ([_mortarPos, random 360, 10] call SHK_pos);
lkr_mortar2 setDir _dir;
lkr_gunner2 = _mortarGrp createUnit [_gunnerClass, _mortarPos, [], 10, "NONE"];
lkr_gunner2 moveInGunner lkr_mortar2;
lkr_gunner2 setVariable ["cacheObject", false, true];

lkr_mortar3 = _mortarClass createVehicle ([_mortarPos, random 360, 10] call SHK_pos);
lkr_mortar3 setDir _dir;
lkr_gunner3 = _mortarGrp createUnit [_gunnerClass, _mortarPos, [], 10, "NONE"];
lkr_gunner3 moveInGunner lkr_mortar3;
lkr_gunner3 setVariable ["cacheObject", false, true];

// LOGIC
lkr_mortarDestroyed = false;
[_mortarPos, "STATE:", ["!alive lkr_gunner1 and !alive lkr_gunner2 and !alive lkr_gunner3", "lkr_mortarDestroyed=true", ""]] call CBA_fnc_createTrigger;

// BEHAVIOUR
[] spawn {
while {!lkr_mortarDestroyed} do {
  {
    _x doWatch ani_target;
    _xpos = getPos ani_target select 0;
    _ypos = getPos ani_target select 1;
    _x commandArtilleryFire [[_xpos, _ypos, 0], "8Rnd_82mm_Mo_shells", 3];
    sleep (3 + (random 3));
  } forEach [lkr_gunner1, lkr_gunner2, lkr_gunner3];
  {
    _x setVehicleAmmo 1;
  } forEach [lkr_mortar1, lkr_mortar2, lkr_mortar3];
  sleep 30 + (random 30);
}
};

/*
// spawn enemies and reinforcements
[_missionStyle, _marker, _reinfMarkers, lkr_mortar1] spawn ani_spawnEnemies;
if(ani_enemyReinforcements == 1) then {
  [_marker] execVM "enemyReinforcements.sqf";
};
*/

if(lkr_hc_present && isMultiplayer) then {
    [[_mortarPos, _mortarPos, [1,1], [2,3]], "lkr_fnc_spawnOccupation", lkr_hc_id] call BIS_fnc_MP;
} else {
    [_mortarPos, _mortarPos, [1,1], [2,3]] call lkr_fnc_spawnOccupation;
};

waitUntil{sleep (1 + (random 2)); lkr_mortarDestroyed};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
// [[_marker, 0.3, "ColorGreen"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
//[_marker, 0.3, "ColorGreen"] call ani_changeMarker;
// cleanup
/*
sleep 120;
while{not ([lkr_mortar1, 500] call CBA_fnc_nearPlayer)} do {sleep 30};
{deleteVehicle _x} forEach [lkr_mortar1, lkr_mortar2, lkr_mortar3, lkr_gunner1, lkr_gunner2, lkr_gunner3];
deleteGroup _mortarGrp;
*/
