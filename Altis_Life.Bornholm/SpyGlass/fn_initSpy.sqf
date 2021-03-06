#define GVAR_UINS uiNamespace getVariable
#define CONST(var1,var2) var1 = compileFinal (if(typeName var2 == "STRING") then {var2} else {str(var2)})
#define steamid getPlayerUID player
/*
	File: fn_initSpy.sqf
	
	Description:
	Does some things that I made over-complicated / un-needed but blah.
	Will eventually include server-side checks but it's blah at this point.
	
	Will also become a standalone system which is why it's setup like this.
*/
private["_binConfigPatches","_cfgPatches","_endM"];
if(isServer && !hasInterface) exitWith {}; //Server doesn't need to know.

CONST(W_O_O_K_I_E_ANTI_ANTI_HAX,"false");
CONST(W_O_O_K_I_E_FUD_ANTI_ANTI_HAX,"false");
CONST(E_X_T_A_S_Y_ANTI_ANTI_HAX,"false");
CONST(E_X_T_A_S_Y_Pro_RE,"false");
CONST(E_X_T_A_S_Y_Car_RE,"false");
CONST(DO_NUKE,"false");
CONST(JxMxE_spunkveh,"false");
CONST(JxMxE_spunkveh2,"false");
CONST(JxMxE_spunkair,"false");
CONST(JJJJ_MMMM___EEEEEEE_LLYYSSTTIICCC_SHIT_RE,"false");
CONST(JJJJ_MMMM___EEEEEEE_LLYYSSTTIICCC_SHIT_RE_OLD,"false");
CONST(JJJJ_MMMM___EEEEEEE_SPAWN_VEH,"false");
CONST(JJJJ_MMMM___EEEEEEE_SPAWN_WEAPON,"false");
CONST(GGGG_EEEE_FFFF__PLAYERs,"false");
CONST(GGGG_EEEE_FFFF___DISPLAYID,"false");

/*
	Compile our list of allowed addon patches, by default this DOES NOT ALLOW ANY ADDONS.
	
	If you want to white-list addons such as JSRS or Blastcore you need to start a test instance (Host locally and not the mission) and first fill the SPY_cfg_patchList array, once you executed it (Filled it)
	Run the following code and it will copy the list of addons / patches not in the list to your clipboard (Ctrl + V) and then add it to the array.
	
	_cfgPatches = [];
	_binConfigPatches = configFile >> "CfgPatches";
	for "_i" from 0 to count (_binConfigPatches)-1 do {
		_patchEntry = _binConfigPatches select _i;
		if(isClass _patchEntry) then {
			if(!((configName _patchEntry) in SPY_cfg_patchList)) then {
				_cfgPatches set[count _cfgPatches,(configName _patchEntry)];
			};
		};
	};

	copyToClipboard str(_cfgPatches);
	
	i.e
	["cba_xeh","Extended_EventHandlers","CBA_Extended_EventHandlers","JSRS_Environment","WarFXPE","cba_common","cba_events","cba_hashes","cba_network","cba_strings","cba_ui","cba_vectors","JSRS2_120mm_Cannon","JSRS2_127","JSRS2_155mm_AMOS",
	"JSRS2_230mm_Titan","JSRS2_30mm_Cannon","JSRS2_35mm_Autocannon","JSRS2_4Five45","JSRS2_ACPC","JSRS2_Autocannon","JSRS2_Bullethits","JSRS2_DAGR","JSRS2_DAR","JSRS2_EBR","JSRS2_Explosions","JSRS2_Explosives","JSRS2_Filters","JSRS2_FS2000",
	"JSRS2_Gatling","JSRS2_GMG20","JSRS2_GMG40","JSRS2_Khaybar","JSRS2_LMGRCWS","JSRS2_M134","JSRS2_M200","JSRS2_M320R","JSRS2_M6","JSRS2_Minigun","JSRS2_MX","JSRS2_NLAW","JSRS2_P07","JSRS2_PDW","JSRS2_Rahim","JSRS2_Rook40","JSRS2_RPG32",
	"JSRS2_Scorpian","JSRS2_SDAR","JSRS2_Skalpel_ATGM","JSRS2_Skyfire","JSRS2_Sonic_Cracks","JSRS2_Titan","JSRS2_TRG20","JSRS2_Vector","JSRS2_Veh_Titan","JSRS2_Zafir","JSRS2_Zubr45","Blastcore_VEP","cba_ai","cba_arrays","cba_diagnostic","cba_help",
	"cba_ui_helper","cba_versioning","JSRS2_Movement","JSRS2_Silencers","cba_main","cba_main_a3","JSRS2_2S9_Sorcher","JSRS2_AFV4_Gorgon","JSRS2_AH99_Blackfoot","JSRS2_AH9_Pawnee","JSRS2_AMV7_Marshal","JSRS2_BTRK_Kamysh","JSRS2_CH49_Mohawk","JSRS2_Distance",
	"JSRS2_FighterPlane3","JSRS2_FV720_Mora","JSRS2_Hunter","JSRS2_Ifrit","JSRS2_IFV6a_Cheetah","JSRS2_IFV6c_Panther","JSRS2_M2A1_Slammer","JSRS2_M4_Scorcher","JSRS2_M5_Sandstorm","JSRS2_MBT52_Kuma","JSRS2_Mi48_Kajman","JSRS2_MSE3_Marid","JSRS2_Offroad",
	"JSRS2_Po30_Orca","JSRS2_Strider","JSRS2_SUV","JSRS2_T100_Varsuk","JSRS2_Truck1","JSRS2_Truck2","JSRS2_UAV_1","JSRS2_UH80_GhostHawk","JSRS2_Van","JSRS2_WY55_Hellcat","JSRS2_ZSU39_Tigris","cba_xeh_a3"]
*/
	
_patchList = 
["A3Data","A3_BaseConfig_F","A3_Dubbing_Radio_F","A3_Functions_F","A3_Functions_F_EPA","A3_Functions_F_EPC","Map_VR","A3_Map_VR_Scenes",
"Shemaghs","D41_Patch140804","D41_Patch140811","D41_Patch140811b","D41_Patch140819","D41_Patch140825","D41_Patch140908","D41_Patch140915",
"D41_Patch140922","D41_Patch140929","D41_Patch141006","D41_Patch141013","D41_Patch141020","D41_Patch141105","D41_Patch141109",
"D41_Patch141110","D41_RHS_Vehicles_GAZ66","A3_Trees","A3_Bush","A3_Plants","A3_Stones","D41_Oil_Mine","D41_RHS_Vehicles_TIGR",
"D41_RHS_Vehicles_UAZ","D41_RHS_Vehicles","BornholmLayers","D41_GNT_C185","rhsusf_main","TacticalHoods","cba_xeh","Extended_EventHandlers",
"CBA_Extended_EventHandlers","A3_Data_F","A3_Data_F_Hook","A3_Data_F_ParticleEffects","A3_Data_F_Bootcamp","A3_Data_F_Kart_ParticleEffects",
"A3_Editor_F","A3_Functions_F_Bootcamp","A3_Functions_F_Curator","A3_Functions_F_Heli","A3_Language_F","A3_Language_F_Beta","A3_Language_F_Curator",
"A3_Language_F_EPA","A3_Language_F_EPB","A3_Language_F_EPC","A3_Language_F_Gamma","A3_Language_F_Heli","A3_Language_F_Kart","A3_LanguageMissions_F",
"A3_LanguageMissions_F_Beta","A3_LanguageMissions_F_Gamma","A3_LanguageMissions_F_Kart","A3_Misc_F","A3_Misc_F_Helpers","A3_Modules_F",
"A3_Modules_F_DynO","A3_Modules_F_Effects","A3_Modules_F_Events","A3_Modules_F_GroupModifiers","A3_Modules_F_HC","A3_Modules_F_Intel",
"A3_Modules_F_LiveFeed","A3_Modules_F_Marta","A3_Modules_F_Misc","A3_Modules_F_Multiplayer","A3_Modules_F_ObjectModifiers","A3_Modules_F_Sites",
"A3_Modules_F_Skirmish","A3_Modules_F_StrategicMap","A3_Modules_F_Supports","A3_Modules_F_UAV","A3_Modules_F_Beta","A3_Modules_F_Beta_FiringDrills",
"A3_Modules_F_EPB","A3_Modules_F_EPB_Misc","A3_Modules_F_Heli","A3_Modules_F_Heli_SpawnAi","A3_Music_F","A3_Music_F_Bootcamp","A3_Music_F_EPA",
"A3_Music_F_EPB","A3_Music_F_EPC","A3_Music_F_Heli","A3_Roads_F","A3_Rocks_F","A3_Sounds_F","A3_Sounds_F_Bootcamp","A3_Sounds_F_EPB",
"A3_Sounds_F_EPC","A3_Structures_F","A3_Structures_F_Bridges","A3_Structures_F_Civ","A3_Structures_F_Civ_Accessories","A3_Structures_F_Civ_Ancient",
"A3_Structures_F_Civ_BellTowers","A3_Structures_F_Civ_Calvaries","A3_Structures_F_Civ_Camping","A3_Structures_F_Civ_Chapels",
"A3_Structures_F_Civ_Constructions","A3_Structures_F_Civ_Dead","A3_Structures_F_Civ_Garbage","A3_Structures_F_Civ_Graffiti",
"A3_Structures_F_Civ_InfoBoards","A3_Structures_F_Civ_Kiosks","A3_Structures_F_Civ_Lamps","A3_Structures_F_Civ_Market","A3_Structures_F_Civ_Offices",
"A3_Structures_F_Civ_Pavements","A3_Structures_F_Civ_PlayGround","A3_Structures_F_Civ_SportsGrounds","A3_Structures_F_Civ_Statues",
"A3_Structures_F_Civ_Tourism","A3_Structures_F_Dominants","A3_Structures_F_Dominants_Amphitheater","A3_Structures_F_Dominants_Castle",
"A3_Structures_F_Dominants_Church","A3_Structures_F_Dominants_Hospital","A3_Structures_F_Dominants_Lighthouse","A3_Structures_F_Dominants_WIP",
"A3_Structures_F_Furniture","A3_Structures_F_Households","A3_Structures_F_Households_Addons","A3_Structures_F_Households_House_Big01",
"A3_Structures_F_Households_House_Big02","A3_Structures_F_Households_House_Shop01","A3_Structures_F_Households_House_Shop02",
"A3_Structures_F_Households_House_Small01","A3_Structures_F_Households_House_Small02","A3_Structures_F_Households_House_Small03",
"A3_Structures_F_Households_Slum","A3_Structures_F_Households_Stone_Big","A3_Structures_F_Households_Stone_Shed",
"A3_Structures_F_Households_Stone_Small","A3_Structures_F_Households_WIP","A3_Structures_F_Ind","A3_Structures_F_Ind_AirPort",
"A3_Structures_F_Ind_Cargo","A3_Structures_F_Ind_CarService","A3_Structures_F_Ind_ConcreteMixingPlant","A3_Structures_F_Ind_Crane",
"A3_Structures_F_Ind_DieselPowerPlant","A3_Structures_F_Ind_Factory","A3_Structures_F_Ind_FuelStation","A3_Structures_F_Ind_FuelStation_Small",
"A3_Structures_F_Ind_Pipes","A3_Structures_F_Ind_PowerLines","A3_Structures_F_Ind_ReservoirTank","A3_Structures_F_Ind_Shed",
"A3_Structures_F_Ind_SolarPowerPlant","A3_Structures_F_Ind_Tank","A3_Structures_F_Ind_Transmitter_Tower","A3_Structures_F_Ind_WavePowerPlant",
"A3_Structures_F_Ind_Windmill","A3_Structures_F_Ind_WindPowerPlant","A3_Structures_F_Items","A3_Structures_F_Items_Documents",
"A3_Structures_F_Items_Electronics","A3_Structures_F_Items_Cans","A3_Structures_F_Items_Gadgets","A3_Structures_F_Items_Luggage",
"A3_Structures_F_Items_Medical","A3_Structures_F_Items_Military","A3_Structures_F_Items_Stationery","A3_Structures_F_Items_Tools",
"A3_Structures_F_Items_Valuables","A3_Structures_F_Items_Vessels","A3_Structures_F_Mil","A3_Structures_F_Mil_BagBunker",
"A3_Structures_F_Mil_BagFence","A3_Structures_F_Mil_Barracks","A3_Structures_F_Mil_Bunker","A3_Structures_F_Mil_Cargo","A3_Structures_F_Mil_Flags",
"A3_Structures_F_Mil_Fortification","A3_Structures_F_Mil_Helipads","A3_Structures_F_Mil_Offices","A3_Structures_F_Mil_Radar",
"A3_Structures_F_Mil_Shelters","A3_Structures_F_Mil_TentHangar","A3_Structures_F_Naval","A3_Structures_F_Naval_Buoys","A3_Structures_F_Naval_Fishing",
"A3_Structures_F_Naval_Piers","A3_Structures_F_Naval_RowBoats","A3_Structures_F_Research","A3_Structures_F_System","A3_Structures_F_Training",
"A3_Structures_F_Training_InvisibleTarget","A3_Structures_F_Walls","A3_Structures_F_Bootcamp_Ind_Cargo","A3_Structures_F_Bootcamp_Items_Sport","
A3_Structures_F_Bootcamp_System","A3_Structures_F_Bootcamp_Training","A3_Structures_F_Bootcamp_VR_Blocks","A3_Structures_F_Bootcamp_VR_CoverObjects",
"A3_Structures_F_Bootcamp_VR_Helpers","A3_Structures_F_EPA_Civ_Camping","A3_Structures_F_EPA_Civ_Constructions","A3_Structures_F_EPA_Items_Electronics",
"A3_Structures_F_EPA_Items_Food","A3_Structures_F_EPA_Items_Medical","A3_Structures_F_EPA_Items_Tools","A3_Structures_F_EPA_Items_Vessels",
"A3_Structures_F_EPA_Walls","A3_Structures_F_EPB_Civ_Accessories","A3_Structures_F_EPB_Civ_Camping","A3_Structures_F_EPB_Civ_Dead",
"A3_Structures_F_EPB_Civ_Garbage","A3_Structures_F_EPB_Civ_Graffiti","A3_Structures_F_EPB_Civ_PlayGround","A3_Structures_F_EPB_Furniture",
"A3_Structures_F_EPB_Items_Documents","A3_Structures_F_EPB_Items_Luggage","A3_Structures_F_EPB_Items_Military","A3_Structures_F_EPB_Items_Vessels",
"A3_Structures_F_EPB_Naval_Fishing","A3_Structures_F_EPC_Civ_Accessories","A3_Structures_F_EPC_Civ_Camping","A3_Structures_F_EPC_Civ_Garbage",
"A3_Structures_F_EPC_Civ_InfoBoards","A3_Structures_F_EPC_Civ_Kiosks","A3_Structures_F_EPC_Civ_PlayGround","A3_Structures_F_EPC_Civ_Tourism",
"A3_Structures_F_EPC_Dominants_GhostHotel","A3_Structures_F_EPC_Dominants_Stadium","A3_Structures_F_EPC_Furniture","A3_Structures_F_EPC_Items_Documents",
"A3_Structures_F_EPC_Items_Electronics","A3_Structures_F_EPC_Walls","A3_Structures_F_Heli_Civ_Accessories","A3_Structures_F_Heli_Civ_Constructions",
"A3_Structures_F_Heli_Civ_Garbage","A3_Structures_F_Heli_Civ_Market","A3_Structures_F_Heli_Furniture","A3_Structures_F_Heli_Ind_AirPort",
"A3_Structures_F_Heli_Ind_Cargo","A3_Structures_F_Heli_Ind_Machines","A3_Structures_F_Heli_Items_Airport","A3_Structures_F_Heli_Items_Luggage",
"A3_Structures_F_Heli_Items_Sport","A3_Structures_F_Heli_Items_Tools","A3_Structures_F_Heli_VR_Helpers","A3_Structures_F_Kart_Civ_SportsGrounds",
"A3_Structures_F_Kart_Mil_Flags","A3_UIFonts_F","D41_Buildings_dingens","D41_I_Items","D41_Tanke","D41_TankeKlein","JSRS_Environment","rhsusf_decals",
"cba_common","cba_events","cba_hashes","cba_network","cba_strings","cba_vectors","A3_Animals_F","A3_Animals_F_AnimConfig","A3_Animals_F_Fishes",
"A3_Animals_F_Kestrel","A3_Animals_F_Rabbit","A3_Animals_F_Seagull","A3_Animals_F_Snakes","A3_Animals_F_Turtle","A3_Animals_F_Chicken","A3_Animals_F_Dog",
"A3_Animals_F_Goat","A3_Animals_F_Sheep","A3_Anims_F","A3_Anims_F_Config_Sdr","A3_Anims_F_EPA","A3_Anims_F_EPC","A3_Anims_F_Kart","A3_Language_F_Bootcamp",
"A3_Map_Data","A3_Map_Stratis","A3_Map_Stratis_Scenes","A3_Plants_F_Bush","A3_Signs_F","A3_Signs_F_AD","A3_Structures_F_Signs_Companies",
"A3_Structures_F_Bootcamp_Civ_Camping","A3_Structures_F_Bootcamp_Civ_SportsGrounds","A3_Structures_F_Bootcamp_Items_Electronics",
"A3_Structures_F_Bootcamp_Items_Food","A3_Structures_F_Heli_Items_Electronics","A3_Structures_F_Heli_Items_Food","A3_Structures_F_Kart_Signs_Companies",
"A3_UI_F","A3_UI_F_Curator","A3_UI_F_Kart","A3_Weapons_F","A3_Weapons_F_NATO","A3_Weapons_F_CSAT","A3_Weapons_F_AAF","A3_weapons_F_FIA",
"A3_Weapons_F_ItemHolders","A3_Weapons_F_Headgear","A3_Weapons_F_Uniforms","A3_Weapons_F_Vests","A3_Weapons_F_Ammoboxes","A3_Weapons_F_DummyWeapons",
"A3_Weapons_F_Explosives","A3_Weapons_F_Items","A3_Weapons_F_Launchers_NLAW","A3_Weapons_F_Launchers_LAW","A3_Weapons_F_Launchers_Titan",
"A3_Weapons_F_EPA_LongRangeRifles_DMR_01","A3_Weapons_F_EBR","A3_Weapons_F_LongRangeRifles_GM6","A3_Weapons_F_LongRangeRifles_M320",
"A3_Weapons_F_Machineguns_M200","A3_Weapons_F_Machineguns_Zafir","A3_Weapons_F_Pistols_ACPC2","A3_Weapons_F_Pistols_P07",
"A3_Weapons_F_Pistols_Pistol_heavy_01","A3_Weapons_F_Pistols_Pistol_heavy_02","A3_Weapons_F_Pistols_Rook40","A3_Weapons_F_Rifles_Khaybar",
"A3_Weapons_F_Rifles_Mk20","A3_Weapons_F_Rifles_MX","A3_Weapons_F_EPB_Rifles_MX_Black","A3_Weapons_F_Rifles_SDAR","A3_Weapons_F_Rifles_TRG20",
"A3_Weapons_F_Pistols_PDW2000","A3_Weapons_F_Rifles_Vector","a3_weapons_f_rifles_SMG_02","A3_Weapons_F_beta","A3_Weapons_F_Beta_Ammoboxes",
"A3_Weapons_F_beta_EBR","A3_Weapons_F_EPA_LongRangeRifles_GM6","A3_Weapons_F_EPB_LongRangeRifles_M320","A3_Weapons_F_beta_Rifles_Khaybar",
"A3_Weapons_F_beta_Rifles_MX","A3_Weapons_F_beta_Rifles_TRG20","A3_Weapons_F_Bootcamp_LongRangeRifles_GM6","A3_Weapons_F_Bootcamp_LongRangeRifles_M320",
"A3_Weapons_F_EPB_LongRangeRifles_GM3","A3_Weapons_F_gamma","A3_Weapons_F_Gamma_Ammoboxes","A3_Weapons_F_EPA_EBR","A3_Weapons_F_EPA_Rifles_MX",
"A3_Weapons_F_Kart_Pistols_Pistol_Signal_F","D41_Drill","Bornholm","bornholmobjects","JSRS2_120mm_Cannon","JSRS2_127","JSRS2_155mm_AMOS",
"JSRS2_230mm_Titan","JSRS2_30mm_Cannon","JSRS2_35mm_Autocannon","JSRS2_4Five45","JSRS2_ACPC","JSRS2_Autocannon","JSRS2_Bullethits","JSRS2_DAGR",
"JSRS2_DAR","JSRS2_EBR","JSRS2_Explosions","JSRS2_Explosives","JSRS2_Filters","JSRS2_FS2000","JSRS2_Gatling","JSRS2_Gau8","JSRS2_GMG20","JSRS2_GMG40",
"JSRS2_Khaybar","JSRS2_LMGRCWS","JSRS2_M134","JSRS2_M200","JSRS2_M320R","JSRS2_M6","JSRS2_Minigun","JSRS2_MX","JSRS2_NLAW","JSRS2_P07","JSRS2_PDW",
"JSRS2_Rahim","JSRS2_Rook40","JSRS2_RPG32","JSRS2_Scorpian","JSRS2_SDAR","JSRS2_Skalpel_ATGM","JSRS2_Skyfire","JSRS2_Sonic_Cracks","DragonFyre_Titan",
"JSRS2_TRG20","JSRS2_Vector","JSRS2_Veh_Titan","JSRS2_Zafir","JSRS2_Zubr45","RH_de_cfg","RH_m4_cfg","rhs_main","rhs_optics","cba_ai",
"cba_arrays","cba_diagnostic","cba_help","cba_keybinding","cba_ui","cba_ui_helper","cba_versioning","A3_Anims_F_Heli","A3_Characters_F",
"A3_Characters_F_BLUFOR","A3_Characters_F_Civil","A3_Characters_F_Heads","A3_Characters_F_OPFOR","A3_Characters_F_Proxies","A3_Characters_F_Beta",
"A3_Characters_F_INDEP","A3_Characters_F_Bootcamp","A3_Characters_F_EPB_Heads","A3_Characters_F_Gamma","A3_Data_F_Curator","A3_Data_F_Curator_Eagle",
"A3_Data_F_Curator_Intel","A3_Data_F_Curator_Misc","A3_Data_F_Curator_Respawn","A3_Data_F_Kart","A3_UAV_F_Characters_F_Gamma","A3_UAV_F_Weapons_F_Gamma_Ammoboxes",
"A3_Weapons_F_gamma_Items","A3_Map_Altis","A3_Map_Altis_Scenes","A3_Missions_F","A3_Missions_F_Beta","A3_Missions_F_Gamma","A3_Missions_F_Kart",
"A3_Modules_F_Curator","A3_Modules_F_Curator_Animals","A3_Modules_F_Curator_CAS","A3_Modules_F_Curator_Curator","A3_Modules_F_Curator_Effects",
"A3_Modules_F_Curator_Environment","A3_Modules_F_Curator_Flares","A3_Modules_F_Curator_Intel","A3_Modules_F_Curator_Lightning","A3_Modules_F_Curator_Mines",
"A3_Modules_F_Curator_Misc","A3_Modules_F_Curator_Multiplayer","A3_Modules_F_Curator_Objectives","A3_Modules_F_Curator_Ordnance","A3_Modules_F_Curator_Respawn",
"A3_Modules_F_Curator_Smokeshells","A3_Modules_F_Kart","A3_Modules_F_Kart_TimeTrials","A3_Static_F","A3_Static_F_Mortar_01","A3_Static_F_Beta_Mortar_01",
"A3_Static_F_Gamma","A3_Static_F_Gamma_Mortar_01","A3_Supplies_F_Heli","A3_Supplies_F_Heli_Bladders","A3_Supplies_F_Heli_CargoNets","A3_Supplies_F_Heli_Fuel",
"A3_Supplies_F_Heli_Slingload","A3_UI_F_Bootcamp","A3_Weapons_F_Acc","A3_Weapons_F_Beta_Acc","A3_Weapons_F_Bootcamp_Ammoboxes","A3_Weapons_F_EPA",
"A3_Weapons_F_EPA_Acc","A3_Weapons_F_EPA_Ammoboxes","A3_Weapons_F_EPB","A3_Weapons_F_EPB_Acc","A3_Weapons_F_EPB_Ammoboxes","A3_Weapons_F_EPC",
"A3_Weapons_F_gamma_Acc","A3_Weapons_F_Kart","asdg_jointrails","asdg_jointrails_rh_m4","D41_Ambience","FHQ_Accessories","hlcweapons_core","hlcweapons_aks",
"hlcweapons_ar15","hlcweapons_falpocalypse","hlcweapons_g3","hlcweapons_m14","hlcweapons_m60e4","hlcweapons_mp5","JSRS2_Movement","JSRS2_Silencers",
"rhs_c_heavyweapons","rhs_c_weapons","rhs_decals","rhsusf_c_heavyweapons","rhsusf_c_weapons","cba_main","cba_main_a3","A3_Air_F","A3_Air_F_Heli_Light_01",
"A3_Air_F_Heli_Light_02","A3_Air_F_Beta","A3_Air_F_Beta_Heli_Attack_01","A3_Air_F_Beta_Heli_Attack_02","A3_Air_F_Beta_Heli_Transport_01",
"A3_Air_F_Beta_Heli_Transport_02","A3_Air_F_Beta_Parachute_01","A3_Air_F_Beta_Parachute_02","A3_Air_F_EPB_Heli_Light_03","A3_Air_F_EPC_Plane_CAS_01",
"A3_Air_F_EPC_Plane_CAS_02","A3_Air_F_Gamma_Plane_Fighter_03","A3_Air_F_RTD","A3_Armor_F","A3_armor_f_beta","A3_Armor_F_Panther","A3_armor_f_beta_APC_Tracked_02",
"A3_Armor_F_EPB_APC_tracked_03","A3_Armor_F_EPB_MBT_03","A3_Armor_F_Slammer","A3_Armor_F_T100K","A3_Boat_F","A3_Boat_F_Boat_Armed_01",
"A3_Boat_F_Boat_Transport_01","A3_Boat_F_Beta_Boat_Armed_01","A3_Boat_F_Beta_Boat_Transport_01","A3_Boat_F_SDV_01","A3_Boat_F_EPC_Submarine_01_F",
"A3_Boat_F_Civilian_Boat","A3_Boat_F_Trawler","A3_Boat_F_Gamma_Boat_Transport_01","A3_Boat_F_Heli_Boat_Armed_01","A3_Boat_F_Heli_SDV_01",
"A3_Characters_F_Common","A3_Characters_F_Bootcamp_Common","A3_Characters_F_EPA","A3_Characters_F_EPB","A3_Characters_F_EPC","A3_Characters_F_Kart",
"A3_Data_F_Curator_Characters","A3_Data_F_Curator_Virtual","A3_Data_F_Heli","A3_Air_F_Gamma_UAV_01","A3_Air_F_Gamma_UAV_02","A3_Missions_F_Bootcamp",
"A3_Missions_F_Curator","A3_Missions_F_EPA","A3_Missions_F_EPB","A3_Missions_F_EPC","A3_Missions_F_Heli","A3_Modules_F_Bootcamp",
"A3_Modules_F_Bootcamp_Misc","A3_Modules_F_Curator_Chemlights","A3_Soft_F","A3_Soft_F_MRAP_01","A3_Soft_F_MRAP_02","A3_Soft_F_Offroad_01",
"A3_Soft_F_Quadbike","A3_Soft_F_MRAP_03","A3_Soft_F_Beta_Quadbike","A3_Soft_F_HEMTT","A3_Soft_F_TruckHeavy","A3_Soft_F_EPC_Truck_03","A3_Soft_F_Car",
"A3_Soft_F_Gamma_Offroad","A3_Soft_F_Gamma_Quadbike","A3_Soft_F_SUV","A3_Soft_F_Gamma_HEMTT","A3_Soft_F_Gamma_TruckHeavy","A3_Soft_F_Truck",
"A3_Soft_F_Heli_Car","A3_Soft_F_Heli_MRAP_01","A3_Soft_F_Heli_MRAP_02","A3_Soft_F_Heli_MRAP_03","A3_Soft_F_Heli_Quadbike","A3_Soft_F_Heli_SUV",
"A3_Soft_F_Heli_Truck","A3_Soft_F_Kart_Kart_01","A3_Static_F_Gamma_AA","A3_Static_F_Gamma_AT","A3_Structures_F_Mil_Scrapyard","A3_Structures_F_Wrecks",
"A3_Structures_F_EPA_Mil_Scrapyard","A3_UI_F_Heli","A3_Weapons_F_Bootcamp","RVE_iveco","RVE_civic","RVE_wildcat","RVE_hemtt","D41_B_M1151",
"D41_HAFM_HMMWV","RVE_littlebird","RVE_punisher","RVE_ka60","RVE_KamAZ_1","RVE_karts","RVE_merlin","RVE_motorboat","D41_BAF_Offroad","RVE_dmax",
"RVE_honda_trx500","D41_Schlauchboot","D41_Hupen","RVE_fennek","RVE_x6","rve_typhoon","D41_Trawler","D41_police_mod","D41_Medic_mod","EWK_M1151",
"HAFM_UK_WHEELED","HAFM_HMMWV","JSRS2_2S9_Sorcher","JSRS2_AFV4_Gorgon","JSRS2_AH99_Blackfoot","JSRS2_AH9_Pawnee","JSRS2_AMV7_Marshal",
"JSRS2_BTRK_Kamysh","JSRS2_CAS_Plane1","JSRS2_CAS_Plane2","JSRS2_CH49_Mohawk","JSRS2_Distance","JSRS2_FighterPlane3","JSRS2_FV720_Mora",
"JSRS2_Hunter","JSRS2_Ifrit","JSRS2_IFV6a_Cheetah","JSRS2_IFV6c_Panther","JSRS2_M2A1_Slammer","JSRS2_M4_Scorcher","JSRS2_M5_Sandstorm",
"JSRS2_MBT52_Kuma","JSRS2_Mi48_Kajman","JSRS2_MSE3_Marid","JSRS2_Offroad","JSRS2_Po30_Orca","JSRS2_Strider","JSRS2_SUV","JSRS2_T100_Varsuk",
"JSRS2_Truck1","JSRS2_Truck2","JSRS2_UAV_1","JSRS2_UH80_GhostHawk","JSRS2_Van","JSRS2_WY55_Hellcat","JSRS2_ZSU39_Tigris","rhs_c_cars",
"rhs_c_troops","rhsusf_c_troops","cba_xeh_a3","A3_Air_F_EPC_Plane_Fighter_03","A3_Air_F_Heli","A3_Air_F_Heli_Heli_Attack_01",
"A3_Air_F_Heli_Heli_Attack_02","A3_Air_F_Heli_Heli_Light_01","A3_Air_F_Heli_Heli_Light_02","A3_Air_F_Heli_Heli_Light_03",
"A3_Air_F_Heli_Heli_Transport_01","A3_Air_F_Heli_Heli_Transport_02","A3_Air_F_Heli_Heli_Transport_03","A3_Air_F_Heli_Heli_Transport_04",
"A3_Armor_F_AMV","A3_Armor_F_Marid","A3_Armor_F_EPC_MBT_01","A3_Armor_F_APC_Wheeled_03","A3_CargoPoses_F","A3_CargoPoses_F_Heli",
"A3_Soft_F_Crusher_UGV","A3_Soft_F_Bootcamp_Offroad_01","A3_Soft_F_Bootcamp_Quadbike","A3_Soft_F_Bootcamp_Truck","A3_Soft_F_Heli_Crusher_UGV",
"D41_A2_Golf","D41_A2_Hunter","D41_A2_Ikarus","D41_A2_Lada","D41_A2_Civilians","D41_A2_S1203","D41_A2_GAZ","RHS_A2_CarsImport","rhs_c_a3retex",
"rhs_c_trucks","A3_Structures_F_Bootcamp_System","D41_Patch141111","D41_Blitze_peng","lop_c_men","lop_c_wep_headgear","lop_c_wep_uniforms","lop_c_wep_vests",
"lop_m_wep_headgear","lop_m_wep_uniforms","lop_main","lop_m_wep_vests","lop_t_wep_headgear","lop_t_wep_uniforms","lop_t_wep_vests","PG_Services_PMC_Bags",
"PG_Services_PMC_CLIENT","PG_Services_PMC_UNITS","PG_Services_PMC_Goggles","PG_Services_PMC_Gear","PG_SERVICES_PMC_UNDERWEAR","PG_SERVICES_PMC_UNIFORMS",
"CUP_BaseConfigs","CUP_BaseData","PG_Services_PMC_Ammoboxes","D41_a2port_cman","rds_a2port_cman","CUP_Weapons_WeaponsCore","CUP_Weapons_West_Attachments",
"CUP_Weapons_Ammunition","CUP_Weapons_AWM","CUP_Weapons_CZ750","CUP_Weapons_CZ805","CUP_Weapons_East_Attachments","CUP_Weapons_G36","CUP_Weapons_HuntingRifle",
"CUP_Weapons_L85","CUP_Weapons_LeeEnfield","CUP_Weapons_M1014","CUP_Weapons_M110","CUP_Weapons_M24","CUP_Weapons_Phantom","CUP_Weapons_VehicleWeapons",
"CUP_Weapons_VSS","CUP_Weapons_SCAR","GNT_C185","D41_ClosedBeta141207","US_ESS_Glasses_tryk","Kio_Balaclava","TRYK_Shemaghs","maa_Uniform","TRYK_BackPack",
"TRYK_Uniform","tfax_nvg","tfaX_units","D41_SchilderZeugs","D41_ClosedBeta141214","D41_Sounds","D41_Patch141222","D41_Taru","D41_Huron","D41_ADAC_mod","D41_sab_An2",
"D41_Patch150110","D41_HMMWV_RHS","D41_RHS_Vehicles_UH60","rhs_heavyweapons","rhs_weapons","rhsusf_weapons","rhs_infantry","rhs_tigr","rhsusf_vehicles","rhsusf_c_hmmwv",
"rhsusf_hmmwv","sab_An2","rhsusf_infantry","rhs_c_a2port_car","rhs_c_btr","rhs_gaz66","RHS_US_A2_AirImport","rhsusf_heavyweapons","rhs_a2port_car","rhs_a3retex","rhs_btr70",
"rhs_btr80","rhsusf_a2port_air","DragonFyre_Bullethits","DragonFyre_Explosions", "DragonFyre_Sonic_Cracks", "DragonFyre_230mm_Titan", "DragonFyre_Air_Weapons",
"DragonFyre_35mm_Autocannon", "DragonFyre_120mm_Cannon", "DragonFyre_Autocannon", "DragonFyre_DAGR", "DragonFyre_DAR", "DragonFyre_Minigun", "DragonFyre_30mm_Cannon",
"DragonFyre_Gau8", "DragonFyre_155mm_AMOS", "DragonFyre_M134", "DragonFyre_LMGRCWS", "DragonFyre_GMG20", "DragonFyre_GMG40", "DragonFyre_127", "DragonFyre_Skalpel_ATGM",
"DragonFyre_Skyfire", "DragonFyre_Veh_Titan", "DragonFyre_4Five45", "DragonFyre_ACPC", "DragonFyre_MX", "DragonFyre_M6", "DragonFyre_Khaybar", "DragonFyre_M320R",
"DragonFyre_EBR", "DragonFyre_FS2000", "DragonFyre_M200", "DragonFyre_P07", "DragonFyre_NLAW", "DragonFyre_PDW", "DragonFyre_Rahim", "DragonFyre_Rook40", "DragonFyre_RPG32",
"DragonFyre_Scorpian", "DragonFyre_TRG20", "DragonFyre_UGL", "DragonFyre_SDAR", "DragonFyre_Vector", "DragonFyre_Zafir", "DragonFyre_Zubr45", "DragonFyre_Movement",
"DragonFyre_Distance", "DragonFyre_FighterPlane3", "DragonFyre_CAS_Plane1", "DragonFyre_AH99_Blackfoot", "DragonFyre_AH9_Pawnee", "DragonFyre_UAV_1",
"DragonFyre_CH67_Huron", "DragonFyre_CH49_Mohawk", "DragonFyre_Mi290_Taru", "DragonFyre_Mi48_Kajman", "DragonFyre_UAV_2", "DragonFyre_Po30_Orca", "DragonFyre_CAS_Plane2",
"DragonFyre_UH80_GhostHawk", "DragonFyre_WY55_Hellcat", "DragonFyre_Boat_Armed_1", "DragonFyre_2S9_Sorcher", "DragonFyre_AFV4_Gorgon", "DragonFyre_AMV7_Marshal",
"DragonFyre_BTRK_Kamysh", "DragonFyre_FV720_Mora", "DragonFyre_IFV6a_Cheetah", "DragonFyre_IFV6c_Panther", "DragonFyre_M2A1_Slammer", "DragonFyre_M4_Scorcher",
"DragonFyre_M5_Sandstorm", "DragonFyre_MBT52_Kuma", "DragonFyre_MSE3_Marid", "DragonFyre_T100_Varsuk", "DragonFyre_ZSU39_Tigris", "DragonFyre_Hatchback",
"DragonFyre_truck1", "DragonFyre_Hunter", "DragonFyre_Ifrit", "DragonFyre_Offroad", "DragonFyre_Quadbike", "DragonFyre_Strider", "DragonFyre_SUV", "DragonFyre_truck2",
"DragonFyre_Van", "DragonFyre_Truck3","D41_PatchV12","PG_Services_PMC_vehicles","RH_acc","asdg_jr_rhs"
];

uiNamespace setVariable["RscDisplayRemoteMissions",displayNull]; //For Spy-Glass..
uiNamespace setVariable["RscDisplayMultiplayer",displayNull];

_binConfigPatches = configFile >> "CfgPatches";
for "_i" from 0 to count (_binConfigPatches)-1 do {
	_patchEntry = _binConfigPatches select _i;
	if(isClass _patchEntry) then {
		if(!((configName _patchEntry) in _patchList)) exitWith {
			[[profileName,steamid,(configName _patchEntry)],"SPY_fnc_cookieJar",false,false] spawn life_fnc_MP;
			[[profileName,format["Unknown Addon Patch: %1",(configName _patchEntry)]],"SPY_fnc_notifyAdmins",true,false] spawn life_fnc_MP;
			sleep 0.5;
			failMission "SpyGlass";
		};
	};
};

//Check for copy-pasters of Dev-Con styled execution.
//Because I am nice, add these to the following below to allow CBA; "CBA_CREDITS_CONT_C","CBA_CREDITS_M_P
private["_children","_allowedChildren"];
_children = [configFile >> "RscDisplayMPInterrupt" >> "controls",0] call BIS_fnc_returnChildren;
_allowedChildren = [
"Title", "MissionTitle", "PlayersName", "ButtonCancel", "ButtonSAVE", "ButtonSkip", "ButtonRespawn", "ButtonOptions",
"ButtonVideo", "ButtonAudio", "ButtonControls", "ButtonGame", "ButtonTutorialHints", "ButtonAbort", "DebugConsole",
"Version", "TraffLight", "Feedback", "MessageBox", "CBA_CREDITS_CONT_C","CBA_CREDITS_M_P"
];

{
	if(!((configName _x) in _allowedChildren)) exitWith {
		[[profileName,steamid,"Modified_MPInterrupt"],"SPY_fnc_cookieJar",false,false] spawn life_fnc_MP;
		[[profileName,"Devcon like executor detected"],"SPY_fnc_notifyAdmins",true,false] spawn life_fnc_MP;
		sleep 0.5;
		failMission "SpyGlass";
	};
} foreach _children;

/*
	Display Validator
	Loops through and makes sure none of the displays were modified..
	
	TODO: Run check every x minutes and validate all displays.
*/
{
	_onLoad = getText(configFile >> (_x select 0) >> "onLoad");
	_onUnload = getText(configFile >> (_x select 0) >> "onUnload");
	if(_onLoad != (_x select 1) OR _onUnload != (_x select 2)) exitWith {
		[[profileName,steamid,format["Modified_Method_%1",_x select 0]],"SPY_fnc_cookieJar",false,false] call life_fnc_MP;
		[[profileName,format["Modified Display Method %1 (Memory Edit)",_x select 0]],"SPY_fnc_notifyAdmins",true,false] call life_fnc_MP;
		sleep 0.5;
		vehicle player setVelocity[1e10,1e14,1e18]; //It's a surprise.
		sleep 3;
		preProcessFile "SpyGlass\endoftheline.sqf";
		sleep 2.5;
		failMission "SpyGlass";
	};
}
foreach [
			["RscDisplayMainMap","[""onLoad"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayGetReady","[""onLoad"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayInventory","[""onLoad"",_this,""RscDisplayInventory"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInventory"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayLoadMission","[""onLoad"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayInterrupt","[""onLoad"",_this,""RscDisplayInterrupt"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInterrupt"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayOptionsVideo","[""onLoad"",_this,""RscDisplayOptionsVideo"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsVideo"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayOptions","[""onLoad"",_this,""RscDisplayOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayAVTerminal","[""onLoad"",_this,""RscDisplayAVTerminal"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayAVTerminal"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayConfigureAction","[""onLoad"",_this,""RscDisplayConfigureAction"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayConfigureAction"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayConfigureControllers","[""onLoad"",_this,""RscDisplayConfigureControllers"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayConfigureControllers"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayControlSchemes","[""onLoad"",_this,""RscDisplayControlSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayControlSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayCustomizeController","[""onLoad"",_this,""RscDisplayCustomizeController"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayCustomizeController"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayDebriefing","[""onLoad"",_this,""RscDisplayDebriefing"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayDebriefing"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayDiary","[""onLoad"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayGameOptions","[""onLoad"",_this,""RscDisplayGameOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayGameOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayJoystickSchemes","[""onLoad"",_this,""RscDisplayJoystickSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayJoystickSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayLoading","[""onLoad"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayMicSensitivityOptions","[""onLoad"",_this,""RscDisplayMicSensitivityOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayMicSensitivityOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayOptionsAudio","[""onLoad"",_this,""RscDisplayOptionsAudio"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsAudio"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayOptionsLayout","[""onLoad"",_this,""RscDisplayOptionsLayout"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsLayout"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayStart","[2] call compile preprocessfilelinenumbers gettext (configfile >> 'CfgFunctions' >> 'init'); ['onLoad',_this,'RscDisplayLoading','Loading'] call (uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayVehicleMsgBox","[""onLoad"",_this,""RscDisplayVehicleMsgBox"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayVehicleMsgBox"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
			["RscDisplayInsertMarker","[""onLoad"",_this,""RscDisplayInsertMarker"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInsertMarker"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"]
		];

[] execVM "SpyGlass\fn_cmdMenuCheck.sqf";
[] execVM "SpyGlass\fn_variableCheck.sqf";
[] execVM "SpyGlass\fn_menuCheck.sqf";