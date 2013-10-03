//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: (AEF)Wolffy.au [2CAV]
// Created: 20090719
// Contact: http://creobellum.org
// Purpose: Teleport group to map click loc
//////////////////////////////////////////////////////////////////
/////call{player execVM "Teleport.sqf";};////


if(isServer && !(local player)) exitWith{};
titleText ["Click on map to teleport your group", "PLAIN"];
player onMapSingleClick "{_x setPos _pos;} forEach units _this;";
