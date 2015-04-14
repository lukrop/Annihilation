/*
	File: fn_mhFreeHostage.hpp
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Frees a hostage by joining it to the group of
		the player who called the action.

	Parameter(s):
		0. OBJECT
			Hostage.
		1. OBJECT
			Unit that called the action.

	Returns:
	-
*/

_hostage = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_unit = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

_hostage setCaptive false;
_hostage enableAI "MOVE";
_hostage enableAI "ANIM";
_hostage setUnitPos "Auto";

[_hostage] joinSilent (group _unit);
doStop _hostage;

[_hostage, "lkr_fnc_removeAllActions", nil, true] spawn BIS_fnc_mp;
