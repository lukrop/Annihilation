/*
	Author: lukrop
	Date: 10/1/2013
  Description: Player init. Only executed on clients (or/and the _listen_ server).
  NOT executed on a dedicated server.
	
	Parameters: -
	
	Returns: -
  
*/

if(isServer and isDedicated) exitWith{};

/*
_gearbox1 = "Box_mas_usd_NATO_equip_F" createVehicleLocal getMarkerPos "gearbox1";
_gearbox2 = "Box_mas_usn_NATO_equip_F" createVehicleLocal getMarkerPos "gearbox2";
_gearbox3 = "Box_mas_usr_NATO_equip_F" createVehicleLocal getMarkerPos "gearbox3";
_wepbox8 = "Box_mas_afr_o_Wps_F" createVehicleLocal getMarkerPos "wepbox8";
_wepbox9 = "Box_mas_rus_GRU_Wps_F" createVehicleLocal getMarkerPos "wepbox9";

_supply = "B_supplyCrate_F" createVehicleLocal getMarkerPos "supply";
_support = "Box_NATO_Support_F" createVehicleLocal getMarkerPos "support";

_wepbox1 = "Box_NATO_Wps_F" createVehicleLocal getMarkerPos "wepbox1";
_wepbox2 = "Box_NATO_WpsSpecial_F" createVehicleLocal getMarkerPos "wepbox2";
_wepbox3 = "FHQ_M4_Ammobox" createVehicleLocal getMarkerPos "wepbox3";
_wepbox4 = "RHARD_Mk18_Ammobox" createVehicleLocal getMarkerPos "wepbox4";
_wepbox5 = "Box_mas_us_rifle_Wps_F" createVehicleLocal getMarkerPos "wepbox5";
_wepbox6 = "R3F_WeaponBox" createVehicleLocal getMarkerPos "wepbox6";
_wepbox7 = "FHQ_ACC_Ammobox" createVehicleLocal getMarkerPos "wepbox7";

_launchers = "Box_NATO_WpsLaunch_F" createVehicleLocal getMarkerPos "launchers";
_grenades = "Box_NATO_Grenades_F" createVehicleLocal getMarkerPos "grenades";
_explosives = "Box_NATO_AmmoOrd_F" createVehicleLocal getMarkerPos "explosives";

{_x setDir 45} forEach [_wepbox1, _wepbox2, _wepbox3, _wepbox4, _wepbox5, _wepbox6, _wepbox7, _launchers, _grenades, _explosives];
{_x setDir 130} forEach [_gearbox1, _gearbox2, _gearbox3, _supply, _support, _wepbox8, _wepbox9];
*/
