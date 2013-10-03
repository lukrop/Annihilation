/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission init. Sets parameters and calls player and server inits.
	
	Parameters: -
	
	Returns: -
  
*/

if(isNil "paramsArray") then{
  paramsArray = [
  6,  // Daytime
  0,  // Enemy skill
  0,  // tpwcas
  0,  // tpwlos
  0,  // acre
  8,  // max group size (recruitable units)
  1,  // revive
  0   // enemy faction
  ];
};

ani_daytime = paramsArray select 0;
ani_enemy_skill = paramsArray select 1;
ani_suppression = paramsArray select 2;
ani_tpwlos = paramsArray select 3;
ani_acre = paramsArray select 4;
ani_maxRecruitUnits = paramsArray select 5;
ani_revive = paramsArray select 6;
// Enemy faction
// 0 = CSAT
// 1 = NATO
// 2 = INDFOR (AAF)
// 3 = Civilian
// 4 = GRU Russian by massi
// 5 = African Rebel Army by massi
// 6 = African Rebel civilians by massi
// 7 = USSOCOM DEVGRU by massi
ani_enemyFaction = paramsArray select 7;

switch (ani_enemy_skill) do {
case 0: {
    SLP_skill_inf = [0.2,0.35];
  };
case 1: {
    SLP_skill_inf = [0.3,0.45];
  };
case 2: {
    SLP_skill_inf = [0.4,0.55];
  };
case 3: {
    SLP_skill_inf = [0.6,0.85];
  };
};

if(ani_suppression == 1) then {
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
if(ani_suppression == 2) then {
  // bullet threshold , delay to start, debug, max dist, player sup, ai sup, ai seek cover
  [5,1,0,700,0,1,1] execVM "scripts\tpw_ebs.sqf";
};

if(ani_acre == 1) then {
  ani_box addAction ["<t color='#11ff11'>Take AN/PRC152</t>", "scripts\addPRC152.sqf"];
};

// disable saving
enableSaving [false, false];

// Viewdistance script
[] execVM "taw_vd\init.sqf";

if(ani_revive == 1) then {
// init revive
call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf";
};

// init SLP (Spawning)
SLP_init = [] execvm "SLP\SLP_init.sqf";
// init SHK_pos
SHK_pos = compile preprocessFile "SLP\scripts\SHK_pos.sqf";

#include "config.sqf"

[] execVM "serverInit.sqf";
[] execVM "playerInit.sqf";

