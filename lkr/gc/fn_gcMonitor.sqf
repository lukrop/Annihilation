/*
	File: fn_gcMonitor.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Monitors the garbage collector queue and initiates
		the removing of objects if the queue is full.

	Parameter(s):
	-

	Returns:
	-
*/
objNull spawn {
	// endless loop
	while {true} do {
		// check if the queue is full
		if(count lkr_gc_queue > lkr_gc_max_size) then {
			//if(lkr_gc_debug) then {"Queue full. Deleting queue contents." call BIS_fnc_log};
			// empty the queue
			//call lkr_fnc_gcEmptyQueue;

			if(lkr_gc_debug) then {"Queue full. Starting deletion of items." call BIS_fnc_log};
			// start removing the items from the front until there is
			// free room in the queue again
			while{count lkr_gc_queue >= lkr_gc_max_size} do {
				// delete first item in queue
				call lkr_fnc_gcDeleteFirstInQueue;
			};
		};
		// wait for the intervall timeout
		sleep lkr_gc_intervall;
	};
};
