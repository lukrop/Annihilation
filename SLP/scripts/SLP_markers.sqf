private ["_grp","_mrkname","_mrk","_markercolor","_side","_vehcount","_grpname","_markertype","_wpPos","_leader","_markerobj","_wpid","_wpname","_pos","_mrkfollow","_mrktask"];
waituntil {scriptdone SLP_init};

if (SLP_Array select 0 == 0) exitwith {};

_grp = _this select 0;
_mrktask = _this select 1;
//_mrktask = if (count _this >= 2) then {_this select 1} else {nil};

_side = side _grp;

SLP_mark= SLP_mark + 1;
_grpname = format["grp%1",SLP_mark];	
_mrkfollow = true;

//hint "markers are up";
	if (leader _grp != Vehicle leader _grp ) then {
		_vehcount = {crew vehicle _x select 0 == _x && vehicle _x != _x} count units _grp;
			_leader = vehicle leader _grp;
			_pos = getpos  _leader;
    } else {
         _vehcount = count units _grp;
			_leader = leader _grp;
			_pos = getpos  _leader;
    };

_mrkname = format["m_%1",_grpname];
_mrk = createmarkerlocal [_mrkname ,_pos];
_mrk setMarkerShapelocal "ICON";
_mrk setMarkerSizelocal [.75, .75];
_markercolor = switch (_side) do 
				{
					case west: {"ColorBlue"};
					case east: {"ColorRed"};
					case resistance: {"ColorGreen"};
					default {"ColorBlack"};
				};
	if (_side == west) then {
		_markertype = switch true do 
						{
						case (_leader iskindof "camanbase"): {"b_inf"};
						case (_leader iskindof "car" || _leader iskindof "motorcycle"): {"b_mech_inf"};
						case (_leader iskindof "tank"|| _leader iskindof "wheeled_apc"): {"b_armor"};
						case (_leader iskindof "air"): {"b_air"};
						case (_leader iskindof "ship"): {"c_ship"};
						};							
	}; 		
	if (_side == east) then {
		_markertype = switch true do 
						{
						case (_leader iskindof "camanbase"): {"o_inf"};
						case (_leader iskindof "car" ||_leader iskindof "motorcycle"): {"o_mech_inf"};
						case (_leader iskindof "tank"|| _leader iskindof "wheeled_apc"): {"o_armor"};
						case (_leader iskindof "air"): {"o_air"};
						case (_leader iskindof "ship"): {"c_ship"};
						};
	};									
	if (_side == resistance) then {
		_markertype = switch true do 
						{
						case (_leader iskindof "camanbase"): {"n_inf"};
						case (_leader iskindof "car" || _leader iskindof "motorcycle"): {"n_mech_inf"};
						case (_leader iskindof "tank"|| _leader iskindof "wheeled_apc"): {"n_armor"};
						case (_leader iskindof "air"): {"n_air"};
						case (_leader iskindof "ship"): {"c_ship"};
						};
	};	
	if (_side == civilian) then {_markertype = "waypoint"};	
																
_mrkname setMarkerTypelocal _markertype;			
_mrkname setMarkerColorlocal _markercolor;
//if (isnil "_mrktask") then {
//	_mrkname setMarkerTextlocal format["%1--%2 units",_grpname,_vehcount];  
//} else {
	_mrkname setMarkerTextlocal format["%1--%2 units..%3",_grpname,_vehcount,_mrktask];  
//};  
           
_wpname=format["dest_%1",_grpname];
_markerobj = createMarkerlocal [_wpname,[0,0]];
_markerobj setMarkerShapelocal "ICON";
_wpname setMarkerTypelocal "waypoint";
_wpname setMarkerColorlocal _markercolor;
_wpname setMarkerTextlocal format["%1",_grpname];
_wpname setMarkerSizelocal [.75,.75];
_wpid = currentWaypoint _grp;
_wpPos = waypointPosition [_grp,_wpid];
_wpname setmarkerposlocal _wppos;  
if ((_wppos select 0) + (_wppos select 1) +(_wppos select 2)  == 0)	 then {_wpname setmarkeralphalocal 0};  

////MAIN LOOP			   
	while {_mrkfollow}do {
					
		if (leader _grp != Vehicle leader _grp ) then {
			_vehcount = {crew vehicle _x select 0 == _x && vehicle _x != _x} count units _grp;
			_leader = vehicle leader _grp;
			_pos = getpos  _leader;
		} else {
			_vehcount = count units _grp;
			_leader = leader _grp;
			_pos = getpos  _leader;
		};
	_mrkname setmarkerposlocal _pos; 
	if (isnil "_mrktask") then {
		_mrkname setMarkerTextlocal format["%1--%2 units",_grpname,_vehcount];  
	} else {
		_mrkname setMarkerTextlocal format["%1--%2 units..%3",_grpname,_vehcount,_mrktask];  
	};  				
	_wpid = currentWaypoint _grp;
	_wpPos = waypointPosition [_grp,_wpid];
	_wpname setmarkerposlocal _wppos;  
	if ((_wppos select 0) + (_wppos select 1) +(_wppos select 2)  == 0)	 then {_wpname setmarkeralphalocal 0}; 
	 
	if ({alive _x} count units _grp <= 0) then {
		{deletemarkerlocal _x} foreach [ _mrkname,_wpname];
		_mrkfollow=false;
	};
	sleep 2;
	};
