/*
Spawning functions for units and vehicles

*/

///////////////////////////////////Infantry////////////////////////////////////////
SLP_fnc_Infantry = {
  private ["_infgrp_num","_infgrp_size","_newunit","_unit","_spawnname","_grp","_newunits","_leaderunit","_lunit","_side","_delay","_randompos","_infgrp","_temparray","_Leaderunits","_units","_task","_position","_infskill"];

  _spawnname = _this select 0;  
  _side = _this select 1;
  _delay =  _this select 2;
  _position = _this select 3;
  _temparray = _this select 4;
  _leaderunits = _temparray select 0;
  _units =  _temparray select 1;
  _infskill = _this select 5;
  _infgrp = _this select 6;
  _infgrp_num = if (typename (_infgrp select 0) == "ARRAY") then {(_infgrp select 0)  call SLP_fnc_randomnum} else {_infgrp select 0};
  _task =  _this select 7;


  if (_infgrp_num == -1) then {
    if ( typename (SLP_ARRAY select 4) == "ARRAY") then {_infgrp_num = (SLP_ARRAY select 4) call SLP_fnc_randomnum} else {_infgrp_num = SLP_ARRAY select 4};
  };

  for "_n" from 1 to _infgrp_num do {
    _infgrp_size = nil;
    _grp = nil;
    _randompos = [_position] call SLP_fnc_randompos;

    _infgrp_size =  if (count _infgrp >= 2) then {
      if ( typename (_infgrp select 1) == "ARRAY") then {(_infgrp select 1) call SLP_fnc_randomnum} else {_infgrp select 1};
    } else {4 + floor (random 4)};

    if (_infgrp_size == -1) then {
      if (typename (SLP_ARRAY select 5) == "ARRAY" ) then {_infgrp_size = (SLP_ARRAY select 5) call SLP_fnc_randomnum} else {_infgrp_size = SLP_ARRAY select 5};
    };

    _grp = createGroup _side;	       
    _newunits =  _units - [_units select 0, _units select 1];
    _leaderunit = _Leaderunits call BIS_fnc_selectRandom;
    _lunit = _grp createunit [ _leaderunit , _randompos, [], 0, "None"]; 
    waituntil {!isnull _lunit};
    _lunit addEventHandler ["killed", {(_this select 0) spawn SLP_fnc_unitkilled;}];
    [_Lunit] join _grp;
    _lunit setRank "SERGEANT";
    _lunit setskill _infskill + .1;
    //		_skill = skill _lunit;
    //		hint format  ["SKill is %1",_skill];
    for "_s" from 2 to _infgrp_size do {	
      _newunit = _newunits call BIS_fnc_selectRandom;
      _unit = (group _Lunit) createunit [  _newunit , _randompos, [], 0, "None"]; 
      waituntil {!isnull _unit};
      _unit addEventHandler ["killed", {(_this select 0) spawn SLP_fnc_unitkilled;}];
      _unit setskill _infskill;	
    }; 
    SLP_Instances = SLP_Instances + 1;

    [_spawnname,_position,_grp,_task] spawn SLP_task;
    
    if (typename _delay == "BOOL" ) then {
      if (!_delay) then  { _infgrp_num = 0};
      waituntil {{alive _x} count units _grp <= 0};
    } else {
      sleep _delay; 
    };	
  };
};
//////////////////////////////////////Vehicles///////////////////////////////////////////////////////////

SLP_fnc_Vehicle ={        
  private ["_Infskill","_newunit","_unit","_spawnname","_grp","_newunits","_side","_delay","_randompos","_temparray","_units","_task","_string","_position","_vehgrp_size","_fillslots","_cpos","_vehicle","_veh","_vehgrp_num","_vehicles","_vehskill","_vehgrp","_vehgrp_inf","_crew","_fillcargo","_SLP_array","_int"];

  _spawnname = _this select 0;  
  _side = _this select 1;
  _delay =  _this select 2;
  _position = _this select 3;
  _temparray = _this select 4;
  _units =  _temparray select 1;
  //      _vehicles = _temparray select 2;
  //      _armor = _temparray select 3;
  _infskill = _this select 5;
  _vehskill = _this select 6;
  _vehgrp = _this select 7;
  _vehgrp_num = if (typename (_vehgrp select 0) == "ARRAY") then {(_vehgrp select 0) call SLP_fnc_randomnum} else {_vehgrp select 0};
  _vehgrp_inf = if (count _vehgrp >= 3) then {_vehgrp select 2} else {false};	
  _task =  _this select 8;
  _int = _this select 9;
  _fillcargo = SLP_ARRAY select 13;  


  if (_int == 0) then {
    _vehicles =_temparray select 2; 
    _crew= _units select 2;
    _SLP_array = SLP_ARRAY select 7;
  } else {
    _vehicles =_temparray select 3; 
    _crew= _units select 1;
    _SLP_array = SLP_ARRAY select 9;
  };


  if (_vehgrp_num == -1) then {
    if ( typename _SLP_ARRAY  == "ARRAY") then {_vehgrp_num = _SLP_ARRAY  call SLP_fnc_randomnum} else {_vehgrp_num = _SLP_ARRAY};
  };

  for "_n" from 1 to _vehgrp_num do {	
    _vehgrp_size = nil;	
    _grp = nil;
    _randompos = [_position] call SLP_fnc_randompos;

    _vehgrp_size =  if (count _vehgrp >= 2) then {
      if ( typename (_vehgrp select 1) == "ARRAY") then {(_vehgrp select 1) call SLP_fnc_randomnum} else {_vehgrp select 1};
    } else {1};

    if (_vehgrp_size == -1) then {
      if (typename _SLP_ARRAY == "ARRAY" ) then {_vehgrp_size = _SLP_ARRAY call SLP_fnc_randomnum} else {_vehgrp_size = _SLP_ARRAY};
    };

    _grp = createGroup _side;
    for "_s" from 1 to _vehgrp_size do {					
      _vehicle = _vehicles call BIS_fnc_selectRandom;
      _veh = createVehicle [  _vehicle , _randompos, [], 0, "None"];
      waituntil {!isnull _veh};
      _vcrew = [_veh, _grp,false,"",_crew] call BIS_fnc_SpawnCrew;
      waituntil {{!isnull _x} foreach _vcrew};
      {_x addEventHandler ["killed", {(_this select 0) spawn SLP_fnc_unitkilled;}];
       _x setskill _vehskill;
      } foreach _vcrew;
      //////////// Fill cargo with infantry if set to true////////////////////////////////////////////////
      if (_vehgrp_inf	) then {
        _newunits =  _units - [_units select 0, _units select 1];
        _cpos = _veh emptyPositions "cargo";

        _fillslots =  if (typename _fillcargo == "ARRAY") then {_cpos *(_fillcargo call SLP_fnc_randomnum)} else {_cpos*_fillcargo};
        //			hint format  ["positions filled are %1",_fillslots];
        for "_f" from 1 to _fillslots do {			
          _newunit = _newunits call BIS_fnc_selectRandom;
          _unit = _grp createunit [  _newunit ,  position _veh, [], 0, "None"]; 
          waituntil {!isnull _unit};
          _unit addEventHandler ["killed", {(_this select 0) spawn SLP_fnc_unitkilled;}];
          [_unit,_veh,_infskill] call SLP_fnc_cargounit;
          _unit setskill _infskill;
        };                                               
      };
    };
    vehicle leader _grp setrank "LIEUTENANT";
    vehicle leader _grp setskill _vehskill + .1;
    //		_skill = skill vehicle leader _grp;
    //		hint format  ["SKill is %1",_skill];
    SLP_Instances = SLP_Instances + 1;

    [_spawnname,_position,_grp,_task] spawn SLP_task;
    
    if (typename _delay == "BOOL" ) then {
      waituntil {{alive _x} count units _grp <= 0};
    } else {
      sleep _delay; 
    };	
  };
};
//////////////////////////////////////////////AIR/////////////////////////////////////////////////////////
SLP_fnc_Air ={        
  private ["_spawnname","_grp","_side","_delay","_randompos","_temparray","_units","_debug","_task","_string","_position","_veh","_crew","_airgrp_size","_airskill","_airgrp_num","_airgrp","_airinfo","_case","_unit","_opt","_rank","_type"];

  _spawnname = _this select 0;  
  _side = _this select 1;
  _delay =  _this select 2;
  _position = _this select 3;
  _temparray = _this select 4;
  _units = _temparray select 1;
  //      _helo =  _temparray select 4;
  //		_plane =  _temparray select 5;
  //		_boat =  _temparray select 6;
  _airskill = _this select 5;
  _airgrp = _this select 6;
  _airgrp_num = if (typename (_airgrp select 0) == "ARRAY") then { (_airgrp select 0)  call SLP_fnc_randomnum} else {_airgrp select 0};
  _airinfo = if (count _airgrp >= 3) then {_airgrp select 2} else {"helo"};		
  _task =  _this select 7;
  _debug = SLP_ARRAY select 0;

  if (_airgrp_num == -1) then {
    if ( typename (SLP_ARRAY select 10) == "ARRAY") then {_airgrp_num = (SLP_ARRAY select 10) call SLP_fnc_randomnum} else {_airgrp_num = SLP_ARRAY select 10};
  };

  if (typeName _airinfo=="STRING") then {
    _airinfo= toUpper _airinfo;
    switch (_airinfo) do 
    {
    case "HELO": {	
        _case = _temparray select 4;
        _unit = _units select 0;
        _opt = "fly";
        _rank = "Captain";
      };

    case "PLANE": {	
        _case = _temparray select 5;
        _unit = _units select 0;
        _opt = "fly";
        _rank = "Captain";
      };
      
    case "BOAT": {	
        _case = _temparray select 6;
        _unit = _units select 2;
        _opt = "none";
        _rank = "LIEUTENANT";
      };

      default 	{
        if(_debug == 1) then {
          hintc format [ "Error: spawnname %1\n\n Must be spelled ""helo"",""plane"",""boat"" or leave it blank (default is ""helo""), check your spelling", _spawnname];
        };
      };
    };
  };
  for "_n" from 1 to _airgrp_num do {	
    _airgrp_size = nil;
    _grp = nil;
    _randompos = [_position,true] call SLP_fnc_randompos;
    _airgrp_size =  if (count _airgrp >= 2) then {
      if ( typename (_airgrp select 1) == "ARRAY") then {(_airgrp select 1) call SLP_fnc_randomnum} else {_airgrp select 1};
    } else {1};

    if (_airgrp_size == -1) then {
      if (typename (SLP_ARRAY select 11) == "ARRAY" ) then {_airgrp_size = (SLP_ARRAY select 11) call SLP_fnc_randomnum} else {_airgrp_size = SLP_ARRAY select 11};
    };
    _grp = createGroup _side;	
    for "_s" from 1 to _airgrp_size do {	
      _type = _case call BIS_fnc_selectRandom;
      _veh = createVehicle [ _type, _randompos, [], 0, _opt]; 
      waituntil {!isnull _veh};
      _crew= [_veh, _grp,false,"",_unit] call BIS_fnc_SpawnCrew; 
      waituntil {{!isnull _x} foreach _crew};
      { 
        _x addEventHandler ["killed", {(_this select 0) spawn SLP_fnc_unitkilled;}];
        _x setskill _airskill;
      } foreach  _crew;			
    };
    vehicle leader _grp setrank _rank;
    vehicle leader _grp setskill _airskill + .1;

    [_spawnname,_position,_grp,_task] spawn SLP_task;

    if (typename _delay == "BOOL" ) then {
      waituntil {{alive _x} count units _grp <= 0};
    } else {
      sleep _delay; 
    };	
  };
};