class Params {
  class ani_daytime {
    title="Time of day";
    values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
    default=6;
    texts[]={"0000","0100","0200","0300","0400","0500","0600","0700","0800","0900","1000","1100","1200","1300","1400","1500","1600","1700","1800","1900","2000","2100","2200","2300"};
  };
  
  class ani_enemy_faction {
    title="Enemy faction";
    values[]={0,2};
    default=0;
    texts[]={"CSAT", "AAF"};
  };
  
  class ani_enemy_count {
    title="Enemy count";
    values[]={0,1,2,3};
    default=0;
    texts[]={"low (1-3 players)", "medium (3-8 players)", "high (8-12 players)", "very high(12-20 players)"};
  };
  
  class ani_enemy_skill {
    title="Enemy infantry skill";
    values[]={0,1,2,3};
    default=0;
    texts[]={"0.1 - 0.3","0.3 - 0.5","0.5 - 0.7","0.7 - 0.9"};
  };
  
  class ani_recruit {
    title="AI Recruitment";
    values[]={0,1};
    default=1;
    texts[]={"Disabled","Enabled"};
  };
  
  class ani_recruit_max {
    title="   Max group size (recruitable units)";
    values[]={4,8,12};
    default=8;
    texts[]={"4","8","12"};
  };
  
  class ani_revive {
    title="Revive";
    values[]={0,1,2};
    default=2;
    texts[]={"Disabled","Enabled (=BTC=)", "Enabled (FAR)"};
  };
  
  class ani_revive_lifes {
    title="   Revive lifes (=BTC= only)";
    values[]={5,10,15,20,0};
    default=10;
    texts[]={"5","10", "15", "20", "Infinite"};
  };
  
  class ani_mobile_respawn {
    title="   Mobile respawn (=BTC= only)";
    values[]={0,1};
    default=1;
    texts[]={"Disabled","Enabled"};
  };
  
  class ani_mobile_respawn_vas {
    title="   Virtual Ammobox on mobile respawn vehicle";
    values[]={0,1};
    default=1;
    texts[]={"Disabled","Enabled"};
  };
  
  class ani_vec_respawndelay {
    title="Vehicle respawn delay";
    values[]={5,15,30,60,120};
    default=60;
    texts[]={"5 seconds","15 seconds", "30 seconds", "60 seconds", "120 seconds"};
  };
  
  class ani_vec_deserteddelay {
    title="[INOP] Vehicle deserted delay";
    values[]={300,600,900,1200,1800,3600};
    default=1800;
    texts[]={"5 minutes","10 minutes", "15 minutes", "20 minutes", "30 minutes", "1 hour"};
  };
  
  class ani_chopper_respawndelay {
    title="Chopper respawn delay";
    values[]={5,15,30,60,120};
    default=120;
    texts[]={"5 seconds","15 seconds", "30 seconds", "60 seconds", "120 seconds"};
  };

  class ani_chopper_deserteddelay {
    title="[INOP] Chopper deserted delay";
    values[]={300,600,900,1200,1800,3600};
    default=1800;
    texts[]={"5 minutes","10 minutes", "15 minutes", "20 minutes", "30 minutes", "1 hour"};
  };
  
  class ani_ammoboxes {
    title="Spawn vanilla ammoboxes in addition to the VAS box.";
    values[]={0,1};
    default=1;
    texts[]={"Disabled","Enabled"};
  };

  class ani_addonammoboxes {
    title="Spawn addon ammoboxes (R3F, FHQ, RHARD Mk18, NATO/Spetsnaz Weps)";
    values[]={0,1};
    default=0;
    texts[]={"Disabled","Enabled"};
  }; 
  
  class ani_tpwcas {
    title="Suppression";
    values[]={0,1,2};
    default=0;
    texts[]={"Disabled","TPWCAS","TPW EBS (only SP)"};
  };

  class ani_tpwlos {
    title="   TPWLOS (only works in conjunction with TPWCAS)";
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

  class ani_jip_markers {
    title="TESTING: JIP markers";
    values[]={0,1};
    default=0;
    texts[]={"Disabled","Enabled"};
  };
};