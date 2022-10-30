class FatZombie_ProjectileExplosion extends RocketExplosion;

simulated function PostBeginPlay()
{
    if ( Level.NetMode != NM_DedicatedServer )
    {
        Spawn(class'NewExplosionA');
	}
}

defaultproperties
{
     RemoteRole=ROLE_SimulatedProxy
}
