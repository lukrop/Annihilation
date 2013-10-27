/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission manager. Responsible for choosing
  the area and the mission and calls the respective mission script.

	Parameters: -

	Returns: -

*/
if(!isServer) exitWith {};

ani_citys = [
["city0", "city0_vecSpawn", [ "city0_scout0",  "city0_scout1",  "city0_scout2",  "city0_scout3"], ["city0_spawn0", "city0_spawn1", "city0_spawn2", "city0_spawn3"] ],
["city1", "city1_vecSpawn", [ "city1_scout0",  "city1_scout1",  "city1_scout2",  "city1_scout3"], ["city1_spawn0", "city1_spawn1", "city1_spawn2", "city1_spawn3"] ],
["city2", "city2_vecSpawn", [ "city2_scout0",  "city2_scout1",  "city2_scout2",  "city2_scout3"], ["city2_spawn0", "city2_spawn1", "city2_spawn2", "city2_spawn3"] ],
["city3", "city3_vecSpawn", [ "city3_scout0",  "city3_scout1",  "city3_scout2",  "city3_scout3"], ["city3_spawn0", "city3_spawn1", "city3_spawn2", "city3_spawn3"] ],
["city4", "city4_vecSpawn", [ "city4_scout0",  "city4_scout1",  "city4_scout2",  "city4_scout3"], ["city4_spawn0", "city4_spawn1", "city4_spawn2", "city4_spawn3"] ],
["city5", "city5_vecSpawn", [ "city5_scout0",  "city5_scout1",  "city5_scout2",  "city5_scout3"], ["city5_spawn0", "city5_spawn1", "city5_spawn2", "city5_spawn3"] ],
["city6", "city6_vecSpawn", [ "city6_scout0",  "city6_scout1",  "city6_scout2",  "city6_scout3"], ["city6_spawn0", "city6_spawn1", "city6_spawn2", "city6_spawn3"] ],
["city7", "city7_vecSpawn", [ "city7_scout0",  "city7_scout1",  "city7_scout2",  "city7_scout3"], ["city7_spawn0", "city7_spawn1", "city7_spawn2", "city7_spawn3"] ],
["city8", "city8_vecSpawn", [ "city8_scout0",  "city8_scout1",  "city8_scout2",  "city8_scout3"], ["city8_spawn0", "city8_spawn1", "city8_spawn2", "city8_spawn3"] ]
];

ani_lands = [
["land0", [ "land0_scout", "land0_scout_1", "land0_scout_2", "land0_scout_3"]],
["land1", [ "land1_scout", "land1_scout_1", "land1_scout_2", "land1_scout_3"]],
["land2", [ "land2_scout", "land2_scout_1", "land2_scout_2", "land2_scout_3"]],
["land3", [ "land3_scout", "land3_scout_1", "land3_scout_2", "land3_scout_3"]],
["land4", [ "land4_scout", "land4_scout_1", "land4_scout_2", "land4_scout_3"]],
["land5", [ "land5_scout", "land5_scout_1", "land5_scout_2", "land5_scout_3"]],
["land6", [ "land6_scout", "land6_scout_1", "land6_scout_2", "land6_scout_3"]],
["land7", [ "land7_scout", "land7_scout_1", "land7_scout_2", "land7_scout_3"]],
["land8", [ "land8_scout", "land8_scout_1", "land8_scout_2", "land8_scout_3"]],
["land9", [ "land9_scout", "land9_scout_1", "land9_scout_2", "land9_scout_3"]],
["land10", [ "land10_scout", "land10_scout_1", "land10_scout_2", "land10_scout_3"]],
["land11", [ "land11_scout", "land11_scout_1", "land11_scout_2", "land11_scout_3"]],
["land12", [ "land12_scout", "land12_scout_1", "land12_scout_2", "land12_scout_3"]],
["land13", [ "land13_scout", "land13_scout_1", "land13_scout_2", "land13_scout_3"]],
["land14", [ "land14_scout", "land14_scout_1", "land14_scout_2", "land14_scout_3"]],
["land15", [ "land15_scout", "land15_scout_1", "land15_scout_2", "land15_scout_3"]]
];

ani_completedMissions = [];

private ["_missionStyle", "_posArray", "_missionType"];

//ani_landMissiontype = ["uav", "mortar", "chopper", "fueltrucks"];
//ani_cityMissiontype = ["cache", "killhvt", "hostage", "capturehvt"];

//ani_landMissiontype = ["uav", "mortar"];
//ani_cityMissiontype = ["cache", "killhvt", "killhvtstatic", "rescuepilot"];1

ani_missions = ["uav", "mortar", "cache", "killhvt", "killhvtstatic", "rescuepilot"];

ani_missionState = "";

waitUntil{sleep 0.1; time > 0};

while {count ani_missions > 0} do {
  sleep ani_timeBetweenMissions;
  ani_missionState = "IN_PROGRESS";

  // select random mission and remove it from future missions
  _missionType = ani_missions call BIS_fnc_selectRandom;
  ani_missions = ani_missions - [_missionType];

  switch(_missionType) do {
    case "cache": {
      _posArray = [0] call ani_getMissionLocation;
    };
    case "killhvt": {
      _posArray = [0] call ani_getMissionLocation;
    };
    case "killhvtstatic": {
      _posArray = [0] call ani_getMissionLocation;
    };
    case "rescuepilot": {
      _posArray = [0] call ani_getMissionLocation;
    };
    case "mortar": {
      _posArray = [1] call ani_getMissionLocation;
    };
    case "uav": {
      _posArray = [1] call ani_getMissionLocation;
    };
  };

  // ##### DEBUG/TESTING #####
/*
  _missionStyle = 1;
  _missionType = "mortar";
  hint format ["%1 | %2", _missionType, _posArray select 0];
*/
  // ##### DEBUG/TESTING #####

  ani_currentMission = [_posArray select 0, _missionType];
  diag_log format ["### ANI: Starting mission %1 at %2 ###", _missionType, (_posArray select 0)];

  [_posArray, _missionStyle] execVM format ["missions\%1.sqf", _missionType];

  // wait until mission is finished
  waitUntil{sleep 1; ani_missionState != "IN_PROGRESS"};
  diag_log format ["### ANI: Finished mission %1 at %2 ###", _missionType, (_posArray select 0)];
  // add to array of finished mission for JIP marker adjustments
  _completed_missionState = ani_missionState;
  ani_completedMissions = ani_completedMissions + [[_posArray select 0, _completed_missionState]];
};