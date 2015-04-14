/*
	File: init.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Executed when mission is started (before briefing screen)

	Parameter(s):
	-

	Returns:
	-
*/

// disable saving
enableSaving [false, false];

// if using Task Force Radio, don't add a long range radio automatically
tf_no_auto_long_range_radio = true;
// if using Task Force Radio, set all short range radios to the same frequency for each side
tf_same_sw_frequencies_for_side = true;

// compile shk_pos
call compile preprocessFileLineNumbers "SHK_pos\shk_pos_init.sqf";

// wait until the config is loaded and the paramters are initialized
waitUntil {!isNil "lkr_config_loaded"};

// setup random roadside IEDs
if(param_ied == 1) then {
  call compile preprocessFileLineNumbers "EPD\Ied_Init.sqf";
};

/*
// init =BTC= revive
if(param_revive == 1) then {
	// init revive
	call compile preprocessFileLineNumbers "=BTC=_revive\=BTC=_revive_init.sqf";

	// set revive lifes
	if(param_btc_revive_lifes == 0) then {
		// disable the life counter
		BTC_active_lifes = 0;
	} else {
		// set the amount of lifes
		BTC_lifes = param_btc_revive_lifes;
	};

	// setup the mobile respawn vehicle
	BTC_active_mobile = param_btc_mobile_respawn;
	if(param_btc_mobile_respawn == 1) then {
		// spawn the mobile respawn vehicle
		if(isServer) then {
			lkr_mhq = lkr_mhq_vehicle_C createVehicle (getMarkerPos "lkr_mhq_spawn");
			// init the mhq
			lkr_mhq call lkr_fnc_initMHQ;
			// enable vehicle respawn, 120 minutes abandoned delay, 1 minute destroyed delay
			[lkr_mhq, 120, 1, {call lkr_fnc_initMHQ}] call lkr_fnc_ICE_vehRespawn;
		};
	};
	// setup the flag to allow teleport to mhq
	BTC_objects_actions_west = [lkr_flag];
	// set the mhq vec as mobile respawn
	BTC_vehs_mobile_west = [lkr_mhq];
};

// init FAR revive
if(param_revive == 2) then {
	call compileFinal preprocessFileLineNumbers "FAR_revive\FAR_revive_init.sqf";
};
*/
