/*
	File: fn_loadConfig.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Loads the config.sqf at the
		preInit stage.

	Parameter(s):
	-

	Returns:
	-
*/

objNull spawn {
	_handle = [] execVM "config.sqf";
	waitUntil {scriptDone _handle;};
	// notify that the config is loaded
	lkr_config_loaded = true;
};
