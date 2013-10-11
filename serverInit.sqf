/*
	Author: lukrop
	Date: 10/1/2013
  Description: Server init. ONLY executed on the server. Starts the mission manager and
  spawns some random patrols.
	
	Parameters: -
	
	Returns: -
  
*/

if(!isServer) exitWith{};
private ["_teamBox", "_infzone1", "_infzone2"];

// set Date/Time
setDate [2035,10,6,ani_daytime,0];
// mcc_sandbox bug workaround
[[0,0,0], "STATE:", ["time > 15", "setDate [2035,10,6,ani_daytime,0];", ""]] call CBA_fnc_createTrigger;

if(ani_ammoboxes == 1) then {
  _gearbox1 = "Box_mas_usd_NATO_equip_F" createVehicle getMarkerPos "gearbox1";
  _gearbox2 = "Box_mas_usn_NATO_equip_F" createVehicle getMarkerPos "gearbox2";
  _gearbox3 = "Box_mas_usr_NATO_equip_F" createVehicle getMarkerPos "gearbox3";
  _wepbox8 = "Box_mas_afr_o_Wps_F" createVehicle getMarkerPos "wepbox8";
  _wepbox9 = "Box_mas_rus_GRU_Wps_F" createVehicle getMarkerPos "wepbox9";

  _supply = "B_supplyCrate_F" createVehicle getMarkerPos "supply";
  _support = "Box_NATO_Support_F" createVehicle getMarkerPos "support";

  _wepbox1 = "Box_NATO_Wps_F" createVehicle getMarkerPos "wepbox1";
  _wepbox2 = "Box_NATO_WpsSpecial_F" createVehicle getMarkerPos "wepbox2";
  _wepbox3 = "FHQ_M4_Ammobox" createVehicle getMarkerPos "wepbox3";
  _wepbox4 = "RHARD_Mk18_Ammobox" createVehicle getMarkerPos "wepbox4";
  _wepbox5 = "Box_mas_us_rifle_Wps_F" createVehicle getMarkerPos "wepbox5";
  _wepbox6 = "R3F_WeaponBox" createVehicle getMarkerPos "wepbox6";
  _wepbox7 = "FHQ_ACC_Ammobox" createVehicle getMarkerPos "wepbox7";

  _launchers = "Box_NATO_WpsLaunch_F" createVehicle getMarkerPos "launchers";
  _grenades = "Box_NATO_Grenades_F" createVehicle getMarkerPos "grenades";
  _explosives = "Box_NATO_AmmoOrd_F" createVehicle getMarkerPos "explosives";

  {_x setDir 325} forEach [_wepbox1, _wepbox2, _wepbox3, _wepbox4, _wepbox5, _wepbox6, _wepbox7, _launchers, _grenades, _explosives];
  {_x setDir 325} forEach [_gearbox1, _gearbox2, _gearbox3, _supply, _support, _wepbox8, _wepbox9];

  /*
  _teamBox = "Box_NATO_Ammo_F" createVehicle getMarkerPos "teamBox";
  clearWeaponCargo _teamBox;
  clearMagazineCargo _teamBox;
  */
};

if(ani_acre == 1) then {
  // give all squad leaders a long range radio
  _leaders = [];
  
  if(not isNil "p1") then {_leaders = _leaders + [p1]};
  if(not isNil "p2") then {_leaders = _leaders + [p2]};
  if(not isNil "p3") then {_leaders = _leaders + [p3]};
  if(not isNil "p4") then {_leaders = _leaders + [p4]};
  if(not isNil "p5") then {_leaders = _leaders + [p5]};
  if(not isNil "p6") then {_leaders = _leaders + [p6]};
  if(not isNil "p7") then {_leaders = _leaders + [p7]};
  
  {
    _x addItem "ACRE_PRC148";
  } forEach _leaders;
};

waituntil {scriptdone SLP_init};
[] execVM "ambientPatrols.sqf";
[] execVM "missionManager.sqf";
