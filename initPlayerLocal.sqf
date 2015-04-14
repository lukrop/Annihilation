/*
	File: initPlayerLocal.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Executed locally when player joins mission (includes both mission start and JIP).

	Parameter(s):
	-

	Returns:
	-
*/

// wait until the config is loaded and the paramters are initialized
waitUntil {!isNil "lkr_config_loaded"};

// add recruit action to flag if recruiting is enabled
if(param_max_recruit_ai > 0) then {
	ani_maxRecruitUnits = param_max_recruit_ai;
	lkr_flag addAction ["<t color='#11ffff'>Recruit units</t>", "ani_recruit\openDialog.sqf"];
};
/*
if(param_vvs == 1) then {
	lkr_vvs_ground addAction["<t color='#11ff11'>Wheeled Victors</t>", VVS_fnc_openVVS, ["lkr_vvs_ground_spawn","Car"]];
	lkr_vvs_ground addAction["<t color='#11ff11'>Armored Victors</t>", VVS_fnc_openVVS, ["lkr_vvs_ground_spawn","Armored"]];
	lkr_vvs_air addAction["<t color='#11ff11'>Air Victors</t>", VVS_fnc_openVVS, ["lkr_vvs_air_spawn","Air"]];
};
*/
