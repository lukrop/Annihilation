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
_missionStyle = _this select 1;

_vecSpawnMarker = _aoArray select 1;
_reinfMarkers = _aoArray select 2;
_spawnMarkers = _aoArray select 3;


// MARKER
_marker = _aoArray select 0;
// [[_marker, 1, "ColorRed"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 1, "ColorRed"] call ani_changeMarker;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "killhvtstatic";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_KILLHVT_DESCRIPTION", localize "STR_ANI_KILLHVT", localize "STR_ANI_HVT"], // description, title, marker
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

// spawn enemies and reinforcements
[_missionStyle, _marker, _reinfMarkers, ani_hvt] call ani_spawnEnemies;

// LOGIC
ani_hvtKilled = false;
[_hvtPos, "STATE:", ["!alive ani_hvt", "ani_hvtKilled=true", ""]] call CBA_fnc_createTrigger;

waitUntil{sleep 0.1;ani_hvtKilled};
ani_missionState = "SUCCESS";
[_taskID, "Succeeded"] call BIS_fnc_taskSetState;
// [[_marker, 0.3, "ColorGreen"], "ani_changeMarker", nil, true] spawn BIS_fnc_MP;
[_marker, 0.3, "ColorGreen"] call ani_changeMarker;

sleep 60;
while{not [ani_hvt, 300] call CBA_fnc_nearPlayer} do {sleep 30};
hideBody ani_hvt;
sleep 10;
deleteVehicle ani_hvt;
