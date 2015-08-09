params ['_obj','_loadout',['_loadoutArray',[]]];
if ((typeName _loadout) == 'STRING') then {
	_loadout = missionConfigFile >> "CfgLoadoutFramework" >> "UserLoadouts" >> _loadout;
};
private ['_isRoot'];
_isRoot = false;
if ((typeName _obj)=='OBJECT') then {
	_isRoot = true;
};

if (!isClass _loadout) exitWith {};

private ['_classes','_properties','_ind','_name'];

_properties = configProperties [_loadout,'isArray _x'];
_classes = 'true' configClasses _loadout;

{
	_name = (configName _x);
	if (!(_name in _loadoutArray)) then {
		_loadoutArray append [_name,[]];
	};
	_ind = _loadoutArray find _name;

	(_loadoutArray select (_ind+1)) append (getArray _x);
} count _properties;

{
	[[],_x,_loadoutArray] call BG_fnc_applyLoadout;
} count _classes;



if (!_isRoot) exitWith{};

removeAllWeapons _obj;
removeAllItems _obj;
removeAllAssignedItems _obj;
removeUniform _obj;
removeVest _obj;
removeBackpack _obj;
removeHeadgear _obj;
removeGoggles _obj;

private ['_items','_item'];
// Uniform
_ind = _loadoutArray find 'uniform';
_items = _loadoutArray select (_ind+1);
if ((count _items) > 0) then {
	_item = _items select (floor random (count _items));
	_obj forceAddUniform _item;
};

// Vest
_ind = _loadoutArray find 'vest';
_items = _loadoutArray select (_ind+1);
if ((count _items) > 0) then {
	_item = _items select (floor random (count _items));
	_obj addVest _item;
};

// Headgear
_ind = _loadoutArray find 'headgear';
_items = _loadoutArray select (_ind+1);
if ((count _items) > 0) then {
	_item = _items select (floor random (count _items));
	_obj addHeadgear _item;
};

// Goggles
_ind = _loadoutArray find 'goggle';
_items = _loadoutArray select (_ind+1);
if ((count _items) > 0) then {
	_item = _items select (floor random (count _items));
	_obj addGoggles _item;
};

// Backpack
_ind = _loadoutArray find 'backpack';
_items = _loadoutArray select (_ind+1);
if ((count _items) > 0) then {
	_item = _items select (floor random (count _items));
	_obj addBackpack _item;
};

// Weapons
{
	_ind = _loadoutArray find _x;
	_items = _loadoutArray select (_ind+1);
	if ((count _items) > 0) then {
		_item = _items select (floor random (count _items));
		_obj addWeapon _item;
	};
} count ['primaryWeapon','secondaryWeapon','handgun'];

// Primary Weapon Items
{
	_ind = _loadoutArray find _x;
	_items = _loadoutArray select (_ind+1);
	if ((count _items) > 0) then {
		_item = _items select (floor random (count _items));
		_obj addPrimaryWeaponItem _item;
	};
} count ['primaryWeaponOptic','primaryWeaponMuzzle','primaryWeaponBarrel','primaryWeaponResting','primaryWeaponLoadedMagazine'];

// Secondary Weapon Items
{
	_ind = _loadoutArray find _x;
	_items = _loadoutArray select (_ind+1);
	if ((count _items) > 0) then {
		_item = _items select (floor random (count _items));
		_obj addSecondaryWeaponItem _item;
	};
} count ['secondaryWeaponOptic','secondaryWeaponMuzzle','secondaryWeaponBarrel','secondaryWeaponResting','secondaryWeaponLoadedMagazine'];

// Handgun Items
{
	_ind = _loadoutArray find _x;
	_items = _loadoutArray select (_ind+1);
	if ((count _items) > 0) then {
		_item = _items select (floor random (count _items));
		_obj addHandgunItem _item;
	};
} count ['handgunOptic','handgunMuzzle','handgunBarrel','handgunResting','handgunLoadedMagazine'];


// Magazines
_ind = _loadoutArray find 'magazines';
_items = _loadoutArray select (_ind+1);
{
	if (typeName _x == 'ARRAY') then {
		_obj addMagazines _x;
	};
	if (typeName _x == 'STRING') then {
		_obj addMagazine _x;
	};

} count _items;

// Items to Uniform
_ind = _loadoutArray find 'itemsUniform';
_items = _loadoutArray select (_ind+1);
{
	if (typeName _x == 'ARRAY') then {
		for "_i" from 1 to (_x select 1) do {
		    _obj addItemToUniform (_x select 0);
		};
	};
	if (typeName _x == 'STRING') then {
		_obj addItemToUniform _x;
	};
} count _items;

// Items to Vest
_ind = _loadoutArray find 'itemsVest';
_items = _loadoutArray select (_ind+1);
{
	if (typeName _x == 'ARRAY') then {
		for "_i" from 1 to (_x select 1) do {
		    _obj addItemToVest (_x select 0);
		};
	};
	if (typeName _x == 'STRING') then {
		_obj addItemToVest _x;
	};
} count _items;

// Items to Backpack
_ind = _loadoutArray find 'itemsBackpack';
_items = _loadoutArray select (_ind+1);
{
	if (typeName _x == 'ARRAY') then {
		for "_i" from 1 to (_x select 1) do {
		    _obj addItemToBackpack (_x select 0);
		};
	};
	if (typeName _x == 'STRING') then {
		_obj addItemToBackpack _x;
	};
} count _items;

// Linked Items
_ind = _loadoutArray find 'linkedItems';
_items = _loadoutArray select (_ind+1);
{
	_obj linkItem _x;
} count _items;

// Scripts
_ind = _loadoutArray find 'script';
_items = _loadoutArray select (_ind+1);
{
	[_obj,_loadoutArray] call compile _x;
} count _items;