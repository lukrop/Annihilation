/*
	File: fn_mhMakeHostage.hpp
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Makes a unit hostage, rescueable via action entry.

	Parameter(s):
		0. OBJECT
			Unit to make hostage.

	Returns:
	-
*/

_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_unit setCaptive true;
removeAllWeapons _unit;
_unit setUnitPos "DOWN";
_unit disableAI "MOVE";
_unit disableAI "ANIM";

[[_unit],"lkr_fnc_addRescueAction",nil,true] spawn BIS_fnc_MP;
