/*
	File: fn_groupExecuteTask.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Makes a group execute a given task.

	Parameter(s):
		0: OBJECT, GROUP
			Group or unit of the group which should execute the task
		1: STRING
			The task to execute. Can be one of:
				"patrol", "defend", "scout", "attack"
		2: STRING, POSITION, OBJECT
			Marker name from within a random position is chosen or
			a object or a position.
		3: SCALAR
			Radius in which the group is patrolling, scanning for hiding
			positions, scouting or searching the area while attacking.
	Returns:
	-
*/

private ["_group", "_task", "_pos", "_radius"];

_param0 = [_this, 0, objNull, [objNull, grpNull]] call BIS_fnc_param;
_task = [_this, 1, "patrol", [""]] call BIS_fnc_param;
_param2 = [_this, 2, [0,0,0], [[],"", objNull],[3]] call BIS_fnc_param;
_radius = [_this, 3, 150, [0]] call BIS_fnc_param;

if(typename _param0 == "OBJECT") then {
	// we got a unit as first param select it's group
	_group = group _param0
} else {
	// we got a group
	_group = _param0;
};

if(typename _param2 == "STRING") then {
	// we got a string so we expect it to be a marker name
	// and choose a random position within that marker
	_pos = _param2 call SHK_pos;
} else {
	if(typename _param2 == "OBJECT") then {
		// we got a object parse its position
		_pos = getPos _param2;
	} else {
		// we got a position
		_pos = _param2;
	};
};

// write warning to rpt if we are tasking to [0,0,0] usually something is fishy in this case
if((_pos select 0) == 0 && (_pos select 1) == 0 && (_pos select 2) == 0) then {
	"Warning! Tasking group to origin position [0,0,0]." call BIS_fnc_log
};


switch(_task) do {
	case "patrol": {
		// lets the group patrol at the given position inside the radius
		[_group, _pos, _radius] call BIS_fnc_taskPatrol;
	};

	case "defend": {
		// lets the group search defend positions within the given radius
		[_group, _pos, _radius, 2, true] call CBA_fnc_taskDefend;
	};

	case "scout": {
		// STUB
		"Warning! Scout task is a STUB. Tasking nothing." call BIS_fnc_log;
	};

	case "attack": {
		// lets the group attack the position and search within the radius for enemys
		[_group, _pos, _radius] call CBA_fnc_taskAttack;
	};
	default {
		["Error! There is no such task as %1. Tasking nothing.", _task] call BIS_fnc_logFormat;
	};
};
