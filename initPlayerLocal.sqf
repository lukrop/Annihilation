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
/*
if(param_max_recruit_ai > 0) then {
	ani_maxRecruitUnits = param_max_recruit_ai;
	lkr_flag addAction ["<t color='#11ffff'>Recruit units</t>", "ani_recruit\openDialog.sqf"];
};
*/
if(param_max_recruit_ai > 0) then {
    [] execVM "bon_recruit_units\init.sqf";
    lkr_flag addAction["<t color='#ff9900'>Recruit Infantry</t>", "bon_recruit_units\open_dialog.sqf"];
};

/*
if(param_vvs == 1) then {
	lkr_vvs_ground addAction["<t color='#11ff11'>Wheeled Victors</t>", VVS_fnc_openVVS, ["lkr_vvs_ground_spawn","Car"]];
	lkr_vvs_ground addAction["<t color='#11ff11'>Armored Victors</t>", VVS_fnc_openVVS, ["lkr_vvs_ground_spawn","Armored"]];
	lkr_vvs_air addAction["<t color='#11ff11'>Air Victors</t>", VVS_fnc_openVVS, ["lkr_vvs_air_spawn","Air"]];
};
*/

if(not isNil "p1") then {
    if(player == p1) then {
        [lkr_arsenal_box, ["rhs_weap_m4_m320", "rhs_weap_m4a1_m320"], false] call BIS_fnc_addVirtualWeaponCargo;
    };
};
if(not isNil "p2") then {
    if(player == p2) then {
        [lkr_arsenal_box, ["rhs_weap_m4_m320", "rhs_weap_m4a1_m320"], false] call BIS_fnc_addVirtualWeaponCargo;
    };
};
if(not isNil "p3") then {
    if(player == p3) then {
        [lkr_arsenal_box, ["rhs_weap_m4_m320", "rhs_weap_m4a1_m320"], false] call BIS_fnc_addVirtualWeaponCargo;
    };
};
if(not isNil "p7") then {
    if(player == p7) then {
        [lkr_arsenal_box, ["rhs_weap_m4_m320", "rhs_weap_m4a1_m320"], false] call BIS_fnc_addVirtualWeaponCargo;
    };
};
if(not isNil "p4") then {
    if(player == p4) then {
        [lkr_arsenal_box, ["arifle_MXM_Black_F", "srifle_DMR_06_olive_F"], false] call BIS_fnc_addVirtualWeaponCargo;
    };
};

waitUntil{!isNil "lkr_request_mission"};
/*
if(isNil "lkr_request_mission") then {
    lkr_request_mission = false;
};*/

if(!lkr_request_mission) then {
    lkr_sat_phone addAction ["<t color='#ff0000'>Request mission</t>", {lkr_request_mission = true; publicVariable "lkr_request_mission"; removeAllActions lkr_sat_phone;}];
};

"lkr_request_mission" addPublicVariableEventHandler {
    if (!(_this select 1)) then {
        lkr_sat_phone addAction ["<t color='#ff0000'>Request mission</t>", {lkr_request_mission = true; publicVariable "lkr_request_mission"; removeAllActions lkr_sat_phone;}];
    } else {
        removeAllActions lkr_sat_phone;
    };
};

