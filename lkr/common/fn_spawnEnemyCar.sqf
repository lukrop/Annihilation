/*
	File: fn_spawnEnemyCar.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Spawns a enemy wheeled vehicle.

	Parameter(s):
		0: STRING, OBJECT, ARRAY:
			The spawn position of the enemy car. Can be a
			marker name in which case a random position is choosen
			within the marker. Can be a object or a position.

		1: ARRAY:
			An array of 3 elements with the task the position and the radius.
			See fn_groupExecuteTask for details.
			Examples:
				["patrol", patrolPosition, 150]
					- patrol a radius of 150 meters around patrolPosition
				["attack", attackPosition, 50]
					- attack the position attackPosition and search for enemys in a radius of 50 meters

		2: BOOL:
			Whether to do garbage collection or not.
			If true dead bodies of this group will be removed
			by the garbage collector. Default is true.

	Returns:
		GROUP:
			The spawned enemy group.
*/

private ["_pos", "_task", "_gc", "_unitsList"];

// check if the paramter is defined if not use [0,0,0]
// paramter can be a string, object or a array of count 3
_param0 = [_this, 0, [0,0,0], [objNull,[],""], [3]] call BIS_fnc_param;

// get a usable position from the diffrent variable types
if(typename _param0 == "OBJECT") then {_pos = getPos _param0};
if(typename _param0 == "ARRAY") then {_pos = _param0};
// if it's a string we assume it's a marker name
// let's choose a random position within the marker
if(typename _param0 == "STRING") then {_pos = _param0 call SHK_pos};

// write warning to rpt if we are spawning to [0,0,0] usually something is fishy in this case
if((_pos select 0) == 0 && (_pos select 1) == 0 && (_pos select 2) == 0) then {
	"Warning! Spawning group at origin position [0,0,0]." call BIS_fnc_log
};

_task = [_this, 1, ["nothing"], [[]], [3]] call BIS_fnc_param;
// check if we should do garbage collection
_gc = [_this, 2, true, [true]] call BIS_fnc_param;

// create unit list for the group;
_unitsList = [(lkr_enemy_inf_units_C call BIS_fnc_selectRandom), (lkr_enemy_inf_units_C call BIS_fnc_selectRandom)];

// spawn the group
_enemyGroup = [_pos, lkr_enemy_side, _unitsList, lkr_enemy_skill_range] call lkr_fnc_spawnGroup;

_veh = createVehicle [lkr_enemy_vecs_C call BIS_fnc_selectRandom, _pos, [], 0, "NONE"];

((units _enemyGroup) select 0) moveInDriver _veh;
((units _enemyGroup) select 1) moveInGunner _veh;

// if we do garbage collection enable it for the whole group
if(_gc) then {
	{
		_x call lkr_fnc_enableGarbageCollection
	} forEach units _enemyGroup;
};

// only assign a task if one is given
if((_task select 0) != "nothing") then {
	// forge the paramters for the groupExecuteTask call
	// the paramters should be [group, taskname, position, radius]
	_taskParam = [_enemyGroup] + _task;
	_taskParam call lkr_fnc_groupExecuteTask;
};

// return the group
_enemyGroup
