/*
	Author: lukrop
	Date: 10/1/2013
  Description: Adds a AN/PRC-152 Radio to the caller.
	
	Parameters:
        OBJECT: object with the action 
        OBJECT: object that called the action
	
	Returns: -
  
*/

_unit = _this select 1;
_unit unassignItem "ItemRadio";
_unit removeItem "ItemRadio";

_unit unassignItem "ACRE_PRC148";
_unit removeItem "ACRE_PRC148";

_unit unassignItem "ACRE_PRC343";
_unit removeItem "ACRE_PRC343";

_unit unassignItem "ACRE_PRC152";
_unit removeItem "ACRE_PRC152";

_unit addItem "ACRE_PRC152";

//_unit removeWeapon "ACRE_PRC152";
//_unit addWeapon "ACRE_PRC152";
