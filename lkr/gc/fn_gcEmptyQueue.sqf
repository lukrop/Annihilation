/*
	File: fn_gcEmptyQueue.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Deletes all objects in the garbage collector queue.

	Parameter(s):
	-

	Returns:
	-
*/

{
	// check if the unit is really dead
	if(!alive _x) then {
		if(lkr_gc_debug) then {["Deleting %1", _x] call BIS_fnc_logFormat};

		// if it's a man it has a body, let's hide it first :o)
		if(_x isKindOf "Man") then {
			_x spawn {
				hideBody _this;
				sleep 5;
				deleteVehicle _this;
			};
		} else {
			deleteVehicle _x;
		};
	};
} count lkr_gc_queue;

// empty the queue
lkr_gc_queue = nil;
lkr_gc_queue = [];
