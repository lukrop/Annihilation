/*
	Author: lukrop
	Date: 10/12/2013
  Description: Changes marker alpha, color and type(icon)

	Parameters:
        STRING: marker name
        NUMBER: 0 - 1 alpha of the marker
        STRING (OPTIONAL): CfgColors color to which the marker should be changed
        STRING (OPTIONAL): CfgMarkers marker icon
        STRING (OPTIONAL): Text to appear alongside the marker

	Returns: -

*/

private ["_marker", "_alpha", "_color", "_type", "_text"];

_marker = _this select 0;
_alpha = _this select 1;
if(count _this > 2) then {_color = _this select 2;} else {_color = markerColor _marker;};
if(count _this > 3) then {_type = _this select 3;} else {_type = markerType _marker};
if(count _this > 4) then {_text = _this select 4;} else {_text = markerText _marker};

_marker setMarkerAlpha _alpha;
_marker setMarkerColor _color;
_marker setMarkerType _type;
_marker setMarkerText _text;
