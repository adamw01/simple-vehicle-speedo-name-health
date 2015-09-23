// INCLUDES //
#include <a_samp>

// TEXTDRAWS //
new PlayerText: VehicleName[MAX_PLAYERS],
PlayerText: VehicleSpeed[MAX_PLAYERS],
PlayerText: VehicleHealth[MAX_PLAYERS];

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
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
		VehicleName[i] = CreatePlayerTextDraw(i, 53.799999, 436, "Vehicle: ~g~"); // Vehicle name (displays 1st)
		PlayerTextDrawLetterSize(i, VehicleName[i], 0.2, 0.999);
		PlayerTextDrawAlignment(i, VehicleName[i], 2);
		PlayerTextDrawColor(i, VehicleName[i], -1);
		PlayerTextDrawSetOutline(i, VehicleName[i], 1);
		PlayerTextDrawFont(i, VehicleName[i], 1);
		PlayerTextDrawUseBox(i, VehicleName[i], 1);
		PlayerTextDrawBoxColor(i, VehicleName[i], 0x00000088);

    	VehicleSpeed[i] = CreatePlayerTextDraw(i, 128.799999, 436, "Speed: ~y~0 ~g~KM/H"); // Vehicle speed in KM/H (displays 2nd)
		PlayerTextDrawLetterSize(i, VehicleSpeed[i], 0.2, 0.999);
		PlayerTextDrawAlignment(i, VehicleSpeed[i], 2);
		PlayerTextDrawColor(i, VehicleSpeed[i], -1);
		PlayerTextDrawSetOutline(i, VehicleSpeed[i], 1);
		PlayerTextDrawFont(i, VehicleSpeed[i], 1);

		VehicleHealth[i] = CreatePlayerTextDraw(i, 175.799999, 436, "Vehicle Health: ~g~0"); // Vehicle health as percentage (displays last)
		PlayerTextDrawBackgroundColor(i, VehicleHealth[i], 255);
		PlayerTextDrawFont(i, VehicleHealth[i], 1);
		PlayerTextDrawLetterSize(i, VehicleHealth[i], 0.2, 0.999);
		PlayerTextDrawColor(i, VehicleHealth[i], -1);
		PlayerTextDrawSetOutline(i, VehicleHealth[i], 1);
		PlayerTextDrawSetProportional(i, VehicleHealth[i], 1);
    }
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			PlayerTextDrawDestroy(i, VehicleName[i]);
    		PlayerTextDrawDestroy(i, VehicleSpeed[i]);
    		PlayerTextDrawDestroy(i, VehicleHealth[i]);
		}

	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	// Showing the textdraw if the player is in the vehicle.
	// If the player decides to leave the vehicle, the textdraw will not display.
	new getvname[50];
    if(oldstate-1 && newstate) PlayerTextDrawHide(playerid, VehicleName[playerid]);
	else if(newstate-1) PlayerTextDrawShow(playerid, VehicleName[playerid]), format(getvname, sizeof(getvname), "Vehicle: ~g~%s", Vehicles[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400]), PlayerTextDrawSetString(playerid, VehicleName[playerid], getvname);

	if(oldstate-1 && newstate) PlayerTextDrawHide(playerid, VehicleSpeed[playerid]);
	else if(newstate-1) PlayerTextDrawShow(playerid, VehicleSpeed[playerid]);

	if(oldstate-1 && newstate) PlayerTextDrawHide(playerid, VehicleHealth[playerid]);
	else if(newstate-1) PlayerTextDrawShow(playerid, VehicleHealth[playerid]);
	return 1;
}

public OnPlayerUpdate(playerid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
	    		// Getting the vehicles speed in km/h
  				new vspeed[25];
				format(vspeed, sizeof(vspeed), "Speed: ~y~%d ~g~KM/H", GetVehicleSpeed(i));
				PlayerTextDrawSetString(i, VehicleSpeed[i], vspeed);

				// Getting the vehicles health (shown as percentage)
				new vhealthtd[32], Float:vHealth;
        		GetVehicleHealth(GetPlayerVehicleID(playerid), vHealth);
				new Float:percentage = (((vHealth - 250.0) / (1000.0 - 250.0)) * 100.0);

        		format(vhealthtd, sizeof(vhealthtd), "Vehicle Health: ~g~%.0f", percentage);
        		PlayerTextDrawSetString(i, VehicleHealth[i], vhealthtd);
			}
		}
	}
	return 1;
}

// STOCKS //

// GETVEHICLESPEED STOCK //
stock GetVehicleSpeed(playerid)
{
    new Float:Pos[4];
    GetVehicleVelocity(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
    Pos[3] = floatsqroot(floatpower(floatabs(Pos[0]), 2) + floatpower(floatabs(Pos[1]), 2) + floatpower(floatabs(Pos[2]), 2)) * 181.5;
    return floatround(Pos[3]);
}
