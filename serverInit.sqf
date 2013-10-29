/*
	Author: lukrop
	Date: 10/1/2013
  Description: Server init. ONLY executed on the server. Starts the mission manager and
  spawns some random patrols.

	Parameters: -

	Returns: -

*/

if(!isServer) exitWith{};

// mcc_sandbox bug workaround
// [[0,0,0], "STATE:", ["time > 5", "setDate [2035,10,6,ani_daytime,0];", ""]] call CBA_fnc_createTrigger;

switch (ani_enemyCount) do {
  case 0: {
    // inf format [[min groups, max groups], [min units per group, max units per group]]
    // it's also possible to set a fixed amount of groups or units. [1,2] would be 1 group with 2 units

    // vec format [[min groups, max groups], [min vecs per group, max vecs per group], fill cargo space?]
    // alternative vec format [[min groups, max groups], fixed vecs per group, fill cargo space?]
    ani_enemyInfPatrolCount = [[2,3],[3,4]];
    ani_enemyInfDefendCount = [1,[5,8]]; // 1 group with 5 to 7 units
    ani_enemyVecPatrolCount = [[0,2],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfScoutCount = [1,[2,4]];
    ani_enemyScouts = [1,2]; // amount of scout groups (with diffrent positions) - [0,0] disables 4 is the maximum

    ani_enemyAmbientInfCount = [[3,4],[3,4]];
    ani_enemyAmbientVecCount = [2,1,false];

    ani_enemyInfReinfCount = [1,1]; // format [min groups, max groups]
    ani_enemyVecReinfCount = [1,1]; // format [min vecs, max vecs]
  };
  case 1: {
    ani_enemyInfPatrolCount = [[2,4],[3,4]];
    ani_enemyInfDefendCount = [2,[5,6]]; // 1 group with 5 to 7 units
    ani_enemyVecPatrolCount = [[1,3],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfScoutCount = [[1,2],[2,4]];
    ani_enemyScouts = [1,2];

    ani_enemyAmbientInfCount = [[3,4],[3,5]];
    ani_enemyAmbientVecCount = [[2,4],1,false];

    ani_enemyInfReinfCount = [1,2]; // format [min groups, max groups]
    ani_enemyVecReinfCount = [1,2]; // format [min vecs, max vecs]
  };
  case 2: {
    ani_enemyInfPatrolCount = [[3,5],[3,4]];
    ani_enemyInfDefendCount = [[2,3],[5,6]]; // 1 group with 5 to 7 units
    ani_enemyVecPatrolCount = [[2,3],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfScoutCount = [[1,2],[2,4]];
    ani_enemyScouts = [[2,3]];

    ani_enemyAmbientInfCount = [[4,6],[3,5]];
    ani_enemyAmbientVecCount = [[3,5],1,false];

    ani_enemyInfReinfCount = [1,3]; // format [min groups, max groups]
    ani_enemyVecReinfCount = [1,3]; // format [min vecs, max vecs]
  };
  case 3: {
    ani_enemyInfPatrolCount = [[4,6],[3,4]];
    ani_enemyInfDefendCount = [[3,4],[5,6]]; // 1 group with 5 to 7 units
    ani_enemyVecPatrolCount = [[3,4],1,false];
    ani_enemyVecDefendCount = [];
    ani_enemyInfScoutCount = [[1,2],[2,4]];
    ani_enemyScouts = [[2,4]];

    ani_enemyAmbientInfCount = [[4,6],[3,5]];
    ani_enemyAmbientVecCount = [[3,5],1,false];

    ani_enemyInfReinfCount = [2,3]; // format [min groups, max groups]
    ani_enemyVecReinfCount = [2,3]; // format [min vecs, max vecs]
  };
};

switch (ani_enemySkill) do {
case 0: {
    ani_skill_inf = [0.1,0.3];
    ani_skill_vec = [0.1,0.3];
    ani_skill_air = [0.2,0.4];
  };
case 1: {
    ani_skill_inf = [0.3,0.5];
    ani_skill_vec = [0.3,0.5];
    ani_skill_air = [0.4,0.6];
  };
case 2: {
    ani_skill_inf = [0.5,0.7];
    ani_skill_vec = [0.5,0.7];
    ani_skill_air = [0.6,0.8];
  };
case 3: {
    ani_skill_inf = [0.7,0.9];
    ani_skill_vec = [0.7,0.9];
    ani_skill_air = [0.8,1];
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
    tpwcas_mode = 2;
    if(isServer and isDedicated) then {tpwcas_mode = 3};

    if(ani_tpwlos == 1) then {
      tpwcas_los_enable = 1;
    } else {
      tpwcas_los_enable = 0;
    };

    [tpwcas_mode] execVM "tpwcas\tpwcas_script_init.sqf";
  };
  case 2: {
     // bullet threshold , delay to start, debug, max dist, player sup, ai sup, ai seek cover
    [5,1,0,700,0,1,1] execVM "scripts\tpw_ebs.sqf";
  };
};

{
  [_x, ani_vec_respawnDelay, ani_vec_desertedDelay] execFSM "fsm\ani_vehicleRespawn.fsm";
} forEach [ani_vec1, ani_vec2, ani_vec3, ani_vec4, ani_vec5, ani_vec6, ani_vec7, ani_vec8];

{
  [_x, ani_chopper_respawnDelay, ani_chopper_desertedDelay] execFSM "fsm\ani_vehicleRespawn.fsm";
} forEach [ani_helo1, ani_helo2, ani_helo3, ani_helo4, ani_helo5];

// init SLP (Spawning)
SLP_init = [] execVM "SLP\SLP_init.sqf";
// compile SHK_pos
SHK_pos = compile preprocessFile "SLP\scripts\SHK_pos.sqf";

waituntil {sleep 0.1; scriptdone SLP_init};

if(ani_enemyAmbientPatrols == 1) then {
  [] execVM "ambientPatrols.sqf";
  sleep 15;
};
[] execVM "enemyOP.sqf";
sleep 15;
[] execVM "missionManager.sqf";
