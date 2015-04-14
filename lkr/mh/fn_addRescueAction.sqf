/*
	File: fn_mhAddRescueAction.hpp
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Adds a action entry to rescue the given unit.

	Parameter(s):
		0. OBJECT
			Unit to add action to.

	Returns:
	-
*/

_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_unit addAction ["Rescue", {[_this select 0, _this select 1] call lkr_fnc_freeHostage}];
