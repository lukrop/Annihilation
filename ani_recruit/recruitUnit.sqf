/*
	Author: lukrop
	Date: 10/2/2013
  Description: Spawns a unit and adds it to the group of the leader as
  long the group is not too big.
	
	Parameters:
        NUMBER: type of the unit
        OBJECT: unit of group in which the new units joins
	
	Returns: -
  
*/

_unitType = _this select 0;
_leader = _this select 1;

if (_leader != leader (group _leader)) then {hint "You are not the squad leader."}
else {
  if(count (units (group _leader)) < ani_maxRecruitUnits) then {
  
  switch (_unitType) do {
    case 0: {
      ani_recruit_ARClass createUnit [(getMarkerPos "recruit_spawn"), group _leader];
    };
    case 1: {
      ani_recruit_MGClass createUnit [(getMarkerPos "recruit_spawn"), group _leader];
    };
    case 2: {
      ani_recruit_ATClass createUnit [(getMarkerPos "recruit_spawn"), group _leader];
    };
    case 3: {
      ani_recruit_LATClass createUnit [(getMarkerPos "recruit_spawn"), group _leader];
    };
    case 4: {
      ani_recruit_MedicClass createUnit [(getMarkerPos "recruit_spawn"), group _leader];
    };
    case 5: {
      ani_recruit_PilotClass createUnit [(getMarkerPos "recruit_spawn"), group _leader];
    };
    case 6: {
      ani_recruit_EngineerClass createUnit [(getMarkerPos "recruit_spawn"), group _leader];
    };
  };

  } else {
  hint format ["You may only have %1 units in your group (including players)", ani_maxRecruitUnits];
  };
};