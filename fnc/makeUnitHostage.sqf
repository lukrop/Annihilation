/*
	Author: lukrop
	Date: 10/6/2013
  Description: Makes unit a hostage. Attaches action to rescue unit.
	
	Parameters:
        OBJECT: object/unit to make held hostage 
        	
	Returns: -
  
*/
_unit = _this select 0;

_unit setCaptive true;
removeAllWeapons _unit;
_unit disableAI "FSM";
_unit disableAI "TARGET";
_unit disableAI "AUTOTARGET";
_unit disableAI "MOVE";
_unit setUnitPos "UP";
_unit forceSpeed 0;
// this animation name is madness.. unit has hands behind head
_unit switchMove "amovpercmstpsnonwnondnon_amovpercmstpssurwnondnon";

[_unit, localize "STR_ANI_RESCUE", "fnc\rescueHostage.sqf"] call ani_addActionMP;