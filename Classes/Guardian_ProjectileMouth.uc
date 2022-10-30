class Guardian_ProjectileMouth extends Guardian_Projectile;

simulated function PostBeginPlay()
{
    Super(Doom_Projectile).PostBeginPlay();
}

defaultproperties
{
     bSeeking=True
     Speed=1000.000000
     Physics=PHYS_Projectile
}
