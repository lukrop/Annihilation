/*
	Author: lukrop
	Date: 10/4/2013
  Description: Spawns enemies with SLP

	Parameters:
        NUMBER: mission style. 0=city, 1=land
        STRING: marker name wich defines ao center
        ARRAY: scout positions
        OBJECT (OPTIONAL): object to defend (e.g. cache, hvt or the uav)
	Returns: -

*/

private ["_marker", "_scoutCount", "_scoutMarkers", "_scoutSpawn", "_missionStyle", "_defendObject", "_radiusDefend", "_radiusPatrol"];

_missionStyle = _this select 0;
_marker = _this select 1;
_scoutMarkers = _this select 2;
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
[_marker,[ani_enemySide, ani_enemyFaction, 20],[_marker, 100],ani_enemyInfPatrolCount,ani_enemyVecPatrolCount,[],[],["patrol_gc", _radiusPatrol]] call SLP_spawn;
sleep 5 + (random 5);
// defending squads
[_marker,[ani_enemySide, ani_enemyFaction, 20],[_defendObject, 10],ani_enemyInfDefendCount,ani_enemyVecDefendCount,[],[],["defend_gc", _radiusDefend]] call SLP_spawn;

_rmin = ani_enemyScouts select 0;
_rmax = ani_enemyScouts select 1;
_scoutCount = _rmin max (round (random _rmax));
// scouts
while {_scoutCount > 0} do {
  sleep 10 + (random 5);
  _scoutCount = _scoutCount - 1;
  // choose scout position and remove from possible next positions
  _scoutSpawn = _scoutMarkers call BIS_fnc_selectRandom;
  _scoutMarkers = _scoutMarkers - [_scoutSpawn];

  [_marker,[ani_enemySide,ani_enemyFaction],[_scoutSpawn, 20],ani_enemyInfscoutCount,[],[],[],["scout_gc", 100]] call SLP_spawn;
};