class Doom_Species extends SpeciesType abstract;

var() string DoomMonsterSpecies[30];

static function string GetRagSkelName(string MeshName)
{
	local int i;

	for(i=0;i<30;i++)
	{
		if(MeshName ~= default.DoomMonsterSpecies[i])
		{
			return default.DoomMonsterSpecies[i];
		}
	}

    if(InStr(MeshName, "Female") >= 0)
    {
        return default.FemaleRagSkelName;
	}
	else
	{
    	return default.MaleRagSkelName;
	}
}

defaultproperties
{
     DoomMonsterSpecies(0)="Archvile"
     DoomMonsterSpecies(1)="Boney"
     DoomMonsterSpecies(2)="Bruiser"
     DoomMonsterSpecies(3)="Cacodemon"
     DoomMonsterSpecies(4)="Cherub"
     DoomMonsterSpecies(5)="Commando"
     DoomMonsterSpecies(6)="Cyberdemon"
     DoomMonsterSpecies(7)="FatZombie"
     DoomMonsterSpecies(8)="Forgotten"
     DoomMonsterSpecies(9)="Guardian"
     DoomMonsterSpecies(10)="HellKnight"
     DoomMonsterSpecies(11)="HunterBerserk"
     DoomMonsterSpecies(12)="HunterHellTime"
     DoomMonsterSpecies(13)="HunterInvul"
     DoomMonsterSpecies(14)="Imp"
     DoomMonsterSpecies(15)="LostSoul"
     DoomMonsterSpecies(16)="Maggot"
     DoomMonsterSpecies(17)="Maledict"
     DoomMonsterSpecies(18)="Mancubus"
     DoomMonsterSpecies(19)="Pinky"
     DoomMonsterSpecies(20)="Revenant"
     DoomMonsterSpecies(21)="Sabaoth"
     DoomMonsterSpecies(22)="Sawyer"
     DoomMonsterSpecies(23)="Seeker"
     DoomMonsterSpecies(24)="Sentry"
     DoomMonsterSpecies(25)="Tick"
     DoomMonsterSpecies(26)="Trite"
     DoomMonsterSpecies(27)="Vagary"
     DoomMonsterSpecies(28)="Vulgar"
     DoomMonsterSpecies(29)="Wraith"
     GibGroup="xEffects.xPawnGibGroup"
}
