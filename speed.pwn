/*******************************************************************************
*  FILTERSCRIPT NAME: Simple Vehicle Speedometer/Health/Vehicle Name
*  FILTERSCRIPT DEVELOPER: Adam W (FreAkeD)
*
*  INFORMATION: Displays vehicle statistics on the bottom of the players screen.
*  (Vehicle Name / Vehicle Health / Vehicle Speed in KM/H
*******************************************************************************/

// INCLUDES //
#include <a_samp>

// TEXTDRAWS //
new Text: VehicleName[MAX_PLAYERS],
Text: VehicleSpeed[MAX_PLAYERS],
Text: VehicleHealth[MAX_PLAYERS];

// VEHICLE ARRAY //
new Vehicles[212][]=
{
{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"}, {"Dumper"},{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},
{"Washington"},{"Bobcat"},{"Mr. Whoopee"},{"BF. Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Article Trailer"},{"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Article Trailer 2"},{"Turismo"},{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},{"Sanchez"},
{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},{"Jetmax"},{"Hotring"},
{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},{"Tanker"},{"Roadtrain"},
{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},{"Blade"},{"Freight"},{"Streak"},{"Vortex"},
{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},
{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Dunerider"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},{"Tug"},{"Article Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Mobile Hotdog"},
{"Club"},{"Freight Carriage"},{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T Van"},{"Alpha"},{"Phoenix"},{"Glendale"},{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},
{"Boxville"},{"Farm Plow"},{"Utility Trailer"}
};

public OnFilterScriptInit()
{
	print("\n--Loaded Simple Speedometer and Vehicle Health System by FreAkeD!--\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	VehicleName[playerid] = TextDrawCreate(53.799999, 436, "Vehicle: ~g~"); // Vehicle name (displays 1st)
	TextDrawLetterSize(VehicleName[playerid], 0.2, 0.999);
	TextDrawAlignment(VehicleName[playerid], 2);
	TextDrawColor(VehicleName[playerid], -1);
	TextDrawSetShadow(VehicleName[playerid], 0);
	TextDrawSetOutline(VehicleName[playerid], 1);
	TextDrawFont(VehicleName[playerid], 1);
	TextDrawUseBox(VehicleName[playerid], 1);
	TextDrawBoxColor(VehicleName[playerid], 0x00000088);

    VehicleSpeed[playerid] = TextDrawCreate(128.799999, 436, "Speed: ~y~0 ~g~KM/H"); // Vehicle speed in KM/H (displays 2nd)
	TextDrawLetterSize(VehicleSpeed[playerid], 0.2, 0.999);
	TextDrawAlignment(VehicleSpeed[playerid], 2);
	TextDrawColor(VehicleSpeed[playerid], -1);
	TextDrawSetShadow(VehicleSpeed[playerid], 0);
	TextDrawSetOutline(VehicleSpeed[playerid], 1);
	TextDrawFont(VehicleSpeed[playerid], 1);

	VehicleHealth[playerid] = TextDrawCreate(175.799999, 436, "Vehicle Health: ~g~0"); // Vehicle health as percentage (displays last)
	TextDrawBackgroundColor(VehicleHealth[playerid], 255);
	TextDrawFont(VehicleHealth[playerid], 1);
	TextDrawLetterSize(VehicleHealth[playerid], 0.2, 0.999);
	TextDrawColor(VehicleHealth[playerid], -1);
	TextDrawSetOutline(VehicleHealth[playerid], 1);
	TextDrawSetProportional(VehicleHealth[playerid], 1);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	// Showing the textdraw if the player is in the vehicle.
	// If the player decides to leave the vehicle, the textdraw will not display.
	new getvname[50];
    if(oldstate-1 && newstate) TextDrawHideForPlayer(playerid, VehicleName[playerid]);
	else if(newstate-1) TextDrawShowForPlayer(playerid, VehicleName[playerid]), format(getvname, sizeof(getvname), "Vehicle: ~g~%s", Vehicles[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400]), TextDrawSetString(VehicleName[playerid], getvname);

	if(oldstate-1 && newstate) TextDrawHideForPlayer(playerid, VehicleSpeed[playerid]);
	else if(newstate-1) TextDrawShowForPlayer(playerid, VehicleSpeed[playerid]);

	if(oldstate-1 && newstate) TextDrawHideForPlayer(playerid, VehicleHealth[playerid]);
	else if(newstate-1) TextDrawShowForPlayer(playerid, VehicleHealth[playerid]);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    // Getting the vehicles speed in km/h
		new vspeed[25];
		format(vspeed, sizeof(vspeed), "Speed: ~y~%d ~g~KM/H", GetVehicleSpeed(playerid));
		TextDrawSetString(VehicleSpeed[playerid], vspeed);

		// Getting the vehicles health (shown as percentage)
		new vhealthtd[32], Float:vHealth;
        GetVehicleHealth(GetPlayerVehicleID(playerid), vHealth);
		new Float:percentage = (((vHealth - 250.0) / (1000.0 - 250.0)) * 100.0);

        format(vhealthtd, sizeof(vhealthtd), "Vehicle Health: ~g~%.0f", percentage);
        TextDrawSetString(VehicleHealth[playerid], vhealthtd);
	}
	return 1;
}

// STOCKS //

// GETVEHICLESPEED STOCK //
stock GetVehicleSpeed(playerid)
{
	new Float: Pos[4];
    GetVehicleVelocity(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
    return floatround(1.61 * floatsqroot(floatabs(floatpower(Pos[0] + Pos[1] + Pos[2], 2))) * 100);
}
