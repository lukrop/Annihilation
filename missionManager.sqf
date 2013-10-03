/*
	Author: lukrop
	Date: 10/1/2013
  Description: Mission manager. Responsible for choosing
  the area and the mission and calls the respective mission script.
	
	Parameters: -
	
	Returns: -
  
*/

private ["_landMissionType", "_cityMissionType", "_missionStyle", "_posArray", "_missionType", "_missionState"];

//_landMissionType = ["uav", "mortar", "chopper", "fueltrucks"];
//_cityMissionType = ["cache", "killhvt", "hostage", "capturehvt"];

_landMissionType = ["uav", "mortar"];
_cityMissionType = ["cache", "killhvt", "killhvtstatic"];

ani_missionState = "";

waitUntil{time > 15};
//waitUntil{daytime > (ani_daytime + 0.001)};

while {(count _landMissionType > 0) or (count _cityMissionType > 0)} do {
  sleep ani_timeBetweenMissions;
  ani_missionState = "IN_PROGRESS";
  
  // check if one of the mission type arrays is empty
  if((count _landMissionType == 0) or (count _cityMissionType == 0)) then {
    // choose a mission from the non empty array
    if(count _cityMissiontype == 0) then {
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
      _posArray = ani_citys call BIS_fnc_selectRandom;
      // choose random mission
      _missionType = _cityMissionType call BIS_fnc_selectRandom;
      // remove place and mission from possible future missions
      ani_citys = ani_citys - [_posArray];
      _cityMissionType = _cityMissiontype - [_missionType];
    };
  // land mission
  case 1: {
      _posArray = ani_lands call BIS_fnc_selectRandom;
      _missionType = _landMissionType call BIS_fnc_selectRandom;
      ani_lands = ani_lands - [_posArray];
      _landMissionType = _landMissiontype - [_missionType];
    };
  };

  // ##### DEBUG/TESTING #####
  /*
  _missionStyle = 0;
  _missionType = "killhvtstatic";
  _posArray = _citys call BIS_fnc_selectRandom;
  hint format ["%1 | %2", _missionType, _posArray select 0];
  */
  // ##### DEBUG/TESTING #####
  
  diag_log format ["### ANI: Starting mission %1 at %2 ###", _missionType, (_posArray select 0)];
  [_posArray, _missionType] execVM format ["missions\%1.sqf", _missionType];
  
  // wait until mission is finished
  waitUntil{sleep 1; ani_missionState != "IN_PROGRESS"};
  diag_log format ["### ANI: Finished mission %1 at %2 ###", _missionType, (_posArray select 0)];
};