/*
	Author: lukrop
	Date: 10/27/2013
  	Description: Finds the closest OP for spawning reinforcements

	Parameters: STRING: marker name of current AO (center)

	Returns: STRING: reinforcement spawn marker

*/

private ["_minDist", "_lastDist", "_closestOP", "_aoCenter", "_return"];

_aoCenter = _this select 0;
_minDist = 999999999999;

{
	_lastDist = (getMarkerPos _aoCenter) distance (getMarkerPos _x);
	if(_lastDist < _minDist) then {
		_minDist = _lastDist;
		_closestOP = _x;
	};
} forEach ani_enemyOPMarkers;

switch (_closestOP) do {
	case "enemy_op": {
		_return  = ["enemy_op", "reinf_vec_spawn"];
	};
	case "enemy_op_1": {
		_return  = ["enemy_op_1", "reinf_vec_spawn_1"];
	};
	case "enemy_op_2": {
		_return  = ["enemy_op_2", "reinf_vec_spawn_2"];
	};
};

_return