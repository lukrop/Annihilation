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
setDate [2035,09,30,ani_daytime,0];
// mcc_sandbox bug workaround
[[0,0,0], "STATE:", ["time > 15", "setDate [2035,09,30,ani_daytime,0];", ""]] call CBA_fnc_createTrigger;


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

{_x setDir 45} forEach [_wepbox1, _wepbox2, _wepbox3, _wepbox4, _wepbox5, _wepbox6, _wepbox7, _launchers, _grenades, _explosives];
{_x setDir 130} forEach [_gearbox1, _gearbox2, _gearbox3, _supply, _support, _wepbox8, _wepbox9];

/*
_teamBox = "Box_NATO_Ammo_F" createVehicle getMarkerPos "teamBox";
clearWeaponCargo _teamBox;
clearMagazineCargo _teamBox;
*/

_infzone1 = round (random 1);
_infzone2 = round (random 1);

if((_infzone1 + _infzone2) < 1) then {
  if((random 1) > 0.5) then {_infzone1 = 1} else {_infzone2 = 1};
};

waituntil {scriptdone SLP_init};

["ambient_patrol1",[ani_enemySide,ani_enemyFaction,10],["ambient_patrol1", 1800],[_infzone1,[3,5]],[[0,1],1,false],[],[],["patrol", 1800]] spawn SLP_spawn;
sleep 5;
["ambient_patrol2",[ani_enemySide,ani_enemyFaction,10],["ambient_patrol2", 1800],[_infzone2,[3,5]],[[0,1],1,false],[],[],["patrol", 1800]] spawn SLP_spawn;

[] execVM "missionManager.sqf";
