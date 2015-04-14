/*
	File: fn_spawnGroup.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Spawns a enemy group.

	Parameter(s):
		0: ARRAY:
			Position where to spawn the group.

		1: SIDE:
			Side of the group. Center has to be created before.

		2: ARRAY:
			Array of unit class names to spawn.

		3: ARRAY:
			Skill range array. [min skill, max skill]

	Returns:
		GROUP:
			The new group.
*/

private ["_pos", "_side", "_units", "_skill_range", "_group"];

// get paramters and set their default values if not present
_pos = [_this, 0, [0,0,0], [[]], [3]] call BIS_fnc_param;
_side = [_this, 1, lkr_enemy_side, [east]] call BIS_fnc_param;
_units = [_this, 2, [], [[]]] call BIS_fnc_param;
_skill_range = [_this, 3, [0.5, 0.5], [[]], [2]] call BIS_fnc_param;

// create group
_group = createGroup _side;

// find out how many units should be in the group
_unit_count = (count _units) - 1;
// loop for the amount of units to spawn
for "_i" from 0 to _unit_count do {
	// select class name of current unit
	_cur_unit = _units select _i;
	// create unit
	_unit = _group createUnit [_cur_unit, _pos, [], 0, "FORM"];
	// set unit skill between min and max
	_skill = _skill_range call lkr_fnc_getNumberBetween;
	_unit setSkill _skill;
	//["Unit: %1 has skill: %2", _unit, _skill] call BIS_fnc_logFormat;
	// sleep between 1 and 2 seconds to let the net engine catch up
	sleep ([1,2] call lkr_fnc_getNumberBetween);
};
// return group
_group
