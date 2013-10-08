/*
	Author: lukrop
	Date: 10/8/2013
  Description: Spawns random patrols in the ambient_patrolx markers.
	
	Parameters: -
	
	Returns: -
  
*/

["ambient_patrol1",[ani_enemySide,ani_enemyFaction,10],["ambient_patrol1", 1800],[[0,1],[3,5]],[[0,1],1,false],[],[],["patrol", 1800]] spawn SLP_spawn;
sleep 3;
["ambient_patrol2",[ani_enemySide,ani_enemyFaction,10],["ambient_patrol2", 1800],[[0,1],[3,5]],[[0,1],1,false],[],[],["patrol", 1800]] spawn SLP_spawn;
sleep 3;
["ambient_patrol3",[ani_enemySide,ani_enemyFaction,10],["ambient_patrol3", 1800],[[0,1],[3,5]],[[0,1],1,false],[],[],["patrol", 1800]] spawn SLP_spawn;
sleep 3;
["ambient_patrol4",[ani_enemySide,ani_enemyFaction,10],["ambient_patrol4", 1800],[[0,1],[3,5]],[[0,1],1,false],[],[],["patrol", 1800]] spawn SLP_spawn;