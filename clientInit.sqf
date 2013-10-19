/*
	Author: lukrop
	Date: 10/1/2013
  Description: Player init. Only executed on clients (or/and a *listen* server).
  NOT executed on a dedicated server.

	Parameters: -

	Returns: -

*/

if(isDedicated) exitWith{};

if(ani_recruit == 1) then {
  // add recruiting action
  ani_recruit_vec addAction ["<t color='#11ffff'>Recruit units</t>", "ani_recruit\openDialog.sqf"];
};

if(ani_acre == 1) then {
  ani_box addAction ["<t color='#11ff11'>Take AN/PRC-152</t>", "fnc\addPRC152.sqf"];
  ani_box addAction ["<t color='#11ff11'>Take AN/PRC-148</t>", "fnc\addPRC148.sqf"];
};

// Viewdistance script
[] execVM "taw_vd\init.sqf";

