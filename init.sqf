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

lkr_hc_present = if(isNil "hc1") then {false} else {true};


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
