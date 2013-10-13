/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission init. Sets parameters and calls player and server inits.
	
	Parameters: -
	
	Returns: -
  
*/

// disable saving
enableSaving [false, false];

if(isNil "paramsArray") then{
  paramsArray = [
  6,  // Daytime
  0,  // enemy faction
  0,  // enemy count
  0,  // Enemy skill
  1,  // recruiting enabled
  8,  // recruiting max group size
  1,  // revive enabled
  10, // revive lifes
  1, // mobile respawn
  1, // mobile respawn vas
  60, // vec respawn delay
  1800, // vec deserted delay
  120, // chopper respawn delay
  1800, // chopper deserted delay
  1,  // ammoboxes
  0,  // tpwcas
  0,  // tpwlos
  0   // acre
  ];
};
_i = 0;
ani_daytime = paramsArray select _i; _i = _i + 1;
ani_enemyFaction = paramsArray select _i; _i = _i + 1; // see factions.txt for details
ani_enemyCount = paramsArray select _i; _i = _i + 1;
ani_enemySkill = paramsArray select _i; _i = _i + 1;
ani_recruit = paramsArray select _i; _i = _i + 1;
ani_maxRecruitUnits = paramsArray select _i; _i = _i + 1;
ani_revive = paramsArray select _i; _i = _i + 1;
ani_reviveLifes = paramsArray select _i; _i = _i + 1;
ani_mobileRespawn = paramsArray select _i; _i = _i + 1;
ani_mobileRespawnVAS = paramsArray select _i; _i = _i + 1;
ani_vec_respawnDelay = paramsArray select _i; _i = _i + 1;
ani_vec_desertedDelay = paramsArray select _i; _i = _i + 1;
ani_chopper_respawnDelay = paramsArray select _i; _i = _i + 1;
ani_chopper_desertedDelay = paramsArray select _i; _i = _i + 1;
ani_ammoBoxes = paramsArray select _i; _i = _i + 1;
ani_suppression = paramsArray select _i; _i = _i + 1;
ani_tpwlos = paramsArray select _i; _i = _i + 1;
ani_acre = paramsArray select _i; _i = _i + 1;


switch (ani_enemyCount) do {
  case 0: {
    // inf format [[min groups, max groups], [min units per group, max units per group]]
    // it's also possible to set a fixed amount of groups or units. [1,2] would be 1 group with 2 units
    
    // vec format [[min groups, max groups], [min vecs per group, max vecs per group], fill cargo space?]
    // alternative vec format [[min groups, max groups], fixed vecs per group, fill cargo space?]
    ani_enemyInfPatrolCount = [[1,3],[3,4]];
    ani_enemyInfDefendCount = [1,[4,6]]; // 1 group with 4 to 6 units
    ani_enemyVecPatrolCount = [[0,2],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfReinfCount = [1,[6,10]];
    ani_enemyReinforcments = [1,2]; // amount of reinforcments (with diffrent positions) - [0,0] disables 3 is the maximum 
  };
  case 1: {
    ani_enemyInfPatrolCount = [[2,4],[3,4]];
    ani_enemyInfDefendCount = [1,[6,8]];
    ani_enemyVecPatrolCount = [[1,2],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfReinfCount = [1,[6,10]];
    ani_enemyReinforcments = [2,3]; // amount of reinforcments (with diffrent positions) - [0,0] disables 3 is the maximum
  };
  case 2: {
    ani_enemyInfPatrolCount = [[3,5],[3,4]];
    ani_enemyInfDefendCount = [[1,2],[6,8]];
    ani_enemyVecPatrolCount = [[1,3],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfReinfCount = [1,[6,10]];
    ani_enemyReinforcments = [2,3]; // amount of reinforcments (with diffrent positions) - [0,0] disables 3 is the maximum
  };
  case 3: {
    ani_enemyInfPatrolCount = [[4,6],[3,4]];
    ani_enemyInfDefendCount = [[2,3],[6,8]];
    ani_enemyVecPatrolCount = [[2,4],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfReinfCount = [2,[6,10]];
    ani_enemyReinforcments = [1,3]; // amount of reinforcments (with diffrent positions) - [0,0] disables 3 is the maximum
  };
};

switch (ani_enemySkill) do {
case 0: {
    ani_skill_inf = [0.2,0.35];
    ani_skill_vec = [0.25,0.4];
    ani_skill_air = [0.3,0.45];
  };
case 1: {
    ani_skill_inf = [0.3,0.45];
    ani_skill_vec = [0.35,0.5];
    ani_skill_air = [0.4,0.55];
  };
case 2: {
    ani_skill_inf = [0.4,0.55];
    ani_skill_vec = [0.45,0.6];
    ani_skill_air = [0.5,0.65];
  };
case 3: {
    ani_skill_inf = [0.6,0.85];
    ani_skill_vec = [0.65,0.9];
    ani_skill_air = [0.7,0.95];
  };
};

if(ani_recruit == 1) then {
  // add recruiting action
  ani_recruit_vec addAction ["<t color='#11ffff'>Recruit units</t>", "ani_recruit\openDialog.sqf"];
} else {
  deleteVehicle ani_recruit_vec;
  "recruitment" setMarkerAlpha 0;
};

switch(ani_suppression) do {
  case 1: {
    tpwcas_mode = 3;
    tpwcas_isHc = false;
    tpwcas_st = 5;
    tpwcas_reveal = 2.5;
    tpwcas_debug = 0;
    
    if(ani_tpwlos == 1) then {
      tpwcas_los_enable = 1;
    };

    [] execVM "tpwcas\tpwcas_init.sqf";
  };
  case 2: {
     // bullet threshold , delay to start, debug, max dist, player sup, ai sup, ai seek cover
    [5,1,0,700,0,1,1] execVM "scripts\tpw_ebs.sqf";
  };
};

if(ani_acre == 1) then {
  ani_box addAction ["<t color='#11ff11'>Take AN/PRC-152</t>", "fnc\addPRC152.sqf"];
  ani_box addAction ["<t color='#11ff11'>Take AN/PRC-148</t>", "fnc\addPRC148.sqf"];
};

// Viewdistance script
[] execVM "taw_vd\init.sqf";

if(ani_revive == 1) then {
  // init revive
  call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";
  if(ani_reviveLifes == 0) then {
    BTC_active_lifes = 0;
  } else {
    BTC_lifes = ani_reviveLifes;
  };
  BTC_active_mobile = ani_mobileRespawn;
  if(ani_mobileRespawn == 1) then {
    MHQ addAction["<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf"];
  };
} else {
  // set respawn time to 15 instead of 1 ### seems to be not working! dunno what to do for now...
  // setPlayerRespawnTime 15;
};

// init SLP (Spawning)
SLP_init = [] execvm "SLP\SLP_init.sqf";
// compile SHK_pos
SHK_pos = compile preprocessFile "SLP\scripts\SHK_pos.sqf";
// compile ani functions
call compile preprocessFile "fnc\compile.sqf";

#include "config.sqf"

[] execVM "serverInit.sqf";
[] execVM "playerInit.sqf";

