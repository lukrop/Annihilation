/*
	Author: lukrop
	Date: 10/4/2013
  Description: Spawns enemies with SLP
	
	Parameters:
        NUMBER: mission style. 0=city, 1=land
        STRING: marker name wich defines ao center
        ARRAY: reinforcement positions
        OBJECT (OPTIONAL): object to defend (e.g. cache, hvt or the uav)
	Returns: -
  
*/

private ["_marker", "_reinfCount", "_reinfMarkers", "_reinfSpawn", "_missionStyle", "_defendObject", "_radiusDefend", "_radiusPatrol"];

_missionStyle = _this select 0;
_marker = _this select 1;
_reinfMarkers = _this select 2;
if(count _this > 3) then {_defendObject = _this select 3} else {_defendObject = _marker};

if(_missionStyle == 0) then {
  _radiusPatrol = 100;
  _radiusDefend = 60;
} else {
  _radiusPatrol = 250;
  _radiusDefend = 120;
};
// SPAWN ENEMIES
// patrolling squads
[_marker,[ani_enemySide,ani_enemyFaction,20],[_marker, 100],ani_enemyInfPatrolCount,ani_enemyVecPatrolCount,[],[],["patrol_gc", _radiusPatrol]] spawn SLP_spawn;
sleep 5 + (random 5);
// defending squads
[_marker,[ani_enemySide,ani_enemyFaction,20],[_defendObject, 10],ani_enemyInfDefendCount,ani_enemyVecDefendCount,[],[],["defend_gc", _radiusDefend]] spawn SLP_spawn;

_rmin = ani_enemyReinforcments select 0;
_rmax = ani_enemyReinforcments select 1;
_reinfCount = _rmin max (round (random _rmax));
// REINFORCEMENTS
while {_reinfCount > 0} do {
  sleep 5 + (random 2);
  _reinfCount = _reinfCount - 1;
  // choose reinf position and remove from possible next positions
  _reinfSpawn = _reinfMarkers call BIS_fnc_selectRandom;
  _reinfMarkers = _reinfMarkers - [_reinfSpawn];
  
  [_marker,[ani_enemySide,ani_enemyFaction,20],[_reinfSpawn, 20],ani_enemyInfReinfCount,[],[],[],["reinforcement_o_gc", _defendObject]] spawn SLP_spawn;
};