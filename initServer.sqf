/*
	File: initServer.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Executed only on server when mission is started.

	Parameter(s):
	-

	Returns:
	-
*/

// set the date
setDate [2014,4,2,param_daytime,0];

// wait until the config is loaded and the paramters are initialized
waitUntil {!isNil "lkr_config_loaded"};


if(param_caching == 1) then {
	// caching/decaching after 1500m
	f_param_caching = 1800;
	f_var_debugMode = 0;
	// start unit caching after 15 seconds
	[10, 15] execVM "f\cache\fn_cInit.sqf";
};

/*
if(param_tpwcas == 1) then {
	// bullet threshold more shots than this will cause unit to drop/crawl.
	tpwcas_st = 5;
	// reveal value when suppressed. 0 = reveal disabled. <1 = suppressed unit
	// knows nothing about shooter. 4 = unit knows the shooter's side, position, shoe size etc.
	tpwcas_reveal = 2.5;
	tpwcas_debug = 0;
	// minimum skill value, none of a unit's skills will drop below this under suppression.
	tpwcas_minskill = 0.15;
	tpwcas_playershake = 0;
	tpwcas_playervis = 0;
	tpwcas_mode = 2;
	if(isServer and isDedicated) then {
		tpwcas_mode = 3
	};
	// enable or disable tpwlos
	if(param_tpwlos == 1) then {
		tpwcas_los_enable = 1;
	} else {
		tpwcas_los_enable = 0;
	};
	// start tpwcas and tpwlos
	[tpwcas_mode] execVM "tpwcas\tpwcas_script_init.sqf";
};

// enable vehicle respawn for all prespawned vehicles
if(param_vec_respawn == 1) then {
	{
		["Vec respawn: %1, A: %2, D: %3", _x, param_vec_respawn_delay_abandoned, param_vec_respawn_delay_destroyed] call BIS_fnc_logFormat;
		[_x, param_vec_respawn_delay_abandoned, param_vec_respawn_delay_destroyed, {}] call lkr_fnc_ICE_vehRespawn;
	} forEach [lkr_veh_1, lkr_veh_2, lkr_veh_3, lkr_veh_4,
		lkr_veh_5, lkr_veh_6, lkr_veh_7, lkr_veh_8, lkr_veh_9,
		lkr_veh_10, lkr_veh_11, lkr_veh_12];
};
*/
if(param_enemy_ambient_patrols == 1) then {
	objNull spawn lkr_fnc_spawnAmbientPatrols;
}
