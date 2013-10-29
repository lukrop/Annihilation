/*
	Author: lukrop
	Date: 10/27/2013
  	Description: Spawns reinforcements at the closest OP if enemys are detected in the AO

	Parameters: STRING: marker name of current AO (center)

	Returns: -

*/
private ["_AOCenterMarker", "_AOCenterPos", "_reinfSpawn", "_reinfPos", "_vec", "_grp",
	"_reinfVecPos", "_minGroups", "_maxGroups", "_groups", "_minVecs", "_maxVecs", "_vecs"];

_AOCenterMarker = _this select 0;

ani_blueDetected = false;

[getMarkerPos _AOCenterMarker,
"AREA:", [300, 300, 0, false],
"ACT:", ["WEST", "EAST D", false],
"STATE:", ["this", "ani_blueDetected=true", ""]] call CBA_fnc_createTrigger;

waitUntil {sleep 1; ani_blueDetected};
if(count ani_enemyOPMarkers > 0) then {
	_reinfSpawn = [_AOCenterMarker] call ani_getClosestOP;

	_AOCenterPos = getMarkerPos _AOCenterMarker;
	_reinfPos = getMarkerPos (_reinfSpawn select 0);
	_reinfVecPos = getMarkerPos (_reinfSpawn select 1);

	_minGroups = ani_enemyInfReinfCount select 0;
	_maxGroups = ani_enemyInfReinfCount select 1;
	_groups = _minGroups max (round (random _maxGroups));

	for "_i" from 1 to _maxGroups do {
		_grp = [_reinfPos, east,
		[ani_enemyLeaders call BIS_fnc_selectRandom,
		ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom,
		ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom,
		ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom, ani_enemyUnits call BIS_fnc_selectRandom],
		[], [], ani_skill_inf, [], [6, 0.5]] call BIS_fnc_spawnGroup;

		if((_reinfPos distance _AOCenterPos) > 500) then {
			_vec = createVehicle [ani_enemyTruckClass, _reinfVecPos, [], 0, "NONE"];
			[_grp, getPos _vec, 0, "GETIN NEAREST", "AWARE", "GREEN", "NORMAL", "COLUMN", "", [0,0,0]] call CBA_fnc_addWaypoint;
			[_grp, _AOCenterPos, 60, "GETOUT", "SAFE", "GREEN", "NORMAL", "COLUMN", "", [0,0,0]] call CBA_fnc_addWaypoint;
			[_grp, _AOCenterPos, 30, "SAD", "AWARE", "YELLOW", "NORMAL", "LINE", "", [0,0,0]] call CBA_fnc_addWaypoint;
			[_grp, _AOCenterPos, 30, "MOVE", "SAFE", "YELLOW", "NORMAL", "COLUMN",
			"[group this, getPos this, 300, 7, 'MOVE', 'SAFE', 'YELLOW', 'LIMITED', 'STAG COLUMN', '', [3,6,9]] call CBA_fnc_taskPatrol",
			[0,0,0]] call CBA_fnc_addWaypoint;
		} else {
			[_grp, _AOCenterPos, 30, "SAD", "AWARE", "YELLOW", "NORMAL", "LINE", "", [0,0,0]] call CBA_fnc_addWaypoint;
			[_grp, _AOCenterPos, 30, "MOVE", "SAFE", "YELLOW", "NORMAL", "COLUMN",
			"[group this, getPos this, 300, 7, 'MOVE', 'SAFE', 'YELLOW', 'LIMITED', 'STAG COLUMN', '', [3,6,9]] call CBA_fnc_taskPatrol",
			[0,0,0]] call CBA_fnc_addWaypoint;
		};

		[_grp] spawn {
		    _grp = _this select 0;
		    waitUntil{sleep 5; ani_missionState != "IN_PROGRESS"};
		    {
		      while{[_x, 1500] call CBA_fnc_nearPlayer} do {sleep 30 + (random 5)};
		      deleteVehicle _x;
		    } forEach units _grp;
			deleteGroup _grp;
		};
		sleep 15;
	};

	_minVecs = ani_enemyVecReinfCount select 0;
	_maxVecs = ani_enemyVecReinfCount select 1;
	_vecs = _minVecs max (round (random _maxVecs));

	for "_i" from 1 to _maxVecs do {
		_grp = [_reinfVecPos, east, [ani_enemyVehicles call BIS_fnc_selectRandom],[], [], ani_skill_vec] call BIS_fnc_spawnGroup;
		[_grp, _AOCenterPos, 30, "SAD", "AWARE", "YELLOW", "NORMAL", "LINE", "", [0,0,0]] call CBA_fnc_addWaypoint;
		[_grp, _AOCenterPos, 30, "MOVE", "SAFE", "YELLOW", "NORMAL", "COLUMN",
			"[group this, getPos this, 300, 7, 'MOVE', 'SAFE', 'YELLOW', 'LIMITED', 'STAG COLUMN', '', [3,6,9]] call CBA_fnc_taskPatrol",
			[0,0,0]] call CBA_fnc_addWaypoint;
		sleep 10;

		[_grp] spawn {
		    _grp = _this select 0;
		    waitUntil{sleep 5; ani_missionState != "IN_PROGRESS"};
		    {
		      while{[_x, 1500] call CBA_fnc_nearPlayer} do {sleep 30 + (random 5)};
		      deleteVehicle _x;
		    } forEach units _grp;
			deleteGroup _grp;
		};
	};
};
