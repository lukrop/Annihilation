/*
	File: config.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Class names and configuration

	Parameter(s):
	-

	Returns:
	-
*/
// wait until all parameters are set
waitUntil {!isNil "params_set"};

// Mobile respawn vehicle class
lkr_mhq_vehicle_C = "B_MRAP_01_F";
// uav class
lkr_uav_C = "B_UAV_02_F";
// chopper class
lkr_chopper_C = "B_Heli_Transport_01_F";
// pilot class
lkr_pilot_C = "B_helipilot_F";

// define enemy side and create center
lkr_enemy_side = east;
lkr_enemy_center = createCenter east;
lkr_friendly_side = west;

// define enemy units classes
switch(param_enemy_faction) do {
	// CSAT
	case 0: {
		lkr_enemy_inf_leaders_C = ["O_Soldier_TL_F","O_officer_F","O_Soldier_SL_F","O_recon_TL_F"];
		lkr_enemy_inf_units_C = ["O_Soldier_lite_F","O_Soldier_GL_F","O_Soldier_AR_F",
		"O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F", "O_soldier_exp_F","O_spotter_F","O_sniper_F",
		"O_Soldier_A_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_recon_F","O_recon_M_F","O_recon_LAT_F",
		"O_recon_medic_F","O_recon_exp_F","O_recon_JTAC_F", "O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AAA_F"];
		lkr_enemy_vecs_C = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_APC_Wheeled_02_rcws_F"];

		lkr_hvt_C = "O_officer_F";
		lkr_hvt_guard_C = "O_Soldier_lite_F";
        
        // mortar class
        lkr_mortarClass = "O_Mortar_01_F";
        // mortar Gun
        lkr_mortarGunnerClass = "O_Soldier_lite_F";
	};
	// AAF
	case 1: {
		lkr_enemy_inf_leaders_C = ["I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F"];
		lkr_enemy_inf_units_C = ["I_soldier_F","I_Soldier_lite_F","I_Soldier_A_F",
        "I_Soldier_GL_F","I_Soldier_M_F","I_Soldier_LAT_F", "I_Soldier_AT_F","I_Soldier_AA_F","I_medic_F",
        "I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F","I_helicrew_F","I_officer_F","I_Spotter_F",
        "I_Sniper_F","I_Soldier_AAR_F","I_Soldier_AAT_F","I_Soldier_AAA_F"];
        lkr_enemy_vecs_C = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];

		lkr_hvt_C = "I_officer_F";
		lkr_hvt_guard_C = "I_Soldier_F";
        // mortar class
        lkr_mortarClass = "I_Mortar_01_F";
        // mortar Gun
        lkr_mortarGunnerClass = "I_Soldier_F";
	};
	// LOP Afghan militia
	case 2: {
		// enemy infantry group leaders
		lkr_enemy_inf_leaders_C = ["LOP_AM_Soldier_SL", "LOP_AM_Soldier_TL"];
		// repeat akm dudes to increase their saturation
		lkr_enemy_inf_units_C = ["LOP_AM_Soldier", "LOP_AM_Soldier_Medic", "LOP_AM_Soldier_GL", "LOP_AM_Soldier_AR",
			"LOP_AM_Soldier_AT", "LOP_AM_Soldier_Marksman", "LOP_AM_Soldier_Engineer", "LOP_AM_Soldier_AT", "LOP_AM_Soldier",
			"LOP_AM_Soldier_AR", "LOP_AM_Soldier", "LOP_AM_Soldier_AT", "LOP_AM_Soldier_AR"];
		// enemy vehicles
		lkr_enemy_vecs_C = ["LOP_AM_Technical_M2", "LOP_AM_Landrover_M2"];

		lkr_hvt_C = "LOP_AM_Soldier_SL";
		lkr_hvt_guard_C = "LOP_AM_Soldier";
        // mortar class
        lkr_mortarClass = " rhs_weap_2p130 ";
        // mortar Gun
        lkr_mortarGunnerClass = "LOP_AM_Soldier";
	};
	// LOP ChDKZ
	case 3: {
		// enemy infantry group leaders
		lkr_enemy_inf_leaders_C = ["LOP_ChDKZ_Soldier_SL", "LOP_ChDKZ_Soldier_TL"];
		// repeat akm dudes to increase their saturation
		lkr_enemy_inf_units_C = ["LOP_ChDKZ_Soldier", "LOP_ChDKZ_Soldier_Medic", "LOP_ChDKZ_Soldier_GL", "LOP_ChDKZ_Soldier_AR",
			"LOP_ChDKZ_Soldier_AT", "LOP_ChDKZ_Soldier_Marksman", "LOP_ChDKZ_Soldier_Engineer", "LOP_ChDKZ_Soldier_AT", "LOP_ChDKZ_Soldier",
			"LOP_ChDKZ_Soldier_AR", "LOP_ChDKZ_Soldier", "LOP_ChDKZ_Soldier_AT", "LOP_ChDKZ_Soldier_AR"];
		// enemy vehicles
		lkr_enemy_vecs_C = ["LOP_ChDKZ_BTR60", "LOP_ChDKZ_M113"];

		lkr_hvt_C = "LOP_ChDKZ_Soldier_SL";
		lkr_hvt_guard_C = "LOP_ChDKZ_Soldier";
        // mortar class
        lkr_mortarClass = " rhs_weap_2p130 ";
        // mortar Gun
        lkr_mortarGunnerClass = "LOP_ChDKZ_Soldier";
	};
	// LOP african
	case 4: {
		// enemy infantry group leaders
		lkr_enemy_inf_leaders_C = ["LOP_AFR_Soldier_SL", "LOP_AFR_Soldier_TL"];
		// repeat akm dudes to increase their saturation
		lkr_enemy_inf_units_C = ["LOP_AFR_Soldier", "LOP_AFR_Soldier_Medic", "LOP_AFR_Soldier_GL", "LOP_AFR_Soldier_AR",
			"LOP_AFR_Soldier_AT", "LOP_AFR_Soldier_Marksman", "LOP_AFR_Soldier_Engineer", "LOP_AFR_Soldier_AT", "LOP_AFR_Soldier",
			"LOP_AFR_Soldier_AR", "LOP_AFR_Soldier", "LOP_AFR_Soldier_AT", "LOP_AFR_Soldier_AR"];
		// enemy vehicles
		lkr_enemy_vecs_C = ["LOP_AFR_Technical_M2", "LOP_AFR_Landrover_M2", "LOP_AFR_M113"];

		lkr_hvt_C = "LOP_AFR_Soldier_SL";
		lkr_hvt_guard_C = "LOP_AFR_Soldier";
        // mortar class
        lkr_mortarClass = " rhs_weap_2p130 ";
        // mortar Gun
        lkr_mortarGunnerClass = "LOP_AFR_Soldier";
	};
    // RHS MSV
	case 5: {
		// enemy infantry group leaders
		lkr_enemy_inf_leaders_C = ["rhs_msv_junior_sergeant", "rhs_msv_sergeant"];
		// repeat akm dudes to increase their saturation
		lkr_enemy_inf_units_C = ["rhs_msv_rifleman", "rhs_msv_grenadier", "rhs_msv_machinegunner", "rhs_msv_efreitor",
			"rhs_msv_machinegunner_assistant", "rhs_msv_at", "rhs_msv_strelok_rpg_assist", "rhs_msv_marksman", "",
			"rhs_msv_engineer", "rhs_msv_aa", "rhs_msv_medic", "rhs_msv_LAT"];
		// enemy vehicles
		lkr_enemy_vecs_C = ["rhs_btr70_msv", "rhs_bmp2_msv"];

		lkr_hvt_C = "rhs_msv_officer";
		lkr_hvt_guard_C = "rhs_msv_rifleman";
        // mortar class
        lkr_mortarClass = " rhs_weap_2p130 ";
        // mortar Gun
        lkr_mortarGunnerClass = "rhs_msv_rifleman";
	};
};

// set skill according to paramters
switch (param_enemy_skill) do {
	// low
	case 0: {
		lkr_enemy_skill_range = [0.2,0.4];
	  };
	// medium
	case 1: {
		lkr_enemy_skill_range = [0.4,0.6];
	  };
	// high
	case 2: {
		lkr_enemy_skill_range = [0.6,0.8];
	  };
	// very high
	case 3: {
		lkr_enemy_skill_range = [0.8,1];
	  };
};

lkr_city_markers = [
	["city0", ["city0_spawn0", "city0_spawn1", "city0_spawn2", "city0_spawn3"]],
	["city1", ["city1_spawn0", "city1_spawn1", "city1_spawn2", "city1_spawn3"]],
	["city2", ["city2_spawn0", "city2_spawn1", "city2_spawn2", "city2_spawn3"]],
	["city3", ["city3_spawn0", "city3_spawn1", "city3_spawn2", "city3_spawn3"]],
	["city4", ["city4_spawn0", "city4_spawn1", "city4_spawn2", "city4_spawn3"]],
	["city5", ["city5_spawn0", "city5_spawn1", "city5_spawn2", "city5_spawn3"]],
	["city6", ["city6_spawn0", "city6_spawn1", "city6_spawn2", "city6_spawn3"]],
	["city7", ["city7_spawn0", "city7_spawn1", "city7_spawn2", "city7_spawn3"]],
	["city8", ["city8_spawn0", "city8_spawn1", "city8_spawn2", "city8_spawn3"]],
	["city9", ["city9_spawn0", "city9_spawn1", "city9_spawn2", "city9_spawn3"]]
];

lkr_land_markers = [
	["land0", ["land0_scout", "land0_scout_1", "land0_scout_2", "land0_scout_3"]],
	["land1", ["land1_scout", "land1_scout_1", "land1_scout_2", "land1_scout_3"]],
	["land2", ["land2_scout", "land2_scout_1", "land2_scout_2", "land2_scout_3"]],
	["land3", ["land3_scout", "land3_scout_1", "land3_scout_2", "land3_scout_3"]],
	["land4", ["land4_scout", "land4_scout_1", "land4_scout_2", "land4_scout_3"]],
	["land5", ["land5_scout", "land5_scout_1", "land5_scout_2", "land5_scout_3"]],
	["land6", ["land6_scout", "land6_scout_1", "land6_scout_2", "land6_scout_3"]],
	["land7", ["land7_scout", "land7_scout_1", "land7_scout_2", "land7_scout_3"]],
	["land8", ["land8_scout", "land8_scout_1", "land8_scout_2", "land8_scout_3"]],
	["land9", ["land9_scout", "land9_scout_1", "land9_scout_2", "land9_scout_3"]],
	["land10", ["land10_scout", "land10_scout_1", "land10_scout_2", "land10_scout_3"]],
	["land11", ["land11_scout", "land11_scout_1", "land11_scout_2", "land11_scout_3"]],
	["land12", ["land12_scout", "land12_scout_1", "land12_scout_2", "land12_scout_3"]],
	["land13", ["land13_scout", "land13_scout_1", "land13_scout_2", "land13_scout_3"]],
	["land14", ["land14_scout", "land14_scout_1", "land14_scout_2", "land14_scout_3"]],
	["land15", ["land15_scout", "land15_scout_1", "land15_scout_2", "land15_scout_3"]]
];

//ani_maxRecruitUnits = 12;
ani_recruit_ARClass = "B_mas_mar_soldier_AR_F_d";
ani_recruit_MGClass = "B_mas_mar_soldier_MG_F_d";
ani_recruit_ATClass = "B_mas_mar_soldier_AT_F_d";
ani_recruit_LATClass = "B_mas_mar_soldier_LAT_F_d";
ani_recruit_MedicClass = "B_mas_mar_medic_F_d";
ani_recruit_PilotClass = "B_helipilot_F";
ani_recruit_EngineerClass = "B_mas_mar_soldier_repair_F_d";
