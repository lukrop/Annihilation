/*
	File: fn_gcInit.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Initializes the garbage collector and starts monitoring
		of the queue.

	Parameter(s):
	-

	Returns:
	-
*/

// only run the gc on the server
if(!isServer) exitWith{};
// wait until the config is loaded
//waitUntil {!isNil "lkr_config_loaded"};

// Disable/Enable debug messages
lkr_gc_debug = true;
// maximum size of the queue
lkr_gc_max_size = 16;
// intervall at which the queue is checked
lkr_gc_intervall = 30;
// start with a empty queue
lkr_gc_queue = [];

if(lkr_gc_debug) then {"Starting lkr garbage collector." call BIS_fnc_log};
// start the monitoring of the queue
call lkr_fnc_gcMonitor;
