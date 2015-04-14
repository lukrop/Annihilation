/*
	Author: lukrop
	Date: 10/8/2013
  Description: Spawns random patrols in the ambient_patrolx markers.

	Parameters: -

	Returns: -

*/

if(!isServer) exitWith {};

waitUntil {sleep 0.5; time > 20};

{
	if((random 1) < 0.6) then {
		[getMarkerPos _x, [3,5], ["patrol", getMarkerPos _x, 1000]] call lkr_fnc_spawnEnemyGroup;
	};

	if((random 1) < 0.5) then {
		[getMarkerPos _x, ["patrol", getMarkerPos _x, 1000]] call lkr_fnc_spawnEnemyCar;
	};
	sleep 15;
} forEach ["ambient_patrol", "ambient_patrol_1", "ambient_patrol_2", "ambient_patrol_3", "ambient_patrol_4"];
