/*
	Author: lukrop
	Date: 10/27/2013
  	Description: Spawns reinforcements at the closest OP if enemys are detected in the AO

	Parameters: STRING: marker name of current AO (center)

	Returns: -

*/

_AOCenterMarker = _this select 0;

ani_blueDetected = false;

[getMarkerPos _AOCenterMarker,
"AREA:", [300, 300, 0, false],
"ACT:", ["WEST", "EAST D", false],
"STATE:", ["this", "ani_blueDetected=true", ""]] call CBA_fnc_createTrigger;

waitUntil {sleep 0.1; ani_blueDetected};
_reinfSpawn = [_AOCenterMarker] call ani_getClosestOP;

_AOCenterPos = getMarkerPos _AOCenterMarker;
_reinfPos = getMarkerPos (_reinfSpawn select 0);
_reinfVecPos = getMarkerPos (_reinfSpawn select 1);

_grp = [_reinfPos, east,
[ani_enemyLeaders call BIS_fnc_selectRandom,
ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom,
ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom,
ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom],
[], [], [0.15,0.45], [], [6, 0.5]] call BIS_fnc_spawnGroup;

if((_reinfPos distance _AOCenterPos) > 500) then {
	//_nearestRoads = _reinfPos nearRoads 300;
	//_roadPos = getPos (_nearestRoads select 0);
	_vec = createVehicle ["O_Truck_02_transport_F", _reinfVecPos, [], 0, "NONE"];
	[_grp, getPos _vec, 0, "GETIN NEAREST", "AWARE", "GREEN", "NORMAL", "COLUMN", "", [0,0,0]] call CBA_fnc_addWaypoint;
	[_grp, _AOCenterPos, 60, "GETOUT", "SAFE", "GREEN", "NORMAL", "COLUMN", "", [0,0,0]] call CBA_fnc_addWaypoint;
	[_grp, _AOCenterPos, 30, "SAD", "AWARE", "YELLOW", "NORMAL", "LINE", "", [0,0,0]] call CBA_fnc_addWaypoint;
} else {
	[_grp, _AOCenterPos, 30, "SAD", "AWARE", "YELLOW", "NORMAL", "LINE", "", [0,0,0]] call CBA_fnc_addWaypoint;
};

