class Seeker_TorchMesh extends Actor;

simulated event BaseChange()
{
	if(Base == None)
	{
		Destroy();
	}
	super.BaseChange();
}

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'tK_DoomMonsterPackv3.SM.SeekerLightFXMesh'
     RemoteRole=ROLE_SimulatedProxy
}
