/*
	Author: lukrop
	Date: 10/17/2013
  Description: executed on the server everytime a new player joins

	Parameters: -

	Returns: -

*/
waitUntil {sleep 0.1; not isNil "ani_currentMission"};

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
