/*
  Author: lukrop
  Date: 10/26/2013
  Description: Selects a random location for the mission. Uses argument to
  determine if it's a land or city mission. Deletes the location from possible
  future locations

  Parameters: NUMBER: mission type: city = 0, land = 1

  Returns: ARRAY: array with markers used for positions

*/
_missionStyle = _this select 0;

switch (_missionStyle) do {
// city mission
case 0: {
    // select a random entry (positions)
    _index = round (random ((count ani_citys) - 1));
    _posArray = ani_citys select _index;
    // remove location from possible future missions
    ani_citys set [_index, -1];
    ani_citys = ani_citys - [-1];
  };
// land mission
case 1: {
    _index = round (random ((count ani_lands) - 1));
    _posArray = ani_lands select _index;
    ani_lands set [_index, -1];
    ani_lands = ani_lands - [-1];
  };
};

_posArray