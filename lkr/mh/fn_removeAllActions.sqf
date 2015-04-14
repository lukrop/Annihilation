/*
	File: fn_mhRemoveAllActions.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Removes all actions from the given unit/object.

	Parameter(s):
		0. OBJECT
			The object.
	Returns:
	-
*/

_obj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
removeAllActions _obj;
