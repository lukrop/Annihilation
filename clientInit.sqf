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
  ani_vasbox addAction ["<t color='#11ff11'>Take AN/PRC-152</t>", "fnc\addPRC152.sqf"];
  ani_vasbox addAction ["<t color='#11ff11'>Take AN/PRC-148</t>", "fnc\addPRC148.sqf"];
};

// Viewdistance script
[] execVM "taw_vd\init.sqf";

if(ani_suppression == 2) then {
  // bullet threshold , delay to start, debug, max dist, player sup, ai sup, ai seek cover
  [5,5,0,700,0,1,1] execVM "scripts\tpw_ebs.sqf";
};

if(ani_tpw_fall == 1) then {
  [100,700,10,1,30] execVM "scripts\tpw_fall.sqf";
};
