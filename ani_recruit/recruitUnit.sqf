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

private ["_unit"];

if (_leader != leader (group _leader)) then {hint "You are not the squad leader."}
else {
  if(count (units (group _leader)) < ani_maxRecruitUnits) then {

  switch (_unitType) do {
    case 0: {
      _unit = (group _leader) createUnit [ani_recruit_ARClass, (getMarkerPos "ani_recruit_spawn"),[] , 0, "FORM"];
    };
    case 1: {
      _unit = (group _leader) createUnit [ani_recruit_MGClass, (getMarkerPos "ani_recruit_spawn"),[] , 0, "FORM"];
    };
    case 2: {
      _unit = (group _leader) createUnit [ani_recruit_ATClass, (getMarkerPos "ani_recruit_spawn"),[] , 0, "FORM"];
    };
    case 3: {
      _unit = (group _leader) createUnit [ani_recruit_LATClass, (getMarkerPos "ani_recruit_spawn"),[] , 0, "FORM"];
    };
    case 4: {
      _unit = (group _leader) createUnit [ani_recruit_MedicClass, (getMarkerPos "ani_recruit_spawn"),[] , 0, "FORM"];
    };
    case 5: {
      _unit = (group _leader) createUnit [ani_recruit_PilotClass, (getMarkerPos "ani_recruit_spawn"),[] , 0, "FORM"];
    };
    case 6: {
      _unit = (group _leader) createUnit [ani_recruit_EngineerClass, (getMarkerPos "ani_recruit_spawn"),[] , 0, "FORM"];
    };
  };

  {_unit removeWeapon _x} forEach ["Binocular", "Laserdesignator", "Rangefinder"];

  _unit setSkill ["aimingAccuracy", 0.7];
  _unit setSkill ["aimingShake", 0.8];
  _unit setSkill ["aimingSpeed", 1];
  _unit setSkill ["endurance", 1];
  _unit setSkill ["spotDistance", 0.7];
  _unit setSkill ["spotTime", 0.8];
  _unit setSkill ["courage", 1];
  _unit setSkill ["reloadSpeed", 1];
  _unit setSkill ["commanding", 1];
  _unit setSkill ["general", 1];

  _unit setVariable ["cacheObject", false, true];

  } else {
  hint format ["You may only have %1 units in your group (including players)", ani_maxRecruitUnits];
  };
};