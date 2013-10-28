/*
	Author: lukrop
	Date: 10/8/2013
  Description: Spawns random patrols in the ambient_patrolx markers.

	Parameters: -

	Returns: -

*/

if(!isServer) exitWith {};

waitUntil {sleep 0.1; time > 5};

["ambient_patrol",
[ani_enemySide, ani_enemyFaction, 30],
[["ambient_patrol", "ambient_patrol_1", "ambient_patrol_2", "ambient_patrol_3", "ambient_patrol_4"]],
ani_enemyAmbientInfCount,
ani_enemyAmbientVecCount,
[],
[],
["patrol", 1500]] call SLP_spawn;
