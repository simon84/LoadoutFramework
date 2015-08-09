class Rifleman : Collection {
    uniform[] = {"U_B_CombatUniform_mcam"};
    vest[] = {"V_PlateCarrierL_CTRG"};
    headgear[] = {"H_HelmetB_camo"};
    goggle[] = {"G_Combat"};
    backpack[] = {"B_AssaultPack_mcamo"};
    handgun[] = {"hgun_P07_F"};
    magazines[] = {{"16Rnd_9x21_Mag",2}};
    itemsBackpack[] = {{"FirstAidKit",3}};
    linkedItems[]={"ItemWatch","ItemCompass","ItemMap","NVGoggles"};
    class PrimaryWeaponClass : Weapon_MX { // Some Collections added to Rifleman Collection
      primaryWeaponOptic[]={}; // Change optic to iron sight for this collection
    };
};