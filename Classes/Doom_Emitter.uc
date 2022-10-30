class Doom_Emitter extends Emitter;

simulated event BaseChange()
{
	if(Base == None)
	{
		Kill();
	}

	Super.BaseChange();
}

defaultproperties
{
     AutoDestroy=True
     bNoDelete=False
     RemoteRole=ROLE_SimulatedProxy
     bNotOnDedServer=False
}
