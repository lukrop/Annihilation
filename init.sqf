/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission init. Sets parameters and calls player and server inits.

	Parameters: -

	Returns: -

*/

startLoadingScreen ["Loading..."];

// disable saving
enableSaving [false, false];

progressLoadingScreen 0.1;

// read paramters
if(isNil "paramsArray") then{
  paramsArray = [
  6,  // Daytime
  30,  // overcast
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
  0,   // acre
  1  // jip markers
  ];
};
_i = 0;
ani_daytime = paramsArray select _i; _i = _i + 1;
ani_overcast = paramsArray select _i; _i = _i + 1;
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
ani_addonAmmoBoxes = paramsArray select _i; _i = _i + 1;
ani_suppression = paramsArray select _i; _i = _i + 1;
ani_tpwlos = paramsArray select _i; _i = _i + 1;
ani_acre = paramsArray select _i; _i = _i + 1;
ani_jip_markers = paramsArray select _i; _i = _i + 1;

// set Date/Time
setDate [2035,10,6,ani_daytime,0];

// set overcast
skipTime -24;
86400 setOvercast (ani_overcast / 100);
skipTime 24;

if(ani_overcast >= 60) then {
  60 setRain (ani_overcast / 100);
}

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
};

if(ani_revive == 2) then {
  call compileFinal preprocessFileLineNumbers "FAR_revive\FAR_revive_init.sqf";
};

// compile ani functions
call compile preprocessFileLineNumbers "fnc\compile.sqf";

progressLoadingScreen 0.8;

#include "config.sqf"

[] execVM "serverInit.sqf";
[] execVM "clientInit.sqf";

if(ani_jip_markers == 1) then {
  [[[], "onPlayerJIP.sqf"], "BIS_fnc_execVM", false, true] spawn BIS_fnc_MP;
};

endLoadingScreen;
