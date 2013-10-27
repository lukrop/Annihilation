/*
	Author: lukrop
	Date: 10/27/2013
  	Description: Populates enemy OPs

	Parameters: -

	Returns: -

*/

ani_enemyOPMarkers = ["enemy_op", "enemy_op_1", "enemy_op_2"];

{
	[_x,[ani_enemySide, ani_enemyFaction],[_x, 20],[[1,2],[3,4]],[],[],[],["patrol", 70]] call SLP_spawn;
	sleep 5 + (random 5);
	[_x,[ani_enemySide, ani_enemyFaction],[_x],[1,8],[],[],[],["defend", 50]] call SLP_spawn;
	sleep 10 + (random 5);
} forEach ani_enemyOPMarkers;
