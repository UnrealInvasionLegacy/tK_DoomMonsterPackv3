class Archvile_Projectile extends Doom_Projectile;

var() Sound BurnSound;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    PlaySound(BurnSound, SLOT_Misc);
    SetTimer(2.00, false);
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{}

simulated function HitWall( vector HitNormal, actor Wall )
{}

simulated function Explode(vector HitLocation,vector HitNormal)
{}

simulated function Timer()
{
	if ( Role == ROLE_Authority )
	{
		HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, Location);
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
     BurnSound=Sound'tK_DoomMonsterPackv3.Archvile.Archvile_burn'
     Speed=900.000000
     MaxSpeed=1150.000000
     Damage=30.000000
     DamageRadius=120.000000
     MomentumTransfer=1000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Archvile_Flames'
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
     LifeSpan=10.000000
     DrawScale=0.600000
     Skins(0)=Texture'tK_DoomMonsterPackv3.Effects.Invis_Mat'
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=15.000000
     CollisionHeight=13.000000
}
