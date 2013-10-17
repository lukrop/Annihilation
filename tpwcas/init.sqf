//////////////////////////////////////////////////////////////////
// TPWCAS v4.5 init startup
//////////////////////////////////////////////////////////////////

// HEADLESS CLIENT CHECK - code by Glowbal
tpwcas_isHC = false;
if ( !isServer ) then 
{
	_hc = ppEffectCreate ["filmGrain", 2005];
	if (_hc == -1) then 
	{
		tpwcas_isHC = true;
	}
	else
	{
		ppEffectDestroy _hc;
	};
};

if !(isNil "tpwcas_mode") then // tpwcas_mode set by logic module or by global pubvar
{
	diag_log format ["%1 pre-init defined twpcas mode: 'tpwcas_mode = %2'", time, tpwcas_mode];
};

// SinglePlayer Mode (tpwcas_mode 1)
if ( (isServer) && !(isMultiPlayer) && (isNil "tpwcas_mode")) then 
{ 
	// check for forced disabled tpwcas for Single Player or (hosted or dedicated) Multi Player Server (tpwcas_mode 0)
	_temp_tpwcas_mode = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_mode");
	if ( ( _temp_tpwcas_mode == 0 ) || ( _temp_tpwcas_mode == 5 ) ) exitWith 
	{
		tpwcas_mode = 0;
		diag_log format ["%1 disabled tpwcas by userconfig file: tpwcas_mode = %2", time, tpwcas_mode];
	};

	//else
	tpwcas_mode = 1; 
	diag_log format ["%1 twpcas mode init check: tpwcas_mode = %2 - Server: [%3] - MP: [%4] - tpwcas_isHC: [%5] - isNil tpwcas_mode: [%6]", time, tpwcas_mode, isServer, isMultiPlayer, tpwcas_isHC, isNil "tpwcas_mode"];
};

// Force SinglePlayer Mode (tpwcas_mode 1) if not set above
if ( (isServer) && !(isMultiPlayer) ) then 
{
	tpwcas_mode = 1;
	diag_log format ["%1 twpcas mode init check: tpwcas_mode = %2 - Server: [%3] - MP: [%4] - tpwcas_isHC: [%5] - isNil tpwcas_mode: [%6]", time, tpwcas_mode, isServer, isMultiPlayer, tpwcas_isHC, isNil "tpwcas_mode"];
};



// Multi Player Client Mode (tpwcas_mode 0, 2, or 3)
if ( !(isServer) && !(tpwcas_isHC) && isMultiPlayer ) then 
{	
	if ( isNil "tpwcas_mode" ) then 
	{
		diag_log format ["%1 waiting for twpcas client mode variable set by server", time];
		0 = [] spawn // set parameter to close tpwcas if no server variable received within 4 minutes
			{ 
				sleep 240;
				if (isNil "tpwcas_mode") then 
				{
					tpwcas_mode = 0;
				}; 	
			};
		waitUntil { sleep 3;!(isNil "tpwcas_mode") };
		diag_log format ["%1 twpcas client mode set to tpwcas_mode: [%2]", time, tpwcas_mode];
	};

	if ( tpwcas_mode == 2 ) then // set by global pub var
	{
		diag_log format ["%1 enabled tpwcas client mode: tpwcas_mode = %2", time, tpwcas_mode];
	}
	else //unknown value or value = 3 - disable tpwcas
	{
		diag_log format ["%1 disable tpwcas client mode: detected value for tpwcas_mode = %2", time, tpwcas_mode];
		tpwcas_mode = 0;
	};
};

// Multi Player Server or HC Mode (tpwcas_mode 2 or 3)
if ( ( ( isServer || tpwcas_isHC ) ) && ( isMultiPlayer ) ) then 
{  
	diag_log format ["%1 tpwcas_mode = %2 - Server: [%3] - MP: [%4] - config: [%5] - isNil: [%6]", time, tpwcas_mode, isServer, isMultiPlayer, getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_mode"), isNil "tpwcas_mode"];
		
	if ( isNil "tpwcas_mode" ) then // read tpwcas_mode value from userconfig file
	{
		tpwcas_mode = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_mode");	
	};
	
	if ( !((tpwcas_mode == 2) || (tpwcas_mode == 3) || (tpwcas_mode == 0) || (tpwcas_mode == 5)) ) then 
	{
		diag_log format ["%1 forcing tpwcas to value [3]: determined tpwcas_mode value: [%2]", time, tpwcas_mode];
		tpwcas_mode = 3; 
	}; 
	
	if ( tpwcas_mode == 5 ) then // => DEPRECATED
	{
		tpwcas_mode = 0;
		diag_log format ["%1 disabled tpwcas by userconfig file: tpwcas_mode = %2", time, tpwcas_mode];
	};
};

//////////////////////////////////////////////////////////////////////////
// Read TPWCAS Parameters from userconfig file
if ( isServer ) then 
{
	tpwcas_hint = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_hint");
	tpwcas_sleep = getnumber(configfile>> "tpwcas_key_setting" >> "tpwcas_sleep");
		
	tpwcas_ir = getnumber(configfile>> "tpwcas_key_setting" >> "tpwcas_ir");
	tpwcas_maxdist = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_maxdist");
	tpwcas_bulletlife = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_bulletlife");
	tpwcas_st = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_st");
	tpwcas_mags = getarray(configfile>> "tpwcas_key_setting"  >> "tpwcas_mags");

	tpwcas_skillsup = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_skillsup");
	tpwcas_minskill = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_minskill");
	tpwcas_reveal = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_reveal");
	tpwcas_canflee = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_canflee");

	
	tpwcas_los_maxdist = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_los_maxdist");
	tpwcas_los_mindist = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_los_mindist");
	tpwcas_los_minfps = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_los_minfps");
	tpwcas_los_knowsabout = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_los_knowsabout");

	tpwcas_coverdist = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_coverdist");
	tpwcas_getcover_minfps = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_getcover_minfps");
	
	tpwcas_playershake = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_playershake");
	tpwcas_playervis = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_playervis");
	//tpwcas_textdebug = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_textdebug"); => DEPRECATED
	
	// if not set using logic read from userconfig file
	if (isNil "tpwcas_debug") then { tpwcas_debug = getnumber(configfile>> "tpwcas_key_setting" >> "tpwcas_debug"); };
	if (isNil "tpwcas_getcover") then { tpwcas_getcover = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_getcover"); };
	if (isNil "tpwcas_los_enable") then { tpwcas_los_enable = getnumber(configfile>> "tpwcas_key_setting"  >> "tpwcas_los_enable"); };
};

if ( !(tpwcas_mode == 0) ) then  
{
	nul = [] execvm "tpwcas\tpwcas_init.sqf";
};
