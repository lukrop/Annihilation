#include "common.hpp"

//--- ani_recruit
#define IDC_ANI_RECRUIT_TITLE     6999
#define IDC_ANI_RECRUIT_GROUPUNITSLIST    7499
#define IDC_ANI_RECRUIT_RECRUITAR     7599
#define IDC_ANI_RECRUIT_RECRUITMG     7600
#define IDC_ANI_RECRUIT_RECRUITAT     7601
#define IDC_ANI_RECRUIT_RECRUITLAT      7602
#define IDC_ANI_RECRUIT_RECRUITMEDIC    7603
#define IDC_ANI_RECRUIT_RECRUITPILOT    7604
#define IDC_ANI_RECRUIT_RECRUITENGINEER   7605
#define IDC_ANI_RECRUIT_DISBANDALL      7606
#define IDC_ANI_RECRUIT_DISBANDUNIT     7607
#define IDC_ANI_RECRUIT_IGUIBACK_2200   8199
#define IDC_ANI_RECRUIT_RSCBUTTONMENUCANCEL_2701  8700

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by lukrop, v1.063, #Leqydu)
////////////////////////////////////////////////////////
class ANI_RECRUIT_DIALOG {
  idd = -1;
  movingenable = true;
  
 class Controls {
  class IGUIBack_2200: IGUIBack
  {
    idc = 2200;
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 5 * GUI_GRID_H + GUI_GRID_Y;
    w = 22 * GUI_GRID_W;
    h = 14.5 * GUI_GRID_H;
  };
  class Title: RscText
  {
    idc = 1000;
    text = "RECRUIT AI"; //--- ToDo: Localize;
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 2.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 22 * GUI_GRID_W;
    h = 2 * GUI_GRID_H;
    colorBackground[] = {-1,-1,-1,0.5};
    sizeEx = 1.5 * GUI_GRID_H;
  };
  class RecruitAR: RscButton
  {
    idc = 1600;
    text = "AR"; //--- ToDo: Localize;
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    action="[0,player] execVM ""ani_recruit\recruitUnit.sqf""";
  };
  class RecruitMG: RscButton
  {
    idc = 1601;
    text = "MG"; //--- ToDo: Localize;
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    action="[1,player] execVM ""ani_recruit\recruitUnit.sqf""";
  };
  class RecruitAT: RscButton
  {
    idc = 1602;
    text = "AT"; //--- ToDo: Localize;
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    action="[2,player] execVM ""ani_recruit\recruitUnit.sqf""";
  };
  class RecruitLAT: RscButton
  {
    idc = 1603;
    text = "LAT"; //--- ToDo: Localize;
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    action="[3,player] execVM ""ani_recruit\recruitUnit.sqf""";
  };
  class RecruitMedic: RscButton
  {
    idc = 1604;
    text = "Medic"; //--- ToDo: Localize;
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 13.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    action="[4,player] execVM ""ani_recruit\recruitUnit.sqf""";
  };
  class RecruitPilot: RscButton
  {
    idc = 1605;
    text = "Pilot"; //--- ToDo: Localize;
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    action="[5,player] execVM ""ani_recruit\recruitUnit.sqf""";
  };
  class RscButtonMenuCancel_2700: RscButtonMenuCancel
  {
    text = "Close"; //--- ToDo: Localize;
    x = 26 * GUI_GRID_W + GUI_GRID_X;
    y = 19.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 6 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    colorBackground[] = {-1,-1,-1,0.5};
    action="closeDialog 0";
  };
  class RecruitEngineer: RscButton
  {
    idc = 1606;
    text = "Engineer"; //--- ToDo: Localize;
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
    action="[6,player] execVM ""ani_recruit\recruitUnit.sqf""";
  };
  class GroupUnitsList: RscListbox
  {
    idc = 1500;
    text = "Units"; //--- ToDo: Localize;
    x = 15.5 * GUI_GRID_W + GUI_GRID_X;
    y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 16 * GUI_GRID_W;
    h = 9.5 * GUI_GRID_H;
  };
  class DisbandAll: RscButton
  {
    idc = 1607;
    text = "Disband All"; //--- ToDo: Localize;
    x = 20 * GUI_GRID_W + GUI_GRID_X;
    y = 18 * GUI_GRID_H + GUI_GRID_Y;
    w = 7 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    action="[player] execVM ""ani_recruit\disbandAll.sqf""";
  };
  class DisbandUnit: RscButton
  {
    idc = 1608;
    text = "[NOOP]Disband"; //--- ToDo: Localize;
    x = 18.5 * GUI_GRID_W + GUI_GRID_X;
    y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////


