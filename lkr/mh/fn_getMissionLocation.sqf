/*
	File: fn_mhGetMissionLocation.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Returns a array of marker names for the given
		location type.

	Parameter(s):
		0: STRING
			location type: "city", "land" or "all"
	Returns:
		ARRAY
			containing markers for the selected location
*/
private ["_posArray", "_locationType"];

_locationType = [_this, 0, "all", [""]] call BIS_fnc_param;

// choose randomly between city or land
if(_locationType == "all") then {
	if(random 1 <= 0.5) then {
		_locationType = "city";
	} else {
		_locationType = "land";
	};
};

switch (_locationType) do {
	// city mission
	case "city": {
		// select a random entry (positions)
		_index = round (random ((count lkr_city_markers) - 1));
		_posArray = lkr_city_markers select _index;
		// remove location from possible future missions
		lkr_city_markers set [_index, -1];
		lkr_city_markers = lkr_city_markers - [-1];
	};
	// land mission
	case "land": {
		_index = round (random ((count lkr_land_markers) - 1));
		_posArray = lkr_land_markers select _index;
		lkr_land_markers set [_index, -1];
		lkr_land_markers = lkr_land_markers - [-1];
	};
};

_posArray
