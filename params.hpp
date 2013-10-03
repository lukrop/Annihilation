class Params {
	class ani_daytime {
		title="Time of day";
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default=6;
		texts[]={"0000","0100","0200","0300","0400","0500","0600","0700","0800","0900","1000","1100","1200","1300","1400","1500","1600","1700","1800","1900","2000","2100","2200","2300"};
	};
  
	class ani_enemy_skill {
		title="Enemy infantry skill";
		values[]={0,1,2,3};
		default=0;
		texts[]={"0.2 - 0.35","0.3 - 0.45","0.4 - 0.55","0.6 - 0.85"};
	};
  
  class ani_tpwcas {
		title="Suppression";
		values[]={0,1,2};
		default=0;
		texts[]={"Disabled","TPWCAS","TPW EBS"};
	};
 
  class ani_tpwlos {
		title="TPWLOS (only works in conjunction with TPWCAS)";
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
  
  class ani_acre {
		title="ACRE";
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
  
  class ani_recruit_max {
  	title="Max group size (recruitable units)";
		values[]={1,4,8,12};
		default=8;
		texts[]={"Recruiting disabled","4","8", "12"};
  };
  
  class ani_revive {
		title="Revive";
		values[]={0,1};
		default=1;
		texts[]={"Disabled","Enabled"};
	};
  
  class ani_enemy_faction {
		title="Enemy faction";
		values[]={0,2};
		default=0;
		texts[]={"CSAT", "AAF"};
	};
};