/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission manager. Responsible for choosing
  the area and the mission and calls the respective mission script.

	Parameters: -

	Returns: -

*/

ani_citys = [
["city0", "city0_vecSpawn", [ "city0_reinf0",  "city0_reinf1",  "city0_reinf2",  "city0_reinf3"], ["city0_spawn0", "city0_spawn1", "city0_spawn2", "city0_spawn3"] ],
["city1", "city1_vecSpawn", [ "city1_reinf0",  "city1_reinf1",  "city1_reinf2",  "city1_reinf3"], ["city1_spawn0", "city1_spawn1", "city1_spawn2", "city1_spawn3"] ],
["city2", "city2_vecSpawn", [ "city2_reinf0",  "city2_reinf1",  "city2_reinf2",  "city2_reinf3"], ["city2_spawn0", "city2_spawn1", "city2_spawn2", "city2_spawn3"] ],
["city3", "city3_vecSpawn", [ "city3_reinf0",  "city3_reinf1",  "city3_reinf2",  "city3_reinf3"], ["city3_spawn0", "city3_spawn1", "city3_spawn2", "city3_spawn3"] ],
["city4", "city4_vecSpawn", [ "city4_reinf0",  "city4_reinf1",  "city4_reinf2",  "city4_reinf3"], ["city4_spawn0", "city4_spawn1", "city4_spawn2", "city4_spawn3"] ],
["city5", "city5_vecSpawn", [ "city5_reinf0",  "city5_reinf1",  "city5_reinf2",  "city5_reinf3"], ["city5_spawn0", "city5_spawn1", "city5_spawn2", "city5_spawn3"] ],
["city6", "city6_vecSpawn", [ "city6_reinf0",  "city6_reinf1",  "city6_reinf2",  "city6_reinf3"], ["city6_spawn0", "city6_spawn1", "city6_spawn2", "city6_spawn3"] ],
["city7", "city7_vecSpawn", [ "city7_reinf0",  "city7_reinf1",  "city7_reinf2",  "city7_reinf3"], ["city7_spawn0", "city7_spawn1", "city7_spawn2", "city7_spawn3"] ]
];

// TODO add another (4th) reinf pos per land mission
ani_lands = [
["land0", [ "city3_reinf1", "city1_vecSpawn", "reinf_spawn0"]],
["land1", [ "city0_reinf1", "city3_reinf0", "reinf_spawn1"]],
["land2", [ "city3_reinf2", "city4_reinf0", "city2_spawn3"]],
["land3", [ "city3_reinf3", "city0_reinf0", "reinf_spawn2"]],
["land4", [ "city1_reinf2", "city4_reinf3", "city4_reinf2"]],
["land5", [ "city3_reinf2", "city3_reinf3", "reinf_spawn2"]],
["land6", [ "city1_reinf3", "city1_vecSpawn", "reinf_spawn0"]],
["land7", [ "city3_reinf0", "city3_spawn1", "city2_reinf3"]],
["land8", [ "city3_spawn0", "reinf_spawn3", "city0_spawn1"]],
["land9", [ "city2_spawn1", "city2_reinf3", "city2_spawn2"]],
["land10", [ "city6_reinf0", "reinf_spawn4", "reinf_spawn5"]],
["land11", [ "city6_reinf1", "city6_reinf2", "city5_reinf3"]],
["land12", [ "reinf_spawn6", "reinf_spawn7", "city5_reinf3"]]
];

ani_completedMissions = [];

private ["_missionStyle", "_posArray", "_missionType"];

//ani_landMissiontype = ["uav", "mortar", "chopper", "fueltrucks"];
//ani_cityMissiontype = ["cache", "killhvt", "hostage", "capturehvt"];

ani_landMissiontype = ["uav", "mortar"];
ani_cityMissiontype = ["cache", "killhvt", "killhvtstatic", "rescuepilot"];

ani_missionState = "";

waitUntil{time > 15};
//waitUntil{daytime > (ani_daytime + 0.001)};

while {(count ani_landMissiontype > 0) or (count ani_cityMissiontype > 0)} do {
  sleep ani_timeBetweenMissions;
  ani_missionState = "IN_PROGRESS";

  // check if one of the mission type arrays is empty
  if((count ani_landMissiontype == 0) or (count ani_cityMissiontype == 0)) then {
    // choose a mission from the non empty array
    if(count ani_cityMissiontype == 0) then {
    _missionStyle = 1}
    else {
    _missionStyle = 0
    };
  // if both still have enough missions just choose a random type
  } else {
    // 0 = city 1 = land
    _missionStyle = round random 1;
  };

  // marker and positions (AO)
  switch (_missionStyle) do {
  // city mission
  case 0: {
      // select a random entry (positions)
      _index = round (random ((count ani_citys) - 1));
      _posArray = ani_citys select _index;
      // choose random mission
      _missionType = ani_cityMissiontype call BIS_fnc_selectRandom;
      // remove place and mission from possible future missions
      ani_citys set [_index, -1];
      ani_citys = ani_citys - [-1];
      //ani_citys = ani_citys - [_posArray];
      ani_cityMissiontype = ani_cityMissiontype - [_missionType];
    };
  // land mission
  case 1: {
      _index = round (random ((count ani_lands) - 1));
      _posArray = ani_lands select _index;
      _missionType = ani_landMissiontype call BIS_fnc_selectRandom;
      ani_lands set [_index, -1];
      ani_lands = ani_lands - [-1];
      //ani_lands = ani_lands - [_posArray];
      ani_landMissiontype = ani_landMissiontype - [_missionType];
    };
  };

  // ##### DEBUG/TESTING #####
/*
  _missionStyle = 0;
  _missionType = "rescuepilot";
  _posArray = ani_citys call BIS_fnc_selectRandom;
  hint format ["%1 | %2", _missionType, _posArray select 0];
*/
  // ##### DEBUG/TESTING #####

  diag_log format ["### ANI: Starting mission %1 at %2 ###", _missionType, (_posArray select 0)];
  ani_currentMission = [_posArray select 0, _missionType];
  [_posArray, _missionStyle] execVM format ["missions\%1.sqf", _missionType];

  // wait until mission is finished
  waitUntil{sleep 1; ani_missionState != "IN_PROGRESS"};
  diag_log format ["### ANI: Finished mission %1 at %2 ###", _missionType, (_posArray select 0)];
  _completed_missionState = ani_missionState;
  ani_completedMissions = ani_completedMissions + [[_posArray select 0, _completed_missionState]];
};