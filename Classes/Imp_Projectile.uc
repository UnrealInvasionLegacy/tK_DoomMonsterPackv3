class Imp_Projectile extends Doom_Projectile;

var() Emitter SmokeTrail;
var() class<Emitter> SmokeTrailClass;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if ( Level.NetMode != NM_DedicatedServer )
    {
        SmokeTrail = Spawn(SmokeTrailClass,self);
        SmokeTrail.SetBase(self);
    }
}

simulated function Destroyed()
{
	if(SmokeTrail != None)
	{
		SmokeTrail.Kill();
	}

    Super.Destroyed();
}

defaultproperties
{
     SmokeTrailClass=Class'tK_DoomMonsterPackv3.Imp_ProjectileSmokeTrail'
     TrailClass=Class'tK_DoomMonsterPackv3.Imp_ProjectileTrail'
     ExplosionClass=Class'tK_DoomMonsterPackv3.Imp_ProjectileExplosion'
     Speed=900.000000
     MaxSpeed=1150.000000
     TossZ=10.000000
     Damage=20.000000
     DamageRadius=150.000000
     MomentumTransfer=3000.000000
     MyDamageType=Class'tK_DoomMonsterPackv3.DamType_Imp_Projectile'
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
     AmbientSound=Sound'tK_DoomMonsterPackv3.Imp.imp_fireball_flight_04'
     LifeSpan=10.000000
     Texture=Shader'tK_DoomMonsterPackv3.Effects.Doom_Imp_FireBall_Texture'
     DrawScale=0.400000
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
