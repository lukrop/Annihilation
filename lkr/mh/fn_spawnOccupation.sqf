/*
	File: fn_spawnOccupation.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Spawns enemy groups with diffrent tasks.

	Parameter(s):
		0: ARRAY
			Position to occupy.
		1: ARRAY
			Position to defend.
		2: ARRAY
			Defend groups count
			0: SCALAR
				Min defend groups
			1: SCALAR
				Max defend groups
		3: ARRAY
			Patrol groups count
			0: SCALAR
				Min patrol groups
			1: SCALAR
				Max patrol groups
	Returns:
	-
*/

private ["_spawnPos", "_defendPos"];

_spawnPos = [_this, 0, [0,0,0], [[]], [3]] call BIS_fnc_param;
_defendPos = [_this, 1, [0,0,0], [[]], [3]] call BIS_fnc_param;
_defendGroupRange = [_this, 2, [1,1], [[]], [2]] call BIS_fnc_param;
_patrolGroupRange = [_this, 3, [2,3], [[]], [2]] call BIS_fnc_param;

_defendGroupCount = _defendGroupRange call lkr_fnc_getNumberBetween;
_patrolGroupCount = _patrolGroupRange call lkr_fnc_getNumberBetween;


for "_i" from 1 to _defendGroupCount do {
	// spawn 8 to 12 units, tasked with defending the _defendPos up to a radius of 100 meters
	[_spawnPos, [6,10], ["defend", _defendPos, 100]] call lkr_fnc_spawnEnemyGroup;
	sleep 5 + (random 5);
};

for "_i" from 1 to _patrolGroupCount do {
	// spawn 3 to 5 units, tasked with patrolling the _defendPos up to a radius of 200 meters
	[_spawnPos, [4,6], ["patrol", _defendPos, 200]] call lkr_fnc_spawnEnemyGroup;
	sleep 10 + (random 5);
	// randomly also spawn a vehicle patroling the defend pos
	if(random 1 < 0.5) then {
		[_spawnPos, ["patrol", _defendPos, 500]] call lkr_fnc_spawnEnemyCar;
        sleep 10 + (random 5);
	};
    if(random 1 < 0.15) then {
		[_spawnPos, ["patrol", _defendPos, 500]] call lkr_fnc_spawnEnemyArmor;
        sleep 10 + (random 5);
	};
};
