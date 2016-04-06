#pragma semicolon 1
#include <emitsoundany> 

#pragma newdecls required // let's go new syntax! 

public Plugin myinfo =
{
	name = "[CS:GO] NoScope sound",
	author = "Hejter",
	version = "0.2",
	url = "HLmod.ru"
};

public void OnPluginStart()
{
	HookEvent("player_death", Event_PlayerDeath);
}

public void OnMapStart()
{
	//AddFileToDownloadsTable("sound/music/kill_03.wav"); 
	PrecacheSoundAny("music/kill_03.wav");
}

public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(event.GetInt("userid"));
    int attacker = GetClientOfUserId(event.GetInt("attacker"));
  
    if (client && IsClientInGame(client))
    {
        if (attacker != 0 && IsClientInGame(attacker))
        {
            if (attacker != client)
            {
            	char weapon[32];
            	GetEventString(event, "weapon", weapon, sizeof(weapon));
                if (!GetEntProp(attacker, Prop_Send, "m_bIsScoped") && strcmp(weapon, "awp", false) == 0 || strcmp(weapon, "ssg08", false) == 0)
                {
					PrintToChatAll("%N убил без прицела %N", attacker, client);
					EmitSoundToClientAny(attacker, "music/kill_03.wav"); // Проигрывает звук убившему.
				}
			}
		}
	}
}