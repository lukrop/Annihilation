/*
	Author: lukrop
	Date: 10/27/2013
  	Description: Populates enemy OPs

	Parameters: -

	Returns: -

*/

ani_enemyOPMarkers = ["enemy_op", "enemy_op_1", "enemy_op_2"];

{
	_tower = createVehicle ["Land_Communication_F", getMarkerPos _x, [], 0, "NONE"];
	missionNamespace setVariable [format ["ani_%1_tower", _x], _tower];
	missionNamespace setVariable [format ["ani_%1_active", _x], true];
	[getMarkerPos _x, "STATE:", [format ["!alive ani_%1_tower", _x], format ["ani_%1_active = false", _x], ""] ] call CBA_fnc_createTrigger;

	[_x] spawn {
		private ["_op"];
		_op = _this select 0;
		waitUntil{sleep 1;not (missionNamespace getVariable (format ["ani_%1_active", _op]))};
		ani_enemyOPMarkers = ani_enemyOPMarkers - [_op];
		[_op, 1, "ColorBLUFOR", "hd_flag", "Cleared"] call ani_changeMarker;
	};

	sleep 5;

	if(ani_populateEnemyOPs == 1) then {
		[_x,[ani_enemySide, ani_enemyFaction],[_x, 20],[[1,2],[2,4]],[],[],[],["patrol", 70]] call SLP_spawn;
		sleep 5 + (random 5);
		[_x,[ani_enemySide, ani_enemyFaction],[_x],[1,[4,6]],[],[],[],["defend", 50]] call SLP_spawn;
		sleep 10 + (random 5);
	};
} forEach ani_enemyOPMarkers;
