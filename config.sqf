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
  };
case 1: {
    // NATO
    ani_mortarClass = "B_Mortar_01_F";
    ani_mortarGunnerClass = "B_Soldier_F";
    ani_hvtClass = "B_officer_F";
    ani_hvtGuardClass = "B_Soldier_F";
    ani_cacheClass = "B_supplyCrate_F";
  };
case 2: {
    // AAF
    ani_mortarClass = "I_Mortar_01_F";
    ani_mortarGunnerClass = "I_Soldier_F";
    ani_hvtClass = "I_officer_F";
    ani_hvtGuardClass = "I_Soldier_F";
    ani_cacheClass = "I_supplyCrate_F";
  };
case 4: {
    // russian GRU by massi
    ani_mortarClass = "O_mas_rus_Mortar_01_F";
    ani_mortarGunnerClass = "O_mas_rus_Soldier_F";
    ani_hvtClass = "O_mas_rus_Soldier_off_F_u";
    ani_hvtGuardClass = "O_mas_rus_Soldier_F";
    ani_cacheClass = "O_supplyCrate_F";
  };
case 5: {
    // african rebel army by massi
    ani_mortarClass = "O_mas_afr_Mortar_01_F";
    ani_mortarGunnerClass = "O_mas_afr_Soldier_F";
    ani_hvtClass = "O_mas_afr_Soldier_off_F";
    ani_hvtGuardClass = "O_mas_afr_Soldier_F";
    ani_cacheClass = "O_supplyCrate_F";
  };
case 6: {
    // african civilian rebels by massi
    ani_mortarClass = "O_mas_afr_Mortar_01_F";
    ani_mortarGunnerClass = "O_mas_afr_Rebel8a_F";
    ani_hvtClass = "O_mas_afr_Soldier_off_F";
    ani_hvtGuardClass = "O_mas_afr_Soldier_F";
    ani_cacheClass = "O_supplyCrate_F";
  };
case 7: {
    // SOCOM DEVGRU by massi
    ani_mortarClass = "B_mas_usr_Mortar_01_F";
    ani_mortarGunnerClass = "B_mas_usn_Soldier_F";
    ani_hvtClass = "B_mas_usn_Soldier_off_F";
    ani_hvtGuardClass = "B_mas_usn_Soldier_F";
    ani_cacheClass = "B_supplyCrate_F";
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
