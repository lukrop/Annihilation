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
ani_ammoBoxes = paramsArray select _i; _i = _i + 1;
ani_suppression = paramsArray select _i; _i = _i + 1;
ani_tpwlos = paramsArray select _i; _i = _i + 1;
ani_acre = paramsArray select _i; _i = _i + 1;

switch (ani_enemyCount) {
  
};

switch (ani_enemySkill) do {
case 0: {
    ani_skill_inf = [0.2,0.35];
  };
case 1: {
    ani_skill_inf = [0.3,0.45];
  };
case 2: {
    ani_skill_inf = [0.4,0.55];
  };
case 3: {
    ani_skill_inf = [0.6,0.85];
  };
};

if(ani_recruit == 1) then {
  // add recruiting action
  ani_recruit_flag addAction ["<t color='#11ffff'>Recruit units</t>", "ani_recruit\openDialog.sqf"];
} else {
  deleteVehicle ani_recruit_flag;
  "recruit" setMarkerAlpha 0;
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
  ani_box addAction ["<t color='#11ff11'>Take AN/PRC152</t>", "scripts\addPRC152.sqf"];
};

// Viewdistance script
[] execVM "taw_vd\init.sqf";

if(ani_revive == 1) then {
  // init revive
  call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";
  BTC_lifes = ani_reviveLifes;
} else {
  // set respawn time to 15 instead of 1 ### seems to be not working! dunno what to do for now...
  // setPlayerRespawnTime 15;
};

// init SLP (Spawning)
SLP_init = [] execvm "SLP\SLP_init.sqf";
// init SHK_pos
SHK_pos = compile preprocessFile "SLP\scripts\SHK_pos.sqf";

#include "config.sqf"

[] execVM "serverInit.sqf";
[] execVM "playerInit.sqf";

