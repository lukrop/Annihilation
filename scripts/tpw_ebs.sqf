/*
TPW EBS - Engine based suppression for Arma3 SP
Version: 1.11
Authors: tpw, mrflay, ollem 
Thanks: -coulum-, fabrizio_t 
Date: 20130917
Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works. 	

To use: 
1 - Save this script into your mission directory as eg tpw_ebs.sqf
2 - Call it with 0 = [5,1,0,500,1,1,1] execvm "\scripts\tpw_ebs.sqf"; where 5 = bullet threshold, 1 = delay until suppression functions start (sec), 0 = debugging, 500 = suppression radius, 1 = player suppression effects, 1 = suppression applied to AI, 1 = AI will seek cover when suppressed.

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS
*/

if ((count _this) < 7) exitWith {hint "TPW EBS incorrect/no config, exiting."};
if !(isnil "tpw_ebs_active") exitWith {hint "TPW EBS already running."};
if (isDedicated) exitWith {};
WaitUntil {!isNull FindDisplay 46};

/////////////
// VARIABLES
/////////////
tpw_ebs_thresh = _this select 0; // unit is suppressed if this many bullets pass by in 5 secs
tpw_ebs_sleep = _this select 1; // how long til suppression functions start
tpw_ebs_debug = _this select 2; // debugging will colour the suppression shell (blue = unsuppressed, green = own side, yellow = enemy <5 bullets, red = enemy >5 bullets)
tpw_ebs_radius = _this select 3; // units must be closer to player than this (m) for suppression to work
tpw_ebs_playersup = _this select 4; // suppression effects applied to player
tpw_ebs_aisup = _this select 5; // suppression effects applied to AI
tpw_ebs_findcover = _this select 6; // AI will seek cover if suppressed
ww_coveractive = 0; // Windwalker AIcover. TPW EBS will not assign units to cover if WW AIcover is already doing so.
tpw_ebs_active = true; //Global enable/disable
tpw_ebs_unitarray = []; // Array of suppressible units
tpw_ebs_version = 1.11; // Version string

// Stance arrays for each weapon
tpw_ebs_standarray = ["AmovPercMstpSrasWnonDnon","AmovPercMstpSrasWpstDnon","AmovPercMstpSrasWrflDnon","AmovPercMstpSrasWlnrDnon"];
tpw_ebs_croucharray = ["AmovPknlMstpSrasWnonDnon","AmovPknlMstpSrasWpstDnon","AmovPknlMstpSrasWrflDnon","AmovPknlMstpSrasWlnrDnon"];
tpw_ebs_pronearray = ["AmovPpneMstpSrasWnonDnon","AmovPpneMstpSrasWpstDnon","AmovPpneMstpSrasWrflDnon","AmovPpneMstpSrasWlnrDnon"];

// Arrays of things which will deactivate the shell if nearby
tpw_ebs_exparray = [
"Timebombcore",
"Rocketcore",
"Submunitioncore",
"Bombcore",
"Grenade",
"Missilecore",
"Shellcore",
"Helicopter"];

////////////
// FUNCS
///////////

// ADD SUPPRESSION SHELL
tpw_ebs_fnc_addshell = 
	{
	private ["_unit"];
	_unit = _this select 0;
	
	//Only add shell if none exists and not near explosive/heli
	if ((_unit getvariable ["tpw_ebs_shell", 0] == 0 ) && (_unit getvariable ["tpw_ebs_near", 0] == 0)) then
		{
		[_unit] call tpw_ebs_fnc_bigshell;
		_unit addeventhandler ["killed", {deletevehicle ((_this select 0) getvariable "tpw_ebs_attachedshell")}]; // remove shell if killed
		_unit setvariable ["tpw_ebs_shell", 1];
		_unit action ["SwitchWeapon",_unit,_unit,0]; // initial weapon switch so weapon detection works
		};
	};

// 5m shell
tpw_ebs_fnc_bigshell = 
	{
	private ["_unit","_shell"];
	_unit = _this select 0;
	(_unit getvariable ["tpw_ebs_attachedshell",objnull]) removeAllEventHandlers "hitpart";
	deletevehicle (_unit getvariable ["tpw_ebs_attachedshell",objnull]);	
	_shell = "FLAY_FireGeom_L" createVehicle [0,0,0];
	_shell addeventhandler ["hitpart",{_this call tpw_ebs_fnc_supstate}];
	_shell setvariable ["tpw_ebs_attachedunit",_unit]; 
	_unit setvariable ["tpw_ebs_attachedshell",_shell];
	_shell attachTo [_unit, [0,0,0]];
	_unit setvariable ["tpw_ebs_shell", 1];
	};
	
// 3m shell	
tpw_ebs_fnc_medshell = 
	{
	private ["_unit","_shell"];
	_unit = _this select 0;
	(_unit getvariable ["tpw_ebs_attachedshell",objnull]) removeAllEventHandlers "hitpart";
	deletevehicle (_unit getvariable ["tpw_ebs_attachedshell",objnull]);	
	_shell = "FLAY_FireGeom_M" createVehicle [0,0,0];
	_shell addeventhandler ["hitpart",{_this call tpw_ebs_fnc_supstate}];
	_shell setvariable ["tpw_ebs_attachedunit",_unit]; 
	_unit setvariable ["tpw_ebs_attachedshell",_shell];
	_shell attachTo [_unit, [0,0,0]];
	_unit setvariable ["tpw_ebs_shell", 1];
	};

// 2m shell	
tpw_ebs_fnc_smallshell = 
	{
	private ["_unit","_shell"];
	_unit = _this select 0;
	(_unit getvariable ["tpw_ebs_attachedshell",objnull]) removeAllEventHandlers "hitpart";
	deletevehicle (_unit getvariable ["tpw_ebs_attachedshell",objnull]);	
	_shell = "FLAY_FireGeom_S" createVehicle [0,0,0];
	_shell addeventhandler ["hitpart",{_this call tpw_ebs_fnc_supstate}];
	_shell setvariable ["tpw_ebs_attachedunit",_unit]; 
	_unit setvariable ["tpw_ebs_attachedshell",_shell];
	_shell attachTo [_unit, [0,0,0]];
	_unit setvariable ["tpw_ebs_shell", 1];
	};	
	
// REMOVE SUPPRESSION SHELL	
tpw_ebs_fnc_removeshell =
	{
	private ["_unit","_shell"];
	_unit = _this select 0;
	
	//Only run if unit already has a shell
	if (_unit getvariable ["tpw_ebs_shell", 0] == 1) then
		{
		(_unit getvariable ["tpw_ebs_attachedshell",objnull]) removeAllEventHandlers "hitpart";
		deletevehicle (_unit getvariable "tpw_ebs_attachedshell");
		_unit setvariable ["tpw_ebs_shell", 0];
		
		// Remove unit from array of suppressible units
		tpw_ebs_unitarray = tpw_ebs_unitarray - [_unit];
		};
	};

// CHECK IF SHELL NEAR EXPLOSIVES/HELICOPTERS
tpw_ebs_fnc_checknear = 
	{
	private ["_unit","_list"];
	_unit = _this select 0;
	_unit setvariable ["tpw_ebs_near", 0];
		{
		_list = (position _unit) nearObjects [_x,15];
		if (count _list > 0) exitwith 
			{
			//hintsilent format ["%1",_list];
			[_unit] call tpw_ebs_fnc_removeshell;
			_unit setvariable ["tpw_ebs_near", 1];
			};
		} foreach tpw_ebs_exparray;
	};	
	
// WHEN SUPPRESSION SHELL IS HIT
tpw_ebs_fnc_supstate =
	{
	private ["_shell","_shellinfo","_unit","_unitside","_shooter","_shooterside","_velocity","_ammo","_hitval","_hitrng","_allbullets","_enemybullets","_supstate","_direct","_exp","_explosive","_expdist","_dmg","_dir"];

	_shellinfo = _this select 0;
	_shell =_shellinfo select 0; 
	_unit = _shell getvariable "tpw_ebs_attachedunit";

	//Exit if no info can be gleaned from what hit the shell - disable shell in case another of the same happens
	if (count (_shellinfo select 6) < 5 ) exitwith 
		{
		[_unit] call tpw_ebs_fnc_removeshell;
		};
	
	_shooter = _shellinfo select 1;
	_velocity = speed (_shellinfo select 2);
	_exp = (_shellinfo select 6) select 3; // explosive?
	_direct = _shellinfo select 10; // direct or indirect hit?
	_unitside = side _unit;
	_shooterside = side _shooter;
	_allbullets = _unit getvariable ["tpw_ebs_allbullets", 0];		
	_enemybullets = _unit getvariable ["tpw_ebs_enemybullets", 0];

	// Ignore subsonic bullets ie pistols and silenced
	if (_velocity < 1500 && _direct) exitwith {};
	
	// Increment bullet counters	
	_allbullets  = _allbullets + 1;
	if (_unitside != _shooterside) then 
		{
		_enemybullets  = _enemybullets + 1;
		_unit setvariable ["tpw_ebs_enemy",_shooter]; 
		};
	
	// Initial skill, stance and fatigue
	if (_allbullets == 1) then
		{
		_unit setvariable ["tpw_ebs_skill",skill _unit];
		_unit setvariable ["tpw_ebs_stance",stance _unit];
		_unit setvariable ["tpw_ebs_fatigue",getfatigue _unit];
		};
	
	// Determine suppression state
	_supstate = 1;	
	if (_enemybullets > 0) then
		{
		_supstate = 2;
		};
	if (_enemybullets > tpw_ebs_thresh) then
		{
		_supstate = 3;
		};

	// If hit by explosion
	if (_exp > 0) then
		{
		_ammo = (_shellinfo select 6) select 4; // ammo object name
		_hitrng = (_shellinfo select 6) select 2; // indirect hit range
		_hitval = (_shellinfo select 6) select 1; // indirect hit value
		_explosive = nearestObject [_unit, _ammo]; // object that exploded
		_expdist = _explosive distance _unit; // distance from unit
		_dir = [_explosive,_unit] call BIS_fnc_dirTo; // direction from explosive to unit
		
		if !(lineintersects [eyepos _unit,getposasl _explosive,_unit,_explosive]) then //explosion will only affect unit that can see it
			{
			// Fudge some damage values and apply them
			_dmg = ((3 * _hitrng) - _expdist) / (3 * _hitrng); // range based damage
			_dmg = (_hitval / 20) * _dmg; // hitval based damage
			if (_dmg > 0.8) then {_dmg = 1};
			_unit setdamage ((damage _unit) + _dmg); // apply damage to unit 
			_unit setBleedingRemaining 30; // apply bleeding to unit
			if !(isnil "tpw_fall_active") then {[_unit,0,_dmg] call tpw_fall_fnc_hitproc}; // TPW FALL from explosion
			};
			_supstate = 3;
		[_unit] call tpw_ebs_fnc_removeshell; // Remove shell so that unit will react natively to any further explosions over the next few sec.	
		};		
	
	// Update unit's variables
	_unit setvariable ["tpw_ebs_allbullets",_allbullets]; // all bullets
	_unit setvariable ["tpw_ebs_enemybullets",_enemybullets]; // enemy bullets
	_unit setvariable ["tpw_ebs_supstate",_supstate]; // suppression state
	_unit setvariable ["tpw_ebs_uptime",time + 5 + (random 5)]; // how long until unit is unsuppressed
	_unit setvariable ["tpw_ebs_downtime",time + (random 1)]; // how long until unit reacts to bullet
	};
	
// DETERMINE UNIT'S WEAPON TYPE 
tpw_ebs_fnc_weptype =
	{
	private["_unit","_weptype","_cw","_hw","_pw","_sw"];
	_unit = _this select 0;	
	
	// Weapon type
	_cw = currentweapon _unit;
	_hw = handgunweapon _unit;
	_pw = primaryweapon _unit;
	_sw = secondaryweapon _unit;
	 switch _cw do
		{
		case "": 
			{
			_weptype = 0;
			};
		case _hw: 
			{
			_weptype = 1;
			};
		case _pw: 
			{
			_weptype = 2;
			};
		case _sw: 
			{
			_weptype = 3;
			};
		default
			{
			_weptype = 0;
			};	
		};
	_unit setvariable ["tpw_ebs_weptype",_weptype];
	};	

// FIND COVER
tpw_ebs_fnc_findcover = 
	{
	private ["_unit","_shooter","_cover","_ball","_debugball","_box","_height","_coverpos"];
	_unit = _this select 0;
	_debugball = false;
	_shooter = 	_unit getvariable ["tpw_ebs_enemy",objnull];
	_cover = nearestobjects [position _unit,["house","landvehicle"],100];
		{
		_box = boundingbox _x;
		_height = ((_box select 1) select 2) - ((_box select 0) select 2);
		if (_height > 1) exitwith 
			{_coverpos = getposatl _x;
			if (tpw_ebs_debug == 1) then 
				{
				_ball = "sign_sphere100cm_F" createvehicle _coverpos;
				_ball attachto [_x,[0,0,5]];
				_debugball = true;
				};
			while {alive _unit && !(isnull _shooter) && (_unit getvariable "tpw_ebs_supstate" > 1) && !(lineintersects [eyepos _unit,eyepos _shooter])} do
				{
				_unit domove _coverpos;
				sleep 1;
				};
			};
		} foreach _cover;
	if (tpw_ebs_debug == 1) then 
		{
		if (_debugball) then 
			{ 
			deleteVehicle _ball;
			};
		};
	};	

// MAIN SUPPRESSION PROCESSING LOOP
tpw_ebs_fnc_procsup =
	{
	private ["_unit","_supstate","_stance","_ctr","_nearair","_cover","_fallstate"];
	while {true} do
		{
			{
			_unit = _x;
			_supstate = _unit getvariable ["tpw_ebs_supstate", 0];
										
			// Deactivate shell if near explosives/helicopters
			[_unit] call tpw_ebs_fnc_checknear;
			
			// Only bother with suppression functions if... (lazy evaluation)
			if (
			(_unit getvariable ["tpw_ebs_shell",0] == 1) // unit has shell
			&& 	{_supstate > _unit getvariable ["tpw_ebs_lastsup",0]}  // supression state has increased
			&& {time >= _unit getvariable ["tpw_ebs_downtime",0]}  // reaction delay time has passed
			&& {_unit getvariable ["tpw_fallstate",0] == 0} // unit is not TPW FALLing
			) then
				{
				_unit setvariable ["tpw_ebs_lastsup",_supstate];
				[_unit] call tpw_ebs_fnc_weptype;
				_stance = stance _unit;
				_unit allowfleeing 0;
				
				// Stop unit from targetting enemy
				_unit dowatch objnull;
				
				// Suppression specific changes (playmove forces stance change)
				switch _supstate do
					{
					case 1:
						{
						// Crouch if not prone
						if (_stance != "PRONE") then
							{
							_unit setunitpos "middle";
							_unit playmove (tpw_ebs_croucharray select (_unit getvariable "tpw_ebs_weptype"));
							};
						};	
					case 2:
						{
						//Medium shell
						[_unit] call tpw_ebs_fnc_medshell;
						
						// Crouch if not prone
						if (_stance != "PRONE") then
							{
							_unit setunitpos "middle";
							_unit playmove (tpw_ebs_croucharray select (_unit getvariable "tpw_ebs_weptype"));
							
							//Find cover
							if (tpw_ebs_findcover == 1 && {ww_coverActive == 0}) then
								{
								[_unit] spawn tpw_ebs_fnc_findcover;
								};
							
							// Reduce skill
							_unit setskill ((_unit getvariable "tpw_ebs_skill") * 0.75);
							};
						
						// Civs hit the deck
						if (side _unit == CIVILIAN) then 
							{
							_unit setunitpos "down";
							_unit playmove (tpw_ebs_pronearray select (_unit getvariable "tpw_ebs_weptype"));
							
							//Find cover
							if (tpw_ebs_findcover == 1 && {ww_coverActive == 0}) then
								{
								[_unit] spawn tpw_ebs_fnc_findcover;
								};
							_unit setSpeedMode "FULL";							
							};
						};


					case 3:
						{
						//Small shell
						[_unit] call tpw_ebs_fnc_smallshell;
						
						// Hit the deck regardless
						_unit setunitpos "down";
						_unit playmove (tpw_ebs_pronearray select (_unit getvariable "tpw_ebs_weptype"));
						
						//Find cover
						if (tpw_ebs_findcover == 1 && {ww_coverActive == 0}) then
							{
							[_unit] spawn tpw_ebs_fnc_findcover;
							};
						
						// Reduce skill
						_unit setskill ((_unit getvariable "tpw_ebs_skill") * 0.5);	
						};	
					};	
				};
				
			// Reset suppression after enough time
			if (time >= (_unit getvariable ["tpw_ebs_uptime", time + 30])) then 			
				{
				[_unit] call tpw_ebs_fnc_bigshell;
				_unit setvariable ["tpw_ebs_allbullets",0];
				_unit setvariable ["tpw_ebs_enemybullets",0];
				_unit setvariable ["tpw_ebs_supstate",0];
				_unit setskill (_unit getvariable "tpw_ebs_skill");

				// Reset stances (playmove will force it)
				[_unit] call tpw_ebs_fnc_weptype;
				switch (_unit getvariable ["tpw_ebs_stance", -1]) do
					{
					case "STAND":
						{
						_unit setunitpos "auto";
						_unit playmove (tpw_ebs_standarray select (_unit getvariable "tpw_ebs_weptype"));
						};	
					case "CROUCH":
						{
						_unit setunitpos "auto";
						_unit playmove (tpw_ebs_croucharray select (_unit getvariable "tpw_ebs_weptype"));
						
						};
					default	
						{
						_unit setunitpos "auto";
						};
					};
				_unit setvariable ["tpw_ebs_lastsup",0];	
				_unit setvariable ["tpw_ebs_uptime",time + 30];	
				};
			
			// Debugging
			if (tpw_ebs_debug == 1) then 
				{
				switch _supstate do
					{
					case 1: 
						{
						(_unit getvariable "tpw_ebs_attachedshell") setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,0.2,CA)"];
						};
					case 2: 
						{
						(_unit getvariable "tpw_ebs_attachedshell") setObjectTexture [0, "#(argb,8,8,3)color(1,1,0,0.2,CA)"];
						};
					case 3: 
						{
						(_unit getvariable "tpw_ebs_attachedshell") setObjectTexture [0, "#(argb,8,8,3)color(1,0,0,0.2,CA)"];
						};
					default
						{
						(_unit getvariable "tpw_ebs_attachedshell") setObjectTexture [0, "#(argb,8,8,3)color(0,0,1,0.1,CA)"];
						};
					};
				};
			} foreach tpw_ebs_unitarray;
		sleep 1;
		};
	};

// PERIODICALLY SCAN APPROPRIATE UNITS INTO ARRAY FOR SUPPRESSION	
tpw_ebs_fnc_screen =
	{
	private ["_shell","_nearair"];
	while {true} do
		{
		tpw_ebs_unitarray = [];
			{
			if (alive _x) then 
				{
				if (_x distance vehicle player < tpw_ebs_radius) then
					{
					if (_x == vehicle _x) then
						{
						if (_x != player) then
							{
							// Deactivate shell if near explosives/helicopters
							[_x] call tpw_ebs_fnc_checknear;
							
							// Add to the array of suppressible units 
							tpw_ebs_unitarray set [count tpw_ebs_unitarray,_x];

							// Add suppression detection shell if needed
							[_x] call tpw_ebs_fnc_addshell;
							
							};
						};
					}
					else
					{
					// Remove shell from distant units
					[_x] call tpw_ebs_fnc_removeshell;
					};
				};
			} foreach allunits;
		sleep 5;
		};
	};	


// PLAYER SUPPRESSION	
tpw_ebs_fnc_playersup =
	{
	private ["_supstate","_fatigue"];
	while {true} do
		{
		if (player == vehicle player) then
			{		
			// Deactivate shell if near explosive/helicopter
			[player] call tpw_ebs_fnc_checknear;
		
			// Re-add shell if OK to do so
			[player] call tpw_ebs_fnc_addshell;
			
			_supstate = player getvariable ["tpw_ebs_supstate",0];

			// Set suppression effects only if suppression state has changed
			if (_supstate > (player getvariable ["tpw_ebs_lastsup",0])) then
				{
				player setvariable ["tpw_ebs_lastsup",_supstate];	
				_fatigue = player getvariable ["tpw_ebs_fatigue",0];
				
				switch _supstate do
					{
					case 1:
						{
						player setfatigue (_fatigue + 0.1);
						};
						
					case 2:
						{
						player setfatigue (_fatigue + 0.3);
						};	
					
					case 3:
						{
						player setfatigue 0.9;
						};
					};
				};	
			
			// Reset if unsuppressed
			if (time >= (player getvariable ["tpw_ebs_uptime", time + 30])) then 			
				{
				player setvariable ["tpw_ebs_allbullets",0];
				player setvariable ["tpw_ebs_enemybullets",0];
				player setvariable ["tpw_ebs_supstate",0];
				player setfatigue (player getvariable "tpw_ebs_fatigue");
				player setvariable ["tpw_ebs_lastsup",0];	
				player setvariable ["tpw_ebs_uptime",time + 30];	
				};
			};
		sleep 1;
		};
	};	

// PERIODICALLY RESET ALL UNITS SUPPRESSION STATUS TO PREVENT THINGS GETTING STUCK
tpw_ebs_fnc_reset =
{
	while {true} do
		{
			{
			_x setvariable ["tpw_ebs_supstate",0];
			} foreach tpw_ebs_unitarray;
		player setvariable ["tpw_ebs_supstate",0];
		sleep random 60;
		};
	};
	
//////////
// RUN IT
//////////

// DELAY
sleep  tpw_ebs_sleep;

// SELECTION LOOP	
0 = [] spawn tpw_ebs_fnc_screen;
sleep 1;

// MAIN AI SUPPRESSION LOOP
if (tpw_ebs_aisup == 1) then 
	{
	0 = [] spawn tpw_ebs_fnc_procsup;
	0 = [] spawn tpw_ebs_fnc_reset;
	};
	
// PLAYER SUPPRESSION LOOP
if (tpw_ebs_playersup == 1) then
	{
	[player] call tpw_ebs_fnc_checknear;
	[player] call tpw_ebs_fnc_addshell;
	0 = [] spawn tpw_ebs_fnc_playersup;
	};
