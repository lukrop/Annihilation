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

if(lkr_hc_present && isMultiplayer) then {
    lkr_hc_id = owner hc1;
    publicVariable "lkr_hc_id";
};

if(param_caching == 1) then {
	// caching/decaching after 1500m
	f_param_caching = 1800;
	f_var_debugMode = 0;
	// start unit caching after 15 seconds
	[10, 15] execVM "f\cache\fn_cInit.sqf";
};

[lkr_arsenal_box, [
"ACE_packingBandage", "ACE_morphine", "ACE_epinephrine", "ACE_fieldDressing", "ACE_IR_Strobe_Item",
"ACE_CableTie", "ACE_Altimeter", "ACE_atropine", "ACE_bloodIV", "ACE_bloodIV_250",
"ACE_bloodIV_500", "ACE_bodyBag", "ACE_Clacker", "ACE_DefusalKit", "ACE_EarPlugs",
"ACE_elasticBandage", "ACE_Kestrel", "ACE_acc_pointer_red", "ACE_M26_Clacker", "ACE_MapTools",
"ACE_microDAGR", "ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500",
"ACE_quikclot", "ACE_salineIV", "ACE_salineIV_250", "ACE_salineIV_500", "ACE_SpareBarrel",
"ACE_surgicalKit", "ACE_tourniquet", "ACE_Vector", "ACE_wirecutter", "optic_Aco",
"optic_ACO_grn", "optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_Arco",
"ACE_optic_Arco_2D", "ACE_optic_Arco_PIP", "ACE_optic_DMS", "ACE_optic_Hamr_2D", "ACE_optic_Hamr_PIP",
"ACE_optic_LRPS_2D", "ACE_optic_LRPS_PIP", "ACE_optic_MRCO_2D", "ACE_optic_MRCO_PIP",
"ACE_optic_SOS_2D", "ACE_optic_SOS_PIP", "", "",
"optic_DMS", "optic_Hamr", "optic_Holosight", "optic_KHS_blk",
"optic_KHS_tan", "optic_LRPS", "optic_MRCO", "optic_MRD", "",
"rhsusf_acc_ACOG", "rhsusf_acc_ACOG2", "rhsusf_acc_ACOG2_USMC", "rhsusf_acc_ACOG3",
"rhsusf_acc_ACOG3_USMC", "rhsusf_acc_ACOG_pip", "rhsusf_acc_ACOG_USMC", "rhsusf_acc_anpeq15",
"rhsusf_acc_anpeq15_light", "rhsusf_acc_anpeq15A", "rhsusf_acc_anpeq15side", "rhsusf_acc_compm4",
"rhsusf_acc_ELCAN", "rhsusf_acc_ELCAN_pip", "rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_LEUPOLDMK4",
"rhsusf_acc_LEUPOLDMK4_2", "rhsusf_acc_M2010S", "rhsusf_acc_muzzleFlash_SF", "rhsusf_acc_rotex5_grey", "rhsusf_acc_rotex5_tan",
"rhsusf_acc_SF3P556", "rhsusf_acc_SFMB556", "rhsusf_acc_SR25S", "rhsusf_ach_bare_wood", "rhsusf_ach_bare_wood_ess", "ToolKit",
"DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag", "muzzle_snds_acp", "ACRE_PRC148", "ACRE_PRC343"
], true] call BIS_fnc_addVirtualItemCargo;

[lkr_arsenal_box, ["rhsusf_assault_eagleaiii_coy"], true] call BIS_fnc_addVirtualBackpackCargo;

[lkr_arsenal_box, ["hgun_ACPC2_F", "hgun_P07_F", "hgun_Pistol_heavy_01_F"], true] call BIS_fnc_addVirtualWeaponCargo;

[lkr_arsenal_box, ["9Rnd_45ACP_Mag", "16Rnd_9x21_Mag", "11Rnd_45ACP_Mag"], true] call BIS_fnc_addVirtualMagazineCargo;

if(param_enemy_ambient_patrols == 1) then {
    objNull spawn lkr_fnc_spawnAmbientPatrols;
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
/*
if(param_enemy_ambient_patrols == 1) then {
    if(lkr_hc_present && isMultiplayer) then {
        [objNull, "lkr_fnc_spawnAmbientPatrols", lkr_hc_id, false, false] call BIS_fnc_MP;
    } else {
        objNull spawn lkr_fnc_spawnAmbientPatrols;
    };
}
*/
