/*
	File: fn_mhMoveInRandomHouse.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Move unit in random house position around given radius.
		If no building is found the unit is not moved.

	Parameter(s):
		0. OBJECT
			Unit to move.
		1. POSITION
			center position
		2. SCALAR
			radius to search for buildings

	Returns:
		new position of the unit
*/


private ["_posArray", "_building", "_p", "_i", "_x", "_newPos"];

_unit = _this select 0;
_pos = _this select 1;
_radius = _this select 2;

_list = _pos nearObjects ["House", _radius];
if(count _list > 0) then {
	_building = _list call BIS_fnc_selectRandom;

	_i = 0;
	_x = "";
	_posArray = [];
	while {format["%1", _x] != "[0,0,0]"} do {
	  _p = _building buildingPos _i;
	  _posArray = _posArray + [_p];
	  _x = str _p;
	  _i = _i + 1;
	};

	_lastPos = (count _posArray) - 1;
	_posArray set [_lastPos, "remove"];
	_posArray = _posArray - ["remove"];

	if(count _posArray == 0) exitWith{getPos _unit};

	_newPos =_posArray call BIS_fnc_selectRandom;
	_unit setPos _newPos;

} else {
	//_building = nearestBuilding _pos;
	_newPos = _pos;
};

_newPos