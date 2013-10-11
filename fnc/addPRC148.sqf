/*
	Author: lukrop
	Date: 10/1/2013
  Description: Adds a AN/PRC-148 to the caller.
	
	Parameters:
        OBJECT: object with the action 
        OBJECT: object that called the action
	
	Returns: -
  
*/

_unit = _this select 1;

// just in case we already have a long range radio
_unit unassignItem "ACRE_PRC148";
_unit removeItem "ACRE_PRC148";
_unit removeWeapon "ACRE_PRC148";

_unit unassignItem "ACRE_PRC152";
_unit removeItem "ACRE_PRC152";
_unit removeWeapon "ACRE_PRC152";

// add the 148
_unit addItem "ACRE_PRC148";
