/*
	Author: lukrop
	Date: 10/8/2013
  Description: Spawns random patrols in the ambient_patrolx markers.

	Parameters: -

	Returns: -

*/
if(!isServer) exitWith {};

waitUntil{!isNil "lkr_config_loaded"};

waitUntil {sleep 0.5; time > 20};
{
    if((random 1) < 0.6) then {
        if(lkr_hc_present && isMultiplayer) then {
            _param = [getMarkerPos _x, [4,6], ["patrol", getMarkerPos _x, 1000]];
            [_param, "lkr_fnc_spawnEnemyGroup", lkr_hc_id, false, true] call BIS_fnc_MP;
        } else {
            [getMarkerPos _x, [4,6], ["patrol", getMarkerPos _x, 1000]] call lkr_fnc_spawnEnemyGroup;
        };
    };
    sleep 5;
    if((random 1) < 0.5) then {
        if(lkr_hc_present && isMultiplayer) then {
            _param = [getMarkerPos _x, [4,6], ["patrol", getMarkerPos _x, 1000]];
            [_param, "lkr_fnc_spawnEnemyGroup", lkr_hc_id, false, true] call BIS_fnc_MP;
        } else {
            [getMarkerPos _x, ["patrol", getMarkerPos _x, 1000]] call lkr_fnc_spawnEnemyArmor;
        };
    };
    sleep 5;
} forEach ["ambient_patrol", "ambient_patrol_1", "ambient_patrol_2", "ambient_patrol_3", "ambient_patrol_4", "ambient_patrol", "ambient_patrol_1", "ambient_patrol_2", "ambient_patrol_3", "ambient_patrol_4"];
