

private ["_units","_string","_side","_delay","_unitinfo","_faction","_infgrp","_vehgrp","_armgrp","_airgrp","_vehicles","_Leaderunits","_task","_temparray","_spawnname","_position","_debug","_Infskill","_Vehskill","_Airskill","_armor","_helo","_plane","_inf","_veh","_arm","_air","_boat"];
if (!isServer) exitwith {}; 
waituntil {scriptdone SLP_init};

_spawnname = _this select 0;
_unitinfo = _this select 1;
    _side = _unitinfo select 0;
    _faction = _unitinfo select 1;
	_delay = if (count _unitinfo >= 3) then {_unitinfo select 2}  else {10};
_position = _this select 2;
_infgrp = _this select 3;
        _inf = if (count _infgrp >= 1) then {true} else {false};
_vehgrp =  _this select 4;
		_veh =   if (count _vehgrp >= 1) then {true} else {false};	
_armgrp = _this select 5;
        _arm = if (count _armgrp >= 1) then {true} else {false};
_airgrp = _this select 6;
		_air = if (count _airgrp >= 1) then {true} else {false};	
_task =  _this select 7;
_debug = SLP_ARRAY select 0;

if (count _this < 8) exitwith {hintc format [ "Error spawnname %1: A SLP script call does not have enough elements\n\nit should have at least 8 elements \n\n0 =[""spawnname"",[Side,Faction],[spawn position],[units],[veh],[tank],[air],[task]] spawn SLP_Spawn\n\nScript call aborted", _spawnname]};
  
if (typename _spawnname !=  "STRING" ) exitwith {hintc format [ "Error: The SLP spawn name in the a script call is either missing or not in """"\n\nScript call aborted"]};    

switch (_side) do 
	{
        case 0: { _side = east};
        case 1: { _side = west};
        case 2: { _side = resistance};
        case 3: { _side = civilian};    
        default {  if(true) exitwith {hintc format [ "Error spawnname %1:\n\n side is not valid number\nScript call aborted", _spawnname]}};
	};

///////setskill for spawned units
_infskill = if (typename (SLP_ARRAY select 1) == "ARRAY" ) then {(SLP_ARRAY select 1) call SLP_fnc_randomnum} else {SLP_ARRAY select 1};
_Vehskill = if (typename (SLP_ARRAY select 2) == "ARRAY" ) then {(SLP_ARRAY select 2) call SLP_fnc_randomnum} else {SLP_ARRAY select 2};
_Airskill = if (typename (SLP_ARRAY select 3) == "ARRAY" ) then {(SLP_ARRAY select 3) call SLP_fnc_randomnum} else {SLP_ARRAY select 3};

_temparray=[_faction,_spawnname] call SLP_units;
	_Leaderunits = _temparray select 0;
	_units = _temparray select 1;
	_vehicles = _temparray select 2;
	_armor = _temparray select 3;
	_helo =  _temparray select 4;
	_plane = _temparray select 5;
	_boat = _temparray select 6;

///////////////////////////////////////////////          START OF INFANTRY SPAWN          ///////////////////////////////////////////////////////////
if (_inf) then {
    if (count _units >=1 and count _Leaderunits >=1) then {
	[_spawnname,_side,_delay,_position,_temparray,_infskill,_infgrp,_task] spawn SLP_fnc_Infantry;
	} else {
		if (_debug==1) then {          
             hint  format [ "Error: spawnname %1\n\n  _units or _leaderunits array in units_config is empty", _spawnname];            
		};
	};
};
sleep 1;
///////////////////////////////////          START OF VEHICLE SPAWN          //////////////////////////////////
if (_veh) then {
    if ( count _vehicles >=1) then {
  	[_spawnname,_side,_delay,_position,_temparray,_infskill,_vehskill,_vehgrp,_task,0] spawn SLP_fnc_vehicle;
	} else {
		if (_debug==1) then {
              hint  format [ "Error: spawnname %1\n\n  _vehicle array in units_config is empty", _spawnname];         
		};
	};
};
sleep 1;
/////////////////////////////////                  START OF ARMOR SPAWN            ///////////////////////////////////
if (_arm) then {
    if ( count _armor >=1) then {
  	[_spawnname,_side,_delay,_position,_temparray,_infskill,_vehskill,_armgrp,_task,1] spawn SLP_fnc_vehicle;
	} else {
		if (_debug==1) then {      
			hint  format [ "Error: spawnname %1\n\n  _armor array in units_config is empty", _spawnname];             
		};
	};
};
sleep 1;
 ///////////////////
 if (_air) then {
	if ( count _helo >=1 || count _plane >= 1 || count _boat >= 1) then {
	[_spawnname,_side,_delay,_position,_temparray,_airskill,_airgrp,_task] spawn SLP_fnc_air;
	} else {
		if (_debug==1) then {
             hint  format [ "Error: spawnname %1\n\n  _Helo,_plane,or _boat arrays in SLP_units_config are empty", _spawnname]; 			
		};
	};
};




             

    


	




