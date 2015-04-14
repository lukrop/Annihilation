/*
    File: fn_initMHQ.sqf
    Author: lukrop

    License: see LICENSE.txt
    Description:
        Adds the VAS to the mobile respawn vehicle and
        sets the global variable for lkr_mhq

    Parameter(s):
        0: OBJECT:
            the vehicle

    Returns:
    -
*/

//[_this, 0, objNull, [objNull]] call BIS_fnc_param;

lkr_mhq = _this;

if(param_btc_mobile_respawn_vas == 1) then {
    lkr_mhq addAction["<t color='#ff1111'>Virtual Ammobox</t>", "VAS\open.sqf"];
};
