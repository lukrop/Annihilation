/*
  Author: lukrop
  Date: 10/2/2013
  Description: Configuration. Sets classnames used in the mission scripts.
  Defines enemy faction and side.

  Parameters: -

  Returns: -

*/

ani_timeBetweenMissions = 100;

// Enemy side
// east = 0
// west = 1
// resistance = 2
// civilian = 3 ## INOP! don't use
ani_enemySide = 0;
ani_friendlySide = 1; // better set this right..

// friendly faction
// 0 = CSAT
// 1 = NATO
// 2 = INDFOR (AAF)
// 3 = Civilian ## INOP! don't use
// 4 = GRU Russian by massi
// 5 = African Rebel Army by massi
// 6 = African Rebel civilians by massi
// 7 = USSCOM DEVGRU by massi
ani_friendlyFaction = 1;


switch (ani_enemyFaction) do {
case 0: {
    // CSAT
    ani_mortarClass = "O_Mortar_01_F";
    ani_mortarGunnerClass = "O_Soldier_F";
    ani_hvtClass = "O_officer_F";
    ani_hvtGuardClass = "O_Soldier_F";
    ani_cacheClass = "O_supplyCrate_F";

    ani_enemyTruckClass = "O_Truck_02_transport_F";

    ani_enemyLeaders = ["O_Soldier_TL_F","O_officer_F","O_Soldier_SL_F","O_recon_TL_F"];
    ani_enemyUnits = ["O_helipilot_F","O_crew_F","O_Soldier_F","O_Soldier_lite_F","O_Soldier_GL_F","O_Soldier_AR_F",
        "O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F", "O_soldier_exp_F","O_spotter_F","O_sniper_F",
        "O_Soldier_A_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_recon_F","O_recon_M_F","O_recon_LAT_F",
        "O_recon_medic_F","O_recon_exp_F","O_recon_JTAC_F", "O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AAA_F"];
    ani_enemyVehicles = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_APC_Wheeled_02_rcws_F"];

  };
case 1: {
    // NATO
    ani_mortarClass = "B_Mortar_01_F";
    ani_mortarGunnerClass = "B_Soldier_F";
    ani_hvtClass = "B_officer_F";
    ani_hvtGuardClass = "B_Soldier_F";
    ani_cacheClass = "B_supplyCrate_F";

    ani_enemyTruckClass = "B_Truck_01_transport_F";

    ani_enemyLeaders = ["B_officer_F","B_Soldier_TL_F","B_recon_TL_F","B_Soldier_SL_F"];
    ani_enemyUnits = ["B_Helipilot_F","B_crew_F","B_Soldier_F","B_Soldier_02_f","B_Soldier_03_f","B_Soldier_lite_F",
        "B_Soldier_GL_F","B_soldier_AR_F","B_soldier_M_F","B_soldier_LAT_F","B_medic_F","B_soldier_repair_F","B_soldier_exp_F",
        "B_spotter_F","B_sniper_F","B_RangeMaster_F","B_Soldier_A_F","B_soldier_AT_F","B_soldier_AA_F","B_engineer_F",
        "B_Competitor_F","B_recon_F","B_recon_LAT_F","B_recon_exp_F","B_recon_medic_F","B_recon_M_F","B_recon_JTAC_F",
        "B_soldier_AAR_F","B_soldier_AAT_F","B_soldier_AAA_F"];
    ani_enemyVehicles = ["B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F"];

  };
case 2: {
    // AAF
    ani_mortarClass = "I_Mortar_01_F";
    ani_mortarGunnerClass = "I_Soldier_F";
    ani_hvtClass = "I_officer_F";
    ani_hvtGuardClass = "I_Soldier_F";
    ani_cacheClass = "I_supplyCrate_F";

    ani_enemyTruckClass = "I_Truck_02_transport_F";

    ani_enemyLeaders = ["I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F"];
    ani_enemyUnits = ["I_helipilot_F","I_crew_F","I_Soldier_02_F","I_soldier_F","I_Soldier_lite_F","I_Soldier_A_F",
        "I_Soldier_GL_F","I_Soldier_M_F","I_Soldier_LAT_F", "I_Soldier_AT_F","I_Soldier_AA_F","I_medic_F",
        "I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F","I_helicrew_F","I_officer_F","I_Spotter_F",
        "I_Sniper_F","I_Soldier_AAR_F","I_Soldier_AAT_F","I_Soldier_AAA_F"];
    ani_enemyVehicles = ["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];
  };
case 4: {
    // russian GRU by massi
    ani_mortarClass = "O_mas_rus_Mortar_01_F";
    ani_mortarGunnerClass = "O_mas_rus_Soldier_F";
    ani_hvtClass = "O_mas_rus_Soldier_off_F_u";
    ani_hvtGuardClass = "O_mas_rus_Soldier_F";
    ani_cacheClass = "O_supplyCrate_F";

    ani_enemyTruckClass = "O_Truck_02_transport_F";

    ani_enemyLeaders = ["O_mas_rus_Soldier_TL_F_v", "O_mas_rus_Soldier_SL_F_v"];
    ani_enemyUnits = ["O_mas_rus_Helipilot_F","O_mas_rus_crew_F","O_mas_rus_Soldier_F_v","O_mas_rus_Soldier_R_F_v",
        "O_mas_rus_Soldier_GL_F_v", "O_mas_rus_Soldier_AR_F_v","O_mas_rus_Soldier_MGh_F_v", "O_mas_rus_soldier_AT_F_v"];
    ani_enemyVehicles = ["O_mas_rus_MRAP_02_hmg_F", "O_mas_rus_APC_Wheeled_02_rcws_F"];
  };
case 5: {
    // african rebel army by massi
    ani_mortarClass = "O_mas_afr_Mortar_01_F";
    ani_mortarGunnerClass = "O_mas_afr_Soldier_F";
    ani_hvtClass = "O_mas_afr_Soldier_off_F";
    ani_hvtGuardClass = "O_mas_afr_Soldier_F";
    ani_cacheClass = "O_supplyCrate_F";

    ani_enemyTruckClass = "O_Truck_02_transport_F";

    ani_enemyLeaders = ["O_mas_afr_Soldier_TL_F", "O_mas_afr_Soldier_SL_F"];
    ani_enemyUnits = ["O_mas_afr_Soldier_lite_F","O_mas_afr_Soldier_lite_F","O_mas_afr_Soldier_F", "O_mas_afr_Soldier_GL_F",
        "O_mas_afr_soldier_AR_F", "O_mas_afr_soldier_MG_F","O_mas_afr_soldier_M_F", "O_mas_afr_soldier_LAT_F", "O_mas_afr_medic_F",
        "O_mas_afr_soldier_repair_F", "O_mas_afr_soldier_exp_F"];
    ani_enemyVehicles = ["O_mas_afr_Offroad_01_armed_F", "O_mas_afr_Offroad_01s_armed_F", "O_mas_afr_Offroad_01c_armed_F"];
  };
case 6: {
    // african civilian rebels by massi
    ani_mortarClass = "O_mas_afr_Mortar_01_F";
    ani_mortarGunnerClass = "O_mas_afr_Rebel8a_F";
    ani_hvtClass = "O_mas_afr_Soldier_off_F";
    ani_hvtGuardClass = "O_mas_afr_Soldier_F";
    ani_cacheClass = "O_supplyCrate_F";

    ani_enemyTruckClass = "O_Truck_02_transport_F";

    ani_enemyLeaders = ["O_mas_afr_Rebel1_F"];
    ani_enemyUnits = ["O_mas_afr_Rebel1_F","O_mas_afr_Rebel1_F","O_mas_afr_Rebel1_F", "O_mas_afr_Rebel2_F","O_mas_afr_Rebel3_F",
        "O_mas_afr_Rebel4_F", "O_mas_afr_Rebel5_F", "O_mas_afr_Rebel6_F", "O_mas_afr_Rebel6a_F", "O_mas_afr_Rebel7_F",
        "O_mas_afr_Rebel8_F", "O_mas_afr_Rebel8a_F"];
    ani_enemyVehicles = ["O_mas_afr_Offroad_01_armed_F", "O_mas_afr_Offroad_01s_armed_F", "O_mas_afr_Offroad_01c_armed_F"];
  };
case 7: {
    // SOCOM DEVGRU by massi
    ani_mortarClass = "B_mas_usr_Mortar_01_F";
    ani_mortarGunnerClass = "B_mas_usn_Soldier_F";
    ani_hvtClass = "B_mas_usn_Soldier_off_F";
    ani_hvtGuardClass = "B_mas_usn_Soldier_F";
    ani_cacheClass = "B_supplyCrate_F";

    ani_enemyTruckClass = "B_Truck_01_transport_F";

    ani_enemyLeaders = ["B_mas_usn_Soldier_SL_F", "B_mas_usn_Soldier_TL_F"];
    ani_enemyUnits = ["B_mas_usr_Helipilot_F","B_mas_usn_Soldier_F","B_mas_usn_Soldier_F", "B_mas_usn_Soldier_GL_F", "B_mas_usn_Soldier_AR_F",
        "B_mas_usn_Soldier_MG_F", "B_mas_usn_Soldier_M_F", "B_mas_usn_soldier_LAT_F"];
    ani_enemyVehicles = ["B_mas_usd_Offroad_02_armed_F", "B_mas_usd_Offroad_01_armed_F", "B_mas_usr_MRAP_01_hmg_F", "B_mas_usr_MRAP_01_gmg_F"];
  };
};

switch (ani_friendlyFaction) do {
case 0: {
    ani_uavClass = "O_UAV_02_F";
    ani_chopperClass = "O_Heli_Light_02_unarmed_F";

    ani_recruit_ARClass = "O_soldier_AR_F";
    ani_recruit_MGClass = "O_soldier_AR_F";
    ani_recruit_ATClass = "O_soldier_AT_F";
    ani_recruit_LATClass = "O_soldier_LAT_F";
    ani_recruit_MedicClass = "O_medic_F";
    ani_recruit_PilotClass = "O_helipilot_F";
    ani_recruit_EngineerClass = "O_engineer_F";
  };
case 1: {
    ani_uavClass = "B_UAV_02_F";
    ani_chopperClass = "B_Heli_Transport_01_F";

    ani_recruit_ARClass = "B_soldier_AR_F";
    ani_recruit_MGClass = "B_soldier_AR_F";
    ani_recruit_ATClass = "B_soldier_AT_F";
    ani_recruit_LATClass = "B_soldier_LAT_F";
    ani_recruit_MedicClass = "B_medic_F";
    ani_recruit_PilotClass = "B_helipilot_F";
    ani_recruit_EngineerClass = "B_engineer_F";
  };
case 2: {
    ani_uavClass = "I_UAV_02_F";
    ani_chopperClass = "I_Heli_Transport_02_F";

    ani_recruit_ARClass = "I_soldier_AR_F";
    ani_recruit_MGClass = "I_soldier_AR_F";
    ani_recruit_ATClass = "I_soldier_AT_F";
    ani_recruit_LATClass = "I_soldier_LAT_F";
    ani_recruit_MedicClass = "I_medic_F";
    ani_recruit_PilotClass = "I_helipilot_F";
    ani_recruit_EngineerClass = "I_engineer_F";
  };
case 4: {
    ani_uavClass = "O_UAV_02_F";
    ani_chopperClass = "O_Heli_Light_02_unarmed_F";

    ani_recruit_ARClass = "O_mas_rus_Soldier_AR_F";
    ani_recruit_MGClass = "O_mas_rus_Soldier_MGh_F";
    ani_recruit_ATClass = "O_mas_rus_soldier_AT_F";
    ani_recruit_LATClass = "O_mas_rus_soldier_LAT_F";
    ani_recruit_MedicClass = "O_mas_rus_medic_F";
    ani_recruit_PilotClass = "O_mas_rus_Helipilot_F";
    ani_recruit_EngineerClass = "O_mas_rus_soldier_repair_F";
  };
case 5: {
    ani_uavClass = "O_UAV_02_F";
    ani_chopperClass = "O_Heli_Light_02_unarmed_F";

    ani_recruit_ARClass = "O_mas_afr_soldier_AR_F";
    ani_recruit_MGClass = "O_mas_afr_soldier_MG_F";
    ani_recruit_ATClass = "O_mas_afr_soldier_LAT_F";
    ani_recruit_LATClass = "O_mas_afr_soldier_LAT_F";
    ani_recruit_MedicClass = "O_mas_afr_medic_F";
    ani_recruit_PilotClass = "O_mas_afr_Soldier_lite_F";
    ani_recruit_EngineerClass = "O_mas_afr_soldier_repair_F";
  };
case 6: {
    ani_uavClass = "O_UAV_02_F";
    ani_chopperClass = "O_Heli_Light_02_unarmed_F";

    // need to test this out, dunno which number is what kind..
    ani_recruit_ARClass = "O_mas_afr_Rebel2_F";
    ani_recruit_MGClass = "O_mas_afr_Rebel3_F";
    ani_recruit_ATClass = "O_mas_afr_Rebel4_F";
    ani_recruit_LATClass = "O_mas_afr_Rebel5_F";
    ani_recruit_MedicClass = "O_mas_afr_Rebel6_F";
    ani_recruit_PilotClass = "O_mas_afr_Rebel7_F";
    ani_recruit_EngineerClass = "O_mas_afr_Rebel8_F";
  };
case 7: {
    ani_uavClass = "B_UAV_02_F";
    ani_chopperClass = "B_Heli_Transport_01_F";

    ani_recruit_ARClass = "B_mas_usn_soldier_AR_F";
    ani_recruit_MGClass = "B_mas_usn_soldier_MG_F";
    ani_recruit_ATClass = "B_mas_usn_soldier_AT_F";
    ani_recruit_LATClass = "B_mas_usn_soldier_LAT_F";
    ani_recruit_MedicClass = "B_mas_usn_medic_F";
    ani_recruit_PilotClass = "B_helipilot_F";
    ani_recruit_EngineerClass = "B_mas_usn_soldier_repair_F";
  };
};
