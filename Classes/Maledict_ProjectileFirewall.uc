class Maledict_ProjectileFirewall extends Doom_Projectile;

var Sound AltAmbient;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

	if(fRand() > 0.5)
	{
		AmbientSound = AltAmbient;
	}

    SetTimer(0.1, true);
}

simulated event PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if (NewVolume.bWaterVolume)
	{
		Destroy();
	}
	Super.PhysicsVolumeChange(NewVolume);
}

simulated function Landed( vector HitNormal )
{
	SetPhysics(PHYS_Walking);
}

simulated function Explode(vector HitLocation,vector HitNormal)
{
    SetCollisionSize(0.0, 0.0);
    Destroy();
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{}

simulated function HitWall( vector HitNormal, actor Wall )
{}

simulated function Timer()
{
	if ( Role == ROLE_Authority )
	{
		HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, Location );
	}

	if (Physics != PHYS_Walking)
	{
		return;
	}
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
    local actor Victims;
    local float damageScale, dist;
    local vector dir;

    if ( bHurtEntry )
        return;

    bHurtEntry = true;
    foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
    {
        if( (Victims != self) && (Victims != Instigator) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') )
        {
            dir = Victims.Location - HitLocation;
            dist = FMax(1,VSize(dir));
            dir = dir/dist;
            damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
            if ( Instigator == None || Instigator.Controller == None )
                Victims.SetDelayedDamageInstigatorController( InstigatorController );
            if ( Victims == LastTouched )
                LastTouched = None;
            Victims.TakeDamage
            (
                damageScale * DamageAmount,
                Instigator,
                Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
                (damageScale * Momentum * dir),
                DamageType
            );
            if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
                Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

        }
    }
    if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
    {
        Victims = LastTouched;
        LastTouched = None;
        dir = Victims.Location - HitLocation;
        dist = FMax(1,VSize(dir));
        dir = dir/dist;
        damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
        if ( Instigator == None || Instigator.Controller == None )
            Victims.SetDelayedDamageInstigatorController(InstigatorController);
        Victims.TakeDamage
        (
            damageScale * DamageAmount,
            Instigator,
            Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
            (damageScale * Momentum * dir),
            DamageType
        );
        if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
            Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
    }

    bHurtEntry = false;
}

defaultproperties
{
     AltAmbient=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_flamewall_04'
     TrailClass=Class'tK_DoomMonsterPackv3.Maledict_FireWallTrail'
     Speed=900.000000
     MaxSpeed=1150.000000
     Damage=5.000000
     DamageRadius=75.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Maledict_Projectile'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightSaturation=127
     LightBrightness=255.000000
     LightRadius=4.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.GrenadeMesh'
     CullDistance=4000.000000
     bDynamicLight=True
     bNetTemporary=False
     Physics=PHYS_Falling
     AmbientSound=Sound'tK_DoomMonsterPackv3.Maledict.Maledict_flamewall_03'
     LifeSpan=4.000000
     DrawScale=0.600000
     Skins(0)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=15.000000
     CollisionHeight=13.000000
}
