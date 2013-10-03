SLP_spawn ...created by Nomadd

Credits: 
BIS
Shuko ... I am using his SHK_pos.sqf to find the spawn locations. I have not altered it in anyway , full credits go to Shuko for this script. I am also using his SHK_buildingpos.sqf script
	  as an example of what can be added to the SLP_tasks.sqf for the spawned groups to preform, again full credit to Shuko for his script.
CBA and it creators
Silola for creating DAC , got alot of ideas from there
all the folks at the BI forums who have taken the time to answer questions and provide help


DISCLAIMER: 
I have tested this on multiplayer listen and dedicated servers, should work fine for SP, just not tested. I am sure their are better ways to do some of the things I have done. If anyone with more 
scripting knoledge wants to improve/change this you have my blessing (just share it with everyone else).



First: 

 In your init.sqf (if you don't have one , you need to make one) put:
   
SLP_init = [] execvm "SLP\SLP_init.sqf";

NOtE: DO NOT TRY and run a ( exp: 0=["trg1",[0,2],[trg1,50],[],[],[2,[1,3],TRUE],[],["patrol",30]] spawn SLP_spawn; ) from your init.sqf. The SLP_init.sqf needs time to initialize everything and the init.sqf may process faster then SLP_init.sqf
      can process. Instead either use another .sqf or use triggers in game. You can use a delay or waituntil {SLP_init == 1}; in your init.sqf but I try and avoid using any type of delays in the init.sqf. There is an example in the demo mission.



Second:

 Make sure you have at least one unit for each side present on the map.
 note: If you want to use this with UPSMON the units have to be present probabitlity 100%.
	UPSmon bugs-out and everything spawned will surrender if no units are present on the map.


How it works:

0= ["nameofspawn",[side,faction,delay(optional)],[position,offset distance(optional)],[infantry],[vehicles],[armor],[air],[tasks,taskinfo1,taskinfo2]] spawn SLP_spawn;
																

0:"nameofspawn" is just a name for debug purposed. If something dosen't work. This should help to find the problem. Name must be in "QUOTES".

1:[side,faction,delay]	

	side:   east=0		The numbers are used in script call to determine the side being spawned.	
		west=1;				
 		resistance=2;			
		civilian=3;
 
	faction: is set in SLP_units_config. SLP_units_config is set by the user. 
	
		NOTE: The SLP_units_config.sqf is designed to be modified by the user. You can change/add anything you want. If you want to use user made mods just put the class names into the SLP_units_config.sqf just follow the way it is shown
		      Also if you want to have for example: Independent using Opfor armor you can set it up that way. 
	          
	
	        EXP: 2 is the faction number used in script call   	case 2: //Takistan army	
										{
	        				 					_Leaderunits = 	["TK_Soldier_SL_EP1","TK_Soldier_Officer_EP1"]; //These are the squad leaders/Officers

											_units =	[
	       !!IMPORTANT!! Unit Array, first position must be pilot					"TK_Soldier_Pilot_EP1","TK_Soldier_Crew_EP1","TK_Soldier_EP1","TK_Soldier_B_EP1","TK_Soldier_LAT_EP1","TK_Soldier_AT_EP1","TK_Soldier_AA_EP1",
	 	second position must be crew								"TK_Soldier_AAT_EP1","TK_Soldier_AMG_EP1","TK_Soldier_HAT_EP1","TK_Soldier_AR_EP1",
													"TK_Soldier_Engineer_EP1","TK_Soldier_GL_EP1","TK_Soldier_MG_EP1","TK_Soldier_Medic_EP1",
													"TK_Soldier_Sniper_EP1","TK_Soldier_SniperH_EP1",
													"TK_Soldier_TWS_EP1","TK_Soldier_Spotter_EP1","TK_Special_Forces_MG_EP1",
													"TK_Special_Forces_EP1","TK_Special_Forces_TL_EP1"
													];
											_vehicles = 	["UAZ_Unarmed_TK_EP1","V3S_TK_EP1","V3S_Open_TK_EP1","UAZ_MG_TK_EP1","UAZ_AGS30_TK_EP1","LandRover_MG_TK_EP1","LandRover_SPG9_TK_EP1","GRAD_TK_EP1","Ural_ZU23_TK_EP1"];
											_tanks = 	["BMP2_TK_EP1","BRDM2_TK_EP1","BRDM2_ATGM_TK_EP1","BTR60_TK_EP1","M113_TK_EP1","T34_TK_EP1","T55_TK_EP1","T72_TK_EP1","ZSU_TK_EP1"];
											_helo = 	["Mi24_D_TK_EP1","Mi17_TK_EP1","UH1H_TK_EP1"];
											_plane=         [];
											_boat = 	[];
										};

	Delay: 	Is the time between group spawns. The delay is optional, if no delay is set, 10 secs is the default.
       		If delay is set: TRUE. All the units must be killed for a new group to spawn.
		EXP: 0=["trg1",[0,2,true],[trg1,50],[2,[4,8]],[],[],[],["patrol",30]] spawn SLP_spawn; 	

	NOTE: The different groups work infantry/vehicles/armor/air work independent of one another. Meaning if delay is set to TRUE. Once an infantry group is killed another infantry group will spawn, when a vehicle group is killed another vehicle group will spawn. 
	      If the delay is in seconds then each group type will use the same delay for spawning.
 

2:[position,offset distance]

	Postion: I like to use triggers, but you can use just about anything- triggers, markers,objects,other units,etc. You can also have an array of positions [trg1,"markname1",obj,gamelogic] and SLP_spawn will randomly spawn groups at the different places.

	Offset: is the distance in meters from the positon you would like the units to ramdomly spawn,if nothing is put here the default is 0. EXP: 100 would randomly spawn units from the original position out to 100 meters in an ellipse.
		this can also be an array [50,100] 50 meter min 100 meter max distance.

3:[infantry]

	This is where the infantry units are set. [1,6] would be 1 group with 6 units. This can also be an array [[1,3],[4,7]]. this will spawn 1 to 3 groups with 4 to 7 units each. You can also just set the number of groups [2] this will spawn
	2 groups with 4-8 units each. If the size if not set the default for infantry groups is 4-8 units.

4: [vehicles]

    	same as infantry. (The default size for vehicle groups is 1 unit.)

   NOTE:  NEW param in script call. You can fill empty cargo places with units, the units spawned will be part of the vehicle group. you can also choose how much of the empty cargo places you want to fill. you must set the 3rd element to true 
	  to have units spawn. This can give you mechanized infantry.
	  EXP: 0=["trg1",[0,2],[trg1,50],[],[2,[1,3],TRUE],[],[],["patrol",30]] spawn SLP_spawn; 	
	  	this is will spawn 2 groups with 1-3 vehicles each and cargo spaces will be filled based on setting in SLP_init. See SLP_init for more info. 

5: [Armor]

	same as infantry. (The default size for Armor groups is 1 unit.)

   NOTE:  NEW param in script call. You can fill empty cargo places with units, the units spawned will be part of the vehicle group. you can also choose how much of the empty cargo places you want to fill. you must set the 3rd element to true 
	  to have units spawn.
	  EXP: 0=["trg1",[0,2],[trg1,50],[],[],[2,[1,3],TRUE],[],["patrol",30]] spawn SLP_spawn; 	
		this is will spawn 2 groups with 1-3 armor each and cargo spaces will be filled based on setting in SLP_init. See SLP_init for more info. 


6: [air and boats]
	same as infantry. (The default size for Air groups is 1 unit.)
	NEW param. you can now choose between "helo","plane" or "boat". You can randomly spawn which ever type you want.
	EXP 0=["trg1",[0,2],[trg1,50],[],[],[],[2,1,"plane"],["patrol",300]] spawn SLP_spawn;
		This will spawn 2 groups with 1 plane each. You can only use "plane" or "helo". Make sure they are in "quotes". If you don't put anything the default is "helo". This uses new arrays in the Units_configs. 

	EXP 0=["trg1",[0,2],[trg1,50],[],[],[],[2,1,"boat"],["patrol",300]] spawn SLP_spawn;

7: [task,task1,task2]


   TASK: 
	This will tell the spawned units what task to preform. Tasks must be in "QUOTES".
	        	"patrol"   	group will patrol -if CBA is used then CBA_fnc_taskpatrol else BIS_fnc_taskpatrol
			"defend"   	group will defend -if CBA is used then CBA_fnc_taskdefend else BIS_fnc_taskdefend 
			"attack" 	group will attack an object,position,group
			"hunt" 	  	group will hunt another group 
(infantry only)		"building"	group will find positions in buildings, I am using Shukos script for this.  Units will also be set in the up position.
			"UPS"           group will use UPS to control its movements
			"crbhouse"      group will use crbhouse to move into house positions, this is best used on groups with just 1-2 units.

            Known issues, if you set a group to occupy "buildings" they will stay inside until first contant, then most always leave the building. 
	    However, If you only spawn only single units. The single units tend to stay inside. This is something with the ARMA AI not the script.

  NOTE: You can add or change TASKs in the SLP_TASKS.sqf just follow the way it is show with the examples										



  task1: defines what the task does
  	["patrol",300] 		would have a group patrol an ellipse of 300 meters

  	["defend", 30] 		group will defend spawned positon out to 30 meters

	["attack",objname] 	group will attack objname, great for setting up defend base type missions, use delay to set the spawn rate and randomize the spawn locations so enemy comes from different places
				objname can be a marker,object,unit,group etc.It also can be in an array EXP: ,["attack",[name1,name2]]. If in an array it will randomly choose one thing to attack

	["hunt",groupname] 	group will hunt another group or object, just use the name of the group or object to be hunted

	["building",40]         groups will occupy building positions out to 40 meters from spawn location

	["ups","mrkname"]       group will use ups with a preplaced marker

	["crbhouse",50]		units will move into house positions within 50 meters from spawn point. They will randomly patrol inside houses within that 50 meter radius


  task2: is optional. if you want to use a different position other than the spawn position to preform the task
	["patrol",300,"mark1"] group will spawn at the original position but will then patrol at "mark1".
	["building",40,objname] group can be spawned outside of a town in a clear area then will find positions in buildings up to 40 meters from an object name objname
	


SETTINGS IN THE SLP_INIT:

SLP_INIT: 

	1: _debug= 1;  1=on,0=off     Just what it says, give hints if the script call is wrong and also attaches markers to all spawned units for quick visual check on the map. Markers do not work on Dedicated.

	2: _setskill: you can set the skills of all the spawned units. Skills can be in an array [0.2,0.4] or single .4 .If you use an array SLP_spawn will choose a random number between your low number and high number.
		     0=no skill , 1=very skilled
				
		_setskill_INF=   [.3,.6]; 		sets the skills of Infantry units
		_setskill_VEh=   [.5,.7]; 		sets the skills of Vehicles and Armor units
		_setskill_AIR=     .8; 			sets the skills of AIR units

	3: if you want to set global values for number of groups/size of each group. It can be done in the SLP_init. You can also set-up and use the paramsarray to change the number of groups/units for any give type. To make it work
		use -1 in the script call
		EXP: 0=["trg1",[1,5,5],[trg1,50],[-1,-1],[-1,-1],[-1],[],["patrol",200]] spawn SLP_spawn; 

		See the demo mission for expample of how to do this.

	4: _burydead =         60 + random 60 ; sets the delay in secs until dead units sink into the ground and are deleted. only works with units spawned with SLP_spawn

	5: _fillcargo =         [.5,1]   ;    //this is 50-100% full !!vehicle and armor only!!
	 	
		If set to true in script call exp 0=["trg1_i",[0,3,true],[trg1_1],[],[3,1,true],[],[],[]] spawn SLP_spawn;
		This will let you choose how many units to fill a vehice with, depented on how many cargo seats available
		can be in an array [.5,1] this will fill the vehicle 50-100% or just a number .5 (would be 50%).
 		values are 0=empty to 1=full.
	
PARAMS
   I have examples of how to use the paramsarry in the demo. This allows the host to change the number of spawns before a mission is played. You can also set it up ,for exp, to change the number of attacking waves of enemy. If you are not familiar
   with using paramsarray or you just do not want to use it. You can delete all of it from the description.ext and aslo from the SLP_init.sqf. In the SLP_init.sqf everywhere it has a (paramsarray select x) just set it to 0.


EXP: 0=["trg1",[0,2,15],[trg1,50],[2,[4,8]],[],[[1,2],1],[],["patrol",300,"patrolhere"]] spawn SLP_spawn; //trg1 is a named trigger in editor
	"trg1" name of spawn for debug purposes, east side, takistan army, 15 sec delay between spawns, trg1 is spawn location, 50 meter random offset from trg1. 2 groups of 4 to 8 infantry, no vehicles,1 to 2 groups of 1 armor each, all groups will patrol around a marker name "patrolhere" in a 300 meter ellipse	
 

EXP: 0=["sp1",[0,2,45],[["mark1","mark2","mark3"],[5,50]],[20,[8,12]],[],[],[],["attack",barrel]] spawn SLP_spawn;
	"sp1" name of spawn for debug purposes, east side, takistan army, 45 sec delay between spawns, groups will randomly spawn at the different "markernames". groups will then attack object name barrel

	

		 