/*
TPW FALL
Version: 1.24
Author: tpw
Date: 20131014
Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works. 

To use: 
1 - Save this script into your mission directory as eg tpw_fall.sqf
2 - Call it with 0 = [100,500,10,1,30] execvm "\scripts\tpw_fall.sqf"; where 100 = sensitivity, 500 = radius around player to apply fall effects, 10 = start delay, 1 = ragdoll effects applied to AI (0 = no ragdoll), 30 = maximum time a unit will be incapacitated by a bullet hit

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS
*/

if (isDedicated) exitWith {};
if ((count _this) < 5) exitWith {hint "TPW FALL incorrect/no config, exiting."};
if !(isnil "tpw_fall_active") exitWith {hint "TPW FALL already running."};
WaitUntil {!isNull FindDisplay 46};

/////////////
// VARIABLES
/////////////

//READ IN VARIABLES
tpw_fall_sens = _this select 0;
tpw_fall_thresh = _this select 1;
tpw_fall_delay = _this select 2;
tpw_fall_ragdoll = _this select 3;
tpw_fall_falltime = _this select 4;

// OTHER VARIABLES	
tpw_fall_int = 0.1; // how often is unit fall status polled (sec). 
tpw_fall_att = 25; // sound attenuation (m)	
tpw_fallunits = []; // Array of units who can fall
tpw_fall_active = true ; //Global enable/disable
tpw_fall_version = "1.24"; // Version string

// NOISE ARRAYS
tpw_fall_steparray = ["gravel_sprint_1","gravel_sprint_2","gravel_sprint_3","gravel_sprint_4","gravel_sprint_5","gravel_sprint_6","gravel_sprint_7"];// footstep noises for landing
tpw_fall_crawlarray = ["crawl_dirt_1","crawl_dirt_2","crawl_dirt_3","crawl_dirt_4","crawl_dirt_5","crawl_dirt_6","crawl_dirt_7"]; // crawl noises for fall after landing
tpw_fall_crawlarray2 = ["crawl_grass_01","crawl_grass_02","crawl_grass_03","crawl_grass_04","crawl_grass_05","crawl_grass_06","crawl_grass_07"]; // crawl noises for getting back up
tpw_fall_splasharray = ["water_sprint_1","water_sprint_2","water_sprint_3","water_sprint_4","water_sprint_5","water_sprint_6","water_sprint_7","water_sprint_8"]; // splash noises for landing in water
tpw_fall_yellarray = ["p1_moan_01","p1_moan_02","p1_moan_03","p1_moan_04","p1_moan_05","p1_moan_06","p1_moan_07","p1_moan_08"]; // yells/gasps after hard landings

// ANIMATION ARRAYS - ANY GIVEN FALL ANIM HAS A MATCHING GETUP ANIM
tpw_fall_sw_fallarray = ["AmovPercMstpSrasWlnrDnon_AmovPpneMstpSnonWnonDnon"]; // launcher fall animations
tpw_fall_sw_getuparray = [""]; // launcher get up animations
tpw_fall_pw_fallarray = ["AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright","AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft"]; // rifle fall animations
tpw_fall_pw_getuparray = ["AadjPpneMstpSrasWrflDright_AmovPercMstpSrasWrflDnon","AadjPpneMstpSrasWrflDleft_AmovPercMstpSrasWrflDnon"]; // rifle get up animations
tpw_fall_hw_fallarray = ["AmovPercMstpSrasWpstDnon_AadjPpneMstpSrasWpstDleft","AmovPercMstpSrasWpstDnon_AadjPpneMstpSrasWpstDright"]; // pistol fall animation
tpw_fall_hw_getuparray = ["AadjPpneMstpSrasWpstDleft_AmovPercMstpSrasWpstDnon","AadjPpneMstpSrasWpstDright_AmovPercMstpSrasWpstDnon"]; // pistol get up animations
tpw_fall_nw_fallarray = ["aparpercmstpsnonwnondnon_amovppnemstpsnonwnondnon"]; // unarmed fall animations
tpw_fall_nw_getuparray = ["AmovPpneMstpSrasWnonDnon_AmovPercMstpSnonWnonDnon"]; //unarmed get up animations


tpw_fall_nw_crouch = "AmovPercMstpSnonWnonDnon_AmovPknlMstpSnonWnonDnon"; // anarmed crouch animation
tpw_fall_hw_crouch = "AmovPercMstpSrasWpstDnon_AmovPknlMstpSrasWpstDnon"; // pistol crouch animation
tpw_fall_pw_crouch = "AmovPercMstpSrasWrflDnon_AmovPknlMstpSrasWrflDnon"; // rifle crouch animation
tpw_fall_sw_crouch = "amovpercmstpsraswlnrdnon_amovpknlmstpsraswlnrdnon"; // launcher crouch animation

tpw_fall_nw_uncrouch = "AmovPknlMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon"; // unarmed uncrouch animation
tpw_fall_hw_uncrouch = "AmovPknlMstpSrasWpstDnon_AmovPercMstpSrasWpstDnon"; // pistol; uncrouch animation
tpw_fall_pw_uncrouch = "AmovPknlMstpSrasWrflDnon_AmovPercMstpSrasWrflDnon"; // rifle uncrouch animations
tpw_fall_sw_uncrouch = ""; // launcher uncrouch animations

tpw_fall_hitgetuparray = ["AmovPpneMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon","AmovPpneMstpSrasWpstDnon_AmovPercMstpSrasWpstDnon","AmovPpneMstpSrasWrflDnon_AmovPercMstpSrasWrflDnon","AmovPpneMstpSrasWlnrDnon_AmovPercMstpSrasWlnrDnon"]; // animations for getting up after ragdoll

// ARRAYS OF ANIMATION ARRAYS
tpw_fall_fallarrays = [tpw_fall_nw_fallarray,tpw_fall_hw_fallarray,tpw_fall_pw_fallarray,tpw_fall_sw_fallarray];
tpw_fall_fallcountarrays = [1,2,2,1]; // number of anims for each fallarray (and getuparray)
tpw_fall_getuparrays = [tpw_fall_nw_getuparray,tpw_fall_hw_getuparray,tpw_fall_pw_getuparray,tpw_fall_sw_getuparray];
tpw_fall_croucharray = [tpw_fall_nw_crouch,tpw_fall_hw_crouch,tpw_fall_pw_crouch,tpw_fall_sw_crouch];
tpw_fall_uncroucharray = [tpw_fall_nw_uncrouch,tpw_fall_hw_uncrouch,tpw_fall_pw_uncrouch,tpw_fall_sw_uncrouch];
	
// DELAY
sleep tpw_fall_delay;

/////////
// FUNCS
/////////

// FREEFALL NOISE
tpw_fall_fnc_freefall = 
	{
	if ((getposasl player) select 2 < 10 ) exitwith {};
	
	// Play freefall noise		
	playmusic "freefallwind";
	
	2 fadeMusic 1;
	
	// Wait until slow enough
	waituntil
		{
		sleep 0.2;
		(abs (velocity player select 2) < 5 || !(alive player)) 
		};
	playmusic "chutewind";
	
	// Wait until on ground
	waituntil
		{
		sleep 1;
		((istouchingground player) || !(alive player)) 
		};
	playmusic "";
	2 fadeMusic 0.5;
	};

//HIDE OBJECT
tpw_fall_fnc_hideunit = 
	{
	private ["_unit"];
	_unit = _this select 0;
	_unit hideobject true;
	};

//UNHIDE OBJECT
tpw_fall_fnc_showunit = 
	{
	private ["_unit"];
	_unit = _this select 0;
	_unit hideobject false;
	};

// DETERMINE UNIT'S WEAPON TYPE 
tpw_fall_fnc_weptype =
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
	_unit setvariable ["tpw_weptype",_weptype];
	};

// RAGDOLL FALL
tpw_fall_fnc_ragdoll =
	{
	private ["_body","_unit","_weptype","_getupanim","_pos","_dir","_speed","_desc","_typ","_grp","_eyepos","_ang","_ct","_neckpos","_skill","_stance","_sleep","_getup","_uniform","_vest","_headgear","_goggles"];
	_unit = _this select 0;

	// Add fatigue
	_fatigue = getfatigue _unit;
	_unit setfatigue (_fatigue + 0.5); 
		
	// Pick appropriate get up anim based on weapon type
	_weptype = _unit getvariable "tpw_weptype";
	_getupanim = tpw_fall_hitgetuparray select _weptype;
		
	//Get info about hit unit
	_uniform = uniform _unit;
	_vest = vest _unit;
	_headgear = headgear _unit;
	_goggles = goggles _unit;
	_pos = getposasl _unit; // position
	_dir = direction _unit; // direction	
	_stance = stance _unit; // stance
	_speed = velocity _unit; //speed
	_desc = getdescription _unit; 
	_typ = _desc select 0; // type of unit

	// Create dummy body with same attributes as unit
	_grp = creategroup west;
	_body = _grp createunit [_typ, [0,0,0], [], 0, ""];
	_body setposasl _pos;
	_body setvelocity _speed;
	_body setdir _dir;
	_body addUniform _uniform;
	_body addvest _vest;
	_body addheadgear _headgear;
	_body addgoggles _goggles;
	_body setvariable ["tpw_fall_parentunit",_unit];
	
	if (_stance == "CROUCH") then 
		{
		_body switchmove "amovpknlmstpsraswrfldnon";
		};

	// Hide unit
	_unit enablesimulation false;
	if (isMultiplayer) then 
		{
		[[_unit], "tpw_fall_fnc_hideunit",false] spawn BIS_fnc_MP;
		}
	else
		{
		_unit hideobject true;
		};
	_unit setvelocity [0,0,0];
	
	// Kill dummy so it ragdolls
	_body setdamage 1;
	
	// If ragdoll is hit, pass damage to parent unit 
	_body addeventhandler ["hitpart", 
	{
	private ["_unit"];
	_unit = ((_this select 0) select 0) getvariable "tpw_fall_parentunit";
	_unit setdamage ((damage _unit) * 2);
	}];	
	
	//Wait until dummy's head hits ground (or 2 seconds, whichever comes first)
	_ct = 0;
	waituntil
		{
		_ct = _ct + 1;
		sleep 0.1;
		_neckpos = (_body selectionPosition "Neck") select 2;
		(_neckpos < 0.5) || (_ct > 20);
		};
	
	//Ragdolls always fall on back, replace ragdoll with unit on back
	_unit enablesimulation true;
	_unit switchmove "acts_InjuredLookingRifle01";
	
	// Get direction of dummy on ground, then remove it
	_pos = getposasl _body;
	_eyepos = eyepos _body;
	_ang = ((((_eyepos select 0) - (_pos select 0)) atan2 ((_eyepos select 1) - (_pos select 1))) + 360) % 360;
	_body removeeventhandler ["hitpart",0];
	deletevehicle _body;

	// Show prone unit in roughly same direction as dummy
	_unit disableai "anim"; // prevent unit from moving whilst incapacitated
	_unit setposasl _pos;
	_unit setdir (_ang + 145);
	if (isMultiplayer) then 
		{
		[[_unit], "tpw_fall_fnc_showunit",false] spawn BIS_fnc_MP;
		}
	else
		{
		_unit hideobject false;
		};
	// Lie on ground a while to "recover" (or die)
	_sleep = 10 + (random tpw_fall_falltime);
	if (_sleep > tpw_fall_falltime) then 
		{
		_sleep = tpw_fall_falltime;
		};
	_getup = diag_ticktime + _sleep;
	waitUntil 
		{
		sleep 0.5; 
		((diag_ticktime > _getup) || !(alive _unit));
		};
	
	//Roll over and get back up if alive
	_unit setdir _ang;
	if (alive _unit) then
		{
		_unit enableai "anim";
		_unit switchmove "AinjPpneMstpSnonWnonDnon_rolltofront";
		_unit disableai "anim";
		sleep random 5;
		_unit playmove _getupanim;
		_unit enableai "anim";	
		_unit setunitpos "auto";
	
		//Reset fall status		
		_unit setvariable ["tpw_fallstate", 0];
		}
	else
		{
		_unit switchmove "AinjPpneMstpSnonWrflDnon_rolltofront";
		_unit setvariable ["tpw_bleedout_writhe",0];
		};
	};

// ANIMATED FALL DOWN / GET UP 
tpw_fall_fnc_falldown = 
	{
	private ["_unit","_weptype","_realdist","_fatigue","_yell","_yellsound","_move","_crawl","_crawlsound","_fallarray","_fallanim","_getuparray","_getupanim","_crawl2","_crawlsound2","_skill"];
	_unit = _this select 0;
	_weptype = _unit getvariable "tpw_weptype";
	_realdist = _unit getvariable "tpw_fallstate";
							
	//Reduce skill
	_skill = skill _unit;
	_unit setskill 0.01;
	
	//Yell (eg 2m fall will yell 40% of the time)
	if (random 100 > (_realdist * 20)) then 
		{
		_yell = tpw_fall_yellarray select (floor (random (count tpw_fall_yellarray)));
		_yellsound = format ["a3\sounds_f\characters\human-sfx\person1\%1.wss",_yell];
		playSound3D [_yellsound,_unit,false,getposasl _unit,1,0.85,tpw_fall_att]; 
		};
	
	// Fall to ground animation
	_fallarray = tpw_fall_fallarrays select _weptype;
	_fallcount = tpw_fall_fallcountarrays select _weptype;
	_animselect = floor random _fallcount;
	_fallanim = _fallarray select _animselect;
	_unit switchmove _fallanim;

	// Random falling noise
	sleep 1;
	_crawl = tpw_fall_crawlarray select (floor (random (count tpw_fall_crawlarray)));	
	_crawlsound = format ["A3\sounds_f\characters\crawl\%1.wss",_crawl];
	playSound3D [_crawlsound,_unit,false,getposasl _unit,1,1,tpw_fall_att];

	// Wait if fall was from hit
	if  ((_unit getvariable "tpw_fallstate" == 10) && (_unit == vehicle _unit)) then
		{
		_unit disableai "move";
		sleep 3 + (random (tpw_fall_falltime / 2));
		_unit enableai "move";
		};
	
	// Get back up animation
	_getuparray = tpw_fall_getuparrays select _weptype;
	_getupanim = _getuparray select _animselect;
	_unit playmove _getupanim;
	if (_weptype == 0) then 
		{
	_unit playmove _getupanim; // unarmed crouch won't uncrouch with playmove
		}
		else
		{
	_unit playmove _getupanim;		
		};
		
	// Random get up noise
	sleep 0.5;
	_crawl2 = tpw_fall_crawlarray2 select (floor (random (count tpw_fall_crawlarray2)));
	_crawlsound2 = format ["A3\sounds_f\characters\crawl\%1.wss",_crawl2];
	playSound3D [_crawlsound2,_unit,false,getposasl _unit,1,1,tpw_fall_att]; 
	
	// Add fatigue
	_fatigue = getfatigue _unit;
	_unit setfatigue (_fatigue + (0.1 *_realdist)); 
	
	//Reset fall status	
	_unit setvariable ["tpw_fallstate", 0];		
	_unit setunitpos "auto";
	
	//Restore skill
	_unit setskill _skill;	
	};	

// PLAYER FALL (NO AUTOMATIC GET UP)
tpw_fall_fnc_playerfall = 
	{
	private ["_unit","_weptype","_realdist","_fatigue","_yell","_yellsound","_move","_crawl","_crawlsound","_fallarray","_fallanim"];
	_unit = player;
	_weptype = _unit getvariable "tpw_weptype";
	_realdist = _unit getvariable "tpw_fallstate";

	//Yell (eg 2m fall will yell 40% of the time)
	if (random 100 > (_realdist * 20)) then 
		{
		_yell = tpw_fall_yellarray select (floor (random (count tpw_fall_yellarray)));
		_yellsound = format ["a3\sounds_f\characters\human-sfx\person1\%1.wss",_yell];
		playSound3D [_yellsound,_unit,false,getposasl _unit,1,0.85,tpw_fall_att]; 
		};
	
	// Fall to ground animation
	_fallarray = tpw_fall_fallarrays select _weptype;
	_fallcount = tpw_fall_fallcountarrays select _weptype;
	_animselect = floor random _fallcount;
	_fallanim = _fallarray select _animselect;
	_unit switchmove _fallanim;

	// Random falling noise
	sleep 1;
	_crawl = tpw_fall_crawlarray select (floor (random (count tpw_fall_crawlarray)));	
	_crawlsound = format ["A3\sounds_f\characters\crawl\%1.wss",_crawl];
	playSound3D [_crawlsound,_unit,false,getposasl _unit,1,1,tpw_fall_att];
	
	// Add fatigue
	_fatigue = getfatigue _unit;
	_unit setfatigue (_fatigue + (0.1 *_realdist)); 
	
	//Reset fall status	
	_unit setvariable ["tpw_fallstate", 0];		
	};	
	
// CROUCH / UNCROUCH
tpw_fall_fnc_crouch = 
	{
	private ["_unit","_realdist","_weptype","_crouchanim","_uncrouchanim","_skill"];
	_unit = _this select 0;
	_weptype = _unit getvariable "tpw_weptype";
	_realdist = _unit getvariable "tpw_fallstate";
	
	//Reduce skill
	_skill = skill _unit;
	_unit setskill 0.01;
	
	// Crouch
	_crouchanim = tpw_fall_croucharray select _weptype;
	_unit playmove _crouchanim;
	
	// Uncrouch
	_uncrouchanim = tpw_fall_uncroucharray select _weptype;	
	if (_weptype == 0) then 
		{
	_unit switchmove _uncrouchanim; // unarmed crouch won't uncrouch with playmove
		}
		else
		{
	_unit playmove _uncrouchanim;		
		};
	// Add fatigue
	_fatigue = getfatigue _unit;
	_unit setfatigue (_fatigue + (0.1 *_realdist)); 
	
	//Reset fall status	
	_unit setvariable ["tpw_fallstate", 0];	
	_unit setunitpos "auto";

	//Restore skill
	_unit setskill _skill;		
	};	

// PROCESS FALL - DETERMINE STATUS BASED ON DISTANCE, WEAPON, WEIGHT, FATIGUE ETC	
tpw_fall_fnc_fallproc =
	{
	private ["_unit","_realdist","_posx","_posy","_weptype","_fatigue","_dist","_zstart","_zstop","_vol","_step","_stepsound","_splash","_splashsound","_weight","_margin","_paraflag"];
	_unit = _this select 0;
	_unit setvariable ["tpw_fallstate",0.1]; //will stop a fall being retriggered on unit until the current fall is complete

	if (_unit == player) then 
		{
		[_unit] spawn tpw_fall_fnc_freefall; // freefall noise
		};

	//Calculate vertical distance traveled when unit touches ground again. 
	_zstart = (getposasl _unit) select 2;
	_zstop = 0;
	_paraflag = 0;
	waituntil
		{
		_zstop = (getposasl _unit) select 2;
		if (vehicle _unit iskindof "ParachuteBase") then // has unit deployed chute?
			{
			_paraflag = 1;
			};	
		sleep tpw_fall_int;
		((istouchingground _unit)||(_zstop < 0)); // unit touching ground or below sea (water) level
		};	
	_realdist = abs(_zstart - _zstop);

	if (_paraflag == 1) then 
		{
		_realdist = 1;
		};
		
	//Fatigue will add an extra distance to the fall, so tired units are more likely to fall
	_fatigue = getfatigue _unit;
	_realdist =  _realdist + _fatigue;
	
	//Weight will add extra distance to the fall, so heavier units are more likely to fall
	_weight = (load _unit);
	_realdist =  _realdist + _weight;

	// Randomise the distance by +/- 10%	
	_margin = _realdist / 10;
	_realdist = _realdist - _margin + (random (2 * _margin));
	
	// Treat all falls past 2m as the same, apply sensitivity
	 _realdist =_realdist * (tpw_fall_sens / 100);
	_dist = floor _realdist;
	if (_dist > 2) then
		{
		_dist = 2;
		};

	// Unit in water? 	
	_posx = (getpos _unit) select 0;
	_posy = (getpos _unit) select 1;
	if (((surfaceiswater [_posx,_posy])) && (_zstart > 0)) then 		
		{
		_dist = 5;
		}; 
		
	// Weapon type
	0 = [_unit] call tpw_fall_fnc_weptype;
	_unit setvariable ["tpw_fallstate",_realdist];
	
	// Footstep sounds for landing
	if !(surfaceiswater [_posx,_posy]) then
		{
		_vol = (_realdist * 0.5); // longer fall = louder volume
		_step = tpw_fall_steparray select (floor (random (count tpw_fall_steparray)));
		_stepsound = format ["A3\sounds_f\characters\footsteps\%1.wss",_step];
		playSound3D [_stepsound,_unit,false,getposasl _unit,_vol,0.7,tpw_fall_att]; // initial thump of feet	
		};
 
	// Play appropriate animations and noises for different heights and weapons
	switch _dist do
		{
		case 1: 
			{
			0 = [_unit] call tpw_fall_fnc_crouch;
			};
		case 2: 
			{
			if (_unit == player) then 
				{
				0 = [_unit] call tpw_fall_fnc_playerfall;
				}
				else
				{
				0 = [_unit] call tpw_fall_fnc_falldown;
				};
			};
		case 5:
			{
			// Random splashing noise
			_vol = _realdist; // higher jump = louder splash
			_splash = tpw_fall_splasharray select (floor (random (count tpw_fall_splasharray))); 
			_splashsound = format ["A3\sounds_f\characters\footsteps\%1.wss",_splash];
			playSound3D [_splashsound,_unit,false,getposasl _unit,_vol,0.3,tpw_fall_att]; 
			};
		};
	};	
	
// PROCESS HIT
tpw_fall_fnc_hitproc = 
	{
	private ["_unit","_yell","_yellsound","_skill","_damage"];
	_unit = _this select 0;
	
	if (_unit == vehicle _unit) then 
		{
		_damage = _this select 2;
		
		// Only bother if unit is not already falling
		if (_unit getvariable "tpw_fallstate" == 0) then 
			{
			_unit setvariable ["tpw_fallstate", 10];
						
			//Yell
			_yell = tpw_fall_yellarray select (floor (random (count tpw_fall_yellarray)));
			_yellsound = format ["a3\sounds_f\characters\human-sfx\person1\%1.wss",_yell];
			playSound3D [_yellsound,_unit,false,getposasl _unit,1,0.85,tpw_fall_att]; 
			
			//Check whether unit not prone
			if (stance _unit != "PRONE") then 
				{
				if (alive _unit) then 
					{
					// Weapon type
					[_unit] call tpw_fall_fnc_weptype;
					
					//Play appropriate animations 
					if (_unit == player) then 
						{
						[] spawn tpw_fall_fnc_playerfall; // no ragdoll for player
						}
						else
						{
						if (_damage < 0.1) then
							{
							[_unit] spawn tpw_fall_fnc_falldown; // no ragdoll for low damage hits
							}
							else
							{
							if (tpw_fall_ragdoll == 1) then
								{
								_falltype = [tpw_fall_fnc_ragdoll,tpw_fall_fnc_falldown] select (floor random 2); // 50% chance of ragdoll
								[_unit] spawn _falltype;
								}
								else
								{
								[_unit] spawn tpw_fall_fnc_falldown; //no ragdoll
								};
							};
						};
					
					// Civilians crawl
					if ((side _unit) == civilian) then 
						{
						_unit setunitposweak "DOWN";
						};	
					};
				};
			};
		};		
	};
	
////////////
// RUN IT
////////////

// ADD ROLLING SOUNDS
player addeventhandler ["animstatechanged",
{
_anim = _this select 1;
if ( // Rolling animations
_anim == "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl" || 
_anim == "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr" || 
_anim == "AmovPpneMstpSrasWpstDnon_AmovPpneMevaSlowWpstDr" || 
_anim == "AmovPpneMstpSrasWpstDnon_AmovPpneMevaSlowWpstDl" ||
_anim == "AmovPpneMstpSnonWnonDnon_AmovPpneMevaSnonWnonDl" ||
_anim == "AmovPpneMstpSnonWnonDnon_AmovPpneMevaSnonWnonDr" ||
_anim == "AmovPpneMstpSrasWrflDnon_Turnr" ||
_anim == "AmovPpneMstpSrasWrflDnon_Turnl" ||
_anim == "AmovPpneMstpSrasWpstDnon_Turnr" ||
_anim == "AmovPpneMstpSrasWpstDnon_Turnl"
) then 
	{
	_sound = format ["A3\sounds_f\characters\crawl\crawl_dirt_%1.wss",ceil random 7];
	playSound3D [_sound,player,false,getposasl player,0.5,1,25];
	};
}];

// PERIODICALLY SCAN APPROPRIATE UNITS INTO ARRAY OF "FALLABLE" UNITS
[] spawn 
	{
	while {true} do
		{
		tpw_fallunits = [];
			{
			if (((_x distance player) < tpw_fall_thresh) && (_x == vehicle _x)) then 
				{
				//Make AI switchweapon otherwise currentweapon returns ""  
				/*
				if ((_x getvariable ["tpw_wepswitch", 0]) == 0) then
					{
					_x action ["SwitchWeapon",_x,_x,0];
					_x setvariable ["tpw_wepswitch", 1]
					};
				*/	
				if (isNil {_x getvariable "tpw_fallstate"}) then 
					{
					_x setvariable ["tpw_fallstate",0];
					_x addeventhandler ["hit",{_this call tpw_fall_fnc_hitproc}];
					};
				tpw_fallunits set [count tpw_fallunits,_x];
				};
			} foreach allunits;
		sleep 5;
		};
	};	

// MAIN FALL MONITORING LOOP - DETERMINE IF A UNIT HAS LEFT THE GROUND (IE BEGUN TO FALL)
while {true} do
	{
	private ["_i","_unit"];
	for "_i" from 0 to (count tpw_fallunits - 1) do
		{
		_unit = tpw_fallunits select _i;
		//Only bother if footbound unit not already falling
		if (_unit getvariable "tpw_fallstate" == 0) then 
			{
			// Is unit in air from a fall?
			if (!istouchingground _unit) then 
				{
				[_unit] spawn tpw_fall_fnc_fallproc;
				};
			};
		};
	sleep tpw_fall_int;
	};	
	
// PERIODICALLY RESET ALL UNITS FALL STATUS TO PREVENT THINGS GETTING STUCK
while {true} do
	{
	private ["_i","_unit"];
	for "_i" from 0 to (count tpw_fallunits - 1) do
		{
		_unit = tpw_fallunits select _i;
		_unit setvariable ["tpw_fallstate",0];
		};
	sleep random 60;
	};	
	
