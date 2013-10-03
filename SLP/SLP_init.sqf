private ["_debug","_setskill_inf","_setskill_veh","_setskill_air","_Infgrp_num","_Infgrp_size","_Vehgrp_num","_Vehgrp_size","_Armgrp_num","_Armgrp_size","_Airgrp_num","_Airgrp_size","_burydead","_fillcargo","_CBA_present"];
if (!isserver) exitwith {};


SLP_mark = 0; 
SLP_Instances = 0; 

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
_debug =                   						0;    // 0:off  1:on  //If on shows markers for group position,type(units,vehicle,armor,air),number of units in the group and current waypoint 
// Also, will turn on debug messages
/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
//sets spawned units skill level can be an array.. [0.2,0.7]  or  0.2

_setskill_inf=SLP_skill_inf;    // sets skill for infantry units
_setskill_veh=[0.3,0.6];   	//sets skill for vehicles and armor units
_setskill_air=[0.5,0.7]; 	// sets skill for Air units

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
//# of Groups and Group size...Global Values use... -1 in script call to activate 
//if you are not using paramsarray then set these values to 0
//_Infgrp_num=             0;
//_Infgrp_size=            0;

_Infgrp_num=  0; // Sets # of Infantry groups
_Infgrp_size= 0; // Sets # of units in infantry groups
_Vehgrp_num=  0; // Sets # of vehicle groups
_Vehgrp_size= 0; // Sets # of units in vehicle groups
_Armgrp_num=  0; // Sets # of Armor groups
_Armgrp_size= 0; // Sets # of units in Armor groups
_Airgrp_num=  0; // Sets # of Air groups
_Airgrp_size= 0; // Sets # of units in Air groups

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
//Burydead: sets the delay until dead units sink into the ground and are deleted. only works with units spawned with SLP_spawn

_burydead =                                1200 + random 150;            //set the delay in secs until units are removed, does not remove vehicles

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/
// vehicle and armor only!!
//If set to true in script call exp 0=["trg1_i",[0,3,true],[trg1_1,[5,10]],[3,[1,4]],[3,1,true],[],[],[]] spawn SLP_spawn;
//This will let you choose how many units to fill a vehice with, depented on how many cargo seats available
//can be in an array [.5,1] this will fill the vehicle 50-100% or just a number .5 (would be 50%).
//  1-full 0-empty

_fillcargo =                                     [0,.5]   ;    //this is 50-100% full

/*-----------------------------------------------------------------------------------------------------------------------------------------------------*/


/////////////////////////////DO NOT EDIT ANYTHING BELOW THIS ////////////////////////////////////////////////////////////////////////////////////////

_CBA_present =if (isClass(configFile >> "cfgPatches" >> "CBA_main")) then {true} else {false};
_ACE_present =if (isClass(configFile >> "cfgPatches" >> "ACE_main")) then {true} else {false};

SLP_ARRAY = [];
SLP_ARRAY = [_debug,_setskill_inf,_setskill_veh,_setskill_air,_Infgrp_num,_Infgrp_size,_Vehgrp_num,_Vehgrp_size,_Armgrp_num,
_Armgrp_size,_Airgrp_num,_Airgrp_size,_burydead,_fillcargo,_CBA_present];

call compile preprocessFileLineNumbers "SLP\scripts\SLP_fnc_common.sqf";
call compile preprocessFileLineNumbers "SLP\scripts\SLP_fnc_spawn.sqf";
SLP_units = compile preprocessfile "SLP\SLP_units_config.sqf";
SLP_Task = compile preprocessfile "SLP\SLP_Tasks.sqf";
SLP_spawn = compile preprocessfile "SLP\scripts\SLP_spawn.sqf";
SHK_pos = compile preprocessfile "SLP\scripts\SHK_pos.sqf";    
SHK_buildpos = compile preprocessfile "SLP\scripts\SHK_buildingpos.sqf";
SLP_markers = compile preprocessfile "SLP\scripts\SLP_markers.sqf";


