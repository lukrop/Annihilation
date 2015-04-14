/*
	File: fn_gcDeleteFirstInQueue.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Deletes the first object in the queue and
		shifts the array to the left. FIFO

	Parameter(s):
	-

	Returns:
	-
*/

_obj = lkr_gc_queue select 0;

// check if the unit/object is really dead/destroyed
if(!alive _obj) then {
	if(lkr_gc_debug) then {["Deleting %1", _obj] call BIS_fnc_logFormat};

	// if it's a man it has a body, let's hide it first :o)
	if(_obj isKindOf "Man") then {
		_obj spawn {
			hideBody _this;
			sleep 5;
			deleteVehicle _this;
		};
	} else {
		deleteVehicle _obj;
	};
};

// now shift the array to the left aka remove the object from the array
lkr_gc_queue = lkr_gc_queue - [_obj];
