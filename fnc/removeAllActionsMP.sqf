/*
	Author: lukrop
	Date: 10/6/2013
  Description: Removes all actions from object via BIS_fnc_MP

	Parameters:
        OBJECT: object to attacht the action to

	Returns: -

*/

private["_object"];
_object = _this select 0;

if(isNull _object) exitWith {};

_object removeAllActions 0;
