/*
	Author: lukrop
	Date: 10/6/2013
  Description: Mission script. Creates task, creates pilot
	
	Parameters:
        ARRAY: position markers array
              [center marker name, vec spawn marker, [reinforcment pos markers], [spawn pos markers]]
        NUMBER: mission type. 0=city, 1=land
	
	Returns: -
  
*/

private ["_posArray", "_missionStyle", "_vecSpawnMarker", "_reinfMarkers", "_spawnMarkers", "_marker", "_aocenter", "_taskID", "_reinfCount"];

_posArray = _this select 0;
_missionStyle = _this select 1;

_vecSpawnMarker = _posArray select 1;
_reinfMarkers = _posArray select 2;
_spawnMarkers = _posArray select 3;


// MARKER
_marker = _posArray select 0;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

_aocenter = getMarkerPos _marker;

// CREATE TASK
_taskID = "rescuepilot";
[
west, // who gets the task
_taskID, // task id
[localize "STR_ANI_RESCUEPILOT_DESCRIPTION", localize "STR_ANI_RESCUEPILOT", localize "STR_ANI_CSAR"], // description, title, marker
_aocenter, // destination
"Assigned", // set as current / state
9 // priority
] call BIS_fnc_taskCreate;

// CREATE Pilot
_crashPos = getMarkerPos (_spawnMarkers call BIS_fnc_selectRandom);
// spawn downed chopper
_chopper = ani_chopperClass createVehicle _crashPos;
_chopper setDamage 0.9;
_chopper setFuel (random 0.3);
_chopper setVehicleAmmo (random 0.5);

["crashsite", [_crashPos select 0, _crashPos select 1], "Icon", [1, 1], "COLOR:", "ColorBlack", "TYPE:", "hd_objective", "PERSIST"] call CBA_fnc_createMarker;

_pilotClass = ani_recruit_PilotClass;
_pilotGrp = createGroup west;
ani_pilot = _pilotGrp createUnit [_pilotClass, _crashPos, [], 0, "FORM"];
// move him to random house position
_pilotPos = [ani_pilot, (getPos ani_pilot), 30] call ani_moveInRandomBuilding;
// make the pilot a hostage
[ani_pilot] call ani_makeUnitHostage;
// spawn two guards
[_pilotPos, east, [ani_hvtGuardClass, ani_hvtGuardClass], [[1,2,0]]] call BIS_fnc_spawnGroup;

// spawn enemies and reinforcements
[_missionStyle, _marker, _reinfMarkers, ani_pilot] call ani_spawnEnemies;

// LOGIC
_base = getMarkerPos "recruitment";
ani_pilotKilled = false;
ani_pilotRescued = false;
[_pilotPos, "STATE:", ["(!alive ani_pilot) and (!ani_pilotRescued)", "ani_pilotKilled=true", ""]] call CBA_fnc_createTrigger;
_trigger = [_base, "AREA:", [10, 10, 0, false], "ACT:", ["VEHICLE", "PRESENT", false],
           "STATE:", ["this and (alive ani_pilot)", "ani_pilotRescued = true", ""]] call CBA_fnc_createTrigger;
_trigger = _trigger select 0;
_trigger triggerAttachVehicle [ani_pilot];


waitUntil{sleep 0.1;ani_pilotKilled or ani_pilotRescued};
if(ani_pilotKilled) then {
  ani_missionState = "FAILED";
  [_taskID, "Failed"] call BIS_fnc_taskSetState;
  _marker setMarkerColor "ColorYellow";
  _marker setMarkerAlpha 0.3;
} else {
  ani_missionState = "SUCCESS";
  [_taskID, "Succeeded"] call BIS_fnc_taskSetState;
  _marker setMarkerColor "ColorGreen";
  _marker setMarkerAlpha 0.3;
};