/*
	Author: lukrop
	Date: 10/17/2013
  Description: returns a array of all players who are group leaders

	Parameters: -

	Returns: array of all players who are group leaders

*/

_players = call CBA_fnc_players;

{
	if(_x != leader group _x) then {_players = _players - [_x]};
} forEach _players;

_players