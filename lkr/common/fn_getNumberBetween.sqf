/*
	File: fn_getNumberBetween.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Returns a number between a given min and max value.

	Parameter(s):
		0: SCALAR
			Min value
		1: SCALAR
			Max value
	Returns:
		SCALAR
			Number between min and max
*/

_min = [_this, 0, 1, [0]] call BIS_fnc_param;
_max = [_this, 1, 1, [0]] call BIS_fnc_param;

_val = _min max (round (random _max));
_val
