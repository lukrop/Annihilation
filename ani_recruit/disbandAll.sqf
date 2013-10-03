/*
	Author: lukrop
	Date: 10/1/2013
  Description: Removes all AI units from the group.
	
	Parameters: 
        OBJECT: unit of the group
	
	Returns: -
  
*/

_leader = _this select 0;
if (_leader != leader (group _leader)) then {hint "You are not the squad leader."}
else {
  {
    if(!isPlayer _x) then {_x setDamage 1; hideBody _x};
  } forEach units group _leader;
};