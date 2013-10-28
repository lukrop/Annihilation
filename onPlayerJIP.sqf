/*
	Author: lukrop
	Date: 10/17/2013
  Description: executed on the server everytime a new player joins

	Parameters: -

	Returns: -

*/
if(!isServer) exitWith {};

waitUntil {sleep 1; not isNil "ani_currentMission"};

// set marker colors of completed missions accordingly to their states
{
	_marker = _x select 0;
	_state = _x select 1;

  if(_state == "SUCCESS") then {
  	[_marker, 0.3, "ColorGreen"] call ani_changeMarker;
  };

  if(_state == "FAILED") then {
  	[_marker, 0.3, "ColorYellow"] call ani_changeMarker;
  };

} forEach ani_completedMissions;

[ani_currentMission select 0, 1, "ColorRed"] call ani_changeMarker;

// adjust markers for outposts
{
  if(not (missionNamespace getVariable (format ["ani_%1_active", _x]))) then {
    [_x, 1, "ColorBLUFOR", "hd_flag", "Cleared"] call ani_changeMarker;
  };
} forEach ani_enemyOPMarkers;
