/*
	File: fn_changeMarker.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Changes marker alpha and optionally color, type and text.

	Parameter(s):
		0: STRING
			Marker name
		1: SCALAR
			Alpha (between 0 and 1)
		2: STRING
			Color from CfgColors
		3: STRING
			Marker type from CfgMarkers
		4: STRING
			Marker text

	Returns:
	-
*/

private ["_marker", "_alpha", "_color", "_type", "_text"];

_marker = [_this, 0, "", [""]] call BIS_fnc_param;
_alpha = [_this, 1, 1, [0]] call BIS_fnc_param;
_color = [_this, 2, (markerColor _marker), [""]] call BIS_fnc_param;
_type = [_this, 3, (markerType _marker), [""]] call BIS_fnc_param;
_text = [_this, 4, (markerText _marker), [""]] call BIS_fnc_param;

_marker setMarkerAlpha _alpha;
_marker setMarkerColor _color;
_marker setMarkerType _type;
_marker setMarkerText _text;