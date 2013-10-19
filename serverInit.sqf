/*
	Author: lukrop
	Date: 10/1/2013
  Description: Server init. ONLY executed on the server. Starts the mission manager and
  spawns some random patrols.

	Parameters: -

	Returns: -

*/

if(!isServer) exitWith{};
private ["_teamBox", "_infzone1", "_infzone2"];

// mcc_sandbox bug workaround
// [[0,0,0], "STATE:", ["time > 15", "setDate [2035,10,6,ani_daytime,0];", ""]] call CBA_fnc_createTrigger;

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


if(ani_ammoboxes == 0) then {
  deleteVehicle ani_ammoBox;
  deleteVehicle ani_supportBox;
  deleteVehicle ani_supplyBox;
  deleteVehicle ani_explosivesBox;
  deleteVehicle ani_grenadesBox;
  deleteVehicle ani_launchersBox;
  deleteVehicle ani_baseWeps;
  deleteVehicle ani_specWeps;
};
ani_addonammoboxes = 1;
if(ani_addonAmmoBoxes == 1) then {
  createVehicle ["R3F_WeaponBox", getMarkerPos "wepbox1", [], 0, "NONE"];
  createVehicle ["RHARD_Mk18_Ammobox", getMarkerPos "wepbox2", [], 0, "NONE"];
  createVehicle ["FHQ_M4_Ammobox", getMarkerPos "wepbox3", [], 0, "NONE"];
  createVehicle ["FHQ_ACC_Ammobox", getMarkerPos "wepbox4", [], 0, "NONE"];
  createVehicle ["Box_mas_us_rifle_Wps_F", getMarkerPos "wepbox5", [], 0, "NONE"];
  createVehicle ["Box_mas_rus_GRU_Wps_F", getMarkerPos "wepbox6", [], 0, "NONE"];
  createVehicle ["Box_mas_afr_o_Wps_F", getMarkerPos "wepbox7", [], 0, "NONE"];
};

if(ani_acre == 1) then {
  // give all squad leaders a long range radio
  _leaders = [];

  if(not isNil "p1") then {_leaders = _leaders + [p1]};
  if(not isNil "p2") then {_leaders = _leaders + [p2]};
  if(not isNil "p3") then {_leaders = _leaders + [p3]};
  if(not isNil "p4") then {_leaders = _leaders + [p4]};
  if(not isNil "p5") then {_leaders = _leaders + [p5]};
  if(not isNil "p6") then {_leaders = _leaders + [p6]};
  if(not isNil "p7") then {_leaders = _leaders + [p7]};

  {
    _x addItem "ACRE_PRC148";
  } forEach _leaders;
};

switch(ani_suppression) do {
  case 1: {
    //tpwcas_isHc = false;
    tpwcas_st = 5;
    tpwcas_reveal = 1;
    tpwcas_debug = 0;
    tpwcas_minskill = 0.1;
    tpwcas_playershake = 0;
    tpwcas_playervis = 0;

    if(ani_tpwlos == 1) then {
      tpwcas_los_enable = 1;
    } else {
      tpwcas_los_enable = 0;
    };

    [3] execVM "tpwcas\tpwcas_script_init.sqf";
  };
  case 2: {
     // bullet threshold , delay to start, debug, max dist, player sup, ai sup, ai seek cover
    [5,1,0,700,0,1,1] execVM "scripts\tpw_ebs.sqf";
  };
};

// init SLP (Spawning)
SLP_init = [] execVM "SLP\SLP_init.sqf";
// compile SHK_pos
SHK_pos = compile preprocessFile "SLP\scripts\SHK_pos.sqf";

waituntil {scriptdone SLP_init};
[] execVM "ambientPatrols.sqf";
[] execVM "missionManager.sqf";
