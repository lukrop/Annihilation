/*
	File: fn_hideMarkers.sqf
	Author: lukrop

	License: see LICENSE.txt
	Description:
		Sets marker alpha to zero for all markers that
		are not needed.
		Automatically run postInit.

	Parameter(s):
	-
	Returns:
	-
*/

{_x setMarkerAlpha 0} forEach [
	"city0", "city1", "city2", "city3", "city4", "city5", "city6", "city7", "city8", "city9",
	"land0", "land1", "land2", "land3", "land4", "land5", "land6", "land7", "land8", "land9", "land10", "land11", "land12", "land13", "land14", "land15",
	"enemy_op", "enemy_op_1", "enemy_op_2"
];
