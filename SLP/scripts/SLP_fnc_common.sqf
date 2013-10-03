/*
common functions 

*/
if (!isServer) exitwith {}; 
////////////////////////////Get Pos//////////////////////////////////
SLP_fnc_getpos = {
   
private ["_pos"];
_pos = toupper (typeName _this);

switch (_pos) do {
	case ("OBJECT") : {
		getpos _this
	};
	case ("GROUP") : {
		getpos (leader _this)
	};
	case ("STRING") : {
		getmarkerpos _this
	};
	case ("LOCATION") : {
		position _this
	};
	default {_this};
};

//_pos   //return
};

/////////////////////////// Random Positon/////////////////////////
SLP_fnc_randompos ={
   
private ["_pos","_posdist","_randompos","_position","_posa","_water"];
_position = _this select 0;
	_pos = _position select 0;
    _posdist = if (count _position >= 2) then {_position select 1} else {0};
 _water = if (count _this >= 2) then {_this select 1} else {false};

///check if in array then select random 
if (typename _pos == "ARRAY") then {
		_pos =_pos call BIS_fnc_selectRandom;
	};

////get the position of whatever it is	
///cba to get position of object,marker etc    
//_posa = _pos call CBA_fnc_getpos;
_posa = _pos call SLP_fnc_getpos;

///SHK_pos to find a safe spot and random distance if called for
if (_water) then {
	_randompos = [ _posa,random 360,_posdist,true] call SHK_pos; 
}else{
	_randompos = [ _posa,random 360,_posdist,false] call SHK_pos; 	
}; 

_randompos //return

};
///////////////////////////randomnumber///////////////////////////
SLP_fnc_randomnum = {

private ["_low","_high","_randomnum"];
_low = _this select 0;   //low  number
_high = _this select 1;   //high number

_low= _low*10;
_high=_high*10;

//swap inputs if they are out of order
if (_low > _high) then {_low = _this select 1; _high = _this select 0};

//get the random number
_randomnum = _low + random (floor (_high - _low)) ;
_randomnum = _randomnum/10;

_randomnum //return
};

///////////////////////////unitkilled /////////////////////////
SLP_fnc_unitkilled ={

private ["_delay"];
_delay = SLP_ARRAY select 12;

sleep _delay;
hidebody _this;
_this removeAllEventHandlers "killed";
sleep 20;

deletevehicle _this;
deletegroup (group _this);
};
////////////////////////////unitcargo///////////////////////////////////
SLP_fnc_cargounit ={

private ["_unit","_veh","_skill"];
_unit = _this select 0;
_veh = _this select 1;
_skill = _this select 2;
 
_unit setskill _skill;
_unit  assignAsCargo _veh;
//[_unit] ordergetin true;
_unit  moveInCargo _veh;
_unit  setrank "private";  

};
///////////////////////////////hunt///////////////////////////////////////
SLP_hunt = {
private ["_pos","_grp","_wp"];

_grp = _this select 0;
    
	while {{alive _x} count (units _grp)  > 0} do {

		_pos = (_this select 1) call SLP_fnc_getpos; 

			_wp = _grp addWaypoint [_pos, 0];
			_wp setWaypointSpeed "FULL";
			_wp setWaypointType "SAD"; 
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointFormation "LINE";//"COLUMN"
			_wp setWaypointCompletionRadius 30;
			sleep 40 + (random 15);
			deleteWaypoint ((waypoints _grp) select 0);

	};
};
///////////////////////////////attack///////////////////////////////////////
SLP_attack = {
private ["_pos","_grp","_wp"];

_grp = _this select 0;
_pos = (_this select 1) call SLP_fnc_getpos; 
	_wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointSpeed "FULL";
	_wp setWaypointType "SAD"; 
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointFormation "LINE";//"COLUMN"
	_wp setWaypointCompletionRadius 30;
};