/*
	File: fn_mhTriggerOnObjectDestroyed.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Sets a variable to true as soon as the
		given object is destroyed/dead.

	Parameter(s):
		0: STRING
			global variable name of the object to watch
		1: STRING
			variable name to set to true
			as soon as the object is destroyed
	Returns:
	-
*/

_object = [_this, 0, "objNull", [""]] call BIS_fnc_param;
_variable = [_this, 1, "variable", [""]] call BIS_fnc_param;

_pos = [0,0,0];
// create condition
_condition = format ["!alive %1", _object];
// create on activation code
_onActivation = format ["%1 = true", _variable];

// create the trigger
[_pos, "STATE:", [_condition, _onActivation, ""]] call CBA_fnc_createTrigger;
