/*
	Author: lukrop
	Date: 10/6/2013
  Description: Rescues a unit held hostage by joining the group of the player/person that
  activated the action.

	Parameters:
        OBJECT: hostage
        OBJECT: unit that called the action
        NUMBER: action id

	Returns: -

*/

_hostage = _this select 0;
_caller = _this select 1;
_id = _this select 2;

//[_hostage] call ani_removeAllActionsMP;
[[_hostage], "ani_removeAllActionsMP", nil, true] spawn BIS_fnc_MP;

[_hostage] join (group _caller);
_hostage setCaptive false;
_hostage enableAI "FSM";
_hostage enableAI "TARGET";
_hostage enableAI "AUTOTARGET";
_hostage enableAI "MOVE";
_hostage forceSpeed -1;