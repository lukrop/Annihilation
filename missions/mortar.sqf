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
_missionStyle = _this select 1;

_reinfMarkers = _aoArray select 1;

// MARKER
_marker = _aoArray select 0;
// [[_marker, 1, "ColorRed"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 1, "ColorRed"] call ani_changeMarker;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "mortar";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_MORTAR_DESCRIPTION", localize "STR_ANI_MORTAR", localize "STR_ANI_SAD"], // description, title, marker
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

// spawn enemies and reinforcements
[_missionStyle, _marker, _reinfMarkers, ani_mortar1] spawn ani_spawnEnemies;

waitUntil{sleep 0.5; ani_mortarDestroyed};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
// [[_marker, 0.3, "ColorGreen"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 0.3, "ColorGreen"] call ani_changeMarker;
// cleanup
sleep 120;
while{not ([ani_mortar1, 500] call CBA_fnc_nearPlayer)} do {sleep 30};
{deleteVehicle _x} forEach [ani_mortar1, ani_mortar2, ani_mortar3, ani_gunner1, ani_gunner2, ani_gunner3];
deleteGroup _mortarGrp;
