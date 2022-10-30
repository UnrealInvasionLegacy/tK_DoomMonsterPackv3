class Guardian_Projectile extends Doom_Projectile;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

	Velocity.z += RandRange(300,700);
}

simulated function Landed( vector HitNormal )
{
    Explode(Location,HitNormal);
}

defaultproperties
{
     TrailClass=Class'tK_DoomMonsterPackv3.Guardian_ProjectileMouthTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Guardian_ProjectileExplosion'
     Speed=900.000000
     MaxSpeed=1150.000000
     Damage=20.000000
     DamageRadius=200.000000
     MomentumTransfer=3000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Guardian_Projectile'
     ImpactSound=Sound'tK_DoomMonsterPackv3.Imp.imp_exp_03'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=8
     LightSaturation=90
     LightBrightness=255.000000
     LightRadius=4.000000
     DrawType=DT_Sprite
     CullDistance=4000.000000
     bDynamicLight=True
     Physics=PHYS_Falling
     AmbientSound=Sound'tK_DoomMonsterPackv3.Imp.imp_fireball_flight_04'
     LifeSpan=6.000000
     Texture=Shader'tK_DoomMonsterPackv3.Effects.Doom_Imp_FireBall_Texture'
     DrawScale=0.200000
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
