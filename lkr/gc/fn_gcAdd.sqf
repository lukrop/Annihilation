/*
	File: fn_gcAdd.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Adds object to garbage collector queue.

	Parameter(s):
		0: OBJECT:
			the object to remove

	Returns:
	-
*/


// we can only add arrays to arrays
if(typename _this != "ARRAY") then {_this = [_this]};
if(lkr_gc_debug) then {["Adding %1 to queue", _this] call BIS_fnc_logFormat};
lkr_gc_queue = lkr_gc_queue + _this;
