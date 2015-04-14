/*
	File: fn_enableGarbageCollection.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Enables garbage collection for a group or unit.

	Parameter(s):
		0: OBJECT
			Unit or vehicle to enable garbage collection for.

	Returns:
	-
*/
private ["_group", "_addToQueue"];

_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

// add a killed event handler which adds the unit to the gc queue
_obj addEventHandler ["killed", {
	// optional timeout before added to gc queue
	// sleep 120;
	(_this select 0) call lkr_fnc_gcAdd;
}];
