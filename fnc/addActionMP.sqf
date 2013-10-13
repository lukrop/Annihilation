/*
	Author: lukrop
	Date: 10/6/2013
  Description: Adds an action entry with BIS_fnc_MP
	
	Parameters:
        OBJECT: object to attacht the action to
        STRING: text wich is shown in the action menu
        STRING: path to the script which is called on activation
	
	Returns: -
  
*/

private["_object","_actionName","_scriptToCall"];
_object = _this select 0;
_actionName = _this select 1;
_scriptToCall = _this select 2;

if(isNull _object) exitWith {};

_object addaction [_actionName,_scriptToCall];
