/*
	File: parameters.hpp
	Author: lukrop

	License: see LICENSE.txt
	Description:
	Mission parameters

	Parameter(s):
	-

	Returns:
	-
*/

class Params {
	class param_category_scenario {
		title = "Scenario:";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class param_daytime {
		title = "  - Time of day";
		values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		texts[] = {"0000","0100","0200","0300","0400","0500","0600","0700","0800","0900","1000","1100",
			"1200","1300","1400","1500","1600","1700","1800","1900","2000","2100","2200","2300"};
		default = 6;
		code = "param_daytime = %1";
	};
	
	
	 class param_weather {
		title = "  - Weather";
		values[] = {0,1,2,3,4};
		texts[] = {"Clear","Overcast","Rain","Fog","Random"};
		default = 1;
		code = "param_weather = %1";
	};
	

	class param_ied {
		title = "  - Roadside IEDs";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
		code = "param_ied = %1";
	};

	/*
	class param_civilians {
		title="  - Civilians in towns";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
		code = "param_civilians = %1";
	};
	*/
	
	class param_category_enemy {
		title = "Enemy force:";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class param_enemy_faction {
		title="  - Faction";
		values[] = {0,1,2,3,4,5};
		texts[] = {"CSAT", "AAF", "Middle eastern", "Eastern european", "African", "MSV (Russian"};
		default = 2;
		code = "param_enemy_faction = %1";
	};

	
	class param_enemy_count {
		title = "  - Count";
		values[] = {0,1,2,3};
		texts[] = {"low (1-3 players)", "medium (3-8 players)", "high (8-12 players)", "very high(12-20 players)"};
		default = 1;
		code = "param_enemy_count = %1";
	};
	
	class param_enemy_skill {
		title = "  - Skill";
		values[] = {0,1,2,3};
		texts[] = {"Low","Medium","High","Very high"};
		default = 1;
		code = "param_enemy_skill = %1";
	};
	
	class param_enemy_reinforcement {
		title = "  - Reinforcements";
		values[] = {0,1};
		texts[] = {"Disabled", "Enabled"};
		default = 1;
		code = "param_enemy_reinforcement = %1";
	};
	
	class param_enemy_ambient_patrols {
		title = "  - Random patrols (across the whole island)";
		values[] = {0,1};
		texts[] = {"Disabled", "Enabled"};
		default = 1;
		code = "param_enemy_ambient_patrols = %1";
	};

	class param_category_gameplay {
		title = "Gameplay:";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class param_max_recruit_ai {
		title = "  - Maximum recruitable AI";
		values[] = {0,4,8,12};
		texts[] = {"Disabled", "4", "8", "12"};
		default = 0;
		code = "param_max_recruit_ai = %1";
	};

    /*
	class param_vvs {
		title = "  - Virtual vehicle spawn";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
		code = "param_vvs = %1";
	};*/

	class param_caching {
		title = "  - Cache enemy AI groups to save resources";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
		code = "param_caching = %1";
	};
    /*
	class param_tpwcas {
		title = "  - Enemy AI groups affected by suppression";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled (TPWCAS)"};
		default = 1;
		code = "param_tpwcas = %1";
	};

	class param_tpwlos {
		title = "  - Enemy AI faster in CQB";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled (TPWLOS)"};
		default = 0;
		code = "param_tpwlos = %1";
	};

	class param_vec_respawn {
		title="  - Vehicle respawn";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 0;
		code = "param_vec_respawn = %1";
	};
	
	class param_vec_respawn_delay_destroyed {
		title = "   -- Destroyed vehicles respawn delay:";
		values[] = {1, 2, 5};
		texts[] = {"1 minute", "2 minutes", "5 minutes"};
		default = 2;
		code = "param_vec_respawn_delay_destroyed = %1";
	};

	class param_vec_respawn_delay_abandoned {
		title = "   -- Abandoned vehicles respawn delay:";
		values[] = {10, 20, 50};
		texts[] = {"10 minute", "20 minutes", "50 minutes"};
		default = 20;
		code = "param_vec_respawn_delay_abandoned = %1";
	};

	class param_revive {
		title="  - Revive";
		values[] = {0,1,2};
		texts[] = {"Disabled","Enabled (=BTC=)", "Enabled (FAR)"};
		default = 2;
		code = "param_revive = %1";
	};
	
	class param_subcategory_btc {
		title = "   -- =BTC= revive:";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class param_btc_revive_lifes {
		title = "    --- Revive lifes";
		values[] = {5,10,15,20,0};
		texts[] = {"5","10", "15", "20", "Infinite"};
		default = 10;
		code = "param_btc_revive_lifes = %1";
	};
	
	class param_btc_mobile_respawn {
		title = "    --- Mobile respawn";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
		code = "param_btc_mobile_respawn = %1";
	};
	
	class param_btc_mobile_respawn_vas {
		title = "    --- VAS on mobile respawn vehicle";
		values[] = {0,1};
		texts[] = {"Disabled","Enabled"};
		default = 1;
		code = "param_btc_mobile_respawn_vas = %1";
	};*/

	class params_set {
		title = "";
		values[] = {0};
		texts[] = {""};
		default = 0;
		code = "params_set = true";
	};
};


