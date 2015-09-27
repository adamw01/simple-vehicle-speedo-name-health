// INCLUDES //
#include <a_samp>
#include <zcmd>

// DEFINES//
// COLORS //
#define COLOR_LIMEGREEN    0x00FF00FF
#define	COLOR_MAROON      0xC11B17FF

// TEXTDRAWS //
new PlayerText: VehicleName[MAX_PLAYERS],
PlayerText: VehicleSpeed[MAX_PLAYERS],
PlayerText: VehicleHealth[MAX_PLAYERS],
PlayerText:TextdrawTitleBox[MAX_PLAYERS],
PlayerText:TextdrawTitle[MAX_PLAYERS],
PlayerText:TextdrawMainBox[MAX_PLAYERS],
PlayerText:TextEngineOn[MAX_PLAYERS],
PlayerText:TextEngineOff[MAX_PLAYERS],
PlayerText:TextLightsOn[MAX_PLAYERS],
PlayerText:TextLightsOff[MAX_PLAYERS],
PlayerText:TextExit[MAX_PLAYERS];

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
        // VEHICLE STATS ON BOTTOM //
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

		// VEHICLE MENU //
		TextdrawTitleBox[i] = CreatePlayerTextDraw(i, 172.625000, 156.059997, "usebox");
		PlayerTextDrawLetterSize(i, TextdrawTitleBox[i], 0.000000, 3.001852);
		PlayerTextDrawTextSize(i, TextdrawTitleBox[i], 27.375000, 0.000000);
		PlayerTextDrawAlignment(i, TextdrawTitleBox[i], 1);
		PlayerTextDrawColor(i, TextdrawTitleBox[i], 0);
		PlayerTextDrawUseBox(i, TextdrawTitleBox[i], true);
		PlayerTextDrawBoxColor(i, TextdrawTitleBox[i], 65416);
		PlayerTextDrawSetShadow(i, TextdrawTitleBox[i], 0);
		PlayerTextDrawSetOutline(i, TextdrawTitleBox[i], 0);
		PlayerTextDrawFont(i, TextdrawTitleBox[i], 0);
		PlayerTextDrawSetSelectable(i, TextdrawTitleBox[i], 0);

		TextdrawTitle[i] = CreatePlayerTextDraw(i, 50.625000, 162.026657, "Vehicle Menu");
		PlayerTextDrawLetterSize(i, TextdrawTitle[i], 0.411249, 1.577600);
		PlayerTextDrawAlignment(i, TextdrawTitle[i], 1);
		PlayerTextDrawColor(i, TextdrawTitle[i], -1);
		PlayerTextDrawSetShadow(i, TextdrawTitle[i], 0);
		PlayerTextDrawSetOutline(i, TextdrawTitle[i], 1);
		PlayerTextDrawBackgroundColor(i, TextdrawTitle[i], 51);
		PlayerTextDrawFont(i, TextdrawTitle[i], 3);
		PlayerTextDrawSetProportional(i, TextdrawTitle[i], 1);
        PlayerTextDrawSetSelectable(i, TextdrawTitle[i], 0);

		TextdrawMainBox[i] = CreatePlayerTextDraw(i, 172.625000, 188.166656, "usebox");
		PlayerTextDrawLetterSize(i, TextdrawMainBox[i], 0.000000, 14.035926);
		PlayerTextDrawTextSize(i, TextdrawMainBox[i], 27.375000, 0.000000);
		PlayerTextDrawAlignment(i, TextdrawMainBox[i], 1);
		PlayerTextDrawColor(i, TextdrawMainBox[i], 0);
		PlayerTextDrawUseBox(i, TextdrawMainBox[i], true);
		PlayerTextDrawBoxColor(i, TextdrawMainBox[i], 102);
		PlayerTextDrawSetShadow(i, TextdrawMainBox[i], 0);
		PlayerTextDrawSetOutline(i, TextdrawMainBox[i], 0);
		PlayerTextDrawFont(i, TextdrawMainBox[i], 0);
        PlayerTextDrawSetSelectable(i, TextdrawMainBox[i], 0);

		TextEngineOn[i] = CreatePlayerTextDraw(i, 58.125000, 195.626678, "~y~1. ~w~Turn Engine On");
		PlayerTextDrawLetterSize(i, TextEngineOn[i], 0.248125, 1.174399);
		PlayerTextDrawAlignment(i, TextEngineOn[i], 1);
		PlayerTextDrawColor(i, TextEngineOn[i], -1);
		PlayerTextDrawSetShadow(i, TextEngineOn[i], 0);
		PlayerTextDrawSetOutline(i, TextEngineOn[i], 1);
		PlayerTextDrawBackgroundColor(i, TextEngineOn[i], 51);
		PlayerTextDrawFont(i, TextEngineOn[i], 1);
		PlayerTextDrawSetProportional(i, TextEngineOn[i], 1);
		PlayerTextDrawSetSelectable(i, TextEngineOn[i], 1);

		TextEngineOff[i] = CreatePlayerTextDraw(i, 56.875000, 212.799987, "~y~2. ~w~Turn Engine Off");
		PlayerTextDrawLetterSize(i, TextEngineOff[i], 0.248125, 1.174399);
		PlayerTextDrawAlignment(i, TextEngineOff[i], 1);
		PlayerTextDrawColor(i, TextEngineOff[i], -1);
		PlayerTextDrawSetShadow(i, TextEngineOff[i], 0);
		PlayerTextDrawSetOutline(i, TextEngineOff[i], 1);
		PlayerTextDrawBackgroundColor(i, TextEngineOff[i], 51);
		PlayerTextDrawFont(i, TextEngineOff[i], 1);
		PlayerTextDrawSetProportional(i, TextEngineOff[i], 1);
		PlayerTextDrawSetSelectable(i, TextEngineOff[i], 1);

		TextLightsOn[i] = CreatePlayerTextDraw(i, 56.875000, 229.973281, "~y~3. ~w~Turn On Lights");
		PlayerTextDrawLetterSize(i, TextLightsOn[i], 0.248125, 1.174399);
		PlayerTextDrawAlignment(i, TextLightsOn[i], 1);
		PlayerTextDrawColor(i, TextLightsOn[i], -1);
		PlayerTextDrawSetShadow(i, TextLightsOn[i], 0);
		PlayerTextDrawSetOutline(i, TextLightsOn[i], 1);
		PlayerTextDrawBackgroundColor(i, TextLightsOn[i], 51);
		PlayerTextDrawFont(i, TextLightsOn[i], 1);
		PlayerTextDrawSetProportional(i, TextLightsOn[i], 1);
		PlayerTextDrawSetSelectable(i, TextLightsOn[i], 1);

		TextLightsOff[i] = CreatePlayerTextDraw(i, 56.250000, 247.146636, "~y~4. ~w~Turn Off Lights");
		PlayerTextDrawLetterSize(i, TextLightsOff[i], 0.248125, 1.174399);
		PlayerTextDrawAlignment(i, TextLightsOff[i], 1);
		PlayerTextDrawColor(i, TextLightsOff[i], -1);
		PlayerTextDrawSetShadow(i, TextLightsOff[i], 0);
		PlayerTextDrawSetOutline(i, TextLightsOff[i], 1);
		PlayerTextDrawBackgroundColor(i, TextLightsOff[i], 51);
		PlayerTextDrawFont(i, TextLightsOff[i], 1);
		PlayerTextDrawSetProportional(i, TextLightsOff[i], 1);
        PlayerTextDrawSetSelectable(i, TextLightsOff[i], 1);

		TextExit[i] = CreatePlayerTextDraw(i, 42.500000, 300.906646, "~r~Close Box");
		PlayerTextDrawLetterSize(i, TextExit[i], 0.248125, 1.174399);
		PlayerTextDrawAlignment(i, TextExit[i], 1);
		PlayerTextDrawColor(i, TextExit[i], -1);
		PlayerTextDrawSetShadow(i, TextExit[i], 0);
		PlayerTextDrawSetOutline(i, TextExit[i], 1);
		PlayerTextDrawBackgroundColor(i, TextExit[i], 51);
		PlayerTextDrawFont(i, TextExit[i], 1);
		PlayerTextDrawSetProportional(i, TextExit[i], 1);
		PlayerTextDrawSetSelectable(i, TextExit[i], 1);
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
    		
    		PlayerTextDrawDestroy(i, TextdrawTitleBox[i]);
    		PlayerTextDrawDestroy(i, TextdrawTitle[i]);
    		PlayerTextDrawDestroy(i, TextdrawMainBox[i]);
    		PlayerTextDrawDestroy(i, TextEngineOn[i]);
    		PlayerTextDrawDestroy(i, TextEngineOff[i]);
    		PlayerTextDrawDestroy(i, TextLightsOn[i]);
    		PlayerTextDrawDestroy(i, TextLightsOff[i]);
    		PlayerTextDrawDestroy(i, TextExit[i]);
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

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
	new vehid = GetPlayerVehicleID(playerid);
	GetVehicleParamsEx(vehid, engine, lights, alarm, doors, bonnet, boot, objective);
	
	if(playertextid == TextEngineOn[playerid])
	{
		SetVehicleParamsEx(vehid, 1, lights, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid, COLOR_LIMEGREEN, "Your vehicles engine has been turned ON.");
	}
	else if(playertextid == TextEngineOff[playerid]) 
	{
		SetVehicleParamsEx(vehid, 0, lights, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid, COLOR_MAROON, "Your vehicles engine has been turned OFF.");
	}
	else if(playertextid == TextLightsOn[playerid]) 
	{
		SetVehicleParamsEx(vehid, engine, 1, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid, COLOR_LIMEGREEN, "Your vehicles lights have been turned ON.");
	}
	else if(playertextid == TextLightsOff[playerid])
	{
		SetVehicleParamsEx(vehid, engine, 0, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid, COLOR_MAROON, "Your vehicles lights have been turned OFF.");
	}
	else if(playertextid == TextExit[playerid])
	{
		PlayerTextDrawHide(playerid, TextdrawTitleBox[playerid]);
		PlayerTextDrawHide(playerid, TextdrawTitle[playerid]);
		PlayerTextDrawHide(playerid, TextdrawMainBox[playerid]);
		PlayerTextDrawHide(playerid, TextEngineOn[playerid]);
		PlayerTextDrawHide(playerid, TextEngineOff[playerid]);
		PlayerTextDrawHide(playerid, TextLightsOn[playerid]);
		PlayerTextDrawHide(playerid, TextLightsOff[playerid]);
		PlayerTextDrawHide(playerid, TextExit[playerid]);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}

COMMAND:vehicle(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
    {
    	PlayerTextDrawShow(playerid, TextdrawTitleBox[playerid]);
		PlayerTextDrawShow(playerid, TextdrawTitle[playerid]);
		PlayerTextDrawShow(playerid, TextdrawMainBox[playerid]);
		PlayerTextDrawShow(playerid, TextEngineOn[playerid]);
		PlayerTextDrawShow(playerid, TextEngineOff[playerid]);
		PlayerTextDrawShow(playerid, TextLightsOn[playerid]);
		PlayerTextDrawShow(playerid, TextLightsOff[playerid]);
		PlayerTextDrawShow(playerid, TextExit[playerid]);
		SelectTextDraw(playerid, 0xE5E5E5FF);
	}
	else
	{
		SendClientMessage(playerid, COLOR_MAROON, "You must be in a vehicle!");
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
